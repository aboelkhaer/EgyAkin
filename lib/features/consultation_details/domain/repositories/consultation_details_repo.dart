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
