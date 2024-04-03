import 'package:egy_akin/features/notification/domain/usecases/get_all_notifications_usecase.dart';
import 'package:egy_akin/features/notification/domain/usecases/update_notification_usecase.dart';

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

  updateNotification() async {
    final result = await _updateNotificationUsecase.excute(NoParams());

    result.fold(
      (l) {
        emit(NotificationState.error(l.message));
      },
      (r) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => NotificationState.loaded(value.notificationData),
        ));
      },
    );
  }

  getAllNotifications() async {
    emit(const NotificationState.loading());
    final result = await _getAllNotificationUsecase.excute(NoParams());

    result.fold(
      (l) {
        emit(NotificationState.error(l.message));
      },
      (notificationData) async {
        emit(NotificationState.loaded(notificationData));
        // updateNotification();
      },
    );
  }
}
