import 'package:egy_akin/features/doctor_profile_view/data/models/update_doctor_profile_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorProfileViewRepository {
  Future<Either<Failure, UpdateDoctorProfileModelResponse>>
      updateDoctorProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String age,
    required String job,
    required String workplace,
    required String registerationNumber,
    required String specialty,
    required String highestDegree,
  });
}
