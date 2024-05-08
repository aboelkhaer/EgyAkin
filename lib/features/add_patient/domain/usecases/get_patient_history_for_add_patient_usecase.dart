import 'package:dartz/dartz.dart';
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
