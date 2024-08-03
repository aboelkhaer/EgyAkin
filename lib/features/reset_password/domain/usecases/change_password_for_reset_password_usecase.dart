import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class ChangePasswordForResetPasswordUsecase
    implements
        BaseUseCase<ChangePasswordForResetPasswordUseCaseInput,
            ResetPasswordModelResponse> {
  final ResetPasswordRepository repository;

  ChangePasswordForResetPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordModelResponse>> execute(
      ChangePasswordForResetPasswordUseCaseInput input) async {
    return await repository.changePasswordForResetPassword(
        email: input.email, password: input.password);
  }
}

class ChangePasswordForResetPasswordUseCaseInput {
  final String email;
  final String password;
  const ChangePasswordForResetPasswordUseCaseInput({
    required this.email,
    required this.password,
  });
}
