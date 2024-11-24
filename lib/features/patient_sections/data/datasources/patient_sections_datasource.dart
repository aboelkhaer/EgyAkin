import '../../../../exports.dart';

abstract class PatientSectionsDataSource {
  Future<GetPatientSectionsModelResponse> getPatientSections(String patientId);
  Future<DeletePatientModelResponse> deletePatient(String patientId);
  Future<FinalSubmitModelResponse> finalSubmit(String patientId);
  Future<DownloadPatientReportModelResponse> downloadPatientReport(
      String patientId);
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

  @override
  Future<DownloadPatientReportModelResponse> downloadPatientReport(
      String patientId) async {
    return await _apiServices.downloadPatientReport(patientId);
  }
}
