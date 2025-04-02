// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_doctor_invitation_for_groups_model_response.freezed.dart';
part 'get_doctor_invitation_for_groups_model_response.g.dart';

@freezed
class GetDoctorInvitationForGroupsModelResponse
    with _$GetDoctorInvitationForGroupsModelResponse {
  const factory GetDoctorInvitationForGroupsModelResponse({
    GetAllGroupsInCommunityDataModelResponse? data,
  }) = _GetDoctorInvitationForGroupsModelResponse;
  factory GetDoctorInvitationForGroupsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetDoctorInvitationForGroupsModelResponseFromJson(json);
}
