import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ProfilePatientsRepository {
  Future<Either<Failure, GetProfilePatientsModelResponse>> getProfilePatients({
    required int page,
    required String doctorId,
  });
}
