import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_sections/data/models/make_mark_patient_model_response.dart';
import '../../../../exports.dart';

class MakeMarkPatientUsecase
    implements BaseUseCase<String, MakeMarkPatientModelResponse> {
  final PatientSectionsRepository repository;

  MakeMarkPatientUsecase(this.repository);

  @override
  Future<Either<Failure, MakeMarkPatientModelResponse>> execute(
      String patientId) async {
    return await repository.makeMarkPatient(patientId: patientId);
  }
}
