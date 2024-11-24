import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class DeletePatientUsecase
    implements BaseUseCase<String, DeletePatientModelResponse> {
  final PatientSectionsRepository repository;

  DeletePatientUsecase(this.repository);

  @override
  Future<Either<Failure, DeletePatientModelResponse>> execute(
      String patientId) async {
    return await repository.deletePatient(patientId: patientId);
  }
}
