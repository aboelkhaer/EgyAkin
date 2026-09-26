import 'package:egy_akin/exports.dart';

/// Skeleton placeholders that mirror chat bubbles while messages load.
class ChatRoomLoadingShimmer extends StatelessWidget {
  final bool isDark;

  const ChatRoomLoadingShimmer({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2438) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3348) : const Color(0xFFF5F2FF);

    return FadeIn(
      duration: const Duration(milliseconds: 280),
      child: ListView(
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 16.h),
        children: [
          _BubbleBone(
            alignEnd: true,
            widthFactor: 0.62,
            lines: 2,
            base: base,
            highlight: highlight,
            isDark: isDark,
            delayMs: 0,
          ),
          _BubbleBone(
            alignEnd: false,
            widthFactor: 0.72,
            lines: 3,
            base: base,
            highlight: highlight,
            isDark: isDark,
            delayMs: 50,
          ),
          _BubbleBone(
            alignEnd: true,
            widthFactor: 0.48,
            lines: 1,
            base: base,
            highlight: highlight,
            isDark: isDark,
            delayMs: 100,
          ),
          _BubbleBone(
            alignEnd: false,
            widthFactor: 0.58,
            lines: 2,
            base: base,
            highlight: highlight,
            isDark: isDark,
            delayMs: 150,
          ),
          _BubbleBone(
            alignEnd: true,
            widthFactor: 0.78,
            lines: 3,
            base: base,
            highlight: highlight,
            isDark: isDark,
            delayMs: 200,
          ),
          _BubbleBone(
            alignEnd: false,
            widthFactor: 0.55,
            lines: 2,
            base: base,
            highlight: highlight,
            isDark: isDark,
            delayMs: 250,
          ),
        ],
      ),
    );
  }
}

class _BubbleBone extends StatelessWidget {
  final bool alignEnd;
  final double widthFactor;
  final int lines;
  final Color base;
  final Color highlight;
  final bool isDark;
  final int delayMs;

  const _BubbleBone({
    required this.alignEnd,
    required this.widthFactor,
    required this.lines,
    required this.base,
    required this.highlight,
    required this.isDark,
    required this.delayMs,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = alignEnd
        ? AppColors.primary.withOpacity(isDark ? 0.35 : 0.28)
        : (isDark ? AppColors.darkCardBG : Colors.white);

    return FadeInUp(
      from: 10,
      duration: const Duration(milliseconds: 360),
      delay: Duration(milliseconds: delayMs),
      child: Padding(
        padding: EdgeInsets.only(
          left: alignEnd ? 56.w : 12.w,
          right: alignEnd ? 12.w : 56.w,
          bottom: 10.h,
        ),
        child: Align(
          alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
          child: Shimmer.fromColors(
            baseColor: alignEnd
                ? AppColors.primary.withOpacity(isDark ? 0.45 : 0.4)
                : base,
            highlightColor: alignEnd
                ? AppColors.primary.withOpacity(isDark ? 0.65 : 0.58)
                : highlight,
            child: FractionallySizedBox(
              widthFactor: widthFactor,
              child: Container(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                    bottomLeft: Radius.circular(alignEnd ? 14.r : 4.r),
                    bottomRight: Radius.circular(alignEnd ? 4.r : 14.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(lines, (i) {
                    final isLast = i == lines - 1;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 6.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: isLast && lines > 1 ? 0.55 : 1,
                          child: Container(
                            height: 9.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.55),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
