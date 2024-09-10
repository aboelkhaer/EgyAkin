import '../../../../exports.dart';

class NotificationTabIcon extends StatelessWidget {
  const NotificationTabIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return state.maybeWhen(
        orElse: () {
          return Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.notifications),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                    loaded: (homeData,
                        currentDoctorModel,
                        dotsPosition,
                        homeIndex,
                        isUploadingSyndicateCard,
                        isUploadedSyndicateCard,
                        message) {
                      return Positioned(
                        left: 0,
                        right: 10.w,
                        top: 2.h,
                        child: homeData.unreadCount == null ||
                                homeData.unreadCount.toString() == '0'
                            ? const SizedBox.shrink()
                            : CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 5.r,
                                child: Text(
                                  homeData.unreadCount == null
                                      ? ''
                                      : homeData.unreadCount.toString(),
                                  style: TextStyle(
                                      fontSize: 7.sp, color: AppColors.white),
                                ),
                              ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
        loaded: (homeData, currentDoctorModel, dotsPosition, homeIndex,
            isUploadingSyndicateCard, isUploadedSyndicateCard, message) {
          return GestureDetector(
            onTap: () {
              if (context.read<HomeCubit>().tabsController.index != 1) {
                context.read<HomeCubit>().tabsController.jumpToTab(1);
              }

              context.read<HomeCubit>().hideHomeHeader();
              if (int.parse(homeData.unreadCount!) > 0) {
                context.read<NotificationCubit>().getAllNotifications();
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    context.read<HomeCubit>().getHome();
                  },
                );
              }
            },
            onLongPress: () {
              // context.read<NotificationCubit>().getAllNotifications();
              // context.read<HomeCubit>().getHome();
              // Future.delayed(
              //   const Duration(milliseconds: 300),
              //   () {
              //   },
              // );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.notifications),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox.shrink();
                      },
                      loaded: (homeData,
                          currentDoctorModel,
                          dotsPosition,
                          homeIndex,
                          isUploadingSyndicateCard,
                          isUploadedSyndicateCard,
                          message) {
                        return Positioned(
                          left: 0,
                          right: 10.w,
                          top: 2.h,
                          child: homeData.unreadCount == null ||
                                  homeData.unreadCount.toString() == '0'
                              ? const SizedBox.shrink()
                              : CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 5.r,
                                  child: Text(
                                    homeData.unreadCount == null
                                        ? ''
                                        : homeData.unreadCount.toString(),
                                    style: TextStyle(
                                        fontSize: 7.sp, color: AppColors.white),
                                  ),
                                ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
