import 'package:egy_akin/features/group_members/data/models/accept_or_decline_member_model_response.dart';
import 'package:egy_akin/features/group_members/data/models/get_group_members_model_response.dart';
import 'package:egy_akin/features/group_members/data/models/get_post_likes_model_response.dart';
import 'package:egy_akin/features/group_members/data/models/remove_member_from_group_model_response.dart';

import '../../../../exports.dart';

abstract class GroupMembersDatasource {
  Future<GetGroupMembersModelResponse> getGroupMembers(
    String groupId,
    int pageNumber,
  );
  Future<GetPostLikesModelResponse> getPostLikes(
    String postId,
    int pageNumber,
  );
  Future<RemoveMemberFromGroupModelResponse> removeMemberFromGroup(
    String groupId,
    String doctorId,
  );
  Future<AcceptOrDeclineMemberModelResponse> acceptOrDeclineMemberInGroup(
    String groupId,
    String status,
    int invitationId,
  );
}

class GroupMembersDatasourceImpl implements GroupMembersDatasource {
  final ApiServices _apiServices;

  GroupMembersDatasourceImpl(this._apiServices);

  @override
  Future<GetGroupMembersModelResponse> getGroupMembers(
      String groupId, int pageNumber) async {
    return await _apiServices.getGroupMembers(pageNumber, groupId);
  }

  @override
  Future<GetPostLikesModelResponse> getPostLikes(
      String postId, int pageNumber) async {
    return await _apiServices.getPostLikes(pageNumber, postId);
  }

  @override
  Future<RemoveMemberFromGroupModelResponse> removeMemberFromGroup(
      String groupId, String doctorId) async {
    return await _apiServices.removeMemberFromGroup(groupId, doctorId);
  }

  @override
  Future<AcceptOrDeclineMemberModelResponse> acceptOrDeclineMemberInGroup(
      String groupId, String status, int invitationId) async {
    return await _apiServices.acceptOrDeclineMemberInGroup(
        groupId, status, invitationId);
  }
}
