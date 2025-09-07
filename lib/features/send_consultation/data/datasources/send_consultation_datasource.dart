import 'package:egy_akin/features/send_consultation/data/models/add_doctors_for_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_members_for_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/remove_member_from_consultation_model_response.dart';
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
  Future<GetMembersForConsultationModelResponse> getMembersForConsultation({
    required String consultationId,
  });
  Future<RemoveMemberFromConsultationModelResponse> removeMemberFromConsultation({
    required String consultationId,
    required String doctorId,
  });
  Future<AddDoctorsForConsultationModelResponse> addDoctorsForConsultation({
    required String consultationId,
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
  @override
  Future<GetMembersForConsultationModelResponse> getMembersForConsultation({required String consultationId}) async {
    return await _apiServices.getMembersForConsultation(consultationId);
  }

  @override
  Future<RemoveMemberFromConsultationModelResponse> removeMemberFromConsultation({required String consultationId, required String doctorId}) async {
    return await _apiServices.removeMemberFromConsultation(consultationId, doctorId);
  }

  @override
  Future<AddDoctorsForConsultationModelResponse> addDoctorsForConsultation({required String consultationId, required String message, required List<String> doctorsIDS}) async {
    return await _apiServices.addDoctorsForConsultation(consultationId, message, doctorsIDS);
  }


}
