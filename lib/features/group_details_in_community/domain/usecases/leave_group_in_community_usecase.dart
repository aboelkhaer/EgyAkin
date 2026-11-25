import 'package:dartz/dartz.dart';
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
