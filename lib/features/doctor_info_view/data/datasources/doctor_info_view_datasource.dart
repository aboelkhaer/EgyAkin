import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';

import '../../../../exports.dart';

abstract class DoctorInfoViewDataSource {
  Future<DoctorInfoViewModelResponse> getDoctorInfoView(String doctorId);
}

class DoctorInfoViewDataSourceImpl implements DoctorInfoViewDataSource {
  final ApiServices _apiServices;

  DoctorInfoViewDataSourceImpl(this._apiServices);

  @override
  Future<DoctorInfoViewModelResponse> getDoctorInfoView(String doctorId) async {
    return await _apiServices.getDoctorInfoView(doctorId);
  }
}
