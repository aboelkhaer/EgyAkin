import 'package:egy_akin/features/consultation_details/data/models/lock_or_unlock_consultation_model_response.dart';

import '../../../../exports.dart';

abstract class ConsultationDetailsDataSource {
  Future<GetConsultationDetailsModelResponse> getConsultationDetails(
      String consultationId);
  Future<AddConsultationReplyModelResponse> addConsultationReply({
    required String consultationId,
    required String reply,
  });
  Future<LockOrUnlockConsultationModelResponse> lockOrUnlockConsultation(
      String consultationId, bool isOpen);
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

  @override
  Future<LockOrUnlockConsultationModelResponse> lockOrUnlockConsultation(
      String consultationId, bool isOpen) async {
    return await _apiServices.lockOrUnlockConsultation(consultationId, isOpen);
  }
}
