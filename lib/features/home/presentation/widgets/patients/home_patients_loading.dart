import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/exports.dart';

/// Skeleton cards that mirror [HomePatientCard] for My / All patients loading.
class HomePatientsLoadingList extends StatelessWidget {
  final bool isDark;
  final int count;

  const HomePatientsLoadingList({
    super.key,
    required this.isDark,
    this.count = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _HomePatientCardSkeleton(
            isDark: isDark,
            delayMs: 40 + (index * 55),
          ),
        );
      }),
    );
  }
}

class _HomePatientCardSkeleton extends StatelessWidget {
  final bool isDark;
  final int delayMs;

  const _HomePatientCardSkeleton({
    required this.isDark,
    required this.delayMs,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);
    final accent = isDark
        ? HomeDashboardColors.primary(isDark).withOpacity(0.35)
        : HomeDashboardColors.primary(isDark).withOpacity(0.25);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 380 + delayMs.clamp(0, 200)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: HomeDashboardDecor.card(isDark).copyWith(
          borderRadius: BorderRadius.circular(20.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5.w, color: accent),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: base,
                  highlightColor: highlight,
                  child: Padding(
                    padding: EdgeInsets.all(11.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32.r,
                              height: 32.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: bone,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Bone(
                                    width: 120.w,
                                    height: 12.h,
                                    color: bone,
                                    radius: 6.r,
                                  ),
                                  SizedBox(height: 6.h),
                                  _Bone(
                                    width: 90.w,
                                    height: 10.h,
                                    color: bone,
                                    radius: 5.r,
                                  ),
                                ],
                              ),
                            ),
                            _Bone(
                              width: 58.w,
                              height: 22.h,
                              color: bone,
                              radius: 20.r,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: HomeDashboardColors.surfaceBg(isDark),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            children: [
                              _Bone(
                                width: 44.w,
                                height: 16.h,
                                color: bone,
                                radius: 6.r,
                              ),
                              SizedBox(width: 8.w),
                              _Bone(
                                width: 52.w,
                                height: 10.h,
                                color: bone,
                                radius: 5.r,
                              ),
                              const Spacer(),
                              _Bone(
                                width: 72.w,
                                height: 10.h,
                                color: bone,
                                radius: 5.r,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            _Bone(
                              width: 14.w,
                              height: 14.h,
                              color: bone,
                              radius: 4.r,
                            ),
                            SizedBox(width: 6.w),
                            _Bone(
                              width: 100.w,
                              height: 10.h,
                              color: bone,
                              radius: 5.r,
                            ),
                            SizedBox(width: 8.w),
                            _Bone(
                              width: 48.w,
                              height: 10.h,
                              color: bone,
                              radius: 5.r,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _Bone(
                                height: 34.h,
                                color: bone,
                                radius: 12.r,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: _Bone(
                                height: 34.h,
                                color: bone,
                                radius: 12.r,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePatientsLoadMoreFooter extends StatelessWidget {
  final bool isDark;

  const HomePatientsLoadMoreFooter({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: HomeDashboardColors.surfaceBg(isDark),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14.sp,
                height: 14.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: primary,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                context.tr(AppStrings.loadingMore),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  final double? width;
  final double height;
  final Color color;
  final double radius;

  const _Bone({
    this.width,
    required this.height,
    required this.color,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
