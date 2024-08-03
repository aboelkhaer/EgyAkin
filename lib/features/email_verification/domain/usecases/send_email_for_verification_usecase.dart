import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SendEmailForVerificationUsecase
    implements BaseUseCase<NoParams, SendEmailForVerificationModelResponse> {
  final EmailVerificationRepository repository;

  SendEmailForVerificationUsecase(this.repository);

  @override
  Future<Either<Failure, SendEmailForVerificationModelResponse>> execute(
      NoParams input) async {
    return await repository.sendEmailForVerification();
  }
}
