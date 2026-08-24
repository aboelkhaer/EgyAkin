import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class AiConsultationHeader extends StatelessWidget {
  final bool isDark;
  final String title;
  final String subtitle;
  final int trialCount;
  final VoidCallback onBack;

  const AiConsultationHeader({
    super.key,
    required this.isDark,
    required this.title,
    required this.subtitle,
    required this.trialCount,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final top = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(12.w, top + 8.h, 16.w, 16.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HomeDashboardColors.header(isDark),
              HomeDashboardColors.scaffold(isDark),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Material(
                  color: isDark ? const Color(0xFF2A2733) : Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onBack,
                    child: Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF3A3645)
                              : HomeDashboardColors.border(isDark),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16.sp,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 34.r,
                  height: 34.r,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(isDark ? 0.22 : 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 18.sp,
                    color: primary,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: HomeDashboardColors.title(isDark),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(isDark ? 0.25 : 0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '$trialCount ${context.tr(AppStrings.leftLabel)}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 48.w, end: 8.w),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
