import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_comment_on_post_model_response.freezed.dart';
part 'add_comment_on_post_model_response.g.dart';

@freezed
class AddCommentOnPostModelResponse with _$AddCommentOnPostModelResponse {
  const factory AddCommentOnPostModelResponse({
    bool? value,
    String? message,
  }) = _AddCommentOnPostModelResponse;
  factory AddCommentOnPostModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCommentOnPostModelResponseFromJson(json);
}
