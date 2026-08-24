import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class PatientCommentsHeader extends StatelessWidget {
  final bool isDark;
  final String title;
  final String subtitle;
  final int commentCount;
  final VoidCallback onBack;

  const PatientCommentsHeader({
    super.key,
    required this.isDark,
    required this.title,
    required this.subtitle,
    required this.commentCount,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final top = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(12.w, top + 6.h, 16.w, 14.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF221A33),
                    HomeDashboardColors.headerDark,
                    HomeDashboardColors.scaffold(isDark),
                  ]
                : [
                    const Color(0xFFF3EEFF),
                    HomeDashboardColors.headerLight,
                    HomeDashboardColors.scaffold(isDark),
                  ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: onBack,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18.sp,
                    color: HomeDashboardColors.title(isDark),
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                      color: HomeDashboardColors.title(isDark),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 4.w),
              child: Row(
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primary,
                          Color.lerp(primary, const Color(0xFF1F2937), 0.35)!,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(isDark ? 0.35 : 0.22),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.forum_rounded,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: HomeDashboardColors.title(isDark),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(isDark ? 0.22 : 0.12),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                '$commentCount ${context.tr(commentCount == 1 ? AppStrings.commentUnit : AppStrings.commentsUnit)}',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: primary,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              context.tr(AppStrings.clinicalThread),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: HomeDashboardColors.subtitle(isDark),
                              ),
                            ),
                          ],
                        ),
                      ],
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
