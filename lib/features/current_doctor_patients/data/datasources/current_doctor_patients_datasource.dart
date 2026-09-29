import 'package:egy_akin/features/all_doctors_patients/domain/usecases/patients_list_page_input.dart';

import '../../../../exports.dart';

abstract class CurrentDoctorPatientsDataSource {
  Future<GetDoctorPatientsModelResponse> getCurrentDoctorPatients(
    PatientsListPageInput input,
  );
}

class CurrentDoctorPatientsDataSourceImpl
    implements CurrentDoctorPatientsDataSource {
  final ApiServices _apiServices;

  CurrentDoctorPatientsDataSourceImpl(this._apiServices);

  @override
  Future<GetDoctorPatientsModelResponse> getCurrentDoctorPatients(
    PatientsListPageInput input,
  ) async {
    return await _apiServices.getCurrentPatients(
      input.page,
      input.sort,
      input.direction,
    );
  }
}
