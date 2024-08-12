import '../../../../exports.dart';

abstract class ConsultationDetailsDataSource {
  Future<List<GetConsultationDetailsModelResponse>> getConsultationDetails(
      String consultationId);
}

class ConsultationDetailsDataSourceImpl
    implements ConsultationDetailsDataSource {
  final ApiServices _apiServices;

  ConsultationDetailsDataSourceImpl(this._apiServices);

  @override
  Future<List<GetConsultationDetailsModelResponse>> getConsultationDetails(
      String consultationId) async {
    return await _apiServices.getConsultationDetails(consultationId);
  }
}
