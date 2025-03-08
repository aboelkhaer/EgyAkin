import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/domain/repositories/all_groups_in_community_repo.dart';
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
