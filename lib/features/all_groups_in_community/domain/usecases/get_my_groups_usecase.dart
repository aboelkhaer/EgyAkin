import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetMyGroupsUsecase
    implements BaseUseCase<int, GetAllGroupsInCommunityModelResponse> {
  final AllGroupsInCommunityRepository repository;

  GetMyGroupsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllGroupsInCommunityModelResponse>> execute(
      int page) async {
    return await repository.getMyGroups(page);
  }
}
