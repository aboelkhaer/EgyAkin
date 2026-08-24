import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class SendConsultationLoadingList extends StatelessWidget {
  final bool isDark;
  final int count;

  const SendConsultationLoadingList({
    super.key,
    required this.isDark,
    this.count = 6,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 100.h),
      itemCount: count,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: HomeDashboardDecor.card(isDark),
            child: Row(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
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
                      Container(
                        width: 140.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 100.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24.r,
                  height: 24.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bone,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SendConsultationSendingOverlay extends StatelessWidget {
  final bool isDark;
  final String? label;

  const SendConsultationSendingOverlay({
    super.key,
    required this.isDark,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final text = label ?? context.tr(AppStrings.sendingEllipsis);

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
        decoration: HomeDashboardDecor.card(isDark),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28.sp,
              height: 28.sp,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: primary,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendConsultationEmptyState extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String title;
  final String subtitle;

  const SendConsultationEmptyState({
    super.key,
    required this.isDark,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HomeDashboardColors.primary(isDark)
                    .withOpacity(isDark ? 0.18 : 0.1),
              ),
              child: Icon(
                icon,
                size: 28.sp,
                color: HomeDashboardColors.primary(isDark),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
