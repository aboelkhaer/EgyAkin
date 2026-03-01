import 'package:egy_akin/features/marked_patients/data/models/get_marked_patients_model_response.dart';

import '../../../../exports.dart';

abstract class MarkedPatientsDataSource {
  Future<GetMarkedPatientsModelResponse> getMarkedPatients(int page);
}

class MarkedPatientsDataSourceImpl implements MarkedPatientsDataSource {
  final ApiServices _apiServices;

  MarkedPatientsDataSourceImpl(this._apiServices);

  @override
  Future<GetMarkedPatientsModelResponse> getMarkedPatients(int page) async {
    return await _apiServices.getMarkedPatients(page);
  }
}
