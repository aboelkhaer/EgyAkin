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
