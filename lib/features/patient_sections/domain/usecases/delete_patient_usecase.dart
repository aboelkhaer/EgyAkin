import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_sections/data/models/delete_patient_model_response.dart';
import '../../../../exports.dart';

class DeletePatientUsecase
    implements BaseUseCase<String, DeletePatientModelResponse> {
  final PatientSectionsRepository repository;

  DeletePatientUsecase(this.repository);

  @override
  Future<Either<Failure, DeletePatientModelResponse>> excute(
      String patientId) async {
    return await repository.deletePatient(patientId: patientId);
  }
}
