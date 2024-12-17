// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_post_model_response.freezed.dart';
part 'delete_post_model_response.g.dart';

@freezed
class DeletePostModelResponse with _$DeletePostModelResponse {
  const factory DeletePostModelResponse({
    String? message,
  }) = _DeletePostModelResponse;
  factory DeletePostModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePostModelResponseFromJson(json);
}
