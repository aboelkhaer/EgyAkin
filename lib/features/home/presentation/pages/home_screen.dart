import 'dart:developer';

import 'package:egy_akin/app/shared/functions/blocked_dialog.dart';
import 'package:egy_akin/app/shared/functions/update_dialog.dart';
import 'package:egy_akin/features/home/presentation/widgets/profile_tab_icon.dart';
import 'package:egy_akin/features/more/presentation/pages/more_screen.dart';
import 'package:egy_akin/app/services/deep_link_handler.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safely obtain the cubit from context when dependencies change
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

  @override
  void dispose() {
    super.dispose();
  }

  void _checkForPendingDeepLinks() {
    // Add a small delay to ensure the UI is fully ready
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Check if the home cubit has loaded data, which means we're ready
        final homeCubit = context.read<HomeCubit>();
        final hasHomeData = homeCubit.homeDataModel.data != null;
        final hasDoctorData = homeCubit.currentDoctorModel.id != null;
        
        debugPrint('Home screen checking deep links - Has home data: $hasHomeData, Has doctor data: $hasDoctorData');
        
        if (hasHomeData && hasDoctorData) {
          debugPrint('Home screen is ready, processing deep links');
          final deepLinkHandler = DeepLinkHandler();
          deepLinkHandler.checkAndProcessPendingDeepLinks(context);
        } else {
          debugPrint('Home screen not ready yet, will check again later');
          // Try again after a longer delay, but limit retries
          if (_deepLinkRetryCount < 5) {
            _deepLinkRetryCount++;
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                _checkForPendingDeepLinks();
              }
            });
          } else {
            debugPrint('Max retries reached, stopping deep link processing');
            _deepLinkRetryCount = 0;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // HomeCubit cubit = HomeCubit.get(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
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
                  if (cubit!.isUpdateMessageHidden4 == false) {
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

                  // Check for pending deep links after home data is loaded
                  // Add a longer delay to ensure the UI is fully ready
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) {
                      _checkForPendingDeepLinks();
                    }
                  });
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        child: HomeHeader(cubit: cubit!),
                      ),
                    ],
                  );
                },
                loading: (tabIndex) {
                  if (tabIndex == 2) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        child: HomeHeader(cubit: cubit!),
                      ),
                    ],
                  );
                },
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
                  if (homeIndex == 2) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        child: HomeHeader(cubit: cubit!),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Expanded(
            child: PersistentTabView(
              context,
              controller: cubit!.tabsController,
              items: _navBarsItems(),
              screens: _buildScreens(cubit!),
              onItemSelected: (value) {
                cubit!.hideHomeHeader(value);
              },
              confineInSafeArea: true,
              backgroundColor: Colors.white,
              popAllScreensOnTapAnyTabs: true,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              hideNavigationBarWhenKeyboardShows: true,
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1.0),
                ),
              ),
              popAllScreensOnTapOfSelectedTab: true,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style12,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildScreens(
    HomeCubit cubit,
  ) {
    return [
      HomeTab(cubit: cubit),
      BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return NotificationScreen(
            currentDoctorModel: cubit.currentDoctorModel,
            accountVerification: cubit.accountVerification ?? false,
            currentDoctorRole: cubit.currentDoctorRole,
            currentDoctorPoints:
                cubit.doctorScore == null ? 0 : int.parse(cubit.doctorScore!),
            isSyndicateCardRequired: cubit.isSyndicateCardRequired,
            homeDataModel: cubit.homeDataModel,
          );
        },
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
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
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
                    accountVerification: cubit.accountVerification!,
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
          );
        },
      ),
      BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return MoreScreen(
                currentDoctorModel: cubit.currentDoctorModel,
                accountVerification: cubit.accountVerification ?? true,
                homeDataModel: cubit.homeDataModel,
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
              return MoreScreen(
                currentDoctorModel: currentDoctorModel,
                accountVerification: homeData.verified ?? true,
                homeDataModel: homeData,
              );
            },
          );
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ('Home'),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const NotificationTabIcon(),
        title: ('Notification'),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const ProfileTabIcon(),
        title: ('Profile'),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.more_horiz),
        title: ('More'),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
