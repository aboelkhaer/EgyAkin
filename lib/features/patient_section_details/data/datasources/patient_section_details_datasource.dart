import 'package:egy_akin/features/patient_section_details/data/models/get_patient_section_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_section_details_model_response.dart';

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
