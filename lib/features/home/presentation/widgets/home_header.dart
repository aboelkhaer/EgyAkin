import 'package:egy_akin/app/shared/functions/blocked_dialog.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  static const double _hideGreetingOffset = 20;
  bool _showGreeting = true;

  @override
  void initState() {
    super.initState();
    widget.cubit.homeTabScrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _onScroll();
    });
  }

  @override
  void dispose() {
    widget.cubit.homeTabScrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final controller = widget.cubit.homeTabScrollController;
    if (!controller.hasClients || controller.positions.length != 1) return;

    final shouldShow = controller.offset <= _hideGreetingOffset;
    if (shouldShow != _showGreeting) {
      setState(() => _showGreeting = shouldShow);
    }
  }

  String _greeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return context.tr(AppStrings.goodMorning);
    if (hour < 17) return context.tr(AppStrings.goodAfternoon);
    return context.tr(AppStrings.goodEvening);
  }

  String _dateLabel(BuildContext context) {
    final localeCode = context.currentLocale?.languageCode ?? 'en';
    return DateFormat('EEE, MMM d', localeCode).format(DateTime.now());
  }

  String _initials() {
    final first = widget.cubit.currentDoctorModel.firstName;
    final last = widget.cubit.currentDoctorModel.lastName;
    final a = (first != null && first.isNotEmpty) ? first[0] : '';
    final b = (last != null && last.isNotEmpty) ? last[0] : '';
    return ('$a$b').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, _) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
            final primary = HomeDashboardColors.primary(isDark);

            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.cubit.tabsController.index != 4) {
                        widget.cubit.tabsController.jumpToTab(4);
                        widget.cubit.hideHomeHeader(4);
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildAvatar(isDark, primary),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRect(
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeInOut,
                                  alignment: AlignmentDirectional.topStart,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 180),
                                    opacity: _showGreeting ? 1 : 0,
                                    child: _showGreeting
                                        ? Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Text(
                                              '${_greeting(context)} ${_dateLabel(context)}',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: HomeDashboardColors
                                                    .subtitle(isDark),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(
                                            width: double.infinity,
                                            height: 0,
                                          ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.cubit.currentDoctorModel
                                                  .firstName ==
                                              null
                                          ? ''
                                          : doctorName(
                                              firstName: widget
                                                      .cubit
                                                      .currentDoctorModel
                                                      .firstName ??
                                                  '',
                                              lastName: widget
                                                      .cubit
                                                      .currentDoctorModel
                                                      .lastName ??
                                                  '',
                                              role: widget
                                                  .cubit.homeDataModel
                                                  .isSyndicateCardRequired
                                                  .toString(),
                                            ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: HomeDashboardColors.title(
                                            isDark),
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<HomeCubit, HomeState>(
                                    builder: (context, state) {
                                      final isVerified = state.maybeWhen(
                                        loaded: (homeData,
                                                _,
                                                __,
                                                ___,
                                                ____,
                                                _____,
                                                ______,
                                                _______,
                                                ________,
                                                __________) =>
                                            homeData
                                                    .isSyndicateCardRequired ==
                                                'Verified',
                                        orElse: () => widget.cubit
                                                .isSyndicateCardRequired ==
                                            'Verified',
                                      );
                                      return isVerified
                                          ? const VerificationIcon(
                                              duration: 300,
                                              isSmaller: true,
                                            )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _NotificationBell(
                  isDark: isDark,
                  hasUnread: widget.cubit.isUnreadNotification ||
                      (int.tryParse(
                            widget.cubit.homeDataModel.unreadCount ?? '0',
                          ) ??
                          0) >
                          0,
                  onTap: () {
                    final cubit = widget.cubit;
                    // Hide the red badge as soon as notifications are opened.
                    if (cubit.isUnreadNotification ||
                        (int.tryParse(
                              cubit.homeDataModel.unreadCount ?? '0',
                            ) ??
                            0) >
                            0) {
                      cubit.removeNotificationCount();
                    }
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.notification,
                      arguments: AppRoutesArgs.notificationRouteArgs(
                        currentDoctorModel: cubit.currentDoctorModel,
                        accountVerification:
                            cubit.accountVerification ?? false,
                        isSyndicateCardRequired:
                            cubit.isSyndicateCardRequired,
                        currentDoctorRole: cubit.currentDoctorRole,
                        currentDoctorPoints: cubit.doctorScore == null
                            ? 0
                            : int.tryParse(cubit.doctorScore!) ?? 0,
                        homeDataModel: cubit.homeDataModel,
                      ),
                    );
                  },
                ),
                SizedBox(width: 8.w),
                _AddButton(
                  cubit: widget.cubit,
                  isDark: isDark,
                  primary: primary,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildAvatar(bool isDark, Color primary) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final image = widget.cubit.currentDoctorModel.image;
            return CircleAvatar(
              radius: 18.r,
              backgroundColor: primary.withOpacity(0.15),
              child: image == null
                  ? Text(
                      _initials().isEmpty ? 'DR' : _initials(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 11.sp,
                        color: primary,
                      ),
                    )
                  : ClipOval(
                      child: CustomCachedNetworkImage(
                        imageUrl: image.toString(),
                        height: 36.h,
                        width: 36.w,
                      ),
                    ),
            );
          },
        ),
        PositionedDirectional(
          end: 0,
          bottom: 0,
          child: Container(
            width: 10.r,
            height: 10.r,
            decoration: BoxDecoration(
              color: HomeDashboardColors.online,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? AppColors.darkScaffoldBG : Colors.white,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationBell extends StatelessWidget {
  final bool isDark;
  final bool hasUnread;
  final VoidCallback onTap;

  const _NotificationBell({
    required this.isDark,
    required this.hasUnread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        String? unreadOf(HomeState state) => state.maybeWhen(
              loaded: (homeData, _, __, ___, ____, _____, ______, _______,
                      ________, _________) =>
                  homeData.unreadCount,
              orElse: () => null,
            );
        return unreadOf(previous) != unreadOf(current);
      },
      builder: (context, state) {
        final unreadFromState = state.maybeWhen(
          orElse: () => null,
          loaded: (homeData, _, __, ___, ____, _____, ______, _______,
                  ________, _________) =>
              homeData.unreadCount,
        );
        final showBadge = unreadFromState != null
            ? (int.tryParse(unreadFromState) ?? 0) > 0
            : hasUnread;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HomeDashboardColors.surfaceBg(isDark),
              border: Border.all(color: HomeDashboardColors.border(isDark)),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 18.sp,
                    color: HomeDashboardColors.title(isDark),
                  ),
                ),
                if (showBadge)
                  PositionedDirectional(
                    end: 7,
                    top: 7,
                    child: Container(
                      width: 7.r,
                      height: 7.r,
                      decoration: const BoxDecoration(
                        color: HomeDashboardColors.danger,
                        shape: BoxShape.circle,
                      ),
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

class _AddButton extends StatelessWidget {
  final HomeCubit cubit;
  final bool isDark;
  final Color primary;

  const _AddButton({
    required this.cubit,
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => _circleButton(onTap: null),
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
            return _circleButton(
              onTap: () => _handleAdd(
                context: context,
                homeData: homeData,
                currentDoctorModel: currentDoctorModel,
              ),
            );
          },
        );
      },
    );
  }

  Widget _circleButton({required VoidCallback? onTap}) {
    final fill = isDark ? const Color(0xFF3B2A6E) : const Color(0xFF5B3FC4);
    final border = isDark ? const Color(0xFF8B6FE8) : const Color(0xFF9B82F0);
    final iconColor =
        isDark ? const Color(0xFFC4B5FD) : const Color(0xFFE9E0FF);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: fill,
          border: Border.all(color: border, width: 1.2),
        ),
        child: Icon(Icons.add_rounded, color: iconColor, size: 22.sp),
      ),
    );
  }

  void _handleAdd({
    required BuildContext context,
    required HomeModelResponse homeData,
    required DoctorModel currentDoctorModel,
  }) {
    final syndicateVerified =
        isVerifiedUser(homeData.isSyndicateCardRequired);

    // Verified syndicate → Add patient (with email / block guards)
    if (syndicateVerified) {
      if (!PermissionHelper.canPermission(AppPermissions.addPatientInHome)) {
        return;
      }

      if (homeData.isUserBlocked == true) {
        showBlockedDialog(
          context: context,
          onDismissed: () {
            cubit.signOut();
            navigatorKey.currentState?.pushReplacementNamed(AppRoutes.signIn);
          },
        );
        return;
      }

      if (homeData.verified != true) {
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.emailVerification),
          description: context.tr(
            AppStrings.youMustVerifyYourEmailAddressToEnjoyAllFeatures,
          ),
          noColoredButtonOnTap: () => Navigator.of(context).pop(),
          coloredButtonText: context.tr(AppStrings.verify),
          noColoredButtonText: context.tr(AppStrings.cancel),
          coloredButtonOnTap: () {
            Navigator.of(context).pop();
            navigatorKey.currentState?.pushNamed(
              AppRoutes.emailVerification,
              arguments: AppRoutesArgs.emailVerificationRouteArgs(
                currentDoctorModel: currentDoctorModel,
              ),
            );
          },
        );
        return;
      }

      navigatorKey.currentState?.pushNamed(
        AppRoutes.addPatient,
        arguments: AppRoutesArgs.addPatientRouteArgs(
          currentDoctorModel: cubit.currentDoctorModel,
          currentDoctorRole: homeData.role.toString(),
          currentDoctorPoints: int.parse(homeData.scoreValue!),
          homeDataModel: homeData,
        ),
      );
      return;
    }

    // Not verified → Create post
    if (PermissionHelper.canPermission(AppPermissions.addPostInHome)) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.createPostInCommunity,
        arguments: AppRoutesArgs.createPostInCommunityRouteArgs(
          currentDoctorModel: currentDoctorModel,
          homeDataModel: homeData,
        ),
      );
    }
  }
}
