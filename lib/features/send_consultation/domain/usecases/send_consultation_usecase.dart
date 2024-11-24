import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SendConsultationUsecase
    implements
        BaseUseCase<SendConsultationUsecaseInput,
            SendConsultationModelResponse> {
  final SendConsultationRepository repository;

  SendConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, SendConsultationModelResponse>> execute(
      SendConsultationUsecaseInput input) async {
    return await repository.sendConsultation(
      patientId: input.patientId,
      message: input.message,
      doctorsIDS: input.doctorsIDS,
    );
  }
}

class SendConsultationUsecaseInput {
  final String patientId;
  final String message;
  final List<String> doctorsIDS;

  SendConsultationUsecaseInput(
      {required this.patientId,
      required this.message,
      required this.doctorsIDS});
}
