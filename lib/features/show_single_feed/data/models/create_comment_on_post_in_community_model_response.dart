// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_comment_on_post_in_community_model_response.freezed.dart';
part 'create_comment_on_post_in_community_model_response.g.dart';

@freezed
class CreateCommentOnPostInCommunityModelResponse
    with _$CreateCommentOnPostInCommunityModelResponse {
  const factory CreateCommentOnPostInCommunityModelResponse({
    String? message,
    CreateCommentOnPostInCommunityDataModelResponse? data,
  }) = _CreateCommentOnPostInCommunityModelResponse;

  factory CreateCommentOnPostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateCommentOnPostInCommunityModelResponseFromJson(json);
}

@freezed
class CreateCommentOnPostInCommunityDataModelResponse
    with _$CreateCommentOnPostInCommunityDataModelResponse {
  const factory CreateCommentOnPostInCommunityDataModelResponse({
    int? id,
    String? comment,
    @JsonKey(name: 'doctor_id') int? doctorId,
  }) = _CreateCommentOnPostInCommunityDataModelResponse;

  factory CreateCommentOnPostInCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateCommentOnPostInCommunityDataModelResponseFromJson(json);
}
