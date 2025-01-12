// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/show_single_feed/data/models/create_comment_on_post_in_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_reply_on_comment_in_community_model_response.freezed.dart';
part 'create_reply_on_comment_in_community_model_response.g.dart';

@freezed
class CreateReplyOnCommentInCommunityModelResponse
    with _$CreateReplyOnCommentInCommunityModelResponse {
  const factory CreateReplyOnCommentInCommunityModelResponse({
    String? message,
    CreateCommentOnPostInCommunityDataModelResponse? data,
  }) = _CreateReplyOnCommentInCommunityModelResponse;

  factory CreateReplyOnCommentInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateReplyOnCommentInCommunityModelResponseFromJson(json);
}
