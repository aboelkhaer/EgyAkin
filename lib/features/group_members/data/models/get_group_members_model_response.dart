// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_group_members_model_response.freezed.dart';
part 'get_group_members_model_response.g.dart';

@freezed
class GetGroupMembersModelResponse with _$GetGroupMembersModelResponse {
  const factory GetGroupMembersModelResponse({
    GetGroupMembersDataModelResponse? data,
  }) = _GetGroupMembersModelResponse;
  factory GetGroupMembersModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetGroupMembersModelResponseFromJson(json);
}

@freezed
class GetGroupMembersDataModelResponse with _$GetGroupMembersDataModelResponse {
  const factory GetGroupMembersDataModelResponse({
    @JsonKey(name: 'current_page') int? currentPage,
    List<DoctorModel>? data,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    List<Link>? links,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _GetGroupMembersDataModelResponse;
  factory GetGroupMembersDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetGroupMembersDataModelResponseFromJson(json);
}
