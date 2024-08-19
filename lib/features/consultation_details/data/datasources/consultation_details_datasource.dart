import 'package:egy_akin/features/consultation_details/data/models/add_consultation_reply_model_response.dart';

import '../../../../exports.dart';

abstract class ConsultationDetailsDataSource {
  Future<GetConsultationDetailsModelResponse> getConsultationDetails(
      String consultationId);
  Future<AddConsultationReplyModelResponse> addConsultationReply({
    required String consultationId,
    required String reply,
  });
}

class ConsultationDetailsDataSourceImpl
    implements ConsultationDetailsDataSource {
  final ApiServices _apiServices;

  ConsultationDetailsDataSourceImpl(this._apiServices);

  @override
  Future<GetConsultationDetailsModelResponse> getConsultationDetails(
      String consultationId) async {
    return await _apiServices.getConsultationDetails(consultationId);
  }

  @override
  Future<AddConsultationReplyModelResponse> addConsultationReply(
      {required String consultationId, required String reply}) async {
    return await _apiServices.addConsultationReply(consultationId, reply);
  }
}
