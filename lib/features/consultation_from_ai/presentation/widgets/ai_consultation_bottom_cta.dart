import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class AiConsultationBottomCta extends StatelessWidget {
  final bool isDark;
  final int trialCount;
  final String trialsLabel;
  final String actionLabel;
  final bool isLoading;
  final VoidCallback onPressed;

  const AiConsultationBottomCta({
    super.key,
    required this.isDark,
    required this.trialCount,
    required this.trialsLabel,
    required this.actionLabel,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final hasTrials = trialCount > 0;

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
                    Icons.auto_awesome_rounded,
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
                        hasTrials
                            ? context.tr(AppStrings.requestAiInsight)
                            : context.tr(AppStrings.noTrialsLeft),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: HomeDashboardColors.title(isDark),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        trialsLabel,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                          color: hasTrials
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
                    onTap: isLoading || !hasTrials ? null : onPressed,
                    borderRadius: BorderRadius.circular(14.r),
                    child: Opacity(
                      opacity: isLoading || !hasTrials ? 0.55 : 1,
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              primary,
                              Color.lerp(
                                primary,
                                const Color(0xFF1F2937),
                                0.22,
                              )!,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 40.w,
                                  height: 18.h,
                                  child: Center(
                                    child: SizedBox(
                                      width: 16.r,
                                      height: 16.r,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      actionLabel,
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
                                        textDirection:
                                            Directionality.of(context),
                                      ),
                                    ),
                                  ],
                                ),
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
