import '../../../../exports.dart';

abstract class PatientSectionDetailsDataSource {
  Future<GetPatientSectionDetailsModelResponse> getPatientSectionDetails(
      String sectionId, String patientId);
  Future<UpdatePatientSectionDetailsModelResponse> updatePatientSectionDetails(
      String sectionId, String patientId, Map<String, dynamic> map);
}

class PatientSectionDetailsDataSourceImpl
    implements PatientSectionDetailsDataSource {
  final ApiServices _apiServices;

  PatientSectionDetailsDataSourceImpl(this._apiServices);

  @override
  Future<GetPatientSectionDetailsModelResponse> getPatientSectionDetails(
      String sectionId, String patientId) async {
    return await _apiServices.getSectionDetails(sectionId, patientId);
  }

  @override
  Future<UpdatePatientSectionDetailsModelResponse> updatePatientSectionDetails(
      String sectionId, String patientId, Map<String, dynamic> map) async {
    return await _apiServices.updateSectionDetails(sectionId, patientId, map);
  }
}
