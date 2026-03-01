// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_marked_patients_model_response.freezed.dart';
part 'get_marked_patients_model_response.g.dart';

@freezed
class GetMarkedPatientsModelResponse with _$GetMarkedPatientsModelResponse {
  const factory GetMarkedPatientsModelResponse({
    GetMarkedPatientsDataModelResponse? data,
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _GetMarkedPatientsModelResponse;
  factory GetMarkedPatientsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMarkedPatientsModelResponseFromJson(json);
}

@freezed
class GetMarkedPatientsDataModelResponse
    with _$GetMarkedPatientsDataModelResponse {
  const factory GetMarkedPatientsDataModelResponse({
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
  }) = _GetMarkedPatientsDataModelResponse;
  factory GetMarkedPatientsDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetMarkedPatientsDataModelResponseFromJson(json);
}
