import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/send_consultation_model_response.dart';

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
