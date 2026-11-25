import 'package:dartz/dartz.dart';
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
