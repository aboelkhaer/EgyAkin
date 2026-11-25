import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetGroupMembersUsecase
    implements
        BaseUseCase<GetGroupMembersUsecaseInput, GetGroupMembersModelResponse> {
  final GroupMembersRepository repository;

  GetGroupMembersUsecase(this.repository);

  @override
  Future<Either<Failure, GetGroupMembersModelResponse>> execute(
      GetGroupMembersUsecaseInput input) async {
    return await repository.getGroupMembers(input.groupId, input.pageNumber);
  }
}

class GetGroupMembersUsecaseInput {
  final String groupId;
  final int pageNumber;

  GetGroupMembersUsecaseInput({
    required this.groupId,
    required this.pageNumber,
  });
}
