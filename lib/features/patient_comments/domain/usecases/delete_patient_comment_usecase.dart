import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_comments/data/models/delete_patient_comment_model_response.dart';
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
