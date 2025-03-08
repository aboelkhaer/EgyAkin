// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_reply_on_comment_in_community_model_response.freezed.dart';
part 'delete_reply_on_comment_in_community_model_response.g.dart';

@freezed
class DeleteReplyOnCommentInCommunityModelResponse
    with _$DeleteReplyOnCommentInCommunityModelResponse {
  const factory DeleteReplyOnCommentInCommunityModelResponse({
    String? message,
  }) = _DeleteReplyOnCommentInCommunityModelResponse;

  factory DeleteReplyOnCommentInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteReplyOnCommentInCommunityModelResponseFromJson(json);
}
