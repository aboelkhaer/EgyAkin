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
}
