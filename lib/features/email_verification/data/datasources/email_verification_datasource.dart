import 'package:egy_akin/features/email_verification/data/models/send_email_for_verification_model_response.dart';
import 'package:egy_akin/features/email_verification/data/models/send_otp_for_email_verification_model_response.dart';

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
