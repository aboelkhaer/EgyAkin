import 'package:egy_akin/features/consultation_from_ai/data/models/get_ai_consultation_history_model_response.dart';
import 'package:egy_akin/features/consultation_from_ai/data/models/send_ai_consultation_request_model_response.dart';

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
