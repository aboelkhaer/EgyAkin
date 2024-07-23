
import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class EmailVerificationRepository {
  Future<Either<Failure, SendEmailForVerificationModelResponse>>
      sendEmailForVerification();
  Future<Either<Failure, SendOTPForEmailVerificationModelResponse>>
      sendOTPForEmailVerification(String otp);
}
