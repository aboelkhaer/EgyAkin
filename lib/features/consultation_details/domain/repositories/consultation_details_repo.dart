import 'package:egy_akin/features/consultation_details/data/models/add_consultation_reply_model_response.dart';

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
}
