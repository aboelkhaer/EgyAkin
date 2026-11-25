import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AcceptOrDeclineMemberInGroupUsecase
    implements
        BaseUseCase<AcceptOrDeclineMemberInGroupUsecaseInput,
            AcceptOrDeclineMemberModelResponse> {
  final GroupMembersRepository repository;

  AcceptOrDeclineMemberInGroupUsecase(this.repository);

  @override
  Future<Either<Failure, AcceptOrDeclineMemberModelResponse>> execute(
      AcceptOrDeclineMemberInGroupUsecaseInput input) async {
    return await repository.acceptOrDeclineMemberInGroup(
        input.groupId, input.status, input.invitationId);
  }
}

class AcceptOrDeclineMemberInGroupUsecaseInput {
  final String groupId;
  final String status;
  final int invitationId;

  AcceptOrDeclineMemberInGroupUsecaseInput(
      {required this.groupId,
      required this.status,
      required this.invitationId});
}
