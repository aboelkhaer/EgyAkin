import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class RemoveMemberFromGroupUsecase
    implements
        BaseUseCase<RemoveMemberFromGroupUsecaseInput,
            RemoveMemberFromGroupModelResponse> {
  final GroupMembersRepository repository;

  RemoveMemberFromGroupUsecase(this.repository);

  @override
  Future<Either<Failure, RemoveMemberFromGroupModelResponse>> execute(
      RemoveMemberFromGroupUsecaseInput input) async {
    return await repository.removeMemberFromGroup(
        input.groupId, input.doctorId);
  }
}

class RemoveMemberFromGroupUsecaseInput {
  final String groupId;
  final String doctorId;

  RemoveMemberFromGroupUsecaseInput(
      {required this.groupId, required this.doctorId});
}
