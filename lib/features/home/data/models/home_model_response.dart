// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_model_response.freezed.dart';
part 'home_model_response.g.dart';

@freezed
class HomeModelResponse with _$HomeModelResponse {
  const factory HomeModelResponse({
    bool? value,
    bool? verified,
    String? unreadCount,
    @JsonKey(name: 'patient_count') String? patientCount,
    @JsonKey(name: 'score_value') String? scoreValue,
    @JsonKey(name: 'role') String? role,
    HomeDataModelResponse? data,
  }) = _HomeModelResponse;
  factory HomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeModelResponseFromJson(json);
}

@freezed
class HomeDataModelResponse with _$HomeDataModelResponse {
  const factory HomeDataModelResponse({
    @JsonKey(name: 'all_patients') List<PatientHomeDataModel>? allPatients,
    @JsonKey(name: 'current_patient')
    List<PatientHomeDataModel>? currentPatients,
    List<PostHomeDataModel>? posts,
  }) = _HomeDataModelResponse;
  factory HomeDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelResponseFromJson(json);
}

@freezed
class PatientHomeDataModel with _$PatientHomeDataModel {
  const factory PatientHomeDataModel({
    int? id,
    @JsonKey(name: 'doctor_id') String? doctorId,
    String? name,
    String? hospital,
    @JsonKey(name: 'updated_at') String? updatedAt,
    DoctorHomeDataModel? doctor,
    SectionHomeDataModel? sections,
  }) = _PatientHomeDataModel;
  factory PatientHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeDataModelFromJson(json);
}

@freezed
class DoctorHomeDataModel with _$DoctorHomeDataModel {
  const factory DoctorHomeDataModel({
    int? id,
    @JsonKey(name: 'name') String? firstName,
    @JsonKey(name: 'lname') String? lastName,
  }) = _DoctorHomeDataModel;
  factory DoctorHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorHomeDataModelFromJson(json);
}

@freezed
class SectionHomeDataModel with _$SectionHomeDataModel {
  const factory SectionHomeDataModel({
    @JsonKey(name: 'patient_id') String? patientId,
    @JsonKey(name: 'submit_status') bool? submitStatus,
    @JsonKey(name: 'outcome_status') bool? outcomeStatus,
  }) = _SectionHomeDataModel;
  factory SectionHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$SectionHomeDataModelFromJson(json);
}

@freezed
class PostHomeDataModel with _$PostHomeDataModel {
  const factory PostHomeDataModel({
    int? id,
    String? title,
    String? content,
    String? image,
    bool? hidden,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'updated_at') String? updatedAt,
    DoctorHomeDataModel? doctor,
  }) = _PostHomeDataModel;
  factory PostHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$PostHomeDataModelFromJson(json);
}
