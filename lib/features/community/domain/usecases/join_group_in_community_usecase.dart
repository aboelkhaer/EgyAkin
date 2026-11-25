import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class JoinGroupInCommunityUsecase
    implements BaseUseCase<String, JoinGroupModelResponse> {
  final CommunityRepository repository;

  JoinGroupInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, JoinGroupModelResponse>> execute(
      String groupId) async {
    return await repository.joinGroupInCommunity(groupId);
  }
}
