import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity_labels.dart';

/// Animated "Name is typing/recording/sending…" row with bouncing dots.
/// Always uses first name only.
class ChatTypingIndicator extends StatelessWidget {
  final String name;
  final bool isDark;
  final bool visible;
  final ChatComposerActivity activity;

  const ChatTypingIndicator({
    super.key,
    required this.name,
    required this.isDark,
    required this.visible,
    this.activity = ChatComposerActivity.typing,
  });

  @override
  Widget build(BuildContext context) {
    final line = ChatComposerActivityLabels.namedLine(
      context,
      fullName: name,
      activity: activity,
    );

    return AnimatedSize(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        opacity: visible ? 1 : 0,
        child: visible
            ? Padding(
                padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 6.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          line,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkDescription
                                : AppColors.description,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      ChatComposerActivityDots(
                        color: isDark
                            ? AppColors.darkDescription
                            : AppColors.description,
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

/// Bouncing dots used for typing / sending activity (chat room + inbox).
class ChatComposerActivityDots extends StatefulWidget {
  final Color color;
  final double size;
  final double gap;

  const ChatComposerActivityDots({
    super.key,
    required this.color,
    this.size = 4,
    this.gap = 3,
  });

  @override
  State<ChatComposerActivityDots> createState() =>
      _ChatComposerActivityDotsState();
}

class _ChatComposerActivityDotsState extends State<ChatComposerActivityDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final start = i * 0.2;
            final t = ((_controller.value - start) % 1.0).clamp(0.0, 1.0);
            final bounce = (t < 0.5) ? (t * 2) : (2 - t * 2);
            final dot = widget.size.w;
            return Padding(
              padding: EdgeInsets.only(
                right: i == 2 ? 0 : widget.gap.w,
              ),
              child: Transform.translate(
                offset: Offset(0, -3.h * bounce),
                child: Container(
                  width: dot,
                  height: dot,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.55 + 0.45 * bounce),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
