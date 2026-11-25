
import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class GroupDetailsInCommunityRepository {
  Future<Either<Failure, GetGroupDetailsInCommunityModelResponse>>
      getGroupDetailsInCommunity(
    String groupId,
    int page,
  );

  Future<Either<Failure, LeaveGroupModelResponse>> leaveGroupInCommunity(
    String groupId,
  );
  Future<Either<Failure, DeleteGroupInCommunityModelResponse>>
      deleteGroupInCommunity(
    String groupId,
  );
}
