import '../../../../exports.dart';

abstract class ConsultationDataSource {
  Future<List<GetCurrentDoctorConsultationModelResponse>>
      getCurrentDoctorConsultation();
  Future<List<GetCurrentDoctorConsultationModelResponse>>
      getReceivedConsultation();
}

class ConsultationDataSourceImpl implements ConsultationDataSource {
  final ApiServices _apiServices;

  ConsultationDataSourceImpl(this._apiServices);

  @override
  Future<List<GetCurrentDoctorConsultationModelResponse>>
      getCurrentDoctorConsultation() async {
    return await _apiServices.getCurrentDoctorConsultation();
  }

  @override
  Future<List<GetCurrentDoctorConsultationModelResponse>>
      getReceivedConsultation() async {
    return await _apiServices.getReceivedConsultation();
  }
}
