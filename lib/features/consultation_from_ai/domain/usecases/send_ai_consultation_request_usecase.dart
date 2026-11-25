import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SendAiConsultationRequestUsecase
    implements BaseUseCase<String, SendAIConsultationRequestModelResponse> {
  final ConsultationFromAIRepository repository;

  SendAiConsultationRequestUsecase(this.repository);

  @override
  Future<Either<Failure, SendAIConsultationRequestModelResponse>> execute(
    String patientId,
  ) async {
    return await repository.sendAIConsultationRequest(patientId: patientId);
  }
}
