import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetPatientSectionDetailsUsecase
    implements
        BaseUseCase<GetPatientSectionDetailsUsecaseInput,
            GetPatientSectionDetailsModelResponse> {
  final PatientSectionDetailsRepository repository;

  GetPatientSectionDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, GetPatientSectionDetailsModelResponse>> execute(
      GetPatientSectionDetailsUsecaseInput input) async {
    return await repository.getPatientSectionDetails(
        input.sectionId, input.patientId);
  }
}

class GetPatientSectionDetailsUsecaseInput {
  final String sectionId;
  final String patientId;

  GetPatientSectionDetailsUsecaseInput(
      {required this.sectionId, required this.patientId});
}
