import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_sections/data/models/final_submit_model_response.dart';
import '../../../../exports.dart';

class FinalSubmitUsecase
    implements BaseUseCase<String, FinalSubmitModelResponse> {
  final PatientSectionsRepository repository;

  FinalSubmitUsecase(this.repository);

  @override
  Future<Either<Failure, FinalSubmitModelResponse>> excute(
      String patientId) async {
    return await repository.finalSubmit(patientId: patientId);
  }
}
