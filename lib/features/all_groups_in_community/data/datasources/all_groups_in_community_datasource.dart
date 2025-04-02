import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/data/models/get_doctor_invitation_for_groups_model_response.dart';

import '../../../../exports.dart';

abstract class AllGroupsInCommunityDatasource {
  Future<GetAllGroupsInCommunityModelResponse> getMyGroups(
    int page,
  );
  Future<GetAllGroupsInCommunityModelResponse> getAllGroups(
    int page,
  );
  Future<GetDoctorInvitationForGroupsModelResponse>
      getDoctorInvitationsForGroups(
    String doctorId,
    int page,
  );
}

class AllGroupsInCommunityDatasourceImpl
    implements AllGroupsInCommunityDatasource {
  final ApiServices _apiServices;

  AllGroupsInCommunityDatasourceImpl(this._apiServices);

  @override
  Future<GetAllGroupsInCommunityModelResponse> getMyGroups(int page) async {
    return await _apiServices.getMyGroup(page);
  }

  @override
  Future<GetAllGroupsInCommunityModelResponse> getAllGroups(int page) async {
    return await _apiServices.getAllGroups(page);
  }

  @override
  Future<GetDoctorInvitationForGroupsModelResponse>
      getDoctorInvitationsForGroups(String doctorId, int page) async {
    return await _apiServices.getDoctorInvitationsForGroups(doctorId, page);
  }
}
