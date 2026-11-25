
import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ConsultationFromAIRepository {
  Future<Either<Failure, GetAiConsultationHistoryModelResponse>>
      getAIConsultationHistory({
    required String patientId,
    required int page,
  });
  Future<Either<Failure, SendAIConsultationRequestModelResponse>>
      sendAIConsultationRequest({
    required String patientId,
  });
}
