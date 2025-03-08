// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_group_in_community_model_response.freezed.dart';
part 'delete_group_in_community_model_response.g.dart';

@freezed
class DeleteGroupInCommunityModelResponse
    with _$DeleteGroupInCommunityModelResponse {
  const factory DeleteGroupInCommunityModelResponse({
    String? message,
  }) = _DeleteGroupInCommunityModelResponse;
  factory DeleteGroupInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteGroupInCommunityModelResponseFromJson(json);
}
