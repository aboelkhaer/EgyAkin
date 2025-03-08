import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_members/data/models/get_group_members_model_response.dart';
import 'package:egy_akin/features/group_members/data/models/remove_member_from_group_model_response.dart';

import '../../../../exports.dart';

abstract class GroupMembersRepository {
  Future<Either<Failure, GetGroupMembersModelResponse>> getGroupMembers(
    String groupId,
    int pageNumber,
  );
  Future<Either<Failure, GetGroupMembersModelResponse>> getPostLikes(
    String postId,
    int pageNumber,
  );
  Future<Either<Failure, RemoveMemberFromGroupModelResponse>>
      removeMemberFromGroup(
    String groupId,
    String doctorId,
  );
}
