import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:http/http.dart' as http;

import '../../../../exports.dart';

/// Shared OG metadata cache for chat link previews.
final Map<String, ChatLinkMeta?> chatLinkMetaCache = {};

/// WhatsApp-like UA — sites like Facebook only emit full OG tags for crawlers.
const _kPreviewUserAgent = 'WhatsApp/2.21.12.21 A';
const _kBrowserUserAgent =
    'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1';

const _kImageHeaders = <String, String>{
  'User-Agent': _kBrowserUserAgent,
  'Accept': 'image/avif,image/webp,image/apng,image/*,*/*;q=0.8',
};

final RegExp chatUrlRegExp = RegExp(
  r'''https?://[^\s<>\[\]\(\)\{\}"']+''',
  caseSensitive: false,
);

String? firstChatUrl(String text) {
  final match = chatUrlRegExp.firstMatch(text.trim());
  if (match == null) return null;
  var url = match.group(0)!;
  while (url.isNotEmpty && '.,;:!?)]}>"\''.contains(url[url.length - 1])) {
    url = url.substring(0, url.length - 1);
  }
  return url.isEmpty ? null : url;
}

bool isChatUrlOnlyMessage(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return false;
  final url = firstChatUrl(trimmed);
  if (url == null) return false;
  return trimmed == url ||
      trimmed.replaceAll(RegExp(r'\s+'), '') == url;
}

/// Caption shown under a link preview — drops the previewed URL and collapses
/// blank lines left by "url + newline + hello" so the bubble matches WhatsApp.
String chatCaptionWithoutPreviewUrl(String text, {String? previewUrl}) {
  final url = (previewUrl ?? firstChatUrl(text))?.trim();
  if (url == null || url.isEmpty) return text.trim();

  var out = text;
  final idx = out.indexOf(url);
  if (idx >= 0) {
    out = out.substring(0, idx) + out.substring(idx + url.length);
  } else {
    out = out.replaceFirst(chatUrlRegExp, '');
  }

  // "url\nhello" / "url\n\nhello" → "hello" (keep intentional mid-caption breaks).
  out = out.replaceAll(RegExp(r'[ \t]*\n[ \t]*'), '\n');
  out = out.replaceAll(RegExp(r'\n{2,}'), '\n');
  return out.trim();
}

String chatLinkHost(String url) {
  try {
    final host = Uri.parse(url).host;
    if (host.isEmpty) return url;
    return host.startsWith('www.') ? host.substring(4) : host;
  } catch (_) {
    return url;
  }
}

String _decodeHtmlEntities(String value) {
  return value
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAllMapped(RegExp(r'&#x([0-9a-fA-F]+);'), (m) {
        final code = int.tryParse(m.group(1)!, radix: 16);
        return code == null ? m.group(0)! : String.fromCharCode(code);
      })
      .replaceAllMapped(RegExp(r'&#(\d+);'), (m) {
        final code = int.tryParse(m.group(1)!);
        return code == null ? m.group(0)! : String.fromCharCode(code);
      });
}

String? _cleanText(String? raw) {
  if (raw == null) return null;
  final value = _decodeHtmlEntities(raw.trim());
  if (value.isEmpty || value.toLowerCase() == 'null') return null;
  return value;
}

String? _normalizeImageUrl(String? raw, String pageUrl) {
  final image = _cleanText(raw);
  if (image == null) return null;
  if (image.startsWith('http://') || image.startsWith('https://')) return image;
  if (image.startsWith('//')) return 'https:$image';
  final base = Uri.tryParse(pageUrl);
  if (base == null) return null;
  return base.resolve(image).toString();
}

Map<String, String> chatOgImageHeaders(String pageUrl) {
  final origin = Uri.tryParse(pageUrl)?.origin;
  return {
    ..._kImageHeaders,
    if (origin != null && origin.isNotEmpty) 'Referer': '$origin/',
  };
}

bool _isYouTubeHost(String host) {
  final h = host.toLowerCase();
  return h.contains('youtube.com') ||
      h.contains('youtu.be') ||
      h.contains('youtube-nocookie.com');
}

