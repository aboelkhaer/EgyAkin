import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:path_provider/path_provider.dart';

/// Resolves chat attachment URLs.
///
/// Per Chat API V3, `url` is a signed link (valid ~30 minutes). Relative paths
/// are prefixed with [ApiEndPoint.baseUrl].
String resolveChatAttachmentUrl(String? raw) {
  final url = raw?.trim() ?? '';
  if (url.isEmpty) return '';
  if (url.startsWith('http://') || url.startsWith('https://')) return url;
  if (url.startsWith('/')) return '${ApiEndPoint.baseUrl}$url';
  return '${ApiEndPoint.baseUrl}/$url';
}

/// Headers required by `/api/v3/chat/files/{id}` signed URLs.
///
/// Even with `expires` + `signature` query params, the API expects:
/// `Authorization: Bearer <token>` and an `Accept` header.
///
/// Cached after the first read so avatars (inbox tiles → More sheet) can reuse
/// disk/memory image cache without flashing a loader on every open.
Map<String, String>? _cachedChatProtectedFileHeaders;
String? _cachedChatProtectedFileToken;
String? _cachedChatProtectedFileAccept;

Future<Map<String, String>> chatProtectedFileHeaders({
  String accept = '*/*',
}) async {
  final token =
      await sl<AppPreferences>().getString(AppLocalStrings.keyToken) ?? '';
  if (_cachedChatProtectedFileHeaders != null &&
      _cachedChatProtectedFileToken == token &&
      _cachedChatProtectedFileAccept == accept) {
    return Map<String, String>.from(_cachedChatProtectedFileHeaders!);
  }
  final headers = <String, String>{
    if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    'Accept': accept,
  };
  _cachedChatProtectedFileHeaders = headers;
  _cachedChatProtectedFileToken = token;
  _cachedChatProtectedFileAccept = accept;
  return Map<String, String>.from(headers);
}

/// Sync headers when already warmed (e.g. inbox list loaded first).
Map<String, String>? chatProtectedFileHeadersIfCached({
  String accept = '*/*',
}) {
  if (_cachedChatProtectedFileHeaders == null) return null;
  if (_cachedChatProtectedFileAccept != accept) return null;
  return Map<String, String>.from(_cachedChatProtectedFileHeaders!);
}

/// Downloads a signed `/chat/files/{id}` URL with Bearer auth (same as images /
/// voice). Caches by [cacheId] under the temp directory.
Future<File> downloadChatProtectedFile({
  required String url,
  required String cacheId,
  String filePrefix = 'chat_file',
  String? mimeType,
  String? originalName,
  String accept = '*/*',
  String fallbackExtension = '',
}) async {
  final dir = await getTemporaryDirectory();
  final existing = await _findCachedChatFile(
    dirPath: dir.path,
    filePrefix: filePrefix,
    cacheId: cacheId,
    originalName: originalName,
  );
  if (existing != null) return existing;

  final headers = await chatProtectedFileHeaders(accept: accept);
  final dio = Dio();
  final response = await dio.get<List<int>>(
    url,
    options: Options(
      headers: headers,
      responseType: ResponseType.bytes,
      followRedirects: false,
      validateStatus: (s) => s != null && s >= 200 && s < 300,
    ),
  );

  final bytes = response.data;
  if (bytes == null || bytes.isEmpty) {
    throw StateError('Empty chat file download');
  }
  // Auth failure often returns the HTML login page / JSON error.
  final probe = String.fromCharCodes(
    bytes.take(bytes.length < 64 ? bytes.length : 64),
  ).toLowerCase();
  if (probe.contains('<!doctype') ||
      probe.contains('<html') ||
      (probe.contains('"message"') && probe.contains('unauthenticat'))) {
    throw StateError('Chat file download unauthorized (got HTML/JSON error)');
  }

  var ext = _extensionForChatFile(
    contentType: response.headers.value('content-type'),
    url: url,
    mimeType: mimeType,
    originalName: originalName,
  );
  if (ext.isEmpty && fallbackExtension.isNotEmpty) {
    ext = fallbackExtension.startsWith('.')
        ? fallbackExtension
        : '.$fallbackExtension';
  }
  final safeName = _safeFileBaseName(originalName) ?? cacheId;
  final out = File('${dir.path}/${filePrefix}_${safeName}_$cacheId$ext');
  await out.writeAsBytes(bytes, flush: true);
  return out;
}

