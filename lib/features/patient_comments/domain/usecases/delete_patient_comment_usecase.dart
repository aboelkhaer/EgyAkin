import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class DeletePatientCommentsUsecase
    implements BaseUseCase<String, DeletePatientCommentsModelResponse> {
  final PatientCommentsRepository repository;

  DeletePatientCommentsUsecase(this.repository);

  @override
  Future<Either<Failure, DeletePatientCommentsModelResponse>> execute(
      String commentId) async {
    return await repository.deletePatientComments(commentId);
  }
}