bool _isTikTokHost(String host) {
  final h = host.toLowerCase();
  return h.contains('tiktok.com') || h.contains('tiktokv.com');
}

bool _isInstagramHost(String host) => host.toLowerCase().contains('instagram.com');

bool _isXHost(String host) {
  final h = host.toLowerCase();
  return h == 'x.com' || h.contains('twitter.com') || h.contains('t.co');
}

String? extractYouTubeVideoId(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return null;
  final host = uri.host.toLowerCase();
  if (!_isYouTubeHost(host)) return null;

  if (host.contains('youtu.be')) {
    final id = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    return (id != null && id.isNotEmpty) ? id : null;
  }

  final v = uri.queryParameters['v'];
  if (v != null && v.isNotEmpty) return v;

  final segments = uri.pathSegments;
  for (var i = 0; i < segments.length - 1; i++) {
    if (segments[i] == 'shorts' ||
        segments[i] == 'embed' ||
        segments[i] == 'live' ||
        segments[i] == 'v') {
      final id = segments[i + 1];
      if (id.isNotEmpty) return id;
    }
  }
  return null;
}

String youtubeThumbnailUrl(String videoId) =>
    'https://i.ytimg.com/vi/$videoId/hqdefault.jpg';

String? extractTikTokVideoId(String url) {
  final match = RegExp(r'/video/(\d+)').firstMatch(url);
  return match?.group(1);
}

String? extractGoogleDriveFileId(String url) {
  final match =
      RegExp(r'/d/([a-zA-Z0-9_-]+)|[?&]id=([a-zA-Z0-9_-]+)').firstMatch(url);
  return match?.group(1) ?? match?.group(2);
}

class ChatLinkMeta {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteLabel;

  const ChatLinkMeta({
    this.title,
    this.description,
    this.imageUrl,
    this.siteLabel,
  });

  bool get hasContent {
    final t = title?.trim() ?? '';
    final d = description?.trim() ?? '';
    return t.isNotEmpty || d.isNotEmpty || (imageUrl?.trim().isNotEmpty == true);
  }

  ChatLinkMeta merge(ChatLinkMeta? other) {
    if (other == null) return this;
    return ChatLinkMeta(
      title: _cleanText(title) ?? _cleanText(other.title),
      description: _cleanText(description) ?? _cleanText(other.description),
      imageUrl: _cleanText(imageUrl) ?? _cleanText(other.imageUrl),
      siteLabel: siteLabel ?? other.siteLabel,
    );
  }
}

ChatLinkMeta _fallbackMeta(String url) {
  final host = chatLinkHost(url);
  String site = host;
  if (_isYouTubeHost(host)) site = 'YouTube';
  if (_isTikTokHost(host)) site = 'TikTok';
  if (_isInstagramHost(host)) site = 'Instagram';
  if (_isXHost(host)) site = 'X';
  if (host.contains('facebook.com') || host.contains('fb.watch')) {
    site = 'Facebook';
  }
  return ChatLinkMeta(
    title: site,
    description: host,
    siteLabel: site,
  );
}

Future<ChatLinkMeta?> _fetchViaAnyLink(String url, String userAgent) async {
  try {
    final raw = await AnyLinkPreview.getMetadata(
      link: url,
      cache: Duration.zero,
      userAgent: userAgent,
    );
    if (raw == null) return null;
    return ChatLinkMeta(
      title: _cleanText(raw.title),
      description: _cleanText(raw.desc),
      imageUrl: _normalizeImageUrl(raw.image, url),
      siteLabel: _cleanText(raw.siteName),
    );
  } catch (_) {
    return null;
  }
}

