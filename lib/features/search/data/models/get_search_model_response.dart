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
  }) = _GetSearchDataModelResponse;
  factory GetSearchDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSearchDataModelResponseFromJson(json);
}
