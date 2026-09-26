import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../exports.dart';

bool _isUpdateDialogOpen = false;

void showUpdateDialog({
  required BuildContext context,
  required VoidCallback onDismissed,
}) {
  if (_isUpdateDialogOpen) return;
  _isUpdateDialogOpen = true;

  final themeState = context.read<ThemeBloc>().state;
  final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

  showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: context.tr(AppStrings.dismiss),
    barrierColor: Colors.black.withOpacity(0.55),
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _WhatsNewDialog(isDark: isDark);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  ).then((_) {
    _isUpdateDialogOpen = false;
    onDismissed();
  });
}

class _WhatsNewDialog extends StatelessWidget {
  final bool isDark;

  const _WhatsNewDialog({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.86;

    final features = <_WhatsNewFeature>[
      _WhatsNewFeature(
        icon: Icons.auto_awesome_rounded,
        accent: const Color(0xFF8B5CF6),
        title: context.tr(AppStrings.updateFeatureRedesignTitle),
        body: context.tr(AppStrings.updateFeatureRedesignBody),
        highlight: true,
      ),
      _WhatsNewFeature(
        icon: Icons.bolt_rounded,
        accent: const Color(0xFFF59E0B),
        title: context.tr(AppStrings.updateFeatureFasterListsTitle),
        body: context.tr(AppStrings.updateFeatureFasterListsBody),
      ),
      _WhatsNewFeature(
        icon: Icons.insights_rounded,
        accent: const Color(0xFF22C55E),
        title: context.tr(AppStrings.updateFeatureProfileStatsTitle),
        body: context.tr(AppStrings.updateFeatureProfileStatsBody),
      ),
      _WhatsNewFeature(
        icon: Icons.medical_services_outlined,
        accent: const Color(0xFF3B82F6),
        title: context.tr(AppStrings.updateFeatureConsultationsTitle),
        body: context.tr(AppStrings.updateFeatureConsultationsBody),
      ),
      _WhatsNewFeature(
        icon: Icons.medication_liquid_rounded,
        accent: const Color(0xFFEC4899),
        title: context.tr(AppStrings.updateFeatureDoseSearchTitle),
        body: context.tr(AppStrings.updateFeatureDoseSearchBody),
      ),
      _WhatsNewFeature(
        icon: Icons.person_add_alt_1_rounded,
        accent: const Color(0xFF14B8A6),
        title: context.tr(AppStrings.updateFeatureAddPatientTitle),
        body: context.tr(AppStrings.updateFeatureAddPatientBody),
      ),
    ];

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 420.w,
                maxHeight: maxHeight,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: HomeDashboardColors.cardBg(isDark),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: HomeDashboardColors.border(isDark).withOpacity(0.7),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.45 : 0.18),
                      blurRadius: 32,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _WhatsNewHero(isDark: isDark, primary: primary),
                      Flexible(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (var i = 0; i < features.length; i++) ...[
                                if (i > 0) SizedBox(height: 8.h),
                                _WhatsNewFeatureCard(
                                  isDark: isDark,
                                  feature: features[i],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 16.h),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: Text(
                              context.tr(AppStrings.gotItExploreTheApp),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
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
          ),
        ),
      ),
    );
  }
}

class _WhatsNewHero extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _WhatsNewHero({
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF2A1F45),
                  const Color(0xFF1A1428),
                  primary.withOpacity(0.35),
                ]
              : [
                  const Color(0xFFEDE7FF),
                  Colors.white,
                  primary.withOpacity(0.14),
                ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.28 : 0.16),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: primary.withOpacity(0.35),
                  ),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: primary,
                  size: 24.sp,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.28 : 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  context.tr(AppStrings.newRelease),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : primary,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            context.tr(AppStrings.whatsNew),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: primary,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            context.tr(AppStrings.appFullyRedesignedTitle),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              height: 1.2,
              color: HomeDashboardColors.title(isDark),
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            context.tr(AppStrings.appFullyRedesignedSubtitle),
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatsNewFeature {
  final IconData icon;
  final Color accent;
  final String title;
  final String body;
  final bool highlight;

  const _WhatsNewFeature({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
    this.highlight = false,
  });
}

class _WhatsNewFeatureCard extends StatelessWidget {
  final bool isDark;
  final _WhatsNewFeature feature;

  const _WhatsNewFeatureCard({
    required this.isDark,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    final accent = feature.accent;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: feature.highlight
            ? accent.withOpacity(isDark ? 0.18 : 0.08)
            : HomeDashboardColors.surfaceBg(isDark),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: feature.highlight
              ? accent.withOpacity(0.35)
              : HomeDashboardColors.border(isDark).withOpacity(0.8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: accent.withOpacity(isDark ? 0.22 : 0.14),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(feature.icon, color: accent, size: 18.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w800,
                    color: HomeDashboardColors.title(isDark),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  feature.body,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
