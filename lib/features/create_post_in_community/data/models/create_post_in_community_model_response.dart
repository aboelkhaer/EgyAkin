// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_post_in_community_model_response.freezed.dart';
part 'create_post_in_community_model_response.g.dart';

@freezed
class CreatePostInCommunityModelResponse
    with _$CreatePostInCommunityModelResponse {
  const factory CreatePostInCommunityModelResponse({
    String? message,
  }) = _CreatePostInCommunityModelResponse;
  factory CreatePostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreatePostInCommunityModelResponseFromJson(json);
}
