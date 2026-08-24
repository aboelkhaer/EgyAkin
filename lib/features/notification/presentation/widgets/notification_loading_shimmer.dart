import '../../../../exports.dart';

class NotificationLoadingShimmer extends StatelessWidget {
  final bool isDark;
  final int itemCount;

  const NotificationLoadingShimmer({
    super.key,
    required this.isDark,
    this.itemCount = 7,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F2FF);
    final card = isDark ? AppColors.darkCardBG : AppColors.white;

    return FadeIn(
      duration: const Duration(milliseconds: 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ShimmerSectionLabel(isDark: isDark, base: base, highlight: highlight),
          SizedBox(height: 10.h),
          ...List.generate(itemCount, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: FadeInUp(
                from: 12,
                duration: const Duration(milliseconds: 380),
                delay: Duration(milliseconds: 40 * index),
                child: _ShimmerCard(
                  isDark: isDark,
                  base: base,
                  highlight: highlight,
                  card: card,
                  widthFactor: index.isEven ? 0.92 : 0.78,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ShimmerSectionLabel extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;

  const _ShimmerSectionLabel({
    required this.isDark,
    required this.base,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Container(
              height: 1,
              color: base.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color card;
  final double widthFactor;

  const _ShimmerCard({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.card,
    required this.widthFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 10.w, 12.h),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isDark
                ? AppColors.darkBorder.withOpacity(0.5)
                : AppColors.primary.withOpacity(0.06),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: base,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: base,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  FractionallySizedBox(
                    widthFactor: widthFactor,
                    child: Container(
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Container(
                    width: 72.w,
                    height: 9.h,
                    decoration: BoxDecoration(
                      color: base,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
