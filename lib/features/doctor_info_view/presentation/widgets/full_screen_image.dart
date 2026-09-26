import 'dart:io';
import 'dart:ui';

import 'package:egy_akin/exports.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';

class FullScreenImage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final bool isLocal;
  final String? heroTagBase;
  final Map<String, String>? httpHeaders;
  /// Parallel to [imageUrls]; when set, reuses CachedNetworkImage disk cache.
  final List<String?>? cacheKeys;

  const FullScreenImage({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.isLocal = false,
    this.heroTagBase,
    this.httpHeaders,
    this.cacheKeys,
  });

  /// Opens a single image, or a gallery when [imageUrls] is provided.
  /// [initialIndex] is used so tapping image N opens that image first,
  /// while still allowing swipe through the full ordered list.
  static Route<void> route({
    String? imageUrl,
    List<String>? imageUrls,
    int initialIndex = 0,
    bool isLocal = false,
    String? heroTagBase,
    Map<String, String>? httpHeaders,
    List<String?>? cacheKeys,
  }) {
    final rawUrls =
        imageUrls ?? (imageUrl != null ? [imageUrl] : const <String>[]);
    final tappedUrl = (initialIndex >= 0 && initialIndex < rawUrls.length)
        ? rawUrls[initialIndex].trim()
        : '';

    final urls = rawUrls
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList(growable: false);

    var startIndex = 0;
    if (urls.isNotEmpty) {
      final matched = tappedUrl.isEmpty ? -1 : urls.indexOf(tappedUrl);
      startIndex =
          matched >= 0 ? matched : initialIndex.clamp(0, urls.length - 1);
    }

    return PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, __, ___) => FullScreenImage(
        imageUrls: urls,
        initialIndex: startIndex,
        isLocal: isLocal,
        heroTagBase: heroTagBase,
        httpHeaders: httpHeaders,
        cacheKeys: cacheKeys,
      ),
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with SingleTickerProviderStateMixin {
  static const _dismissDistance = 140.0;
  static const _dismissVelocity = 800.0;

  final GlobalKey _shareButtonKey = GlobalKey();

  late final PageController _pageController;
  late int _currentIndex;

  Offset _drag = Offset.zero;
  int _pointers = 0;
  Offset _lastMoveDelta = Offset.zero;
  Duration _moveDt = const Duration(milliseconds: 16);
  Duration? _prevMoveStamp;
  bool _closing = false;
  bool _horizontalGesture = false;
  bool _busy = false;
  PhotoViewScaleState _scaleState = PhotoViewScaleState.initial;
  late final AnimationController _snap;
  Animation<Offset>? _snapAnim;

  bool get _zoomed =>
      _scaleState == PhotoViewScaleState.covering ||
      _scaleState == PhotoViewScaleState.zoomedIn;

  bool get _canDismiss => !_zoomed && !_closing;

  bool get _isGallery => widget.imageUrls.length > 1;

  ImageProvider _providerFor(String url, {String? cacheKey}) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return CachedNetworkImageProvider(
        url,
        cacheKey: cacheKey,
        headers: widget.httpHeaders,
      );
    }
    // Chat previews pass absolute file paths; assets stay as AssetImage.
    if (widget.isLocal || url.startsWith('/')) {
      return FileImage(File(url));
    }
    return AssetImage(url);
  }

  String? _cacheKeyAt(int index) {
    final keys = widget.cacheKeys;
    if (keys == null || index < 0 || index >= keys.length) return null;
    final key = keys[index]?.trim();
    return (key == null || key.isEmpty) ? null : key;
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _snap = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
  }

  @override
  void dispose() {
    _snap.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPointerUp() {
    _pointers = (_pointers - 1).clamp(0, 10);
    if (_pointers != 0) return;

    final wasHorizontal = _horizontalGesture;
    _horizontalGesture = false;

    if (!_canDismiss || wasHorizontal) {
      if (_drag != Offset.zero) _snapBack();
      _lastMoveDelta = Offset.zero;
      return;
    }

    final dtMs = _moveDt.inMilliseconds.clamp(8, 40);
    final velocity = _lastMoveDelta.dy.abs() / (dtMs / 1000);

    if (_drag.dy.abs() > _dismissDistance || velocity > _dismissVelocity) {
      _close();
      return;
    }
    if (_drag != Offset.zero) _snapBack();
    _lastMoveDelta = Offset.zero;
  }

  void _snapBack() {
    _snapAnim?.removeListener(_onSnap);
    _snap
      ..stop()
      ..reset();
    _snapAnim = Tween<Offset>(begin: _drag, end: Offset.zero).animate(
      CurvedAnimation(parent: _snap, curve: Curves.easeOutCubic),
    )..addListener(_onSnap);
    _snap.forward();
  }

  void _onSnap() {
    final value = _snapAnim?.value ?? Offset.zero;
    if (mounted) setState(() => _drag = value);
  }

  void _close() {
    if (_closing || !mounted) return;
    _closing = true;
    Navigator.of(context).pop();
  }

  Rect? _shareOrigin() {
    final box =
        _shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    final offset = box.localToGlobal(Offset.zero);
    return offset & box.size;
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<File?> _fileForCurrent() async {
    if (widget.imageUrls.isEmpty) return null;
    final url = widget.imageUrls[_currentIndex];

    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      final file = File(url);
      return await file.exists() ? file : null;
    }

    final res = await http.get(
      Uri.parse(url),
      headers: widget.httpHeaders,
    );
    if (res.statusCode < 200 || res.statusCode >= 300) return null;

    final dir = await getTemporaryDirectory();
    final lower = url.toLowerCase();
    final ext = lower.contains('.png')
        ? 'png'
        : lower.contains('.webp')
            ? 'webp'
            : lower.contains('.gif')
                ? 'gif'
                : 'jpg';
    final file = File(
      '${dir.path}/egyakin_media_${DateTime.now().millisecondsSinceEpoch}.$ext',
    );
    await file.writeAsBytes(res.bodyBytes);
    return file;
  }

  Future<void> _showActions() async {
    if (_busy || widget.imageUrls.isEmpty) return;
    final url = widget.imageUrls[_currentIndex];
    final cacheKey = _cacheKeyAt(_currentIndex);
    final countLabel = _isGallery
        ? '${_currentIndex + 1} / ${widget.imageUrls.length}'
        : null;

    final action = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
      isScrollControlled: true,
      builder: (ctx) {
        return _MediaActionsSheet(
          imageUrl: url,
          isLocal: widget.isLocal,
          httpHeaders: widget.httpHeaders,
          cacheKey: cacheKey,
          countLabel: countLabel,
          onSave: () => Navigator.pop(ctx, 'save'),
          onShare: () => Navigator.pop(ctx, 'share'),
          onCancel: () => Navigator.pop(ctx),
        );
      },
    );
    if (!mounted || action == null) return;
    if (action == 'save') {
      await _saveCurrent();
    } else if (action == 'share') {
      await _shareCurrent();
    }
  }

  Future<void> _saveCurrent() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final file = await _fileForCurrent();
      if (!mounted) return;
      if (file == null) {
        _toast(context.tr(AppStrings.failedToSaveImage));
        return;
      }
      final hasAccess = await Gal.hasAccess();
      if (!mounted) return;
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!mounted) return;
        if (!granted) {
          _toast(context.tr(AppStrings.failedToSaveImage));
          return;
        }
      }
      await Gal.putImage(file.path);
      if (!mounted) return;
      _toast(context.tr(AppStrings.imageSaved));
    } on GalException catch (_) {
      if (mounted) _toast(context.tr(AppStrings.failedToSaveImage));
    } catch (_) {
      if (mounted) _toast(context.tr(AppStrings.failedToSaveImage));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _shareCurrent() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final file = await _fileForCurrent();
      if (!mounted) return;
      if (file == null) {
        _toast(context.tr(AppStrings.failedToShare));
        return;
      }
      // iOS requires a non-zero origin or the share sheet may not appear.
      final origin = _shareOrigin() ??
          Rect.fromCenter(
            center: Offset(
              MediaQuery.sizeOf(context).width / 2,
              MediaQuery.paddingOf(context).top + 40,
            ),
            width: 1,
            height: 1,
          );
      await Share.shareXFiles(
        [XFile(file.path)],
        sharePositionOrigin: origin,
      );
    } catch (_) {
      if (mounted) _toast(context.tr(AppStrings.failedToShare));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final progress = (_drag.dy.abs() / size.height).clamp(0.0, 1.0);
    final bgOpacity = (1 - progress * 1.15).clamp(0.0, 1.0);
    final scale = (1 - progress * 0.28).clamp(0.72, 1.0);
    final urls = widget.imageUrls;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Listener(
          onPointerDown: (_) {
            _pointers++;
            _prevMoveStamp = null;
            _horizontalGesture = false;
          },
          onPointerCancel: (_) => _onPointerUp(),
          onPointerUp: (_) => _onPointerUp(),
          onPointerMove: (event) {
            if (!_canDismiss || _pointers != 1) return;

            // Gallery: let mostly-horizontal moves change pages, not dismiss.
            if (_isGallery &&
                _drag == Offset.zero &&
                event.delta.dx.abs() > event.delta.dy.abs()) {
              _horizontalGesture = true;
              return;
            }
            if (_horizontalGesture) return;

            _snap.stop();
            if (_prevMoveStamp != null) {
              _moveDt = event.timeStamp - _prevMoveStamp!;
            }
            _prevMoveStamp = event.timeStamp;
            _lastMoveDelta = event.delta;
            // Vertical-only dismiss so it doesn't fight gallery paging.
            setState(() => _drag += Offset(0, event.delta.dy));
          },
          child: GestureDetector(
            onTap: _canDismiss ? _close : null,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(
                  color: Colors.black.withOpacity(bgOpacity),
                ),
                Transform.translate(
                  offset: _drag,
                  child: Transform.scale(
                    scale: scale,
                    child: urls.isEmpty
                        ? const SizedBox.shrink()
                        : PhotoViewGallery.builder(
                            pageController: _pageController,
                            itemCount: urls.length,
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                                _scaleState = PhotoViewScaleState.initial;
                              });
                            },
                            scaleStateChangedCallback: (state) {
                              setState(() => _scaleState = state);
                            },
                            builder: (context, index) {
                              final heroBase = widget.heroTagBase;
                              return PhotoViewGalleryPageOptions(
                                imageProvider: _providerFor(
                                  urls[index],
                                  cacheKey: _cacheKeyAt(index),
                                ),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 3,
                                initialScale: PhotoViewComputedScale.contained,
                                heroAttributes: heroBase == null
                                    ? null
                                    : PhotoViewHeroAttributes(
                                        tag: '${heroBase}_${urls[index]}',
                                      ),
                                onTapUp: (_, __, ___) {
                                  if (_canDismiss) _close();
                                },
                              );
                            },
                          ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.paddingOf(context).top + 8,
                  left: 4,
                  child: Opacity(
                    opacity: bgOpacity,
                    child: IconButton(
                      key: _shareButtonKey,
                      icon: _busy
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.ios_share_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                      onPressed: _busy ? null : _showActions,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.paddingOf(context).top + 8,
                  right: 12,
                  child: Opacity(
                    opacity: bgOpacity,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: _close,
                    ),
                  ),
                ),
                if (_isGallery)
                  Positioned(
                    top: MediaQuery.paddingOf(context).top + 16,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: bgOpacity,
                      child: IgnorePointer(
                        child: Text(
                          '${_currentIndex + 1} / ${urls.length}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MediaActionsSheet extends StatelessWidget {
  final String imageUrl;
  final bool isLocal;
  final Map<String, String>? httpHeaders;
  final String? cacheKey;
  final String? countLabel;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onCancel;

  const _MediaActionsSheet({
    required this.imageUrl,
    required this.isLocal,
    required this.onSave,
    required this.onShare,
    required this.onCancel,
    this.httpHeaders,
    this.cacheKey,
    this.countLabel,
  });

  ImageProvider get _thumbProvider {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return CachedNetworkImageProvider(
        imageUrl,
        cacheKey: cacheKey,
        headers: httpHeaders,
      );
    }
    if (isLocal || imageUrl.startsWith('/')) {
      return FileImage(File(imageUrl));
    }
    return AssetImage(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(14, 0, 14, 10 + bottom),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2A2438).withOpacity(0.94),
                  const Color(0xFF16121F).withOpacity(0.96),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.14),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.25),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image(
                          image: _thumbProvider,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => ColoredBox(
                            color: Colors.white.withOpacity(0.08),
                            child: const Icon(
                              Icons.image_outlined,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr(AppStrings.photo),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              countLabel ??
                                  context.tr(AppStrings.saveImage),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.55),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _MediaActionCard(
                          icon: Icons.download_rounded,
                          label: context.tr(AppStrings.saveImage),
                          accent: AppColors.primary,
                          onTap: onSave,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MediaActionCard(
                          icon: Icons.ios_share_rounded,
                          label: context.tr(AppStrings.share),
                          accent: const Color(0xFF38BDF8),
                          onTap: onShare,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onCancel,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withOpacity(0.72),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.10),
                          ),
                        ),
                        backgroundColor: Colors.white.withOpacity(0.06),
                      ),
                      child: Text(
                        context.tr(AppStrings.cancel),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MediaActionCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color accent;
  final VoidCallback onTap;

  const _MediaActionCard({
    required this.icon,
    required this.label,
    required this.accent,
    required this.onTap,
  });

  @override
  State<_MediaActionCard> createState() => _MediaActionCardState();
}

class _MediaActionCardState extends State<_MediaActionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.accent.withOpacity(_pressed ? 0.28 : 0.20),
                widget.accent.withOpacity(_pressed ? 0.12 : 0.08),
              ],
            ),
            border: Border.all(
              color: widget.accent.withOpacity(0.35),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.accent.withOpacity(0.22),
                  boxShadow: [
                    BoxShadow(
                      color: widget.accent.withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 22),
              ),
              const SizedBox(height: 10),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
