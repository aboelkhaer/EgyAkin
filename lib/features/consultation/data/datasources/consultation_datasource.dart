import '../../../../exports.dart';

abstract class ConsultationDataSource {
  Future<GetCurrentDoctorConsultationModelResponse>
      getCurrentDoctorConsultation();
}

class ConsultationDataSourceImpl implements ConsultationDataSource {
  final ApiServices _apiServices;

  ConsultationDataSourceImpl(this._apiServices);

  @override
  Future<GetCurrentDoctorConsultationModelResponse>
      getCurrentDoctorConsultation() async {
    return await _apiServices.getCurrentDoctorConsultation();
  }
}
