import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ResetPasswordRepository {
  Future<Either<Failure, ResetPasswordModelResponse>>
      sendEmailForResetPassword({
    required String email,
  });
  Future<Either<Failure, ResetPasswordModelResponse>>
      verifyOTPForResetPassword({
    required String email,
    required String otp,
  });
  Future<Either<Failure, ResetPasswordModelResponse>>
      changePasswordForResetPassword({
    required String email,
    required String password,
  });
}
