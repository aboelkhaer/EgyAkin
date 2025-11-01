import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_sections/data/models/make_unmark_patient_model_response.dart';
import '../../../../exports.dart';

class MakeUnMarkPatientUsecase
    implements BaseUseCase<String, MakeUnMarkPatientModelResponse> {
  final PatientSectionsRepository repository;

  MakeUnMarkPatientUsecase(this.repository);

  @override
  Future<Either<Failure, MakeUnMarkPatientModelResponse>> execute(
      String patientId) async {
    return await repository.makeUnMarkPatient(patientId: patientId);
  }
}
