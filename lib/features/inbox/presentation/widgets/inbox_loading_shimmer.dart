import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

/// Skeleton that mirrors the inbox header + thread list layout.
class InboxLoadingShimmer extends StatelessWidget {
  final bool isDark;

  const InboxLoadingShimmer({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = HomeDashboardColors.scaffold(isDark);
    final primary = HomeDashboardColors.primary(isDark);
    final base = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F2FF);

    return Scaffold(
      backgroundColor: scaffold,
      body: FadeIn(
        duration: const Duration(milliseconds: 280),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: isDark
                      ? [
                          const Color(0xFF7C3AED).withOpacity(0.40),
                          const Color(0xFF6D28D9).withOpacity(0.18),
                          const Color(0xFF6D28D9).withOpacity(0.0),
                        ]
                      : [
                          const Color(0xFFA78BFA).withOpacity(0.36),
                          const Color(0xFFC4B5FD).withOpacity(0.16),
                          const Color(0xFFC4B5FD).withOpacity(0.0),
                        ],
                  stops: const [0.0, 0.45, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28.r),
                  bottomRight: Radius.circular(28.r),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                  child: Shimmer.fromColors(
                    baseColor: base,
                    highlightColor: highlight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 22.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  color: base,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                            Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.45),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        Container(
                          height: 42.h,
                          decoration: BoxDecoration(
                            color: base,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: List.generate(4, (i) {
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Container(
                                height: 30.h,
                                width: (56 + i * 10).w,
                                decoration: BoxDecoration(
                                  color: base,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return FadeInUp(
                    from: 12,
                    duration: const Duration(milliseconds: 380),
                    delay: Duration(milliseconds: 40 * index),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _ThreadRowBone(
                        isDark: isDark,
                        base: base,
                        highlight: highlight,
                        titleWidth: index.isEven ? 0.55 : 0.42,
                        previewWidth: index.isEven ? 0.88 : 0.7,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreadRowBone extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final double titleWidth;
  final double previewWidth;

  const _ThreadRowBone({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.titleWidth,
    required this.previewWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: HomeDashboardDecor.card(isDark),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: base,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: titleWidth,
                          child: Container(
                            height: 11.h,
                            decoration: BoxDecoration(
                              color: base,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 36.w,
                        height: 9.h,
                        decoration: BoxDecoration(
                          color: base,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: previewWidth,
                    child: Container(
                      height: 9.h,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: previewWidth * 0.65,
                    child: Container(
                      height: 9.h,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
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
