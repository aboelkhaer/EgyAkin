
import '../../../../exports.dart';

abstract class AddPatientDataSource {
  Future<GetPatientHistoryForAddPatientModelResponse>
      getPatientHistoryForAddPatient({
    required String sectionId,
  });
  Future<AddPatientForFirstTimeModelResponse> addPatientForFirstTime({
    required Map<String, dynamic> map,
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

  @override
  Future<AddPatientForFirstTimeModelResponse> addPatientForFirstTime(
      {required Map<String, dynamic> map}) async {
    return await _apiServices.addPatientForFirstTime(map);
  }
}
