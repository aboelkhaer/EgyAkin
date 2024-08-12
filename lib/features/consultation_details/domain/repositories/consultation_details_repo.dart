import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ConsultationDetailsRepository {
  Future<Either<Failure, List<GetConsultationDetailsModelResponse>>>
      getConsultationDetails(String consultationId);
}
