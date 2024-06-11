import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';
import 'package:egy_akin/features/change_password/data/models/change_password_model_response.dart';

import '../../../../exports.dart';

abstract class ChangePasswordDataSource {
  Future<ChangePasswordModelResponse> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}

class ChangePasswordDataSourceImpl implements ChangePasswordDataSource {
  final ApiServices _apiServices;

  ChangePasswordDataSourceImpl(this._apiServices);

  @override
  Future<ChangePasswordModelResponse> changePassword(
      {required String oldPassword, required String newPassword}) async {
    return await _apiServices.changePasswordFeature(oldPassword, newPassword);
  }
}
