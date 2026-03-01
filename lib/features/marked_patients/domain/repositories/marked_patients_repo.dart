import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/marked_patients/data/models/get_marked_patients_model_response.dart';

import '../../../../exports.dart';

abstract class MarkedPatientsRepository {
  Future<Either<Failure, GetMarkedPatientsModelResponse>> getMarkedPatients(
      int page);
}
