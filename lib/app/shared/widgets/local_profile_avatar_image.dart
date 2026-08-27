import 'package:egy_akin/app/shared/functions/local_profile_image_helper.dart';
import 'package:egy_akin/app/shared/widgets/custom_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Local-first profile avatar with a calm old→new crossfade (no flicker).
class LocalProfileAvatarImage extends StatefulWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final int revision;
  final Widget? fallback;
  final BoxFit fit;

  const LocalProfileAvatarImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.revision = 0,
    this.fallback,
    this.fit = BoxFit.cover,
  });

  @override
  State<LocalProfileAvatarImage> createState() =>
      _LocalProfileAvatarImageState();
}

class _LocalProfileAvatarImageState extends State<LocalProfileAvatarImage>
    with SingleTickerProviderStateMixin {
  Uint8List? _fromBytes;
  Uint8List? _toBytes;
  String? _shownPath;
  bool _ready = false;
  int _loadGeneration = 0;

  late final AnimationController _controller;
  late final Animation<double> _t;

  /// Gentle duration — longer feels calmer than a snappy snap.
  static const _duration = Duration(milliseconds: 650);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _t = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    LocalProfileImageHelper.revision.addListener(_onLocalRevision);
    _loadLatest();
  }

  @override
  void dispose() {
    LocalProfileImageHelper.revision.removeListener(_onLocalRevision);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LocalProfileAvatarImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // URL-only; local file changes come from [LocalProfileImageHelper.revision].
    if (oldWidget.imageUrl != widget.imageUrl) {
      _loadLatest();
    }
  }

  void _onLocalRevision() => _loadLatest();

  Future<void> _loadLatest() async {
    final generation = ++_loadGeneration;
    final file = await LocalProfileImageHelper.resolve(widget.imageUrl);
    if (!mounted || generation != _loadGeneration) return;

    if (file == null) {
      if (!_ready) setState(() => _ready = true);
      return;
    }

    // Same file already on screen — do not restart animation.
    if (_shownPath == file.path && _fromBytes != null && _toBytes == null) {
      if (!_ready) setState(() => _ready = true);
      return;
    }

    final bytes = await file.readAsBytes();
    if (!mounted || generation != _loadGeneration || bytes.isEmpty) return;

    await _crossfadeTo(bytes, file.path, generation);
  }

  Future<void> _crossfadeTo(
    Uint8List bytes,
    String path,
    int generation,
  ) async {
    if (!mounted || generation != _loadGeneration) return;

    // First paint: no animation.
    if (_fromBytes == null) {
      setState(() {
        _fromBytes = bytes;
        _toBytes = null;
        _shownPath = path;
        _ready = true;
      });
      _controller.value = 0;
      return;
    }

    // Wait out any in-flight fade so we never interrupt mid-way.
    if (_controller.isAnimating) {
      try {
        await _controller.forward();
      } catch (_) {
        return;
      }
      if (!mounted || generation != _loadGeneration) return;
      _commitToAsFrom();
    }

    setState(() {
      _toBytes = bytes;
      _shownPath = path;
      _ready = true;
    });

    try {
      await _controller.forward(from: 0);
    } catch (_) {
      return;
    }
    if (!mounted || generation != _loadGeneration) return;
    _commitToAsFrom();
  }

  void _commitToAsFrom() {
    if (_toBytes == null) return;
    setState(() {
      _fromBytes = _toBytes;
      _toBytes = null;
    });
    _controller.value = 0;
  }

  int get _cacheWidth {
    final dpr = MediaQuery.maybeDevicePixelRatioOf(context) ?? 2.0;
    return (widget.width * dpr).round().clamp(64, 1024);
  }

  @override
  Widget build(BuildContext context) {
    final cacheWidth = _cacheWidth;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: RepaintBoundary(
        child: ClipOval(
          child: AnimatedBuilder(
            animation: _t,
            builder: (context, _) {
              final progress = _t.value;
              final hasTo = _toBytes != null;

              if (_fromBytes == null) {
                if (!_ready) {
                  return widget.fallback ?? const SizedBox.shrink();
                }
                return _networkOrFallback();
              }

              return Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: hasTo ? (1.0 - progress) : 1.0,
                    child: Image.memory(
                      _fromBytes!,
                      fit: widget.fit,
                      gaplessPlayback: true,
                      filterQuality: FilterQuality.medium,
                      cacheWidth: cacheWidth,
                    ),
                  ),
                  if (hasTo)
                    Opacity(
                      opacity: progress,
                      child: Image.memory(
                        _toBytes!,
                        fit: widget.fit,
                        gaplessPlayback: true,
                        filterQuality: FilterQuality.medium,
                        cacheWidth: cacheWidth,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _networkOrFallback() {
    final url = widget.imageUrl;
    if (url != null && url.isNotEmpty) {
      return CustomCachedNetworkImage(
        imageUrl: url,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    }
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: widget.fallback,
    );
  }
}
