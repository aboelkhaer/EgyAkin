import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_comments/data/models/add_patient_comment_model_response.dart';
import '../../../../exports.dart';

class AddPatientCommentsUsecase
    implements
        BaseUseCase<AddCommentUseCaseInput, AddPatientCommentsModelResponse> {
  final PatientCommentsRepository repository;

  AddPatientCommentsUsecase(this.repository);

  @override
  Future<Either<Failure, AddPatientCommentsModelResponse>> excute(
      AddCommentUseCaseInput input) async {
    return await repository.addPatientComments(input.patientId, input.content);
  }
}

class AddCommentUseCaseInput {
  final String patientId;
  final String content;
  const AddCommentUseCaseInput({
    required this.patientId,
    required this.content,
  });
}
