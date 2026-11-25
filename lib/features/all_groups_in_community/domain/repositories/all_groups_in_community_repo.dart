
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
