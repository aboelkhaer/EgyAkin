import '../../../../exports.dart';

abstract class ResetPasswordDataSource {
  Future<ResetPasswordModelResponse> sendEmailForResetPassword({
    required String email,
  });
  Future<ResetPasswordModelResponse> verifyOTPForResetPassword({
    required String email,
    required String otp,
  });
  Future<ResetPasswordModelResponse> changePasswordForResetPassword({
    required String email,
    required String password,
  });
}

class ResetPasswordDataSourceImpl implements ResetPasswordDataSource {
  final ApiServices _apiServices;

  ResetPasswordDataSourceImpl(this._apiServices);

  @override
  Future<ResetPasswordModelResponse> sendEmailForResetPassword({
    required String email,
  }) async {
    return await _apiServices.sendEmailForForgetPassword(email);
  }

  @override
  Future<ResetPasswordModelResponse> verifyOTPForResetPassword(
      {required String email, required String otp}) async {
    return await _apiServices.verifyOTP(email, otp);
  }

  @override
  Future<ResetPasswordModelResponse> changePasswordForResetPassword(
      {required String email, required String password}) async {
    return await _apiServices.changePassword(email, password);
  }
}
