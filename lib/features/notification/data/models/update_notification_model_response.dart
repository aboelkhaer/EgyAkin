import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_notification_model_response.freezed.dart';
part 'update_notification_model_response.g.dart';

@freezed
class UpdateNotificationModelResponse with _$UpdateNotificationModelResponse {
  const factory UpdateNotificationModelResponse({
    bool? value,
    String? message,
  }) = _UpdateNotificationModelResponse;
  factory UpdateNotificationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotificationModelResponseFromJson(json);
}
