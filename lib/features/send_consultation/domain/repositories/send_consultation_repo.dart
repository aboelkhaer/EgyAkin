import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class SendConsultationRepository {
  Future<Either<Failure, GetConsultationSearchModelResponse>>
      consultationDoctorSearch({
    required String searchContent,
  });
}
