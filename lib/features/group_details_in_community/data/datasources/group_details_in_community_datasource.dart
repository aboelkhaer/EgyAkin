import 'package:egy_akin/features/group_details_in_community/data/models/delete_group_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/get_group_details_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/leave_group_model_response.dart';

import '../../../../exports.dart';

abstract class GroupDetailsInCommunityDatasource {
  Future<GetGroupDetailsInCommunityModelResponse> getGroupDetailsInCommunity(
      String groupId);
  Future<LeaveGroupModelResponse> leaveGroupInCommunity(
    String groupId,
  );
  Future<DeleteGroupInCommunityModelResponse> deleteGroupInCommunity(
    String groupId,
  );
}

class GroupDetailsInCommunityDatasourceImpl
    implements GroupDetailsInCommunityDatasource {
  final ApiServices _apiServices;

  GroupDetailsInCommunityDatasourceImpl(this._apiServices);

  @override
  Future<GetGroupDetailsInCommunityModelResponse> getGroupDetailsInCommunity(
      String groupId) async {
    return await _apiServices.getGroupDetailsInCommunity(groupId);
  }

  @override
  Future<LeaveGroupModelResponse> leaveGroupInCommunity(String groupId) async {
    return await _apiServices.leaveGroupInCommunity(groupId);
  }

  @override
  Future<DeleteGroupInCommunityModelResponse> deleteGroupInCommunity(
      String groupId) async {
    return await _apiServices.deleteGroupInCommunity(groupId);
  }
}
