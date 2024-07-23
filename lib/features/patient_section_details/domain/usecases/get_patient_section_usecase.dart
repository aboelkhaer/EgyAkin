import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_patient_section_model_response.dart';
import '../../../../exports.dart';

class GetPatientSectionDetailsUsecase
    implements
        BaseUseCase<GetPatientSectionDetailsUsecaseInput,
            GetPatientSectionDetailsModelResponse> {
  final PatientSectionDetailsRepository repository;

  GetPatientSectionDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, GetPatientSectionDetailsModelResponse>> excute(
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
