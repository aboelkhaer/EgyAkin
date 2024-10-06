// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_filters_options_model_response.freezed.dart';
part 'get_filters_options_model_response.g.dart';

@freezed
class GetFiltersOptionsModelResponse with _$GetFiltersOptionsModelResponse {
  const factory GetFiltersOptionsModelResponse({
    List<GetFiltersOptionsDataModelResponse>? data,
  }) = _GetFiltersOptionsModelResponse;
  factory GetFiltersOptionsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFiltersOptionsModelResponseFromJson(json);
}

@freezed
class GetFiltersOptionsDataModelResponse
    with _$GetFiltersOptionsDataModelResponse {
  const factory GetFiltersOptionsDataModelResponse({
    int? id,
    String? condition,
    List<dynamic>? values,
    String? type,
    @JsonKey(name: 'keyboard_type') String? keyboardType,
  }) = _GetFiltersOptionsDataModelResponse;
  factory GetFiltersOptionsDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetFiltersOptionsDataModelResponseFromJson(json);
}
