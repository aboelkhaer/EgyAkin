import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:egy_akin/features/add_patient/domain/repositories/add_patient_repo.dart';
import '../../../../exports.dart';

class GetPatientHistoryForAddPatientUsecase
    implements
        BaseUseCase<String, GetPatientHistoryForAddPatientModelResponse> {
  final AddPatientRepository repository;

  GetPatientHistoryForAddPatientUsecase(this.repository);

  @override
  Future<Either<Failure, GetPatientHistoryForAddPatientModelResponse>> excute(
    String sectionId,
  ) async {
    return await repository.getPatientHistoryForAddPatient(
        sectionId: sectionId);
  }
}
