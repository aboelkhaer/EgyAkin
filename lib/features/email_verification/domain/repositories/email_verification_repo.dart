import 'package:egy_akin/features/email_verification/data/models/send_email_for_verification_model_response.dart';
import 'package:egy_akin/features/email_verification/data/models/send_otp_for_email_verification_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class EmailVerificationRepository {
  Future<Either<Failure, SendEmailForVerificationModelResponse>>
      sendEmailForVerification();
  Future<Either<Failure, SendOTPForEmailVerificationModelResponse>>
      sendOTPForEmailVerification(String otp);
}
