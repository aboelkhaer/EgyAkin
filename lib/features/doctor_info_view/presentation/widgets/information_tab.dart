import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class InformationTab extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  /// When true, content participates in a parent [CustomScrollView]
  /// and does not create its own scroll view.
  final bool nestInParentScroll;

  const InformationTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.nestInParentScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loaded: (
                doctorInfo,
                isLoadingScoreHistory,
                isLoadedScoreHistory,
                message,
                scoreHistory,
                changesCounter,
              ) {
                final data = doctorInfo?.data;
                final rows = <_InfoRowData>[
                  _InfoRowData(
                    icon: Icons.work_outline_rounded,
                    accent: const Color(0xFF8B5CF6),
                    label: context.tr(AppStrings.job),
                    value: data?.job ?? context.tr(AppStrings.noData),
                  ),
                  _InfoRowData(
                    icon: Icons.apartment_rounded,
                    accent: const Color(0xFF0EA5E9),
                    label: context.tr(AppStrings.workPlace),
                    value: data?.workingplace ?? context.tr(AppStrings.noData),
                  ),
                  _InfoRowData(
                    icon: Icons.biotech_outlined,
                    accent: const Color(0xFF14B8A6),
                    label: context.tr(AppStrings.specialty),
                    value: data?.specialty ?? context.tr(AppStrings.noData),
                  ),
                  _InfoRowData(
                    icon: Icons.school_outlined,
                    accent: const Color(0xFFF59E0B),
                    label: context.tr(AppStrings.highestDegree),
                    value:
                        data?.highestdegree ?? context.tr(AppStrings.noData),
                  ),
                  _InfoRowData(
                    icon: Icons.mail_outline_rounded,
                    accent: const Color(0xFF3B82F6),
                    label: context.tr(AppStrings.email),
                    value: data?.email ?? context.tr(AppStrings.noData),
                  ),
                  _InfoRowData(
                    icon: Icons.phone_outlined,
                    accent: const Color(0xFF22C55E),
                    label: context.tr(AppStrings.phone),
                    value: data?.phone ?? context.tr(AppStrings.noData),
                  ),
                ];

                final content = Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                  child: Column(
                    children: [
                      ...List.generate(rows.length, (index) {
                        final row = rows[index];
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 380 + (index * 70)),
                          curve: Curves.easeOutCubic,
                          builder: (context, t, child) {
                            return Opacity(
                              opacity: t.clamp(0.0, 1.0),
                              child: Transform.translate(
                                offset: Offset(0, (1 - t) * 14),
                                child: child,
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: _InfoCard(
                              isDark: isDark,
                              data: row,
                            ),
                          ),
                        );
                      }),
                      AdminSide(
                        homeDataModel: homeDataModel,
                        doctorInfo: doctorInfo!,
                        currentDoctorModel: currentDoctorModel,
                      ),
                    ],
                  ),
                );

                if (nestInParentScroll) return content;

                return SingleChildScrollView(
                  controller: context
                      .read<DoctorInfoViewCubit>()
                      .doctorInfoViewScrollController,
                  physics: const BouncingScrollPhysics(),
                  child: content,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _InfoRowData {
  final IconData icon;
  final Color accent;
  final String label;
  final String value;

  const _InfoRowData({
    required this.icon,
    required this.accent,
    required this.label,
    required this.value,
  });
}

class _InfoCard extends StatelessWidget {
  final bool isDark;
  final _InfoRowData data;

  const _InfoCard({required this.isDark, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: data.accent.withOpacity(isDark ? 0.22 : 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(data.icon, size: 18.sp, color: data.accent),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.label.replaceAll(':', ''),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
                SizedBox(height: 4.h),
                SelectableText(
                  data.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    color: HomeDashboardColors.title(isDark),
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
