import 'package:flutter/material.dart';

/// Fades, slides, and collapses a post when [animateOut] becomes true.
class PostRemovalAnimator extends StatefulWidget {
  final bool animateOut;
  final Widget child;
  final VoidCallback onExitComplete;

  const PostRemovalAnimator({
    super.key,
    required this.animateOut,
    required this.child,
    required this.onExitComplete,
  });

  @override
  State<PostRemovalAnimator> createState() => _PostRemovalAnimatorState();
}

class _PostRemovalAnimatorState extends State<PostRemovalAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _size;
  late final Animation<Offset> _slide;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    );
    _fade = Tween<double>(begin: 1, end: 0).animate(curve);
    _size = Tween<double>(begin: 1, end: 0).animate(curve);
    _slide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.08),
    ).animate(curve);

    _controller.addStatusListener(_onStatus);
    if (widget.animateOut) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant PostRemovalAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animateOut && !oldWidget.animateOut && !_completed) {
      _controller.forward();
    }
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_completed) {
      _completed = true;
      widget.onExitComplete();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SizeTransition(
        sizeFactor: _size,
        axisAlignment: -1,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      ),
    );
  }
}
