import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';

import '../../../../exports.dart';

abstract class SendConsultationDataSource {
  Future<GetConsultationSearchModelResponse> consultationDoctorSearch({
    required String searchContent,
  });
}

class SendConsultationDataSourceImpl implements SendConsultationDataSource {
  final ApiServices _apiServices;

  SendConsultationDataSourceImpl(this._apiServices);

  @override
  Future<GetConsultationSearchModelResponse> consultationDoctorSearch(
      {required String searchContent}) async {
    return await _apiServices.consultationDoctorSearch(searchContent);
  }
}
