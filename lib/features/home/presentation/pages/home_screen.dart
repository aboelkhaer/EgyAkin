import 'dart:developer';

import 'package:egy_akin/app/shared/functions/blocked_dialog.dart';
import 'package:egy_akin/app/shared/functions/update_dialog.dart';
import 'package:egy_akin/features/more/presentation/pages/more_screen.dart';

import '../../../../exports.dart';

class HomeScreen extends StatefulWidget {
  final int page;
  const HomeScreen({super.key, required this.page});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit? _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<HomeCubit>();
    });

    context.read<HomeCubit>().tabsController.jumpToTab(widget.page);
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);

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
                ) {
                  if (checkUpdateMessageCounter == 1) {
                    if (homeData.isUserBlocked == true) {
                      showBlockedDialog(
                        context: context,
                        onDismissed: () {
                          cubit.signOut();
                        },
                      );
                      cubit.checkUpdateMessageCounter++;
                    }
                    if (cubit.isUpdateMessageHidden == false) {
                      showUpdateDialog(
                        context: context,
                        onDismissed: () {
                          cubit.setUpdateMessageStatusToLocal();
                        },
                      );
                      cubit.checkUpdateMessageCounter++;
                    }
                  }
                  if (isUserBlocked) {
                    navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.signIn);
                  }
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
                        child: HomeHeader(cubit: cubit),
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
                        child: HomeHeader(cubit: cubit),
                      ),
                    ],
                  );
                },
              );
              // return cubit.hideHomeHeader(cubit);
            },
          ),
          Expanded(
            child: PersistentTabView(
              context,
              controller: cubit.tabsController,
              items: _navBarsItems(),
              screens: _buildScreens(cubit),
              onItemSelected: (value) {
                cubit.hideHomeHeader();
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
                ) {
                  return ProfileScreen(
                    isSyndicateCardRequired: cubit.isSyndicateCardRequired,
                    accountVerification: cubit.accountVerification!,
                    homeDataModel: homeData,
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
          return MoreScreen(
            currentDoctorModel: cubit.currentDoctorModel,
            accountVerification: cubit.accountVerification ?? true,
            homeDataModel: cubit.homeDataModel,
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
        icon: const Icon(Icons.person),
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
