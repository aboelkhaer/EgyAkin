import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class UpdateDoctorProfileUsecase
    implements
        BaseUseCase<UpdateDoctorProfileUsecaseInput,
            UpdateDoctorProfileModelResponse> {
  final DoctorProfileViewRepository repository;

  UpdateDoctorProfileUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateDoctorProfileModelResponse>> execute(
      UpdateDoctorProfileUsecaseInput input) async {
    return await repository.updateDoctorProfile(
      firstName: input.firstName,
      lastName: input.lastName,
      email: input.email,
      phone: input.phone,
      age: input.age,
      job: input.job,
      workplace: input.workplace,
      registrationNumber: input.registrationNumber,
      specialty: input.specialty,
      highestDegree: input.highestDegree,
      userType: input.userType,
    );
  }
}

class UpdateDoctorProfileUsecaseInput {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String age;
  final String job;
  final String workplace;
  final String registrationNumber;
  final String specialty;
  final String highestDegree;
  final String userType;
  UpdateDoctorProfileUsecaseInput(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.age,
      required this.job,
      required this.workplace,
      required this.registrationNumber,
      required this.specialty,
      required this.highestDegree,
      required this.userType});
}
