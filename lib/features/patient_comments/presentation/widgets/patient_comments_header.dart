import 'dart:ui' as ui;

import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class PatientCommentsHeader extends StatelessWidget {
  final bool isDark;
  final String title;
  final String subtitle;
  final String? patientNameTooltip;
  final int commentCount;
  final VoidCallback onBack;
  final VoidCallback? onPatientNameTap;

  const PatientCommentsHeader({
    super.key,
    required this.isDark,
    required this.title,
    required this.subtitle,
    this.patientNameTooltip,
    required this.commentCount,
    required this.onBack,
    this.onPatientNameTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final titleColor = HomeDashboardColors.title(isDark);
    final top = MediaQuery.paddingOf(context).top;
    final isArabicName =
        RegExp(r'[\u0600-\u06FF]').hasMatch(patientNameTooltip ?? subtitle);
    final canOpenPatient = onPatientNameTap != null &&
        subtitle.trim().isNotEmpty &&
        subtitle != context.tr(AppStrings.clinicalDiscussion);

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
                    color: titleColor,
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
                      color: titleColor,
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
                        if (canOpenPatient)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: onPatientNameTap,
                              borderRadius: BorderRadius.circular(99),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: isDark
                                      ? Colors.white.withOpacity(0.12)
                                      : Colors.white.withOpacity(0.75),
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.14)
                                        : primary.withOpacity(0.18),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    8.w,
                                    4.h,
                                    6.w,
                                    4.h,
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 18.r,
                                          height: 18.r,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isDark
                                                ? primary.withOpacity(0.35)
                                                : primary.withOpacity(0.12),
                                          ),
                                          child: Icon(
                                            Icons.person_rounded,
                                            size: 12.sp,
                                            color: isDark
                                                ? Colors.white
                                                : primary,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        Flexible(
                                          child: Tooltip(
                                            message:
                                                patientNameTooltip ?? subtitle,
                                            child: Text(
                                              subtitle,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: isArabicName
                                                  ? ui.TextDirection.rtl
                                                  : ui.TextDirection.ltr,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: isDark
                                                    ? Colors.white
                                                        .withOpacity(0.92)
                                                    : titleColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 16.sp,
                                          color: isDark
                                              ? Colors.white.withOpacity(0.7)
                                              : primary.withOpacity(0.8),
                                          textDirection:
                                              Directionality.of(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: titleColor,
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
                                color:
                                    primary.withOpacity(isDark ? 0.22 : 0.12),
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
