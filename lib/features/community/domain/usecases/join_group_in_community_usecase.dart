import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/join_group_model_response.dart';
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
