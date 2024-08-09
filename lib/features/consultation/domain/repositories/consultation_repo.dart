import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ConsultationRepository {
  Future<Either<Failure, List<GetCurrentDoctorConsultationModelResponse>>>
      getCurrentDoctorConsultation();
  Future<Either<Failure, List<GetCurrentDoctorConsultationModelResponse>>>
      getReceivedConsultation();
}
