import 'package:egy_akin/features/patient_sections/data/models/delete_patient_model_response.dart';
import 'package:egy_akin/features/patient_sections/data/models/final_submit_model_response.dart';

import '../../../../exports.dart';

abstract class PatientSectionsDataSource {
  Future<GetPatientSectionsModelResponse> getPatientSections(String patientId);
  Future<DeletePatientModelResponse> deletePatient(String patientId);
  Future<FinalSubmitModelResponse> finalSubmit(String patientId);
}

class PatientSectionsDataSourceImpl implements PatientSectionsDataSource {
  final ApiServices _apiServices;

  PatientSectionsDataSourceImpl(this._apiServices);

  @override
  Future<GetPatientSectionsModelResponse> getPatientSections(
      String patientId) async {
    return await _apiServices.getPatientSections(patientId);
  }

  @override
  Future<DeletePatientModelResponse> deletePatient(String patientId) async {
    return await _apiServices.deletePatient(patientId);
  }

  @override
  Future<FinalSubmitModelResponse> finalSubmit(String patientId) async {
    return await _apiServices.finalSubmit(patientId);
  }
}
