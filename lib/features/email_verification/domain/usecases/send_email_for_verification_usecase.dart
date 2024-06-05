import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/email_verification/data/models/send_email_for_verification_model_response.dart';
import '../../../../exports.dart';

class SendEmailForVerificationUsecase
    implements BaseUseCase<NoParams, SendEmailForVerificationModelResponse> {
  final EmailVerificationRepository repository;

  SendEmailForVerificationUsecase(this.repository);

  @override
  Future<Either<Failure, SendEmailForVerificationModelResponse>> excute(
      NoParams input) async {
    return await repository.sendEmailForVerification();
  }
}
