import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_members/data/models/accept_or_decline_member_model_response.dart';
import 'package:egy_akin/features/group_members/domain/repositories/group_members_repo.dart';
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