Future<File?> _findCachedChatFile({
  required String dirPath,
  required String filePrefix,
  required String cacheId,
  String? originalName,
}) async {
  final dir = Directory(dirPath);
  if (!await dir.exists()) return null;
  final safeName = _safeFileBaseName(originalName);
  await for (final entity in dir.list()) {
    if (entity is! File) continue;
    final name = entity.uri.pathSegments.isNotEmpty
        ? entity.uri.pathSegments.last
        : entity.path.split(Platform.pathSeparator).last;
    final matchesId = name.contains('${filePrefix}_') && name.contains(cacheId);
    final matchesNamed = safeName != null &&
        name.startsWith('${filePrefix}_${safeName}_$cacheId');
    if ((matchesNamed || matchesId) && await entity.length() > 64) {
      return entity;
    }
  }
  return null;
}

String? _safeFileBaseName(String? originalName) {
  final raw = originalName?.trim() ?? '';
  if (raw.isEmpty) return null;
  final base = raw.split(RegExp(r'[\\/]')).last;
  final withoutExt =
      base.contains('.') ? base.substring(0, base.lastIndexOf('.')) : base;
  final cleaned = withoutExt.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
  if (cleaned.isEmpty) return null;
  return cleaned.length > 40 ? cleaned.substring(0, 40) : cleaned;
}

String _extensionForChatFile({
  String? contentType,
  required String url,
  String? mimeType,
  String? originalName,
}) {
  final name = (originalName ?? '').toLowerCase();
  final dot = name.lastIndexOf('.');
  if (dot >= 0 && dot < name.length - 1) {
    final ext = name.substring(dot);
    if (ext.length <= 8 && RegExp(r'^\.[a-z0-9]+$').hasMatch(ext)) {
      return ext;
    }
  }

  final ct = (contentType ?? mimeType ?? '').toLowerCase();
  if (ct.contains('pdf')) return '.pdf';
  if (ct.contains('msword') || ct.contains('wordprocessingml')) return '.doc';
  if (ct.contains('sheet') || ct.contains('excel')) return '.xlsx';
  if (ct.contains('presentation') || ct.contains('powerpoint')) return '.pptx';
  if (ct.contains('zip')) return '.zip';
  if (ct.contains('text/plain')) return '.txt';
  if (ct.contains('csv')) return '.csv';
  if (ct.contains('jpeg')) return '.jpg';
  if (ct.contains('png')) return '.png';
  if (ct.contains('gif')) return '.gif';
  if (ct.contains('webp')) return '.webp';
  if (ct.contains('mpeg') || ct.contains('mp3')) return '.mp3';
  if (ct.contains('wav')) return '.wav';
  if (ct.contains('ogg')) return '.ogg';
  if (ct.contains('aac')) return '.aac';
  if (ct.contains('mp4') || ct.contains('m4a') || ct.contains('x-m4a')) {
    return '.m4a';
  }

  final lowerUrl = url.toLowerCase();
  for (final ext in [
    '.pdf',
    '.doc',
    '.docx',
    '.xls',
    '.xlsx',
    '.ppt',
    '.pptx',
    '.txt',
    '.csv',
    '.zip',
    '.jpg',
    '.jpeg',
    '.png',
    '.m4a',
    '.mp3',
  ]) {
    if (lowerUrl.contains(ext)) return ext == '.jpeg' ? '.jpg' : ext;
  }
  return '';
}

/// Stable cache key so thumbnails and full-screen share the same disk entry
/// (signed URLs rotate; attachment id does not).
String chatAttachmentCacheKey(ChatAttachmentItem attachment) {
  if (attachment.id != null) return 'chat_att_${attachment.id}';
  final local = attachment.localFile?.path;
  if (local != null && local.isNotEmpty) return 'chat_local_$local';
  return resolveChatAttachmentUrl(attachment.url);
}

