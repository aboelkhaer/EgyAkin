import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetAllGroupsUsecase
    implements BaseUseCase<int, GetAllGroupsInCommunityModelResponse> {
  final AllGroupsInCommunityRepository repository;

  GetAllGroupsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllGroupsInCommunityModelResponse>> execute(
      int page) async {
    return await repository.getAllGroups(page);
  }
}
