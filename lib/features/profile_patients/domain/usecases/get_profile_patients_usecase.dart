import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/profile_patients/data/models/get_profile_patients_model_response.dart';
import 'package:egy_akin/features/profile_patients/domain/repositories/profile_patients_repo.dart';

import '../../../../exports.dart';

class GetProfilePatientsUsecase
    implements
        BaseUseCase<GetProfilePatientsUsecaseInput,
            GetProfilePatientsModelResponse> {
  final ProfilePatientsRepository repository;

  GetProfilePatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetProfilePatientsModelResponse>> excute(
      GetProfilePatientsUsecaseInput input) async {
    return await repository.getProfilePatients(
      page: input.page,
      doctorId: input.doctorId,
    );
  }
}

class GetProfilePatientsUsecaseInput {
  final int page;
  final String doctorId;

  GetProfilePatientsUsecaseInput({
    required this.page,
    required this.doctorId,
  });
}
