import 'package:freezed_annotation/freezed_annotation.dart';
part 'delete_post_comment_model_response.freezed.dart';
part 'delete_post_comment_model_response.g.dart';

@freezed
class DeletePostCommentModelResponse with _$DeletePostCommentModelResponse {
  const factory DeletePostCommentModelResponse({
    String? message,
  }) = _DeletePostCommentModelResponse;
  factory DeletePostCommentModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePostCommentModelResponseFromJson(json);
}
