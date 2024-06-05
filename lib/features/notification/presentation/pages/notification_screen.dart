import '../../../../exports.dart';

class NotificationScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  const NotificationScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationCubit? _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<NotificationCubit>();

      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (context.read<NotificationCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<NotificationCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll =
          context.read<NotificationCubit>().scrollController!.position.pixels;
      const threshold = 200.0;
      if (context.read<NotificationCubit>().isLoadingMoreForScroll == false &&
          maxScroll - currentScroll <= threshold) {
        context.read<NotificationCubit>().isLoadingMoreForScroll = true;

        context.read<NotificationCubit>().loadMoreNotifications();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    NotificationCubit cubit = NotificationCubit.get(context);
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            await cubit.getAllNotifications();
            // await Future.delayed(const Duration(
            //     milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
            await cubit.loadMoreNotifications();
          },
          color: AppColors.primary,
          child: Container(
            color: Colors.grey.shade100,
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
                            // return const CircularProgressIndicator();
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
                                            notificationData.todayRecords!,
                                        currentDoctorModel:
                                            widget.currentDoctorModel,
                                        accountVerification:
                                            widget.accountVerification,
                                      ),
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
                            return const SizedBox.shrink();
                          },
                          loading: () {
                            return const SizedBox.shrink();
                          },
                          loaded: (notificationData, isSeeMore) {
                            return notificationData
                                        .recentRecords!.data!.isEmpty &&
                                    notificationData.todayRecords!.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(height: 100.h),
                                      Image.asset(
                                        AppImages.noNetwork,
                                        width: 150.w,
                                        height: 150.h,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      notificationData
                                              .recentRecords!.data!.isEmpty
                                          ? const SizedBox.shrink()
                                          : Row(
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
                                      NotificationsView(
                                        notificationsModel: notificationData
                                            .recentRecords!.data!,
                                        currentDoctorModel:
                                            widget.currentDoctorModel,
                                        accountVerification:
                                            widget.accountVerification,
                                      ),
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
                    SizedBox(height: 20.h),
                  ],
                ),
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
                animateToTopOfScreen(cubit.scrollController!);
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
