import '../../../../exports.dart';

/// Collapses a comment/reply with fade + slide when [exiting] becomes true.
class CommentExitAnimator extends StatefulWidget {
  final bool exiting;
  final Widget child;
  final VoidCallback? onExited;
  final Duration duration;

  const CommentExitAnimator({
    super.key,
    required this.exiting,
    required this.child,
    this.onExited,
    this.duration = const Duration(milliseconds: 320),
  });

  @override
  State<CommentExitAnimator> createState() => _CommentExitAnimatorState();
}

class _CommentExitAnimatorState extends State<CommentExitAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _size;
  late final Animation<Offset> _slide;
  bool _exitStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: 1,
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    );
    _fade = curved;
    _size = curved;
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.06),
      end: Offset.zero,
    ).animate(curved);

    if (widget.exiting) {
      _startExit();
    }
  }

  @override
  void didUpdateWidget(covariant CommentExitAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.exiting && !oldWidget.exiting) {
      _startExit();
    }
  }

  void _startExit() {
    if (_exitStarted) return;
    _exitStarted = true;
    _controller.reverse().whenComplete(() {
      if (!mounted) return;
      widget.onExited?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.exiting || _exitStarted,
      child: FadeTransition(
        opacity: _fade,
        child: SizeTransition(
          sizeFactor: _size,
          axisAlignment: -1,
          child: SlideTransition(
            position: _slide,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
