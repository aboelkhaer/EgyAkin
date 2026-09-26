import 'dart:math' as math;
import 'dart:ui';

import 'package:egy_akin/exports.dart';

/// Decorative chat wallpaper — soft gradient + medical doodle pattern.
class ChatRoomBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const ChatRoomBackground({
    super.key,
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: CustomPaint(
            painter: _ChatRoomBackgroundPainter(isDark: isDark),
          ),
        ),
        child,
      ],
    );
  }
}

/// Frosted bar surface so the chat wallpaper shows through header/footer.
class ChatRoomGlassSurface extends StatefulWidget {
  final bool isDark;
  final Widget child;
  final BoxBorder? border;

  const ChatRoomGlassSurface({
    super.key,
    required this.isDark,
    required this.child,
    this.border,
  });

  static Color glassColor(bool isDark) => isDark
      ? AppColors.darkCardBG.withOpacity(0.94)
      : Colors.white.withOpacity(0.94);

  /// Opaque fill for the home-indicator strip under the composer — same as
  /// the composer chrome so the bottom doesn't look like a mismatched gap.
  static Color solidBarColor(bool isDark) =>
      isDark ? AppColors.darkCardBG : Colors.white;

  static Color fieldGlassColor(bool isDark) => isDark
      ? AppColors.darkCardBG.withOpacity(0.72)
      : Colors.white.withOpacity(0.72);

  @override
  State<ChatRoomGlassSurface> createState() => _ChatRoomGlassSurfaceState();
}

class _ChatRoomGlassSurfaceState extends State<ChatRoomGlassSurface> {
  /// BackdropFilter on the first frame after a push-tap resume can native-crash
  /// Metal/Impeller on device. Paint opaque glass first, then enable blur.
  bool _blurReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _blurReady = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: ChatRoomGlassSurface.glassColor(widget.isDark),
        border: widget.border,
      ),
      child: widget.child,
    );
    if (!_blurReady) {
      return ClipRect(child: content);
    }
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: content,
      ),
    );
  }
}

class _ChatRoomBackgroundPainter extends CustomPainter {
  _ChatRoomBackgroundPainter({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    _paintBaseGradient(canvas, size);
    _paintGlows(canvas, size);
    _paintDotGrid(canvas, size);
    _paintDoodles(canvas, size);
  }

  void _paintBaseGradient(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = isDark
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF15111F),
              Color(0xFF0E1218),
              Color(0xFF101820),
            ],
            stops: [0.0, 0.55, 1.0],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEDE7FF),
              Color(0xFFF4F0FF),
              Color(0xFFEEF6FF),
            ],
            stops: [0.0, 0.5, 1.0],
          );
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  void _paintGlows(Canvas canvas, Size size) {
    final primary = isDark ? AppColors.darkPrimary : AppColors.primary;

    _radialGlow(
      canvas,
      center: Offset(size.width * 0.88, size.height * 0.08),
      radius: size.width * 0.55,
      color: primary.withOpacity(isDark ? 0.18 : 0.14),
    );
    _radialGlow(
      canvas,
      center: Offset(size.width * 0.12, size.height * 0.72),
      radius: size.width * 0.48,
      color: const Color(0xFF14B8A6).withOpacity(isDark ? 0.10 : 0.08),
    );
    _radialGlow(
      canvas,
      center: Offset(size.width * 0.5, size.height * 0.45),
      radius: size.width * 0.35,
      color: primary.withOpacity(isDark ? 0.06 : 0.05),
    );
  }

  void _radialGlow(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawOval(
      rect,
      Paint()
        ..shader = RadialGradient(
          colors: [color, color.withOpacity(0)],
        ).createShader(rect),
    );
  }

  void _paintDotGrid(Canvas canvas, Size size) {
    const step = 28.0;
    final paint = Paint()
      ..color = (isDark ? Colors.white : AppColors.primary)
          .withOpacity(isDark ? 0.04 : 0.035)
      ..style = PaintingStyle.fill;

    for (double y = 0; y < size.height; y += step) {
      for (double x = 0; x < size.width; x += step) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  void _paintDoodles(Canvas canvas, Size size) {
    const cols = 4;
    const rows = 8;
    final cellW = size.width / cols;
    final cellH = size.height / rows;
    final doodlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = (isDark ? Colors.white : AppColors.primary)
          .withOpacity(isDark ? 0.07 : 0.09);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = (isDark ? AppColors.darkPrimary : AppColors.primary)
          .withOpacity(isDark ? 0.05 : 0.06);

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final seed = row * cols + col;
        final type = seed % 5;
        final cx = cellW * (col + 0.5) + _jitter(seed, 12);
        final cy = cellH * (row + 0.5) + _jitter(seed + 7, 14);
        final angle = (seed % 7 - 3) * 0.18;
        final s = 14.0 + (seed % 3) * 2.5;

        canvas.save();
        canvas.translate(cx, cy);
        canvas.rotate(angle);

        switch (type) {
          case 0:
            _drawChatBubble(canvas, s, doodlePaint, fillPaint);
          case 1:
            _drawPulse(canvas, s, doodlePaint);
          case 2:
            _drawCapsule(canvas, s, doodlePaint);
          case 3:
            _drawCross(canvas, s, doodlePaint);
          case 4:
            _drawRing(canvas, s, doodlePaint);
        }

        canvas.restore();
      }
    }
  }

  double _jitter(int seed, double max) {
    final v = math.sin(seed * 12.9898) * 43758.5453;
    return (v - v.floor()) * max * 2 - max;
  }

  void _drawChatBubble(Canvas canvas, double s, Paint stroke, Paint fill) {
    final r = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: s * 1.5, height: s),
      Radius.circular(s * 0.35),
    );
    canvas.drawRRect(r, fill);
    canvas.drawRRect(r, stroke);
    final tail = Path()
      ..moveTo(-s * 0.15, s * 0.42)
      ..lineTo(-s * 0.45, s * 0.62)
      ..lineTo(-s * 0.05, s * 0.55)
      ..close();
    canvas.drawPath(tail, fill);
    canvas.drawPath(tail, stroke);
  }

  void _drawPulse(Canvas canvas, double s, Paint paint) {
    final path = Path()
      ..moveTo(-s * 0.9, 0)
      ..lineTo(-s * 0.35, 0)
      ..lineTo(-s * 0.15, -s * 0.55)
      ..lineTo(0.05 * s, s * 0.65)
      ..lineTo(0.25 * s, -s * 0.35)
      ..lineTo(0.45 * s, 0)
      ..lineTo(s * 0.9, 0);
    canvas.drawPath(path, paint);
  }

  void _drawCapsule(Canvas canvas, double s, Paint paint) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: s * 1.6, height: s * 0.55),
      Radius.circular(s * 0.3),
    );
    canvas.drawRRect(rect, paint);
    canvas.drawLine(
      Offset(0, -s * 0.28),
      Offset(0, s * 0.28),
      paint,
    );
  }

  void _drawCross(Canvas canvas, double s, Paint paint) {
    canvas.drawLine(Offset(-s * 0.45, 0), Offset(s * 0.45, 0), paint);
    canvas.drawLine(Offset(0, -s * 0.45), Offset(0, s * 0.45), paint);
    canvas.drawCircle(Offset.zero, s * 0.55, paint);
  }

  void _drawRing(Canvas canvas, double s, Paint paint) {
    canvas.drawCircle(Offset.zero, s * 0.42, paint);
    canvas.drawCircle(Offset.zero, s * 0.18, paint);
  }

  @override
  bool shouldRepaint(covariant _ChatRoomBackgroundPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
