
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
    return await _apiServices.getMyGroup(page, 'all');
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
