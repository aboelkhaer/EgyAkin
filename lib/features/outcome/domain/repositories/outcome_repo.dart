import 'package:egy_akin/features/outcome/data/models/sumbit_outcome_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_patient_section_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class OutcomeRepository {
  Future<Either<Failure, GetOutcomeModelResponse>> getOutcome(
      String sectionId, String patientId);
  Future<Either<Failure, SubmitOutcomeModelResponse>> submitOutcome(
    String patientId,
    String sectionId,
    Map<String, dynamic> map,
  );
}
