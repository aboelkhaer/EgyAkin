import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';

import '../../../../exports.dart';

abstract class AllDoctorsPatientsDataSource {
  Future<GetAllDoctorsPatientsModelResponse> getAllDoctorPatients(int page);
}

class AllDoctorsPatientsDataSourceImpl implements AllDoctorsPatientsDataSource {
  final ApiServices _apiServices;

  AllDoctorsPatientsDataSourceImpl(this._apiServices);

  @override
  Future<GetAllDoctorsPatientsModelResponse> getAllDoctorPatients(
      int page) async {
    return await _apiServices.getAllPatients(page);
  }
}
