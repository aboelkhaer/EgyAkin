// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_comment_on_post_in_community_model_response.freezed.dart';
part 'delete_comment_on_post_in_community_model_response.g.dart';

@freezed
class DeleteCommentOnPostInCommunityModelResponse
    with _$DeleteCommentOnPostInCommunityModelResponse {
  const factory DeleteCommentOnPostInCommunityModelResponse({
    String? message,
  }) = _DeleteCommentOnPostInCommunityModelResponse;

  factory DeleteCommentOnPostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteCommentOnPostInCommunityModelResponseFromJson(json);
}
