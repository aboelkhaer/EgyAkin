import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loading() = _Loading;
  const factory NotificationState.loaded(
          GetAllNotificationsModelResponse notificationData, bool isSeeMore) =
      _Loaded;
  const factory NotificationState.error(String message) = _Error;
}
