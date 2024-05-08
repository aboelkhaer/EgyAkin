import '../../../../exports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().scrollController.addListener(_onScroll);
    // context.read<NotificationCubit>().loadMoreNotifications();
  }

  @override
  void dispose() {
    context.read<NotificationCubit>().scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = context
        .read<NotificationCubit>()
        .scrollController
        .position
        .maxScrollExtent;
    final currentScroll =
        context.read<NotificationCubit>().scrollController.position.pixels;
    const threshold = 200.0;
    if (context.read<NotificationCubit>().isLoadingMoreForScroll == false &&
        maxScroll - currentScroll <= threshold) {
      context.read<NotificationCubit>().isLoadingMoreForScroll = true;

      context.read<NotificationCubit>().loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    NotificationCubit cubit = NotificationCubit.get(context);
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            // return await cubit.onRefreshInicator();
            await cubit.getAllNotifications();
            // await cubit.updateNotification();
            await Future.delayed(const Duration(
                milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
          },
          color: AppColors.primary,
          child: SingleChildScrollView(
            controller: cubit.scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const ShimmerLoadingPatientsCards(
                            ishorizontal: false,
                          );
                        },
                        loaded: (notificationData, isSeeMore) {
                          return notificationData.todayRecords!.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Today',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    NotificationsView(
                                        notificationsModel:
                                            notificationData.todayRecords!),
                                  ],
                                );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 5.h),
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const ShimmerLoadingPatientsCards(
                            ishorizontal: false,
                          );
                        },
                        loading: () {
                          return const ShimmerLoadingPatientsCards(
                            ishorizontal: false,
                          );
                        },
                        loaded: (notificationData, isSeeMore) {
                          return Column(
                            children: [
                              notificationData.recentRecords!.data!.isEmpty
                                  ? const SizedBox.shrink()
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Recent',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                      ],
                                    ),
                              NotificationsView(
                                  notificationsModel:
                                      notificationData.recentRecords!.data!),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox.shrink();
                        },
                        loaded: (notificationData, isSeeMore) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isSeeMore
                                  ? const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        cubit.loadMoreNotifications();
                                      },
                                      child: const Text(
                                        '',
                                      ),
                                    ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 20.w,
          bottom: 20.h,
          child: Ink(
            decoration: ShapeDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: const CircleBorder(),
            ),
            child: IconButton(
              onPressed: () {
                animateToTopOfScreen(cubit.scrollController);
              },
              icon: const Icon(
                Icons.keyboard_arrow_up_outlined,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
