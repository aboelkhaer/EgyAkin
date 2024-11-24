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
