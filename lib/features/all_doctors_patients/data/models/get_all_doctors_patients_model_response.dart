// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_all_doctors_patients_model_response.freezed.dart';
part 'get_all_doctors_patients_model_response.g.dart';

@freezed
class GetAllDoctorsPatientsModelResponse
    with _$GetAllDoctorsPatientsModelResponse {
  const factory GetAllDoctorsPatientsModelResponse({
    bool? value,
    bool? verified,
    @JsonKey(name: 'score_value') String? scoreValue,
    @JsonKey(name: 'patient_count') String? patientCount,
    GetAllDoctorsPatientDataModelResponse? data,
  }) = _GetAllDoctorsPatientsModelResponse;
  factory GetAllDoctorsPatientsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllDoctorsPatientsModelResponseFromJson(json);
}

@freezed
class GetAllDoctorsPatientDataModelResponse
    with _$GetAllDoctorsPatientDataModelResponse {
  const factory GetAllDoctorsPatientDataModelResponse({
    @JsonKey(name: 'current_page') int? currentPage,
    List<PatientHomeDataModel>? data,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    List<Link>? links,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _GetAllDoctorsPatientDataModelResponse;
  factory GetAllDoctorsPatientDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllDoctorsPatientDataModelResponseFromJson(json);
}
