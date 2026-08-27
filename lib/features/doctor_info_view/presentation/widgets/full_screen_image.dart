import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final bool isLocal;
  final String? heroTagBase;

  const FullScreenImage({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.isLocal = false,
    this.heroTagBase,
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

  late final PageController _pageController;
  late int _currentIndex;

  Offset _drag = Offset.zero;
  int _pointers = 0;
  Offset _lastMoveDelta = Offset.zero;
  Duration _moveDt = const Duration(milliseconds: 16);
  Duration? _prevMoveStamp;
  bool _closing = false;
  bool _horizontalGesture = false;
  PhotoViewScaleState _scaleState = PhotoViewScaleState.initial;
  late final AnimationController _snap;
  Animation<Offset>? _snapAnim;

  bool get _zoomed =>
      _scaleState == PhotoViewScaleState.covering ||
      _scaleState == PhotoViewScaleState.zoomedIn;

  bool get _canDismiss => !_zoomed && !_closing;

  bool get _isGallery => widget.imageUrls.length > 1;

  ImageProvider _providerFor(String url) {
    if (widget.isLocal) {
      return AssetImage(url);
    }
    return CachedNetworkImageProvider(url);
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
                                imageProvider: _providerFor(urls[index]),
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
