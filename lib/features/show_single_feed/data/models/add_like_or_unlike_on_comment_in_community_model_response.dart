// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_like_or_unlike_on_comment_in_community_model_response.freezed.dart';
part 'add_like_or_unlike_on_comment_in_community_model_response.g.dart';

@freezed
class AddLikeOrUnlikeOnCommentInCommunityModelResponse
    with _$AddLikeOrUnlikeOnCommentInCommunityModelResponse {
  const factory AddLikeOrUnlikeOnCommentInCommunityModelResponse({
    String? message,
  }) = _AddLikeOrUnlikeOnCommentInCommunityModelResponse;

  factory AddLikeOrUnlikeOnCommentInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddLikeOrUnlikeOnCommentInCommunityModelResponseFromJson(json);
}
