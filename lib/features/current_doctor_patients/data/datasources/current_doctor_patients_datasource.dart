import 'package:egy_akin/features/doctor_info_view/data/models/get_achievements_model_response.dart';
import 'package:egy_akin/features/current_doctor_patients/data/models/get_current_doctor_patients_model_response.dart';

import '../../../../exports.dart';

abstract class CurrentDoctorPatientsDataSource {
  Future<GetDoctorPatientsModelResponse> getCurrentDoctorPatients(int page);
}

class CurrentDoctorPatientsDataSourceImpl
    implements CurrentDoctorPatientsDataSource {
  final ApiServices _apiServices;

  CurrentDoctorPatientsDataSourceImpl(this._apiServices);

  @override
  Future<GetDoctorPatientsModelResponse> getCurrentDoctorPatients(
      int page) async {
    return await _apiServices.getCurrentPatients(page);
  }
}
