// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_profile_patients_model_response.freezed.dart';
part 'get_profile_patients_model_response.g.dart';

@freezed
class GetProfilePatientsModelResponse with _$GetProfilePatientsModelResponse {
  const factory GetProfilePatientsModelResponse({
    bool? value,
    GetProfilePatientsDataModelResponse? data,
  }) = _GetProfilePatientsModelResponse;
  factory GetProfilePatientsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProfilePatientsModelResponseFromJson(json);
}

@freezed
class GetProfilePatientsDataModelResponse
    with _$GetProfilePatientsDataModelResponse {
  const factory GetProfilePatientsDataModelResponse({
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
  }) = _GetProfilePatientsDataModelResponse;
  factory GetProfilePatientsDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetProfilePatientsDataModelResponseFromJson(json);
}
