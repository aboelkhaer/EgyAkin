import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/block_user_for_admin_side.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/verify_email_for_admin.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/verify_syndicate_card_for_admin.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

class AdminSide extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;
  final DoctorModel currentDoctorModel;

  const AdminSide({
    super.key,
    required this.homeDataModel,
    required this.doctorInfo,
    required this.currentDoctorModel,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = DoctorInfoViewCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        if (!PermissionHelper.canPermission(
              AppPermissions.viewAdminSideInProfiles,
            ) ||
            currentDoctorModel.id == doctorInfo.data!.id) {
          return const SizedBox.shrink();
        }

        final primary = HomeDashboardColors.primary(isDark);
        final data = doctorInfo.data!;

        return Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        const Color(0xFF1A1428),
                        HomeDashboardColors.cardBg(isDark),
                      ]
                    : [
                        const Color(0xFFF5F3FF),
                        Colors.white,
                      ],
              ),
              border: Border.all(
                color: primary.withOpacity(isDark ? 0.35 : 0.18),
              ),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: primary.withOpacity(0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 10.h),
                  child: Row(
                    children: [
                      Container(
                        width: 38.r,
                        height: 38.r,
                        decoration: BoxDecoration(
                          color: primary.withOpacity(isDark ? 0.22 : 0.12),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.admin_panel_settings_rounded,
                          size: 20.sp,
                          color: primary,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr(AppStrings.adminSide),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              context.tr(AppStrings.restrictedModerationTools),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: HomeDashboardColors.subtitle(isDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AdminOnlyBadge(
                        showBadge: true,
                        style: BadgeStyle.premium,
                        fontSize: 8.sp,
                        badgePadding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        showIcon: false,
                        glowEffect: false,
                        pulseAnimation: false,
                        badgeText: context.tr(AppStrings.adminBadge),
                        top: 0,
                        right: 0,
                        child: SizedBox(width: 52.w, height: 22.h),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: HomeDashboardColors.border(isDark).withOpacity(0.8),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 4.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _AdminMetaTile(
                              isDark: isDark,
                              icon: Icons.cake_outlined,
                              accent: const Color(0xFF0EA5E9),
                              label: context.tr(AppStrings.age),
                              value: data.age ?? context.tr(AppStrings.noData),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: _AdminMetaTile(
                              isDark: isDark,
                              icon: Icons.badge_outlined,
                              accent: const Color(0xFF8B5CF6),
                              label: context.tr(AppStrings.id),
                              value: data.id.toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      _AdminMetaTile(
                        isDark: isDark,
                        icon: Icons.event_available_rounded,
                        accent: const Color(0xFF14B8A6),
                        label: context.tr(AppStrings.joinUs),
                        value: TimeAgoService.instance.formatTimeAgoFromString(
                          data.createdAt.toString(),
                          context,
                        ),
                        fullWidth: true,
                      ),
                      SizedBox(height: 8.h),
                      _AdminMetaTile(
                        isDark: isDark,
                        icon: Icons.numbers_rounded,
                        accent: const Color(0xFFF59E0B),
                        label: context.tr(AppStrings.registrationNumber),
                        value: data.registrationNumber ??
                            context.tr(AppStrings.noData),
                        fullWidth: true,
                      ),
                      VerifyEmailForAdmin(
                        homeDataModel: homeDataModel,
                        doctorInfo: doctorInfo,
                        isDarkMode: isDark,
                        cubit: cubit,
                      ),
                      KeyedSubtree(
                        key: cubit.syndicateCardSectionKey,
                        child: VerifySyndicateCardForAdmin(
                          homeDataModel: homeDataModel,
                          doctorInfo: doctorInfo,
                          isDarkMode: isDark,
                          cubit: cubit,
                        ),
                      ),
                      BlockUserForAdminSide(
                        homeDataModel: homeDataModel,
                        doctorInfo: doctorInfo,
                        isDarkMode: isDark,
                        cubit: cubit,
                      ),
                      SizedBox(height: 8.h),
                    ],
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

class _AdminMetaTile extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color accent;
  final String label;
  final String value;
  final bool fullWidth;

  const _AdminMetaTile({
    required this.isDark,
    required this.icon,
    required this.accent,
    required this.label,
    required this.value,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: accent.withOpacity(isDark ? 0.22 : 0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 16.sp, color: accent),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.replaceAll(':', ''),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
                SizedBox(height: 2.h),
                SelectableText(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
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
