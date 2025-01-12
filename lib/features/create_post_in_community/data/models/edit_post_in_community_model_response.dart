// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'edit_post_in_community_model_response.freezed.dart';
part 'edit_post_in_community_model_response.g.dart';

@freezed
class EditPostInCommunityModelResponse with _$EditPostInCommunityModelResponse {
  const factory EditPostInCommunityModelResponse({
    String? message,
  }) = _EditPostInCommunityModelResponse;
  factory EditPostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$EditPostInCommunityModelResponseFromJson(json);
}
