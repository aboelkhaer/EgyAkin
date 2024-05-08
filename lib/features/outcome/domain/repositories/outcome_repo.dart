import 'package:egy_akin/features/outcome/data/models/sumbit_outcome_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class OutcomeRepository {
  Future<Either<Failure, GetOutcomeModelResponse>> getOutcome(String patientId);
  Future<Either<Failure, SubmitOutcomeModelResponse>> submitOutcome(
      String patientId,
      String outcomeOfThePatient,
      String creatinineOnDischarge,
      String durationField,
      String finalStatus,
      String other);
}
