// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_sort_models.freezed.dart';
part 'patient_sort_models.g.dart';

@freezed
class SortOptionModelResponse with _$SortOptionModelResponse {
  const factory SortOptionModelResponse({
    String? key,
    String? label,
    @JsonKey(name: 'default_direction') String? defaultDirection,
  }) = _SortOptionModelResponse;

  factory SortOptionModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SortOptionModelResponseFromJson(json);
}

@freezed
class AppliedSortModelResponse with _$AppliedSortModelResponse {
  const factory AppliedSortModelResponse({
    String? key,
    String? direction,
  }) = _AppliedSortModelResponse;

  factory AppliedSortModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AppliedSortModelResponseFromJson(json);
}
