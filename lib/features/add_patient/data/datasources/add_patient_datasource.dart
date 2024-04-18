import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';

import '../../../../exports.dart';

abstract class AddPatientDataSource {
  Future<GetPatientHistoryForAddPatientModelResponse>
      getPatientHistoryForAddPatient({
    required String sectionId,
  });
}

class AddPatientDataSourceImpl implements AddPatientDataSource {
  final ApiServices _apiServices;

  AddPatientDataSourceImpl(this._apiServices);

  @override
  Future<GetPatientHistoryForAddPatientModelResponse>
      getPatientHistoryForAddPatient({required String sectionId}) async {
    return await _apiServices.getPatientHistoryForAddPatient(sectionId);
  }
}
