import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_members/data/models/accept_or_decline_member_model_response.dart';
import 'package:egy_akin/features/group_members/data/models/get_group_members_model_response.dart';
import 'package:egy_akin/features/group_members/data/models/get_post_likes_model_response.dart';

import '../../../../exports.dart';

abstract class GroupMembersRepository {
  Future<Either<Failure, GetGroupMembersModelResponse>> getGroupMembers(
    String groupId,
    int pageNumber,
  );
  Future<Either<Failure, GetPostLikesModelResponse>> getPostLikes(
    String postId,
    int pageNumber,
  );
  Future<Either<Failure, RemoveMemberFromGroupModelResponse>>
      removeMemberFromGroup(
    String groupId,
    String doctorId,
  );
  Future<Either<Failure, AcceptOrDeclineMemberModelResponse>>
      acceptOrDeclineMemberInGroup(
    String groupId,
    String status,
    int invitationId,
  );
}
