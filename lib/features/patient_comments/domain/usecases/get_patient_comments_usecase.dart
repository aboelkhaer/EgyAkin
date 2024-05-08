import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetPatientCommentsUsecase
    implements BaseUseCase<String, GetPatientCommentsModelResponse> {
  final PatientCommentsRepository repository;

  GetPatientCommentsUsecase(this.repository);

  @override
  Future<Either<Failure, GetPatientCommentsModelResponse>> excute(
      String patientId) async {
    return await repository.getPatientComments(patientId);
  }
}
