import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetDoctorInvitationsForGroupsUsecase
    implements
        BaseUseCase<GetDoctorInvitationsForGroupsUsecaseInput,
            GetDoctorInvitationForGroupsModelResponse> {
  final AllGroupsInCommunityRepository repository;

  GetDoctorInvitationsForGroupsUsecase(this.repository);

  @override
  Future<Either<Failure, GetDoctorInvitationForGroupsModelResponse>> execute(
      GetDoctorInvitationsForGroupsUsecaseInput input) async {
    return await repository.getDoctorInvitationsForGroups(
        input.doctorId, input.page);
  }
}

class GetDoctorInvitationsForGroupsUsecaseInput {
  final String doctorId;
  final int page;

  GetDoctorInvitationsForGroupsUsecaseInput({
    required this.doctorId,
    required this.page,
  });
}
