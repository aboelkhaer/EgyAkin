import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AiConsultationLoadingList extends StatelessWidget {
  final bool isDark;
  final int count;

  const AiConsultationLoadingList({
    super.key,
    required this.isDark,
    this.count = 4,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 100.h),
      itemCount: count,
      separatorBuilder: (_, __) => SizedBox(height: 14.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: bone,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: HomeDashboardDecor.card(isDark),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 110.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: double.infinity,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 180.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 140.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AiConsultationEmptyState extends StatelessWidget {
  final bool isDark;

  const AiConsultationEmptyState({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: primary.withOpacity(isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 28.sp,
                color: primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              context.tr(AppStrings.noAiOpinionsYet),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              context.tr(AppStrings.requestAiOpinionToGetStarted),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.4,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
