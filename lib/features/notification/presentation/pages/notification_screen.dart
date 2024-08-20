import '../../../../exports.dart';

class NotificationScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  const NotificationScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = NotificationCubit.get(context);
    _cubit.scrollController = ScrollController();
    _cubit.scrollController!.addListener(_onScroll);
  }

  @override
  void dispose() {
    _cubit.scrollController!.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_cubit.isLastPage) return;

    final maxScroll = _cubit.scrollController!.position.maxScrollExtent;
    final currentScroll = _cubit.scrollController!.position.pixels;
    const threshold = 200.0;

    if (!_cubit.isLoadingMoreForScroll &&
        maxScroll - currentScroll <= threshold) {
      _cubit.isLoadingMoreForScroll = true;
      _cubit.loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await _cubit.getAllNotifications();
              // await _cubit.loadMoreNotifications();
            },
            color: AppColors.primary,
            child: Container(
              color: Colors.grey.shade100,
              child: SingleChildScrollView(
                controller: _cubit.scrollController,
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
                                              notificationData.todayRecords!,
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          currentDoctorRole:
                                              widget.currentDoctorRole,
                                          currentDoctorPoints:
                                              widget.currentDoctorPoints,
                                          accountVerification:
                                              widget.accountVerification,
                                          isSyndicateCardRequired:
                                              widget.isSyndicateCardRequired,
                                          homeDataModel: widget.homeDataModel,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                          currentDoctorRole:
                                              widget.currentDoctorRole,
                                          currentDoctorPoints:
                                              widget.currentDoctorPoints,
                                          accountVerification:
                                              widget.accountVerification,
                                          isSyndicateCardRequired:
                                              widget.isSyndicateCardRequired,
                                          homeDataModel: widget.homeDataModel,
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
                                            _cubit.loadMoreNotifications();
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
                  animateToTopOfScreen(_cubit.scrollController!);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_up_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
