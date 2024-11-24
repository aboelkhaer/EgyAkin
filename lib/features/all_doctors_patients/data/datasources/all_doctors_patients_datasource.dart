import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';

import '../../../../exports.dart';

abstract class AllDoctorsPatientsDataSource {
  Future<GetAllDoctorsPatientsModelResponse> getAllDoctorPatients(int page);

  Future<ApplyPatientFiltersModelResponse> applyPatientsFilters(
    Map<String, dynamic> map,
    int page,
  );
}

class AllDoctorsPatientsDataSourceImpl implements AllDoctorsPatientsDataSource {
  final ApiServices _apiServices;

  AllDoctorsPatientsDataSourceImpl(this._apiServices);

  @override
  Future<GetAllDoctorsPatientsModelResponse> getAllDoctorPatients(
      int page) async {
    return await _apiServices.getAllPatients(page);
  }

  @override
  Future<ApplyPatientFiltersModelResponse> applyPatientsFilters(
      Map<String, dynamic> map, int page) async {
    return await _apiServices.applyPatientFilters(map, page);
  }
}
