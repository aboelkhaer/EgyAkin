import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_groups_in_community/data/models/get_doctor_invitation_for_groups_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/domain/repositories/all_groups_in_community_repo.dart';
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
