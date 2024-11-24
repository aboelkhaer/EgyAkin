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
}
