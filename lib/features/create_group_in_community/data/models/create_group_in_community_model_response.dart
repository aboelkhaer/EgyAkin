// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_group_in_community_model_response.freezed.dart';
part 'create_group_in_community_model_response.g.dart';

@freezed
class CreateGroupInCommunityModelResponse
    with _$CreateGroupInCommunityModelResponse {
  const factory CreateGroupInCommunityModelResponse({
    String? message,
  }) = _CreateGroupInCommunityModelResponse;
  factory CreateGroupInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateGroupInCommunityModelResponseFromJson(json);
}
