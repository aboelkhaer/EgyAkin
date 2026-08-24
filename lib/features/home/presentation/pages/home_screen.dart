import 'package:egy_akin/app/shared/functions/blocked_dialog.dart';
import 'package:egy_akin/app/shared/functions/update_dialog.dart';
import 'package:egy_akin/app/services/deep_link_handler.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patients_tab.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/patients_header.dart';
import 'package:egy_akin/features/inbox/presentation/pages/inbox_screen.dart';

import '../../../../exports.dart';

class HomeScreen extends StatefulWidget {
  final int page;
  const HomeScreen({super.key, required this.page});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit? cubit;
  int _deepLinkRetryCount = 0;

  static const int _profileTabIndex = 4;
  static const int _patientsTabIndex = 1;
  static const int _communityTabIndex = 2;
  static const int _inboxTabIndex = 3;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<HomeCubit>();
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    cubit!.getHome();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        cubit!.tabsController.jumpToTab(widget.page);
      }
    });
  }

  void _checkForPendingDeepLinks() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        final homeCubit = context.read<HomeCubit>();
        final hasHomeData = homeCubit.homeDataModel.data != null;
        final hasDoctorData = homeCubit.currentDoctorModel.id != null;

        if (hasHomeData && hasDoctorData) {
          final deepLinkHandler = DeepLinkHandler();
          deepLinkHandler.checkAndProcessPendingDeepLinks(context);
        } else if (_deepLinkRetryCount < 5) {
          _deepLinkRetryCount++;
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) _checkForPendingDeepLinks();
          });
        } else {
          _deepLinkRetryCount = 0;
        }
      }
    });
  }

  String _doctorInitials() {
    final first = cubit?.currentDoctorModel.firstName;
    final last = cubit?.currentDoctorModel.lastName;
    final a = (first != null && first.isNotEmpty) ? first[0] : '';
    final b = (last != null && last.isNotEmpty) ? last[0] : '';
    final initials = ('$a$b').toUpperCase();
    return initials.isEmpty ? 'DR' : initials;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final headerColor = HomeDashboardColors.header(isDarkMode);

        return BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) {
            int indexOf(HomeState state) => state.maybeWhen(
                  loaded: (
                    _,
                    __,
                    ___,
                    homeIndex,
                    ____,
                    _____,
                    ______,
                    _______,
                    ________,
                    __________,
                  ) =>
                      homeIndex,
                  loading: (index) => index,
                  orElse: () => cubit?.tabsController.index ?? 0,
                );
            return indexOf(previous) != indexOf(current);
          },
          builder: (context, homeState) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                // Transparent so Community (and home) gradients paint into the status bar.
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                    isDarkMode ? Brightness.dark : Brightness.light,
                systemStatusBarContrastEnforced: false,
              ),
              child: Scaffold(
                backgroundColor: HomeDashboardColors.scaffold(isDarkMode),
                body: Column(
                  children: [
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
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
                            if (cubit!.shouldShowUpdateMessage) {
                              showUpdateDialog(
                                context: context,
                                onDismissed: () {
                                  cubit!.setUpdateMessageStatusToLocal();
                                },
                              );
                            }

                            if (homeData.isUserBlocked == true) {
                              showBlockedDialog(
                                context: context,
                                onDismissed: () {
                                  cubit!.signOut();
                                },
                              );
                            }

                            if (isUserBlocked) {
                              navigatorKey.currentState
                                  ?.pushReplacementNamed(AppRoutes.signIn);
                            }

                            Future.delayed(const Duration(seconds: 1), () {
                              if (mounted) _checkForPendingDeepLinks();
                            });
                          },
                        );
                      },
                      builder: (context, state) {
                        int tabIndex(HomeState current) {
                          return current.maybeWhen(
                            loaded: (
                              _,
                              __,
                              ___,
                              homeIndex,
                              ____,
                              _____,
                              ______,
                              _______,
                              ________,
                              __________,
                            ) =>
                                homeIndex,
                            loading: (index) => index,
                            orElse: () => cubit!.tabsController.index,
                          );
                        }

                        Widget header(int index) {
                          if (index == _profileTabIndex ||
                              index == _communityTabIndex ||
                              index == _inboxTabIndex) {
                            return const SizedBox.shrink();
                          }

                          return ColoredBox(
                            color: headerColor,
                            child: SafeArea(
                              bottom: false,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: isDarkMode
                                        ? [
                                            HomeDashboardColors.headerDark,
                                            AppColors.darkScaffoldBG,
                                          ]
                                        : [
                                            HomeDashboardColors.headerLight,
                                            const Color(0xFFF5F5F7),
                                          ],
                                  ),
                                ),
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 10.h),
                                child: index == _patientsTabIndex
                                    ? PatientsHeader(cubit: cubit!)
                                    : HomeHeader(cubit: cubit!),
                              ),
                            ),
                          );
                        }

                        return state.maybeWhen(
                          orElse: () => header(tabIndex(state)),
                          loading: (index) => header(index),
                          loaded: (
                            homeData,
                            currentDoctorModel,
                            dotsPosition,
                            homeIndex,
                            isUploadingSyndicateCard,
                            isUploadedSyndicateCar,
                            message,
                            checkUpdateMessageCounter,
                            isUserBlocked,
                            changesCounter,
                          ) {
                            return header(homeIndex);
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: PersistentTabView(
                        context,
                        controller: cubit!.tabsController,
                        items: _navBarsItems(context, isDarkMode),
                        screens: _buildScreens(cubit!),
                        onItemSelected: (value) {
                          cubit!.hideHomeHeader(value);
                        },
                        // Keep safe-area padding OUT of the floating pill so
                        // there is no empty gap under the icons.
                        confineInSafeArea: false,
                        backgroundColor:
                            isDarkMode ? AppColors.darkCardBG : Colors.white,
                        popAllScreensOnTapAnyTabs: true,
                        handleAndroidBackButtonPress: true,
                        resizeToAvoidBottomInset: true,
                        stateManagement: true,
                        hideNavigationBarWhenKeyboardShows: true,
                        margin: EdgeInsets.fromLTRB(
                          14.w,
                          0,
                          14.w,
                          20.h,
                        ),
                        bottomScreenMargin: 78.h,
                        padding: const NavBarPadding.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: NavBarDecoration(
                          borderRadius: BorderRadius.circular(32.r),
                          colorBehindNavBar:
                              HomeDashboardColors.scaffold(isDarkMode),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(isDarkMode ? 0.35 : 0.1),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: isDarkMode
                                ? AppColors.darkBorder.withOpacity(0.6)
                                : const Color(0xFFE8E8EE),
                          ),
                        ),
                        popAllScreensOnTapOfSelectedTab: true,
                        itemAnimationProperties: const ItemAnimationProperties(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease,
                        ),
                        screenTransitionAnimation:
                            const ScreenTransitionAnimation(
                          animateTabTransition: true,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 200),
                        ),
                        navBarStyle: NavBarStyle.style7,
                        navBarHeight: 72,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildScreens(HomeCubit cubit) {
    return [
      HomeTab(cubit: cubit),
      HomePatientsTab(cubit: cubit),
      CommunityScreen(
        currentDoctorModel: cubit.currentDoctorModel,
        homeDataModel: cubit.homeDataModel,
        initialTab: 0,
        isEmbeddedInHomeTab: true,
      ),
      InboxScreen(
        currentDoctorModel: cubit.currentDoctorModel,
        homeDataModel: cubit.homeDataModel,
      ),
      BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ProfileScreen(
                isSyndicateCardRequired: cubit.isSyndicateCardRequired,
                accountVerification: false,
                currentDoctorRole: cubit.currentDoctorRole,
                currentDoctorModel: cubit.currentDoctorModel,
                homeDataModel: cubit.homeDataModel,
                currentDoctorPoints: cubit.doctorScore == null
                    ? 0
                    : int.parse(cubit.doctorScore!),
              );
            },
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
              return ProfileScreen(
                isSyndicateCardRequired: cubit.isSyndicateCardRequired,
                accountVerification: cubit.accountVerification ?? false,
                homeDataModel: homeData,
                currentDoctorModel: cubit.currentDoctorModel,
                currentDoctorPoints: cubit.doctorScore == null
                    ? 0
                    : int.parse(cubit.doctorScore!),
                currentDoctorRole: homeData.role.toString(),
              );
            },
          );
        },
      ),
    ];
  }

  Widget _badgeIcon({
    required IconData icon,
    required String count,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 22.sp),
        if (count != '0' && count.isNotEmpty)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: HomeDashboardColors.danger,
                borderRadius: BorderRadius.circular(8.r),
              ),
              constraints: BoxConstraints(minWidth: 14.r),
              child: Text(
                count,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(
    BuildContext context,
    bool isDarkMode,
  ) {
    final activeColor = isDarkMode ? AppColors.darkPrimary : AppColors.primary;
    final inactiveColor =
        isDarkMode ? AppColors.darkDescription : const Color(0xFF9CA3AF);
    final unread = cubit?.homeDataModel.unreadCount?.toString() ?? '0';
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 11.sp,
    );

    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_rounded, size: 22.sp),
        title: context.tr(AppStrings.home),
        textStyle: titleStyle,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.groups_rounded, size: 22.sp),
        title: context.tr(AppStrings.patients),
        textStyle: titleStyle,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: _badgeIcon(icon: Icons.explore_outlined, count: '4'),
        inactiveIcon: _badgeIcon(icon: Icons.explore_outlined, count: '4'),
        title: context.tr(AppStrings.community),
        textStyle: titleStyle,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: _badgeIcon(icon: Icons.mail_outline_rounded, count: unread),
        inactiveIcon:
            _badgeIcon(icon: Icons.mail_outline_rounded, count: unread),
        title: context.tr(AppStrings.inbox),
        textStyle: titleStyle,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        // Selected style7 pill shows avatar + "Profile" (matches mockup).
        icon: CircleAvatar(
          radius: 11.r,
          backgroundColor: Colors.white.withOpacity(0.28),
          child: Text(
            _doctorInitials(),
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        inactiveIcon: CircleAvatar(
          radius: 11.r,
          backgroundColor: inactiveColor.withOpacity(0.16),
          child: Text(
            _doctorInitials(),
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w800,
              color: inactiveColor,
            ),
          ),
        ),
        title: context.tr(AppStrings.profile),
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 11.sp,
        ),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: Colors.white,
      ),
    ];
  }
}
