
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