/// Chat image tile that:
/// - prefers [ChatAttachmentItem.localFile]
/// - loads signed network URLs with auth headers
/// - uses a stable [cacheKey] by attachment id (not the rotating signed URL)
/// - retries locally after scroll recycle instead of crashing to a placeholder
class ChatAttachmentImage extends StatefulWidget {
  final ChatAttachmentItem attachment;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final VoidCallback? onExpired;

  const ChatAttachmentImage({
    super.key,
    required this.attachment,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.onExpired,
  });

  @override
  State<ChatAttachmentImage> createState() => _ChatAttachmentImageState();
}

class _ChatAttachmentImageState extends State<ChatAttachmentImage> {
  int _retry = 0;
  bool _askedRefresh = false;
  Map<String, String>? _headers;
  bool _headersReady = false;

  String get _cacheKey => chatAttachmentCacheKey(widget.attachment);

  @override
  void initState() {
    super.initState();
    unawaited(_loadHeaders());
  }

  @override
  void didUpdateWidget(covariant ChatAttachmentImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.attachment.url != widget.attachment.url ||
        oldWidget.attachment.id != widget.attachment.id) {
      _retry = 0;
      _askedRefresh = false;
    }
  }

  Future<void> _loadHeaders() async {
    final headers = await chatProtectedFileHeaders();
    if (!mounted) return;
    setState(() {
      _headers = headers;
      _headersReady = true;
    });
  }

  Future<void> _retryAfterEvict() async {
    final key = _cacheKey;
    if (key.isEmpty) return;
    try {
      await CachedNetworkImage.evictFromCache(key);
    } catch (_) {}
    if (!mounted) return;
    setState(() => _retry++);
  }

  void _onNetworkError() {
    if (_retry < 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_retryAfterEvict());
      });
      return;
    }
    if (_askedRefresh) return;
    _askedRefresh = true;
    widget.onExpired?.call();
  }

  @override
  Widget build(BuildContext context) {
    return _clip(
      SizedBox(
        width: widget.width.isFinite ? widget.width : null,
        height: widget.height.isFinite ? widget.height : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth.isFinite && constraints.maxWidth > 0
                ? constraints.maxWidth
                : (widget.width.isFinite ? widget.width : 220.0);
            final h =
                constraints.maxHeight.isFinite && constraints.maxHeight > 0
                    ? constraints.maxHeight
                    : (widget.height.isFinite ? widget.height : 200.0);
            // Chat tiles always cover; full-screen uses PhotoView separately.
            const fit = BoxFit.cover;
            final local = widget.attachment.localFile;
            if (local != null) {
              return Image.file(
                local,
                width: w,
                height: h,
                fit: fit,
                alignment: Alignment.center,
                gaplessPlayback: true,
                filterQuality: FilterQuality.medium,
                errorBuilder: (_, __, ___) => _networkOrPlaceholder(w, h),
              );
            }
            return _networkOrPlaceholder(w, h);
          },
        ),
      ),
    );
  }

  Widget _networkOrPlaceholder(double w, double h) {
    final resolved = resolveChatAttachmentUrl(widget.attachment.url);
    if (resolved.isEmpty) return _placeholder(w, h);

    // Wait for Bearer token before the first request — otherwise the cache
    // may store a 401/403 response under the stable attachment cacheKey.
    if (!_headersReady) return _loading(w, h);

    final cacheKey = _cacheKey.isEmpty ? resolved : _cacheKey;
    final dpr = MediaQuery.maybeDevicePixelRatioOf(context) ?? 2.0;
    final memW = (w * dpr).round().clamp(80, 900);
    return CachedNetworkImage(
      key: ValueKey('$_cacheKey-$_retry'),
      imageUrl: resolved,
      cacheKey: cacheKey,
      httpHeaders: _headers,
      width: w,
      height: h,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      useOldImageOnUrlChange: true,
      memCacheWidth: memW,
      // Paint via DecorationImage so cover always fills (OctoImage fit was
      // letterboxing tall chat screenshots).
      imageBuilder: (context, imageProvider) {
        return SizedBox(
          width: w,
          height: h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        );
      },
      placeholder: (_, __) => _loading(w, h),
      errorWidget: (_, url, __) {
        _onNetworkError();
        if (url.isNotEmpty) {
          unawaited(CachedNetworkImage.evictFromCache(url));
        }
        return _retry < 2 ? _loading(w, h) : _placeholder(w, h);
      },
      errorListener: (_) {},
    );
  }

  Widget _clip(Widget child) {
    final radius = widget.borderRadius;
    if (radius == null) return child;
    return ClipRRect(borderRadius: radius, child: child);
  }

  Widget _loading(double w, double h) {
    return SizedBox(
      width: w,
      height: h,
      child: ColoredBox(
        color: Colors.black.withOpacity(0.08),
        child: Center(
          child: SizedBox(
            width: 22.r,
            height: 22.r,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }

  Widget _placeholder(double w, double h) {
    return SizedBox(
      width: w,
      height: h,
      child: ColoredBox(
        color: Colors.grey.withOpacity(0.2),
        child: Center(
          child: Icon(Icons.image_rounded, size: 32.sp, color: Colors.grey),
        ),
      ),
    );
  }
}

/// Avatar / thumbnail for chat conversation images that require Bearer auth.
///
/// Group (and some peer) photos are served from `/api/v3/chat/files/...` and
/// return 401 without `Authorization: Bearer <token>`.
class ChatAuthCachedImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ChatAuthCachedImage({
    super.key,
    required this.imageUrl,
    required this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<ChatAuthCachedImage> createState() => _ChatAuthCachedImageState();
}

class _ChatAuthCachedImageState extends State<ChatAuthCachedImage> {
  Map<String, String>? _headers;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    // Reuse warmed Bearer headers so opening More / reopening a sheet does not
    // flash a spinner while awaiting SharedPreferences again.
    final cached = chatProtectedFileHeadersIfCached(accept: '*/*');
    if (cached != null) {
      _headers = cached;
      _ready = true;
    }
    _loadHeaders();
  }

  @override
  void didUpdateWidget(covariant ChatAuthCachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      final cached = chatProtectedFileHeadersIfCached(accept: '*/*');
      _headers = cached;
      _ready = cached != null;
      _loadHeaders();
    }
  }

  Future<void> _loadHeaders() async {
    final headers = await chatProtectedFileHeaders(accept: '*/*');
    if (!mounted) return;
    if (_ready &&
        _headers?['Authorization'] == headers['Authorization'] &&
        _headers?['Accept'] == headers['Accept']) {
      return;
    }
    setState(() {
      _headers = headers;
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final resolved = resolveChatAttachmentUrl(widget.imageUrl);
    if (resolved.isEmpty) {
      return widget.errorWidget ??
          SizedBox(width: widget.width, height: widget.height);
    }

    final loading = widget.placeholder ??
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: Center(
            child: SizedBox(
              width: 16.r,
              height: 16.r,
              child: const CircularProgressIndicator(strokeWidth: 1.6),
            ),
          ),
        );

    if (!_ready || _headers == null) return loading;

    final memW = widget.width.isFinite
        ? (widget.width * MediaQuery.devicePixelRatioOf(context))
            .round()
            .clamp(48, 160)
        : 96;
    final memH = widget.height != null && widget.height!.isFinite
        ? (widget.height! * MediaQuery.devicePixelRatioOf(context))
            .round()
            .clamp(48, 160)
        : memW;

    return CachedNetworkImage(
      imageUrl: resolved,
      cacheKey: 'chat-auth:${resolved.hashCode}',
      httpHeaders: _headers,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      memCacheWidth: memW,
      memCacheHeight: memH,
      placeholder: (_, __) => loading,
      errorWidget: (_, __, ___) =>
          widget.errorWidget ??
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: Icon(
              Icons.broken_image_outlined,
              size: 18.sp,
              color: Colors.grey,
            ),
          ),
    );
  }
}
