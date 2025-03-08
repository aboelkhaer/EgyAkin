import 'package:egy_akin/features/send_consultation/data/models/send_invitation_model_response.dart';

import '../../../../exports.dart';

abstract class SendConsultationDataSource {
  Future<GetConsultationSearchModelResponse> consultationDoctorSearch({
    required String searchContent,
  });
  Future<SendConsultationModelResponse> sendConsultation({
    required String patientId,
    required String message,
    required List<String> doctorsIDS,
  });
  Future<SendInvitationModelResponse> sendGroupInvitation({
    required String groupId,
    required String message,
    required List<String> doctorsIDS,
  });
}

class SendConsultationDataSourceImpl implements SendConsultationDataSource {
  final ApiServices _apiServices;

  SendConsultationDataSourceImpl(this._apiServices);

  @override
  Future<GetConsultationSearchModelResponse> consultationDoctorSearch(
      {required String searchContent}) async {
    return await _apiServices.consultationDoctorSearch(searchContent);
  }

  @override
  Future<SendConsultationModelResponse> sendConsultation(
      {required String patientId,
      required String message,
      required List<String> doctorsIDS}) async {
    return await _apiServices.sendConsultation(patientId, message, doctorsIDS);
  }

  @override
  Future<SendInvitationModelResponse> sendGroupInvitation(
      {required String groupId,
      required String message,
      required List<String> doctorsIDS}) async {
    return await _apiServices.sendGroupInvitation(groupId, message, doctorsIDS);
  }
}
