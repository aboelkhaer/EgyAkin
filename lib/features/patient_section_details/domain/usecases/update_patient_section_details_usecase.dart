import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class UpdatePatientSectionDetailsUsecase
    implements
        BaseUseCase<UpdatePatientSectionDetailsUsecaseInput,
            UpdatePatientSectionDetailsModelResponse> {
  final PatientSectionDetailsRepository repository;

  UpdatePatientSectionDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, UpdatePatientSectionDetailsModelResponse>> execute(
      UpdatePatientSectionDetailsUsecaseInput input) async {
    return await repository.updatePatientSectionDetails(
        input.sectionId, input.patientId, input.map);
  }
}

class UpdatePatientSectionDetailsUsecaseInput {
  final String sectionId;
  final String patientId;
  final Map<String, dynamic> map;

  UpdatePatientSectionDetailsUsecaseInput(
      {required this.sectionId, required this.patientId, required this.map});
}
