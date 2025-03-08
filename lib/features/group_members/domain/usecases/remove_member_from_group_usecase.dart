import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_members/data/models/remove_member_from_group_model_response.dart';
import 'package:egy_akin/features/group_members/domain/repositories/group_members_repo.dart';
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
