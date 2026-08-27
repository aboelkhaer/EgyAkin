import '../../../../exports.dart';

/// Same loading pattern as [patient_section_details_screen] question cards.
class OutcomeLoadingShimmer extends StatelessWidget {
  final bool isDark;
  final int itemCount;

  const OutcomeLoadingShimmer({
    super.key,
    required this.isDark,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final shimmer = isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE8E8EE);

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 24.h),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (_, __) {
        return Container(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : const Color(0xFFE8E8EE),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12.h,
                width: 140.w,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 42.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: shimmer.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
