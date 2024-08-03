import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class VerifyOTPForResetPasswordUsecase
    implements
        BaseUseCase<VerifyOTPForResetPasswordUseCaseInput,
            ResetPasswordModelResponse> {
  final ResetPasswordRepository repository;

  VerifyOTPForResetPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordModelResponse>> execute(
      VerifyOTPForResetPasswordUseCaseInput input) async {
    return await repository.verifyOTPForResetPassword(
        email: input.email, otp: input.otp);
  }
}

class VerifyOTPForResetPasswordUseCaseInput {
  final String email;
  final String otp;
  const VerifyOTPForResetPasswordUseCaseInput({
    required this.email,
    required this.otp,
  });
}
