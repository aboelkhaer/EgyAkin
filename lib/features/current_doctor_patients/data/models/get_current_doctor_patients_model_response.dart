// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_current_doctor_patients_model_response.freezed.dart';
part 'get_current_doctor_patients_model_response.g.dart';

@freezed
class GetDoctorPatientsModelResponse with _$GetDoctorPatientsModelResponse {
  const factory GetDoctorPatientsModelResponse({
    bool? value,
    bool? verified,
    @JsonKey(name: 'score_value') String? scoreValue,
    @JsonKey(name: 'patient_count') String? patientCount,
    @JsonKey(name: 'filter') List<GetFiltersOptionsDataModelResponse>? filters,
    GetDoctorPatientsDataModelResponse? data,
  }) = _GetDoctorPatientsModelResponse;
  factory GetDoctorPatientsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorPatientsModelResponseFromJson(json);
}

@freezed
class GetDoctorPatientsDataModelResponse
    with _$GetDoctorPatientsDataModelResponse {
  const factory GetDoctorPatientsDataModelResponse({
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
  }) = _GetDoctorPatientsDataModelResponse;
  factory GetDoctorPatientsDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetDoctorPatientsDataModelResponseFromJson(json);
}
