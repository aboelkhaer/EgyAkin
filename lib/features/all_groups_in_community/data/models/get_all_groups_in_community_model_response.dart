// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_all_groups_in_community_model_response.freezed.dart';
part 'get_all_groups_in_community_model_response.g.dart';

@freezed
class GetAllGroupsInCommunityModelResponse
    with _$GetAllGroupsInCommunityModelResponse {
  const factory GetAllGroupsInCommunityModelResponse({
    bool? value,
    GetAllGroupsInCommunityDataModelResponse? data,
  }) = _GetAllGroupsInCommunityModelResponse;
  factory GetAllGroupsInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllGroupsInCommunityModelResponseFromJson(json);
}

@freezed
class GetAllGroupsInCommunityDataModelResponse
    with _$GetAllGroupsInCommunityDataModelResponse {
  const factory GetAllGroupsInCommunityDataModelResponse({
    List<GroupModel>? data,
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _GetAllGroupsInCommunityDataModelResponse;
  factory GetAllGroupsInCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllGroupsInCommunityDataModelResponseFromJson(json);
}
