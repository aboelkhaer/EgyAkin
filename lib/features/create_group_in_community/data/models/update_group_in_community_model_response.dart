// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_group_in_community_model_response.freezed.dart';
part 'update_group_in_community_model_response.g.dart';

@freezed
class UpdateGroupInCommunityModelResponse
    with _$UpdateGroupInCommunityModelResponse {
  const factory UpdateGroupInCommunityModelResponse({
    String? message,
  }) = _UpdateGroupInCommunityModelResponse;
  factory UpdateGroupInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateGroupInCommunityModelResponseFromJson(json);
}
