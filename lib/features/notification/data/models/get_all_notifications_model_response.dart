// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_all_notifications_model_response.freezed.dart';
part 'get_all_notifications_model_response.g.dart';

@freezed
class GetAllNotificationsModelResponse with _$GetAllNotificationsModelResponse {
  const factory GetAllNotificationsModelResponse({
    bool? value,
    String? unreadCount,
    List<NotificationsModel>? todayRecords,
    List<NotificationsModel>? recentRecords,
  }) = _GetAllNotificationsModelResponse;
  factory GetAllNotificationsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllNotificationsModelResponseFromJson(json);
}

@freezed
class NotificationsModel with _$NotificationsModel {
  const factory NotificationsModel({
    int? id,
    bool? read,
    String? type,
    @JsonKey(name: 'created_at') String? createdAt,
    PatientNotificationModel? patient,
  }) = _NotificationsModel;
  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);
}

@freezed
class PatientNotificationModel with _$PatientNotificationModel {
  const factory PatientNotificationModel({
    int? id,
    String? name,
    String? hospital,
    String? governorate,
    DoctorNotificationDataModel? doctor,
    SectionsNotificationDataModel? sections,
  }) = _PatientNotificationModel;
  factory PatientNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$PatientNotificationModelFromJson(json);
}

@freezed
class DoctorNotificationDataModel with _$DoctorNotificationDataModel {
  const factory DoctorNotificationDataModel({
    int? id,
    @JsonKey(name: 'name') String? firstName,
    @JsonKey(name: 'lname') String? lastName,
    String? workingplace,
  }) = _DoctorNotificationDataModel;
  factory DoctorNotificationDataModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorNotificationDataModelFromJson(json);
}

@freezed
class SectionsNotificationDataModel with _$SectionsNotificationDataModel {
  const factory SectionsNotificationDataModel({
    int? id,
    @JsonKey(name: 'submit_status') bool? submitStatus,
    @JsonKey(name: 'outcome_status') bool? outcomeStatus,
    String? workingplace,
  }) = _SectionsNotificationDataModel;
  factory SectionsNotificationDataModel.fromJson(Map<String, dynamic> json) =>
      _$SectionsNotificationDataModelFromJson(json);
}
