import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PatientCommentsLoadingList extends StatelessWidget {
  final bool isDark;
  final int count;

  const PatientCommentsLoadingList({
    super.key,
    required this.isDark,
    this.count = 5,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 20.h),
      itemCount: count,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: bone,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 78.h,
                  decoration: BoxDecoration(
                    color: bone,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
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

class PatientCommentsEmptyState extends StatelessWidget {
  final bool isDark;

  const PatientCommentsEmptyState({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primary,
                    Color.lerp(primary, const Color(0xFF1F2937), 0.3)!,
                  ],
                ),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(isDark ? 0.35 : 0.22),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.forum_rounded,
                size: 30.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              context.tr(AppStrings.startTheDiscussion),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              context.tr(AppStrings.shareClinicalNotesAndCollaborate),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.45,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
