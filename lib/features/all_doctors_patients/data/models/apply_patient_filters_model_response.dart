// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/home/data/models/home_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'apply_patient_filters_model_response.freezed.dart';
part 'apply_patient_filters_model_response.g.dart';

@freezed
class ApplyPatientFiltersModelResponse with _$ApplyPatientFiltersModelResponse {
  const factory ApplyPatientFiltersModelResponse({
    List<PatientHomeDataModel>? data,
    PaginationFiltersModelResponse? pagination,
  }) = _ApplyPatientFiltersModelResponse;
  factory ApplyPatientFiltersModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ApplyPatientFiltersModelResponseFromJson(json);
}

@freezed
class PaginationFiltersModelResponse with _$PaginationFiltersModelResponse {
  const factory PaginationFiltersModelResponse({
    int? total,
    @JsonKey(name: 'last_page') int? lastPage,
  }) = _PaginationFiltersModelResponse;
  factory PaginationFiltersModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationFiltersModelResponseFromJson(json);
}
