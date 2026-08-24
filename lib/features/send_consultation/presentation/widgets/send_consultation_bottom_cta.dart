import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class SendConsultationBottomCta extends StatelessWidget {
  final bool isDark;
  final int selectedCount;
  final String label;
  final String readyTitle;
  final VoidCallback onPressed;

  const SendConsultationBottomCta({
    super.key,
    required this.isDark,
    required this.selectedCount,
    required this.label,
    required this.readyTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final hasSelection = selectedCount > 0;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 10.h),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.85),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.28 : 0.07),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 10.w, 10.h),
            child: Row(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(isDark ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.groups_2_outlined,
                    size: 18.sp,
                    color: primary,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hasSelection
                            ? readyTitle
                            : context.tr(AppStrings.selectDoctors),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: HomeDashboardColors.title(isDark),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        hasSelection
                            ? '$selectedCount ${context.tr(selectedCount == 1 ? AppStrings.doctorUnit : AppStrings.doctorsUnit)} ${context.tr(AppStrings.selectedLower)}'
                            : context.tr(AppStrings.chooseAtLeastOneDoctor),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: hasSelection
                              ? primary
                              : HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    borderRadius: BorderRadius.circular(14.r),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            primary,
                            Color.lerp(primary, const Color(0xFF1F2937), 0.22)!,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              width: 22.r,
                              height: 22.r,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                size: 14.sp,
                                color: Colors.white,
                                textDirection: Directionality.of(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
