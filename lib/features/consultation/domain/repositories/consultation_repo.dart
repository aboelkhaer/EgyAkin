import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ConsultationRepository {
  Future<Either<Failure, GetCurrentDoctorConsultationModelResponse>>
      getCurrentDoctorConsultation();
}
