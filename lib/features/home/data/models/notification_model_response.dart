// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model_response.freezed.dart';
part 'notification_model_response.g.dart';

@freezed
class NotificationModelResponse with _$NotificationModelResponse {
  const factory NotificationModelResponse({
    bool? value,
    int? unreadCount,
    List<NotificationDataModelResponse>? data,
  }) = _NotificationModelResponse;
  factory NotificationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelResponseFromJson(json);
}

@freezed
class NotificationDataModelResponse with _$NotificationDataModelResponse {
  const factory NotificationDataModelResponse({
    int? id,
    String? type,
    bool? read,
    @JsonKey(name: 'created_at') String? createdAt,
    PatientNotificationDataModelResponse? patient,
  }) = _NotificationDataModelResponse;
  factory NotificationDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataModelResponseFromJson(json);
}

@freezed
class PatientNotificationDataModelResponse
    with _$PatientNotificationDataModelResponse {
  const factory PatientNotificationDataModelResponse({
    int? id,
    String? name,
    String? hospital,
    String? governorate,
    DoctorNotificationDataModelResponse? doctor,
    SectionsNotificationDataModelResponse? sections,
  }) = _PatientNotificationDataModelResponse;
  factory PatientNotificationDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PatientNotificationDataModelResponseFromJson(json);
}

@freezed
class DoctorNotificationDataModelResponse
    with _$DoctorNotificationDataModelResponse {
  const factory DoctorNotificationDataModelResponse({
    int? id,
    @JsonKey(name: 'name') String? firstName,
    @JsonKey(name: 'lname') String? lastName,
    String? workingplace,
  }) = _DoctorNotificationDataModelResponse;
  factory DoctorNotificationDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DoctorNotificationDataModelResponseFromJson(json);
}

@freezed
class SectionsNotificationDataModelResponse
    with _$SectionsNotificationDataModelResponse {
  const factory SectionsNotificationDataModelResponse({
    int? id,
    @JsonKey(name: 'submit_status') bool? submitStatus,
    @JsonKey(name: 'outcome_status') bool? outcomeStatus,
    String? workingplace,
  }) = _SectionsNotificationDataModelResponse;
  factory SectionsNotificationDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SectionsNotificationDataModelResponseFromJson(json);
}
