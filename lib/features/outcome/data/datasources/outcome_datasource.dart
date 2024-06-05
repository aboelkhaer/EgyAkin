import 'package:egy_akin/features/outcome/data/models/sumbit_outcome_model_response.dart';

import '../../../../exports.dart';

abstract class OutcomeDataSource {
  Future<GetOutcomeModelResponse> getOutcome(
      String sectionId, String patientId);
  Future<SubmitOutcomeModelResponse> submitOutcome(
    String patientId,
    String sectionId,
    Map<String, dynamic> map,
  );
}

class OutcomeDataSourceImpl implements OutcomeDataSource {
  final ApiServices _apiServices;

  OutcomeDataSourceImpl(this._apiServices);

  @override
  Future<GetOutcomeModelResponse> getOutcome(
      String sectionId, String patientId) async {
    return await _apiServices.getOutcome(sectionId, patientId);
  }

  @override
  Future<SubmitOutcomeModelResponse> submitOutcome(
      String patientId, String sectionId, Map<String, dynamic> map) async {
    return await _apiServices.submitOutcome(sectionId, patientId, map);
  }
}
