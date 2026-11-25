import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class DeleteGroupInCommunityUsecase
    implements BaseUseCase<String, DeleteGroupInCommunityModelResponse> {
  final GroupDetailsInCommunityRepository repository;

  DeleteGroupInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, DeleteGroupInCommunityModelResponse>> execute(
      String groupId) async {
    return await repository.deleteGroupInCommunity(groupId);
  }
}
