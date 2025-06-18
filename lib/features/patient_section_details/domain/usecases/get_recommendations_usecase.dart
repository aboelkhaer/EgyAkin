import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';
import '../../../../exports.dart';

class GetRecommendationsUsecase
    implements BaseUseCase<String, GetRecommendationsModelResponse> {
  final PatientSectionDetailsRepository repository;

  GetRecommendationsUsecase(this.repository);

  @override
  Future<Either<Failure, GetRecommendationsModelResponse>> execute(
      String patientId) async {
    return await repository.getRecommendations(patientId);
  }
}
