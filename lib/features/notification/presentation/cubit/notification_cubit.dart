import '../../../../exports.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(
      this._updateNotificationUsecase, this._getAllNotificationUsecase)
      : super(const NotificationState.initial());
  final UpdateNotificationUsecase _updateNotificationUsecase;
  final GetAllNotificationUsecase _getAllNotificationUsecase;
  static NotificationCubit get(context) => BlocProvider.of(context);
  ScrollController? scrollController;

  DateTime? _lastFetchedAt;
  static const Duration _cacheTtl = Duration(minutes: 3);

  bool get hasCachedNotifications => state.maybeWhen(
        loaded: (_, __) => true,
        orElse: () => false,
      );

  bool get _isCacheFresh =>
      _lastFetchedAt != null &&
      DateTime.now().difference(_lastFetchedAt!) < _cacheTtl;

  /// Prefer cached list when opening the tab. Refetch only when empty,
  /// stale, or [force] (e.g. unread badge / pull-to-refresh).
  Future<void> ensureNotificationsLoaded({bool force = false}) async {
    if (!force && hasCachedNotifications && _isCacheFresh) return;
    await getAllNotifications(showLoading: !hasCachedNotifications);
  }

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

  int currentPage = 1;

  Future<void> getAllNotifications({bool showLoading = true}) async {
    if (showLoading) {
      emit(const NotificationState.loading());
    }
    currentPage = 1;
    isLastPage = false;
    final result = await _getAllNotificationUsecase.execute(currentPage);

    await result.fold<Future<void>>(
      (l) async {
        emit(NotificationState.error(l.message));
      },
      (notificationData) async {
        _lastFetchedAt = DateTime.now();
        emit(NotificationState.loaded(notificationData, false));
        // Mark all as read on the server so the home header badge stays cleared.
        await updateNotification();
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
