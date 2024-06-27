// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exports.dart';
part 'get_search_model_response.freezed.dart';
part 'get_search_model_response.g.dart';

@freezed
class GetSearchModelResponse with _$GetSearchModelResponse {
  const factory GetSearchModelResponse({
    bool? value,
    GetSearchDataModelResponse? data,
  }) = _GetSearchModelResponse;
  factory GetSearchModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSearchModelResponseFromJson(json);
}

@freezed
class GetSearchDataModelResponse with _$GetSearchDataModelResponse {
  const factory GetSearchDataModelResponse({
    List<PatientHomeDataModel>? patients,
    List<SearchDataForDosesModelResponse>? doses,
  }) = _GetSearchDataModelResponse;
  factory GetSearchDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSearchDataModelResponseFromJson(json);
}

@freezed
class SearchDataForDosesModelResponse with _$SearchDataForDosesModelResponse {
  const factory SearchDataForDosesModelResponse({
    int? id,
    String? title,
    String? description,
    String? dose,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _SearchDataForDosesModelResponse;
  factory SearchDataForDosesModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDataForDosesModelResponseFromJson(json);
}
