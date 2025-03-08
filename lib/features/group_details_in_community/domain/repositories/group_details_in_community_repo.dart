import 'package:egy_akin/features/group_details_in_community/data/models/delete_group_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/get_group_details_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/leave_group_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class GroupDetailsInCommunityRepository {
  Future<Either<Failure, GetGroupDetailsInCommunityModelResponse>>
      getGroupDetailsInCommunity(String groupId);

  Future<Either<Failure, LeaveGroupModelResponse>> leaveGroupInCommunity(
    String groupId,
  );
  Future<Either<Failure, DeleteGroupInCommunityModelResponse>>
      deleteGroupInCommunity(
    String groupId,
  );
}
