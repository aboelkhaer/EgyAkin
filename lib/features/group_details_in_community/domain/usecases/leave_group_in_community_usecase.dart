import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/leave_group_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/domain/repositories/group_details_in_community_repo.dart';
import '../../../../exports.dart';

class LeaveGroupInCommunityUsecase
    implements BaseUseCase<String, LeaveGroupModelResponse> {
  final GroupDetailsInCommunityRepository repository;

  LeaveGroupInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, LeaveGroupModelResponse>> execute(
      String groupId) async {
    return await repository.leaveGroupInCommunity(groupId);
  }
}
