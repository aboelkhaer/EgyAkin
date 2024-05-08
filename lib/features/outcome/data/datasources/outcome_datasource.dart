import 'package:egy_akin/features/outcome/data/models/sumbit_outcome_model_response.dart';

import '../../../../exports.dart';

abstract class OutcomeDataSource {
  Future<GetOutcomeModelResponse> getOutcome(String patientId);
  Future<SubmitOutcomeModelResponse> submitOutcome(
      String patientId,
      String outcomeOfThePatient,
      String creatinineOnDischarge,
      String durationField,
      String finalStatus,
      String other);
}

class OutcomeDataSourceImpl implements OutcomeDataSource {
  final ApiServices _apiServices;

  OutcomeDataSourceImpl(this._apiServices);

  @override
  Future<GetOutcomeModelResponse> getOutcome(String patientId) async {
    return await _apiServices.getOutcome(patientId);
  }

  @override
  Future<SubmitOutcomeModelResponse> submitOutcome(
      String patientId,
      String outcomeOfThePatient,
      String creatinineOnDischarge,
      String durationField,
      String finalStatus,
      String other) async {
    return await _apiServices.submitOutcome(patientId, outcomeOfThePatient,
        creatinineOnDischarge, durationField, finalStatus, other);
  }
}
