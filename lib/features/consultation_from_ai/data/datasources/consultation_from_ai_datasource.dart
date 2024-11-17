import 'package:egy_akin/features/consultation_from_ai/data/models/get_ai_consultation_history_model_response.dart';
import 'package:egy_akin/features/consultation_from_ai/data/models/send_ai_consultation_request_model_response.dart';

import '../../../../exports.dart';

abstract class ConsultationFromAIDatasource {
  Future<GetAiConsultationHistoryModelResponse> getAIConsultationHistory({
    required String patientId,
    required int page,
  });
  Future<SendAIConsultationRequestModelResponse> sendAIConsultationRequest({
    required String patientId,
  });
}

class ConsultationFromAIDatasourceImpl implements ConsultationFromAIDatasource {
  final ApiServices _apiServices;

  ConsultationFromAIDatasourceImpl(this._apiServices);

  @override
  Future<GetAiConsultationHistoryModelResponse> getAIConsultationHistory({
    required String patientId,
    required int page,
  }) async {
    return await _apiServices.getAIConsultationHistory(patientId, page);
  }

  @override
  Future<SendAIConsultationRequestModelResponse> sendAIConsultationRequest(
      {required String patientId}) async {
    return await _apiServices.sendAIConsultationRequest(patientId);
  }
}