Future<ChatLinkMeta?> _fetchTikTokOEmbed(String url) async {
  try {
    final endpoint = Uri.parse(
      'https://www.tiktok.com/oembed?url=${Uri.encodeComponent(url)}',
    );
    final res = await http
        .get(endpoint, headers: {'User-Agent': _kBrowserUserAgent})
        .timeout(const Duration(seconds: 8));
    if (res.statusCode != 200) return null;
    final json = jsonDecode(res.body);
    if (json is! Map) return null;
    final title = _cleanText(json['title']?.toString());
    final author = _cleanText(json['author_name']?.toString());
    final thumb = _normalizeImageUrl(json['thumbnail_url']?.toString(), url);
    return ChatLinkMeta(
      title: title ?? 'TikTok',
      description: author != null ? '@$author on TikTok' : 'Watch on TikTok',
      imageUrl: thumb,
      siteLabel: 'TikTok',
    );
  } catch (_) {
    return null;
  }
}

Future<ChatLinkMeta?> _fetchYouTubeOEmbed(String url) async {
  try {
    final endpoint = Uri.parse(
      'https://www.youtube.com/oembed?url=${Uri.encodeComponent(url)}&format=json',
    );
    final res = await http
        .get(endpoint, headers: {'User-Agent': _kBrowserUserAgent})
        .timeout(const Duration(seconds: 8));
    if (res.statusCode != 200) return null;
    final json = jsonDecode(res.body);
    if (json is! Map) return null;
    final title = _cleanText(json['title']?.toString());
    final author = _cleanText(json['author_name']?.toString());
    final thumb = _normalizeImageUrl(json['thumbnail_url']?.toString(), url);
    return ChatLinkMeta(
      title: title ?? 'YouTube',
      description: author != null ? author : 'Watch on YouTube',
      imageUrl: thumb,
      siteLabel: 'YouTube',
    );
  } catch (_) {
    return null;
  }
}

Future<ChatLinkMeta?> fetchChatLinkMeta(String url) async {
  // Return any cached meta (including no-image) so list recycle doesn't refetch.
  if (chatLinkMetaCache.containsKey(url)) {
    return chatLinkMetaCache[url];
  }

  final host = chatLinkHost(url).toLowerCase();
  ChatLinkMeta? meta;

  // --- YouTube ---
  final ytId = extractYouTubeVideoId(url);
  if (ytId != null || _isYouTubeHost(host)) {
    meta = await _fetchYouTubeOEmbed(url);
    meta ??= await _fetchViaAnyLink(url, _kPreviewUserAgent);
    final id = ytId ?? extractYouTubeVideoId(url);
    if (id != null) {
      meta = (meta ?? const ChatLinkMeta()).merge(
        ChatLinkMeta(
          title: meta?.title ?? 'YouTube',
          description: meta?.description ?? 'Watch on YouTube',
          imageUrl: youtubeThumbnailUrl(id),
          siteLabel: 'YouTube',
        ),
      );
    }
  }

  // --- TikTok ---
  else if (_isTikTokHost(host)) {
    meta = await _fetchTikTokOEmbed(url);
    meta ??= await _fetchViaAnyLink(url, _kBrowserUserAgent);
    meta ??= await _fetchViaAnyLink(url, _kPreviewUserAgent);
    final ttId = extractTikTokVideoId(url);
    if (meta?.imageUrl == null && ttId != null) {
      meta = (meta ?? const ChatLinkMeta()).merge(
        ChatLinkMeta(
          title: meta?.title ?? 'TikTok',
          description: meta?.description ?? 'Watch on TikTok',
          imageUrl: 'https://www.tiktok.com/api/img/?itemId=$ttId',
          siteLabel: 'TikTok',
        ),
      );
    }
  }

  // --- Google Drive ---
  else if (host.contains('drive.google.com') ||
      host.contains('docs.google.com')) {
    final fileId = extractGoogleDriveFileId(url);
    meta = await _fetchViaAnyLink(url, _kBrowserUserAgent);
    if (fileId != null) {
      meta = (meta ?? const ChatLinkMeta()).merge(
        ChatLinkMeta(
          title: meta?.title ?? 'Google Drive',
          description: meta?.description ?? 'Open file',
          imageUrl: 'https://drive.google.com/thumbnail?id=$fileId&sz=w1000',
          siteLabel: 'Google Drive',
        ),
      );
    }
  }

  // --- General sites (Facebook, Instagram, news, etc.) ---
  else {
    meta = await _fetchViaAnyLink(url, _kPreviewUserAgent);
    if (meta == null || meta.imageUrl == null || meta.title == null) {
      final retry = await _fetchViaAnyLink(url, _kBrowserUserAgent);
      meta = meta?.merge(retry) ?? retry;
    }
  }

  // Always provide at least host title so the card still renders.
  final resolved = (meta ?? const ChatLinkMeta())
      .merge(_fallbackMeta(url));
  chatLinkMetaCache[url] = resolved;
  return resolved;
}

