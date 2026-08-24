import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;
  final bool isLocal;

  const FullScreenImage({
    super.key,
    required this.imageUrl,
    this.isLocal = false,
  });

  static Route<void> route({
    required String imageUrl,
    bool isLocal = false,
  }) {
    return PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, __, ___) => FullScreenImage(
        imageUrl: imageUrl,
        isLocal: isLocal,
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

  Offset _drag = Offset.zero;
  int _pointers = 0;
  Offset _lastMoveDelta = Offset.zero;
  Duration _moveDt = const Duration(milliseconds: 16);
  Duration? _prevMoveStamp;
  bool _closing = false;
  PhotoViewScaleState _scaleState = PhotoViewScaleState.initial;
  late final AnimationController _snap;
  Animation<Offset>? _snapAnim;

  bool get _zoomed =>
      _scaleState == PhotoViewScaleState.covering ||
      _scaleState == PhotoViewScaleState.zoomedIn;

  bool get _canDismiss => !_zoomed && !_closing;

  ImageProvider get _provider {
    if (widget.isLocal) {
      return AssetImage(widget.imageUrl);
    }
    return CachedNetworkImageProvider(widget.imageUrl);
  }

  @override
  void initState() {
    super.initState();
    _snap = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
  }

  @override
  void dispose() {
    _snap.dispose();
    super.dispose();
  }

  void _onPointerUp() {
    _pointers = (_pointers - 1).clamp(0, 10);
    if (_pointers != 0 || !_canDismiss) return;

    final dtMs = _moveDt.inMilliseconds.clamp(8, 40);
    final velocity = _lastMoveDelta.distance / (dtMs / 1000);

    if (_drag.distance > _dismissDistance || velocity > _dismissVelocity) {
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
    final progress = (_drag.distance / size.height).clamp(0.0, 1.0);
    final bgOpacity = (1 - progress * 1.15).clamp(0.0, 1.0);
    final scale = (1 - progress * 0.28).clamp(0.72, 1.0);

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
          },
          onPointerCancel: (_) => _onPointerUp(),
          onPointerUp: (_) => _onPointerUp(),
          onPointerMove: (event) {
            if (!_canDismiss || _pointers != 1) return;
            _snap.stop();
            if (_prevMoveStamp != null) {
              _moveDt = event.timeStamp - _prevMoveStamp!;
            }
            _prevMoveStamp = event.timeStamp;
            _lastMoveDelta = event.delta;
            setState(() => _drag += event.delta);
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
                    child: PhotoView(
                      imageProvider: _provider,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 3,
                      initialScale: PhotoViewComputedScale.contained,
                      scaleStateChangedCallback: (state) {
                        setState(() => _scaleState = state);
                      },
                      onTapUp: (_, __, ___) {
                        if (_canDismiss) _close();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
