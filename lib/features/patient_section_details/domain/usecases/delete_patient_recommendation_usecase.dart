import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/delete_patient_recommendation_model_response.dart';
import '../../../../exports.dart';

class DeletePatientRecommendationUsecase
    implements BaseUseCase<DeletePatientRecommendationUsecaseInput, DeletePatientRecommendationModelResponse> {
  final PatientSectionDetailsRepository repository;

  DeletePatientRecommendationUsecase(this.repository);

  @override
  Future<Either<Failure, DeletePatientRecommendationModelResponse>> execute(
      DeletePatientRecommendationUsecaseInput input) async {
    return await repository.deletePatientRecommendation(input.patientId, input.ids);
  }
}
class DeletePatientRecommendationUsecaseInput{
  final String patientId;
  final List<int> ids;

  DeletePatientRecommendationUsecaseInput({required this.patientId, required this.ids});
}