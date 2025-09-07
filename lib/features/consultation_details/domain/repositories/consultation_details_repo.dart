import 'package:egy_akin/features/consultation_details/data/models/lock_or_unlock_consultation_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ConsultationDetailsRepository {
  Future<Either<Failure, GetConsultationDetailsModelResponse>>
      getConsultationDetails(String consultationId);

  Future<Either<Failure, AddConsultationReplyModelResponse>>
      addConsultationReply({
    required String consultationId,
    required String reply,
  });

  Future<Either<Failure, LockOrUnlockConsultationModelResponse>>
      lockOrUnlockConsultation(String consultationId, bool isOpen);
}
