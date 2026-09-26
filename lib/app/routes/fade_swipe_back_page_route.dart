import 'package:flutter/material.dart';

/// Fades the page in/out, and supports iOS-style swipe-from-left to pop.
///
/// Avoids [CupertinoPageRoute] slide internals (which caused a frozen /
/// black split screen when combined with fade).
class FadeSwipeBackPageRoute<T> extends PageRouteBuilder<T> {
  FadeSwipeBackPageRoute({
    required WidgetBuilder builder,
    super.settings,
    Duration fadeDuration = const Duration(milliseconds: 260),
  }) : super(
          opaque: true,
          barrierDismissible: false,
          transitionDuration: fadeDuration,
          reverseTransitionDuration: fadeDuration,
          pageBuilder: (context, animation, secondaryAnimation) {
            return EdgeSwipeBack(child: builder(context));
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              ),
              child: child,
            );
          },
        );
}

/// Thin left-edge drag → [Navigator.maybePop].
///
/// During the drag we only preview a light slide. On commit we clear that
/// offset immediately and let the route's reverse transition own the pop —
/// animating both was what made chat-info look broken / "panicky".
class EdgeSwipeBack extends StatefulWidget {
  final Widget child;

  const EdgeSwipeBack({super.key, required this.child});

  @override
  State<EdgeSwipeBack> createState() => _EdgeSwipeBackState();
}

class _EdgeSwipeBackState extends State<EdgeSwipeBack>
    with SingleTickerProviderStateMixin {
  static const double _edgeWidth = 24;
  static const double _popDistance = 64;
  /// How far the preview tracks the finger (fraction of screen width).
  static const double _previewFactor = 0.22;

  late final AnimationController _drag;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _drag = AnimationController(vsync: this, value: 0);
  }

  @override
  void dispose() {
    _drag.dispose();
    super.dispose();
  }

  bool get _canAttemptPop {
    final route = ModalRoute.of(context);
    if (route == null || !route.isCurrent) return false;
    // Use navigator history, not route.canPop — PopScope(canPop: false)
    // still wants maybePop so onPopInvoked can run custom pop logic.
    return Navigator.of(context).canPop();
  }

  void _onDragStart(DragStartDetails details) {
    if (!_canAttemptPop) return;
    _dragging = true;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_dragging) return;
    final width = MediaQuery.sizeOf(context).width;
    if (width <= 0) return;
    _drag.value =
        (_drag.value + (details.primaryDelta ?? 0) / width).clamp(0.0, 1.0);
  }

  Future<void> _onDragEnd(DragEndDetails details) async {
    if (!_dragging) return;
    _dragging = false;
    final width = MediaQuery.sizeOf(context).width;
    final vx = details.velocity.pixelsPerSecond.dx;
    final shouldPop = _drag.value > 0.28 ||
        (vx > 650 && _drag.value > 0.06) ||
        (_drag.value * width > _popDistance);

    if (shouldPop) {
      // Drop the preview offset so it doesn't fight the route slide-out.
      _drag.value = 0;
      if (mounted) await Navigator.of(context).maybePop();
      return;
    }

    await _drag.animateTo(
      0,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
    );
  }

  void _onDragCancel() {
    if (!_dragging) return;
    _dragging = false;
    _drag.animateTo(
      0,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _drag,
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        final dx = _drag.value * width * _previewFactor;
        return Stack(
          fit: StackFit.expand,
          children: [
            Transform.translate(
              offset: Offset(dx, 0),
              child: child,
            ),
            // Only the left edge captures the back-swipe.
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: _edgeWidth,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragStart: _onDragStart,
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                onHorizontalDragCancel: _onDragCancel,
              ),
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
