import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/data/models/get_doctor_invitation_for_groups_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AllGroupsInCommunityRepository {
  Future<Either<Failure, GetAllGroupsInCommunityModelResponse>> getMyGroups(
    int page,
  );
  Future<Either<Failure, GetAllGroupsInCommunityModelResponse>> getAllGroups(
    int page,
  );
  Future<Either<Failure, GetDoctorInvitationForGroupsModelResponse>>
      getDoctorInvitationsForGroups(
    String doctorId,
    int page,
  );
}
