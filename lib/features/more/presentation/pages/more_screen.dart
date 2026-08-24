import 'dart:convert';

import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/more/presentation/cubit/more_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/shared/functions/app_update_message_utils.dart';
import '../../../../exports.dart';
import '../widgets/searchable_permissions_dialog.dart';

class MoreScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final HomeModelResponse homeDataModel;

  const MoreScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.homeDataModel,
  });

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoreCubit>().getFcmTokenTest();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = MoreCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: scaffold,
            body: Column(
              children: [
                _MoreHeader(
                  isDark: isDark,
                  scaffold: scaffold,
                  primary: primary,
                  titleColor: titleColor,
                  muted: muted,
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 100.h),
                    children: [
                      _SectionLabel(
                        isDark: isDark,
                        title: context.tr(AppStrings.general).toUpperCase(),
                      ),
                      SizedBox(height: 6.h),
                      _SettingsGroup(
                        isDark: isDark,
                        children: [
                          _MoreTile(
                            isDark: isDark,
                            iconBg: const Color(0xFF3B82F6),
                            icon: Icons.calculate_outlined,
                            title: context.tr(AppStrings.gfrCalculator),
                            subtitle: context.tr(AppStrings.clinicalTools),
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.gfrCalculator,
                                arguments: AppRoutesArgs.gfrCalculatorRouteArgs(
                                  homeDataModel: widget.homeDataModel,
                                ),
                              );
                            },
                          ),
                          _MoreDivider(isDark: isDark),
                          _MoreTile(
                            isDark: isDark,
                            iconBg: const Color(0xFF8B5CF6),
                            icon: Icons.analytics_outlined,
                            title: context.tr(AppStrings.analytics),
                            subtitle: context.tr(AppStrings.insightsAndReports),
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.webview,
                                arguments: AppRoutesArgs.webViewRouteArgs(
                                  url:
                                      '${ApiEndPoint.baseUrl}/analytics?user_id=${widget.currentDoctorModel.id}&dark=${isDark ? 'true' : 'false'}',
                                  title: context.tr(AppStrings.analytics),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      _SectionLabel(
                        isDark: isDark,
                        title: context
                            .tr(AppStrings.privacySecurity)
                            .toUpperCase(),
                      ),
                      SizedBox(height: 6.h),
                      _SettingsGroup(
                        isDark: isDark,
                        children: [
                          _MoreTile(
                            isDark: isDark,
                            iconBg: const Color(0xFF22C55E),
                            icon: Icons.lock_outline_rounded,
                            title: context.tr(AppStrings.changePassword),
                            subtitle: context.tr(AppStrings.accountSecurity),
                            onTap: () {
                              navigatorKey.currentState
                                  ?.pushNamed(AppRoutes.changePassword);
                            },
                          ),
                          if (widget.homeDataModel.verified != true) ...[
                            _MoreDivider(isDark: isDark),
                            _MoreTile(
                              isDark: isDark,
                              iconBg: const Color(0xFFEF4444),
                              icon: Icons.mark_email_unread_outlined,
                              title: context.tr(AppStrings.emailVerification),
                              subtitle: context.tr(AppStrings.verifyYourEmail),
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.emailVerification,
                                  arguments: AppRoutesArgs
                                      .emailVerificationRouteArgs(
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                  ),
                                );
                              },
                            ),
                          ],
                          if (!isVerifiedUser(widget
                                  .homeDataModel.isSyndicateCardRequired) &&
                              widget.homeDataModel.verified == true &&
                              widget.homeDataModel.userType != 'normal') ...[
                            _MoreDivider(isDark: isDark),
                            _SyndicateTile(
                              isDark: isDark,
                              primary: primary,
                              homeDataModel: widget.homeDataModel,
                            ),
                          ],
                          _MoreDivider(isDark: isDark),
                          _MoreTile(
                            isDark: isDark,
                            iconBg: const Color(0xFF64748B),
                            icon: Icons.privacy_tip_outlined,
                            title: context.tr(AppStrings.privacyPolicy),
                            subtitle: context.tr(AppStrings.legalInformation),
                            onTap: () {
                              launchURL(
                                url: 'https://egyakin.com/policy',
                                onError: (error) {
                                  showErrorDialog(context, error);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      _SectionLabel(
                        isDark: isDark,
                        title: context.tr(AppStrings.support).toUpperCase(),
                      ),
                      SizedBox(height: 6.h),
                      _SettingsGroup(
                        isDark: isDark,
                        children: [
                          _MoreTile(
                            isDark: isDark,
                            iconBg: const Color(0xFF06B6D4),
                            icon: Icons.mail_outline_rounded,
                            title: context.tr(AppStrings.contactUs),
                            subtitle: context.tr(AppStrings.getInTouch),
                            onTap: () {
                              navigatorKey.currentState
                                  ?.pushNamed(AppRoutes.contactUs);
                            },
                          ),
                          _MoreDivider(isDark: isDark),
                          _MoreTile(
                            isDark: isDark,
                            iconBg: const Color(0xFFF59E0B),
                            icon: Icons.info_outline_rounded,
                            title: context.tr(AppStrings.aboutUs),
                            subtitle: context.tr(AppStrings.aboutEgyAkin),
                            onTap: () {
                              navigatorKey.currentState
                                  ?.pushNamed(AppRoutes.aboutUs);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      _SectionLabel(
                        isDark: isDark,
                        title: context.tr(AppStrings.preferences).toUpperCase(),
                      ),
                      SizedBox(height: 6.h),
                      _SettingsGroup(
                        isDark: isDark,
                        children: [
                          LanguageSelector(moreCubit: cubit),
                          _MoreDivider(isDark: isDark),
                          _ThemeTile(isDark: isDark),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      BlocBuilder<MoreCubit, MoreState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const SizedBox.shrink(),
                            loaded: () => Center(
                              child: Text(
                                'v${context.read<HomeCubit>().currentUserVersion} (${context.read<HomeCubit>().currentUserBuildNumber}-${ApiEndPoint.versioning}) ${ApiEndPoint.baseUrl == 'https://test.egyakin.com' ? 'T' : 'P'}',
                                style: TextStyle(
                                  color: muted,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      BlocBuilder<MoreCubit, MoreState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const SizedBox.shrink(),
                            loaded: () => widget.homeDataModel.role == 'Admin'
                                ? SelectableText(
                                    cubit.fcmToken,
                                    style: const TextStyle(
                                      color: Colors.transparent,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          );
                        },
                      ),
                      PermissionGuard(
                        permission: AppPermissions
                            .viewClearUpdateMessageButtonInMore,
                        child: Column(
                          children: [
                            SizedBox(height: 12.h),
                            Center(
                              child: AdminOnlyBadge(
                                style: BadgeStyle.premium,
                                glowEffect: true,
                                pulseAnimation: true,
                                fontSize: 8.sp,
                                badgePadding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.h,
                                ),
                                tooltipMessage: context.tr(AppStrings
                                    .adminOnlyClearUpdateMessageFlag),
                                child: _AdminActionButton(
                                  isDark: isDark,
                                  primary: primary,
                                  label: context.tr(AppStrings
                                      .clearUpdateMessageToShowItAgain),
                                  onTap: () async {
                                    try {
                                      await AppUpdateMessageUtils
                                          .clearDismissedFlag(
                                        sl<AppPreferences>(),
                                      );
                                      if (context.mounted) {
                                        customSnackBar(
                                          context: context,
                                          message: context.tr(AppStrings
                                              .updateMessageFlagClearedSuccessfully),
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        customSnackBar(
                                          context: context,
                                          message: context.tr(
                                            '${AppStrings.failedToClearUpdateMessageFlag}: ${e.toString()}',
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Center(
                              child: AdminOnlyBadge(
                                style: BadgeStyle.premium,
                                glowEffect: true,
                                pulseAnimation: true,
                                fontSize: 8.sp,
                                badgePadding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.h,
                                ),
                                tooltipMessage: context.tr(
                                  AppStrings.showCurrentUserPermissions,
                                ),
                                child: _AdminActionButton(
                                  isDark: isDark,
                                  primary: primary,
                                  label: context.tr(
                                    AppStrings.showCurrentUserPermissions,
                                  ),
                                  onTap: () async {
                                    try {
                                      final prefs = await SharedPreferences
                                          .getInstance();
                                      final permissions = prefs.getString(
                                        AppLocalStrings.permissions,
                                      );

                                      if (permissions != null) {
                                        final decoded =
                                            jsonDecode(permissions);
                                        final List<dynamic> permissionsList =
                                            decoded is List<dynamic>
                                                ? decoded
                                                : (decoded is List
                                                    ? List<dynamic>.from(
                                                        decoded)
                                                    : <dynamic>[
                                                        decoded.toString()
                                                      ]);
                                        final permissionStrings =
                                            permissionsList
                                                .map((e) => e.toString())
                                                .toList();
                                        if (!context.mounted) return;
                                        await showSearchablePermissionsDialog(
                                          context,
                                          permissions: permissionStrings,
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        customSnackBar(
                                          context: context,
                                          message: context.tr(
                                            'Failed to show current user permissions: ${e.toString()}',
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
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
      },
    );
  }
}

class _MoreHeader extends StatelessWidget {
  final bool isDark;
  final Color scaffold;
  final Color primary;
  final Color titleColor;
  final Color muted;
  final VoidCallback onBack;

  const _MoreHeader({
    required this.isDark,
    required this.scaffold,
    required this.primary,
    required this.titleColor,
    required this.muted,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  HomeDashboardColors.headerDark,
                  scaffold,
                ]
              : [
                  HomeDashboardColors.headerLight,
                  scaffold,
                ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 2.h, 14.w, 10.h),
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
                      size: 16.sp,
                      color: titleColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      context.tr(AppStrings.settingsAndMore),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 48.w),
                child: Text(
                  context.tr(AppStrings.settingsAndMoreHeaderSubtitle),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final bool isDark;
  final String title;

  const _SectionLabel({required this.isDark, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 9.5.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: HomeDashboardColors.subtitle(isDark),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;

  const _SettingsGroup({
    required this.isDark,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: HomeDashboardDecor.card(isDark),
      child: Column(children: children),
    );
  }
}

class _MoreDivider extends StatelessWidget {
  final bool isDark;

  const _MoreDivider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 52.w,
      color: HomeDashboardColors.border(isDark).withOpacity(0.6),
    );
  }
}

class _MoreTile extends StatelessWidget {
  final bool isDark;
  final Color iconBg;
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _MoreTile({
    required this.isDark,
    required this.iconBg,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: iconBg.withOpacity(isDark ? 0.18 : 0.12),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(icon, size: 15.sp, color: iconBg),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 1.h),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 9.5.sp,
                          fontWeight: FontWeight.w500,
                          color: HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16.sp,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SyndicateTile extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final HomeModelResponse homeDataModel;

  const _SyndicateTile({
    required this.isDark,
    required this.primary,
    required this.homeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = homeDataModel.isSyndicateCardRequired ==
        VerificationBySyndicateCard.Pending.name;

    return _MoreTile(
      isDark: isDark,
      iconBg: const Color(0xFFF59E0B),
      icon: Icons.badge_outlined,
      title: isPending
          ? context.tr(AppStrings.waitingForApproval)
          : context.tr(AppStrings.syndicateCardVerification),
      subtitle: isPending
          ? context.tr(AppStrings.pendingReview)
          : context.tr(AppStrings.uploadSyndicateCard),
      trailing: isPending
          ? null
          : BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => Icon(
                    Icons.chevron_right_rounded,
                    size: 16.sp,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                  loaded: (
                    homeData,
                    currentDoctorModel,
                    dotsPosition,
                    homeIndex,
                    isUploadingSyndicateCard,
                    isUploadedSyndicateCard,
                    message,
                    checkUpdateMessageCounter,
                    isUserBlocked,
                    changesCounter,
                  ) {
                    if (isUploadingSyndicateCard) {
                      return SizedBox(
                        height: 14.r,
                        width: 14.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: primary,
                        ),
                      );
                    }
                    return Icon(
                      Icons.chevron_right_rounded,
                      size: 16.sp,
                      color: HomeDashboardColors.subtitle(isDark),
                    );
                  },
                );
              },
            ),
      onTap: isPending
          ? null
          : () => context.read<HomeCubit>().uploadSyndicateCard(),
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final bool isDark;

  const _ThemeTile({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final dark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        return _MoreTile(
          isDark: isDark,
          iconBg: const Color(0xFF8B5CF6),
          icon: dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
          title: dark ? context.tr('Dark Mode') : context.tr('Light Mode'),
          subtitle: context.tr(AppStrings.appearance),
          trailing: Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: dark,
              onChanged: (_) {
                context.read<ThemeBloc>().add(ToggleTheme());
              },
              activeColor: primary,
            ),
          ),
          onTap: () {
            context.read<ThemeBloc>().add(ToggleTheme());
          },
        );
      },
    );
  }
}

class _AdminActionButton extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String label;
  final VoidCallback onTap;

  const _AdminActionButton({
    required this.isDark,
    required this.primary,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primary,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
