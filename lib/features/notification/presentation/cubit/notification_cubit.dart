import '../../../../exports.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(
      this._updateNotificationUsecase, this._getAllNotificationUsecase)
      : super(const NotificationState.initial());
  final UpdateNotificationUsecase _updateNotificationUsecase;
  final GetAllNotificationUsecase _getAllNotificationUsecase;
  static NotificationCubit get(context) => BlocProvider.of(context);
  ScrollController? scrollController;

  updateNotification() async {
    final result = await _updateNotificationUsecase.execute(NoParams());

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

  int currentPage = 0;

  getAllNotifications() async {
    emit(const NotificationState.loading());
    currentPage = 0;
    final result = await _getAllNotificationUsecase.execute(currentPage);

    result.fold(
      (l) {
        emit(NotificationState.error(l.message));
      },
      (notificationData) async {
        emit(NotificationState.loaded(notificationData, false));
      },
    );
  }

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;

  loadMoreNotifications() async {
    currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => NotificationState.loaded(value.notificationData, true),
    ));
    final result = await _getAllNotificationUsecase.execute(currentPage);
    result.fold(
      (l) {
        currentPage--;
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
            if (currentPage >= notificationData.recentRecords!.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            // emit(NotificationState.loaded(updatedData, false));
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => NotificationState.loaded(updatedData, false),
            ));
          },
          error: (error) {},
        );
      },
    );
  }
}
