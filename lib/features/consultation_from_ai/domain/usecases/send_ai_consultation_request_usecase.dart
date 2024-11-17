import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/consultation_from_ai/data/models/send_ai_consultation_request_model_response.dart';
import 'package:egy_akin/features/consultation_from_ai/domain/repositories/consultation_from_ai_repo.dart';
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
