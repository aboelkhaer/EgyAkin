// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_group_details_in_community_model_response.freezed.dart';
part 'get_group_details_in_community_model_response.g.dart';

@freezed
class GetGroupDetailsInCommunityModelResponse
    with _$GetGroupDetailsInCommunityModelResponse {
  const factory GetGroupDetailsInCommunityModelResponse({
    GetGroupDetailsInCommunityDataModelResponse? data,
  }) = _GetGroupDetailsInCommunityModelResponse;
  factory GetGroupDetailsInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetGroupDetailsInCommunityModelResponseFromJson(json);
}

@freezed
class GetGroupDetailsInCommunityDataModelResponse
    with _$GetGroupDetailsInCommunityDataModelResponse {
  const factory GetGroupDetailsInCommunityDataModelResponse({
    GroupModel? group,
    GetPostsCommunityDataModelResponse? posts,
  }) = _GetGroupDetailsInCommunityDataModelResponse;
  factory GetGroupDetailsInCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetGroupDetailsInCommunityDataModelResponseFromJson(json);
}
