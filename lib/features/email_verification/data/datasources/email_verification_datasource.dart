
import '../../../../exports.dart';

abstract class EmailVerificationDataSource {
  Future<SendEmailForVerificationModelResponse> sendEmailForVerification();
  Future<SendOTPForEmailVerificationModelResponse> sendOTPForEmailVerification(
      String otp);
}

class EmailVerificationDataSourceImpl implements EmailVerificationDataSource {
  final ApiServices _apiServices;

  EmailVerificationDataSourceImpl(this._apiServices);

  @override
  Future<SendEmailForVerificationModelResponse>
      sendEmailForVerification() async {
    return await _apiServices.sendEmailVerification();
  }

  @override
  Future<SendOTPForEmailVerificationModelResponse> sendOTPForEmailVerification(
      String otp) async {
    return await _apiServices.sendOTPForEmailVerification(otp);
  }
}
