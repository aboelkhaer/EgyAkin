import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_section_details_model_response.dart';
import '../../../../exports.dart';

class UpdatePatientSectionDetailsUsecase
    implements
        BaseUseCase<UpdatePatientSectionDetailsUsecaseInput,
            UpdatePatientSectionDetailsModelResponse> {
  final PatientSectionDetailsRepository repository;

  UpdatePatientSectionDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, UpdatePatientSectionDetailsModelResponse>> excute(
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
