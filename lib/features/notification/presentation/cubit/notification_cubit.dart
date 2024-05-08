import '../../../../exports.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(
      this._updateNotificationUsecase, this._getAllNotificationUsecase)
      : super(const NotificationState.initial());
  final UpdateNotificationUsecase _updateNotificationUsecase;
  final GetAllNotificationUsecase _getAllNotificationUsecase;
  static NotificationCubit get(context) => BlocProvider.of(context);

  // @override
  // Future<void> close() {
  //   // updateNotification();
  //   return super.close();
  // }

  // onRefreshInicator() async {
  //   sl<HomeCubit>().getHome();
  //   sl<HomeCubit>().getNotifications();
  //   await Future.delayed(const Duration(
  //       milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
  //   WidgetsBinding.instance.addPostFrameCallback((_) => updateNotification());
  // }

  // fetchNotifications(List<NotificationDataModelResponse> notifications) {
  //   // Update state with received notifications
  //   emit(NotificationState.loaded(notifications));
  // }
  // @override
  // Future<void> close() {
  //   scrollController.dispose();
  //   return super.close();
  // }

  updateNotification() async {
    final result = await _updateNotificationUsecase.excute(NoParams());

    result.fold(
      (l) {
        emit(NotificationState.error(l.message));
      },
      (r) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) =>
              NotificationState.loaded(value.notificationData, false),
        ));
      },
    );
  }

  int _currentPage = 1;

  getAllNotifications() async {
    emit(const NotificationState.loading());
    final result = await _getAllNotificationUsecase.excute(_currentPage);

    result.fold(
      (l) {
        emit(NotificationState.error(l.message));
      },
      (notificationData) async {
        emit(NotificationState.loaded(notificationData, false));
        // sl<HomeCubit>().getHome();
      },
    );
  }

  final ScrollController scrollController = ScrollController();
  bool isLoadingMoreForScroll = false;

  void loadMoreNotifications() async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => NotificationState.loaded(value.notificationData, true),
    ));
    final result = await _getAllNotificationUsecase.excute(_currentPage);
    result.fold(
      (l) {
        _currentPage--;
        emit(NotificationState.error(l.message));
      },
      (loadMoreNotifications) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (notificationData, isSeeMore) {
            final updatedData = notificationData.copyWith(
              recentRecords: notificationData.recentRecords!.copyWith(
                data: [
                  ...notificationData.recentRecords!.data!,
                  ...loadMoreNotifications.recentRecords!.data!
                ],
              ),
            );
            isLoadingMoreForScroll = false;
            emit(NotificationState.loaded(updatedData, false));
          },
          error: (error) {},
        );
      },
    );
  }
}
