import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/create_patient_recommendation_model_response.dart';
import '../../../../exports.dart';

class CreateRecommendationsUsecase
    implements
        BaseUseCase<CreateRecommendationsUsecaseInput,
            CreatePatientRecommendationModelResponse> {
  final PatientSectionDetailsRepository repository;

  CreateRecommendationsUsecase(this.repository);

  @override
  Future<Either<Failure, CreatePatientRecommendationModelResponse>> execute(
      CreateRecommendationsUsecaseInput input) async {
    return await repository.createPatientRecommendation(input.patientId, input.body);
  }
}

class CreateRecommendationsUsecaseInput {

  final String patientId;
 final Map<String, dynamic> body;

  CreateRecommendationsUsecaseInput({required this.patientId, required this.body});

 
}
