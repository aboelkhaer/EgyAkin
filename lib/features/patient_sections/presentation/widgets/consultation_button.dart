import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class ConsultationButtonsRow extends StatelessWidget {
  final VoidCallback onDoctorConsultationTap;
  final VoidCallback onAiConsultationTap;

  const ConsultationButtonsRow({
    super.key,
    required this.onDoctorConsultationTap,
    required this.onAiConsultationTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _ConsultationCard(
                    isDark: isDark,
                    icon: Icons.medical_services_outlined,
                    title: context.tr(AppStrings.askADoctor),
                    subtitle: context.tr(AppStrings.sendCaseToColleague),
                    onTap: onDoctorConsultationTap,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _ConsultationCard(
                    isDark: isDark,
                    icon: Icons.auto_awesome_rounded,
                    title: context.tr(AppStrings.askAi),
                    subtitle: context.tr(AppStrings.instantAiSecondOpinion),
                    onTap: onAiConsultationTap,
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

class _ConsultationCard extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ConsultationCard({
    required this.isDark,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = HomeDashboardColors.cardBg(isDark);
    final border = HomeDashboardColors.border(isDark);
    final titleColor = HomeDashboardColors.title(isDark);
    final subtitleColor = HomeDashboardColors.subtitle(isDark);
    final primary = HomeDashboardColors.primary(isDark);
    final iconBg = primary.withOpacity(isDark ? 0.18 : 0.12);

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: border),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(icon, size: 15.sp, color: primary),
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 9.5.sp,
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                  color: subtitleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
