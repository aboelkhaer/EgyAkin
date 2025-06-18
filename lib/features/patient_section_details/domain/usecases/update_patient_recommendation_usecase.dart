import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_recommendation_model_response.dart';
import '../../../../exports.dart';

class UpdatePatientRecommendationUsecase
    implements
        BaseUseCase<UpdatePatientRecommendationUsecaseInput,
            UpdatePatientRecommendationModelResponse> {
  final PatientSectionDetailsRepository repository;

  UpdatePatientRecommendationUsecase(this.repository);

  @override
  Future<Either<Failure, UpdatePatientRecommendationModelResponse>> execute(
      UpdatePatientRecommendationUsecaseInput input) async {
    return await repository.updatePatientRecommendation(input.patientId, input.body);
  }
}

class UpdatePatientRecommendationUsecaseInput {

  final String patientId;
 final Map<String, dynamic> body;

  UpdatePatientRecommendationUsecaseInput({required this.patientId, required this.body});

 
}
