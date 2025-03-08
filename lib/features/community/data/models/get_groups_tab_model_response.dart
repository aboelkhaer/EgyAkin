// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exports.dart';

part 'get_groups_tab_model_response.freezed.dart';
part 'get_groups_tab_model_response.g.dart';

@freezed
class GetGroupsTabModelResponse with _$GetGroupsTabModelResponse {
  const factory GetGroupsTabModelResponse({
    LatestGroupsData? data,
    String? message,
  }) = _GetGroupsTabModelResponse;
  factory GetGroupsTabModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetGroupsTabModelResponseFromJson(json);
}

@freezed
class LatestGroupsData with _$LatestGroupsData {
  const factory LatestGroupsData({
    @JsonKey(name: 'latest_groups') List<GroupModel>? latestGroups,
    @JsonKey(name: 'random_posts')
    GetPostsCommunityDataModelResponse? randomPosts,
  }) = _LatestGroupsData;

  factory LatestGroupsData.fromJson(Map<String, dynamic> json) =>
      _$LatestGroupsDataFromJson(json);
}

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    int? id,
    String? name,
    String? description,
    @JsonKey(name: 'header_picture') String? headerPicture,
    @JsonKey(name: 'group_image') String? groupImage,
    String? privacy,
    @JsonKey(name: 'owner_id') int? ownerId,
    @JsonKey(name: 'member_count') int? memberCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'user_status') String? userStatus,
    DoctorModel? owner,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}
