// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_or_unsave_post_model_response.freezed.dart';
part 'save_or_unsave_post_model_response.g.dart';

@freezed
class SaveOrUnsavePostModelResponse with _$SaveOrUnsavePostModelResponse {
  const factory SaveOrUnsavePostModelResponse({
    String? message,
  }) = _SaveOrUnsavePostModelResponse;
  factory SaveOrUnsavePostModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SaveOrUnsavePostModelResponseFromJson(json);
}
