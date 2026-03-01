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
    required String registrationNumber,
    required String specialty,
    required String highestDegree,
    required String userType,
  });
}
