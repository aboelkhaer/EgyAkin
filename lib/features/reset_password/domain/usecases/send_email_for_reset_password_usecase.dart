import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SendEmailForResetPasswordUsecase
    implements BaseUseCase<String, ResetPasswordModelResponse> {
  final ResetPasswordRepository repository;

  SendEmailForResetPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordModelResponse>> excute(
      String email) async {
    return await repository.sendEmailForResetPassword(email: email);
  }
}
