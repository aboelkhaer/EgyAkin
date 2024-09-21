// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'block_user_model_response.freezed.dart';
part 'block_user_model_response.g.dart';

@freezed
class BlockUserModelResponse with _$BlockUserModelResponse {
  const factory BlockUserModelResponse({
    String? message,
  }) = _BlockUserModelResponse;
  factory BlockUserModelResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockUserModelResponseFromJson(json);
}
