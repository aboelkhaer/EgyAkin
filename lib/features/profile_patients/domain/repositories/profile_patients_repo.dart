import 'package:egy_akin/features/profile_patients/data/models/get_profile_patients_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ProfilePatientsRepository {
  Future<Either<Failure, GetProfilePatientsModelResponse>> getProfilePatients({
    required int page,
    required String doctorId,
  });
}