Future<void> openChatLink(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// App logo used when OG image is missing in compact thumbs (composer / reply).
class ChatLinkAppLogoFallback extends StatelessWidget {
  final double size;
  final Color? background;

  const ChatLinkAppLogoFallback({
    super.key,
    this.size = 40,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    final logoSize = (size * 0.42).clamp(14.0, 28.0);
    return ColoredBox(
      color: background ?? Colors.black.withOpacity(0.06),
      child: Center(
        child: Image.asset(
          AppImages.appIcon,
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
          // Keep decode stable across list recycle.
          gaplessPlayback: true,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}

/// OG preview image with crawler-friendly headers.
/// Loading → quiet spinner. Failed → [errorFallback] (or empty).
class ChatOgNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String pageUrl;
  final double width;
  final double? height;
  final BoxFit fit;
  final Widget? errorFallback;
  final bool isDark;
  final VoidCallback? onError;

  const ChatOgNetworkImage({
    super.key,
    required this.imageUrl,
    required this.pageUrl,
    required this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorFallback,
    this.isDark = false,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.06);
    final loading = ColoredBox(
      color: bg,
      child: const Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
    final error = errorFallback ??
        ChatLinkAppLogoFallback(
          size: (height ?? width).clamp(24, 120),
          background: bg,
        );

    return CachedNetworkImage(
      imageUrl: imageUrl,
      httpHeaders: chatOgImageHeaders(pageUrl),
      width: width.isFinite ? width : null,
      height: height != null && height!.isFinite ? height : null,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 180),
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      memCacheWidth: width.isFinite ? (width * 2).round() : null,
      placeholder: (_, __) => loading,
      errorWidget: (context, url, _) {
        // Bad OG URLs (HTML/empty "png") throw Invalid image data — drop cache
        // and clear the cached meta thumb so we don't keep retrying.
        unawaited(CachedNetworkImage.evictFromCache(url));
        final cached = chatLinkMetaCache[pageUrl];
        if (cached != null && cached.imageUrl == url) {
          chatLinkMetaCache[pageUrl] = ChatLinkMeta(
            title: cached.title,
            description: cached.description,
            imageUrl: null,
            siteLabel: cached.siteLabel,
          );
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onError?.call();
        });
        return error;
      },
      errorListener: (_) {
        // Swallow codec noise; errorWidget already shows the fallback.
      },
    );
  }
}

/// Picks network thumb or compact app logo (composer / reply only).
class ChatLinkThumb extends StatelessWidget {
  final String pageUrl;
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isDark;
  final VoidCallback? onImageError;
  /// When false and there is no image, renders nothing (WhatsApp bubble style).
  final bool showLogoWhenMissing;

  const ChatLinkThumb({
    super.key,
    required this.pageUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.isDark = false,
    this.onImageError,
    this.showLogoWhenMissing = true,
  });

  @override
  Widget build(BuildContext context) {
    final logo = ChatLinkAppLogoFallback(
      size: height.clamp(28, 64),
      background: isDark
          ? Colors.white.withOpacity(0.08)
          : Colors.black.withOpacity(0.05),
    );
    final url = imageUrl?.trim();
    if (url == null || url.isEmpty) {
      return showLogoWhenMissing ? logo : const SizedBox.shrink();
    }
    return ChatOgNetworkImage(
      imageUrl: url,
      pageUrl: pageUrl,
      width: width,
      height: height,
      fit: fit,
      isDark: isDark,
      errorFallback: showLogoWhenMissing ? logo : const SizedBox.shrink(),
      onError: onImageError,
    );
  }
}

/// WhatsApp-style compact preview above the composer.
class ChatLinkComposerPreview extends StatelessWidget {
  final String url;
  final ChatLinkMeta? meta;
  final bool loading;
  final bool isDark;
  final VoidCallback onDismiss;
  final VoidCallback? onTap;

  const ChatLinkComposerPreview({
    super.key,
    required this.url,
    required this.meta,
    required this.loading,
    required this.isDark,
    required this.onDismiss,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final host = chatLinkHost(url);
    final title = (meta?.title?.trim().isNotEmpty == true)
        ? meta!.title!.trim()
        : host;
    final thumb = meta?.imageUrl;
    final bg = isDark ? const Color(0xFF1F2C34) : const Color(0xFFF0F2F5);
    final titleColor = isDark ? Colors.white : const Color(0xFF111B21);
    final hostColor = isDark ? const Color(0xFF8696A0) : const Color(0xFF667781);

    return Material(
      color: bg,
      child: InkWell(
        onTap: onTap ?? () => openChatLink(url),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 8.w, 10.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: SizedBox(
                  width: 48.r,
                  height: 48.r,
                  child: loading
                      ? ColoredBox(
                          color: isDark
                              ? Colors.white.withOpacity(0.06)
                              : Colors.black.withOpacity(0.05),
                          child: const Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        )
                      : ChatLinkThumb(
                          pageUrl: url,
                          imageUrl: thumb,
                          width: 48.r,
                          height: 48.r,
                          isDark: isDark,
                        ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      host,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hostColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDismiss,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.close_rounded,
                  size: 20.sp,
                  color: hostColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// WhatsApp-style rich preview inside a chat bubble.
class ChatLinkBubblePreview extends StatefulWidget {
  final String url;
  final bool isOutgoing;
  final bool isDark;
  /// When true, image + meta span the full bubble width (no inset card).
  final bool edgeToEdge;
  /// Caps OG image height (e.g. long-press overlay) so the bubble fits.
  final double? maxImageHeight;

  const ChatLinkBubblePreview({
    super.key,
    required this.url,
    required this.isOutgoing,
    required this.isDark,
    this.edgeToEdge = true,
    this.maxImageHeight,
  });

  @override
  State<ChatLinkBubblePreview> createState() => _ChatLinkBubblePreviewState();
}

class _ChatLinkBubblePreviewState extends State<ChatLinkBubblePreview> {
  ChatLinkMeta? _meta;
  bool _loading = true;
  bool _imageFailed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant ChatLinkBubblePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _imageFailed = false;
      _load();
    }
  }

  Future<void> _load() async {
    final cached = chatLinkMetaCache[widget.url];
    if (cached != null) {
      if (!mounted) return;
      setState(() {
        _meta = cached;
        _loading = false;
        _imageFailed = false;
      });
      return;
    }

    setState(() => _loading = true);
    final meta = await fetchChatLinkMeta(widget.url);
    if (!mounted) return;
    setState(() {
      _meta = meta;
      _loading = false;
      _imageFailed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final host = chatLinkHost(widget.url);
    final title = (_meta?.title?.trim().isNotEmpty == true)
        ? _meta!.title!.trim()
        : host;
    final description = _meta?.description?.trim();
    final image = _meta?.imageUrl?.trim();
    final hasImage =
        !_imageFailed && image != null && image.isNotEmpty;
    final isOut = widget.isOutgoing;
    final edge = widget.edgeToEdge;

    final metaBg = isOut
        ? Colors.black.withOpacity(widget.isDark ? 0.18 : 0.10)
        : (widget.isDark
            ? Colors.white.withOpacity(0.06)
            : Colors.black.withOpacity(0.04));
    final titleColor = isOut
        ? Colors.white
        : (widget.isDark ? AppColors.darkTitle : AppColors.title);
    final descColor = isOut
        ? Colors.white.withOpacity(0.78)
        : (widget.isDark
            ? AppColors.darkDescription
            : Colors.grey.shade600);
    final hostColor = isOut
        ? Colors.white.withOpacity(0.65)
        : (widget.isDark
            ? const Color(0xFF8696A0)
            : const Color(0xFF667781));

    // WhatsApp-style: no image → compact title / description / host only.
    final metaBlock = ColoredBox(
      color: metaBg,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
        child: _loading
            ? SizedBox(
                height: 36.h,
                child: const Center(
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                  if (description != null && description.isNotEmpty) ...[
                    SizedBox(height: 3.h),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: descColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                  ],
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.link_rounded,
                        size: 13.sp,
                        color: hostColor,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          host,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: hostColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );

    final children = <Widget>[
      if (hasImage)
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final aspect = edge ? 5 / 4 : 16 / 9;
            var height = width / aspect;
            final cap = widget.maxImageHeight;
            if (cap != null && cap.isFinite && height > cap) {
              height = cap;
            }
            return SizedBox(
              width: width,
              height: height,
              child: ChatLinkThumb(
                pageUrl: widget.url,
                imageUrl: image,
                width: width,
                height: height,
                isDark: widget.isDark || isOut,
                showLogoWhenMissing: false,
                onImageError: () {
                  if (!mounted || _imageFailed) return;
                  setState(() => _imageFailed = true);
                },
              ),
            );
          },
        ),
      metaBlock,
    ];

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    return GestureDetector(
      onTap: () => openChatLink(widget.url),
      behavior: HitTestBehavior.opaque,
      child: edge
          ? column
          : ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: column,
            ),
    );
  }
}

/// Small square thumb for reply chrome: attachment image, else link OG image.
class ChatReplyMediaThumb extends StatefulWidget {
  final ChatAttachmentItem? imageAttachment;
  final String messageText;
  final double size;
  final bool isDark;

  const ChatReplyMediaThumb({
    super.key,
    required this.messageText,
    required this.size,
    required this.isDark,
    this.imageAttachment,
  });

  @override
  State<ChatReplyMediaThumb> createState() => _ChatReplyMediaThumbState();
}

class _ChatReplyMediaThumbState extends State<ChatReplyMediaThumb> {
  String? _pageUrl;
  String? _imageUrl;
  bool _resolved = false;

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  @override
  void didUpdateWidget(covariant ChatReplyMediaThumb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageAttachment != widget.imageAttachment ||
        oldWidget.messageText != widget.messageText) {
      _resolved = false;
      _pageUrl = null;
      _imageUrl = null;
      _resolve();
    }
  }

  Future<void> _resolve() async {
    if (widget.imageAttachment != null) {
      if (mounted) setState(() => _resolved = true);
      return;
    }
    final url = firstChatUrl(widget.messageText);
    if (url == null) {
      if (mounted) setState(() => _resolved = true);
      return;
    }
    final cached = chatLinkMetaCache[url]?.imageUrl?.trim();
    if (cached != null && cached.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        _pageUrl = url;
        _imageUrl = cached;
        _resolved = true;
      });
      return;
    }
    final meta = await fetchChatLinkMeta(url);
    if (!mounted) return;
    final image = meta?.imageUrl?.trim();
    setState(() {
      _pageUrl = url;
      _imageUrl = (image != null && image.isNotEmpty) ? image : null;
      _resolved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final attachment = widget.imageAttachment;
    if (attachment != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: ChatAttachmentImage(
          attachment: attachment,
          width: widget.size.w,
          height: widget.size.w,
          fit: BoxFit.cover,
        ),
      );
    }

    final pageUrl = _pageUrl;
    final imageUrl = _imageUrl;
    if (!_resolved || pageUrl == null || imageUrl == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: ChatLinkThumb(
        pageUrl: pageUrl,
        imageUrl: imageUrl,
        width: widget.size.w,
        height: widget.size.w,
        fit: BoxFit.cover,
        isDark: widget.isDark,
      ),
    );
  }
}
