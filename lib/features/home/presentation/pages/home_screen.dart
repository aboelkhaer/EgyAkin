import '../../../../exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Column(
                    children: [
                      SizedBox(height: 50.h),
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
                loaded: (homeData, currentDoctorModel, dotsPosition,
                    notificationDataModel, homeIndex) {
                  if (homeIndex == 2) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      SizedBox(height: 50.h),
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
              screens: _buildScreens(
                cubit,
              ),
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
      const NotificationScreen(),
      const ProfileScreen(),
      const Center(child: Text('More')),
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
