import 'package:egy_akin/features/send_consultation/data/models/add_doctors_for_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_members_for_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/remove_member_from_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/send_invitation_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class SendConsultationRepository {
  Future<Either<Failure, GetConsultationSearchModelResponse>>
      consultationDoctorSearch({
    required String searchContent,
  });
  Future<Either<Failure, SendConsultationModelResponse>> sendConsultation({
    required String patientId,
    required String message,
    required List<String> doctorsIDS,
  });

  Future<Either<Failure, SendInvitationModelResponse>> sendGroupInvitation({
    required String groupId,
    required String message,
    required List<String> doctorsIDS,
  });
  Future<Either<Failure, GetMembersForConsultationModelResponse>> getMembersForConsultation({
    required String consultationId,
  });

  Future<Either<Failure, RemoveMemberFromConsultationModelResponse>> removeMemberFromConsultation({
    required String consultationId,
    required String doctorId,
  });

  Future<Either<Failure, AddDoctorsForConsultationModelResponse>> addDoctorsForConsultation({
    required String consultationId,
    required String message,
    required List<String> doctorsIDS,
  });

}
