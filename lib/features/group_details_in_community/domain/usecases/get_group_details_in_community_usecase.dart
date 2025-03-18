import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/get_group_details_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/domain/repositories/group_details_in_community_repo.dart';
import '../../../../exports.dart';

class GetGroupDetailsInCommunityUsecase
    implements
        BaseUseCase<GetGroupDetailsInCommunityUsecaseInput,
            GetGroupDetailsInCommunityModelResponse> {
  final GroupDetailsInCommunityRepository repository;

  GetGroupDetailsInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, GetGroupDetailsInCommunityModelResponse>> execute(
      GetGroupDetailsInCommunityUsecaseInput input) async {
    return await repository.getGroupDetailsInCommunity(
        input.groupId, input.page);
  }
}

class GetGroupDetailsInCommunityUsecaseInput {
  final String groupId;
  final int page;

  GetGroupDetailsInCommunityUsecaseInput(
      {required this.groupId, required this.page});
}
