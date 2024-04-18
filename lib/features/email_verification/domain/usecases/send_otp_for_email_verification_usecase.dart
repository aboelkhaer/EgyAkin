import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/email_verification/data/models/send_otp_for_email_verification_model_response.dart';
import '../../../../exports.dart';

class SendOTPForEmailVerificationUsecase
    implements BaseUseCase<String, SendOTPForEmailVerificationModelResponse> {
  final EmailVerificationRepository repository;

  SendOTPForEmailVerificationUsecase(this.repository);

  @override
  Future<Either<Failure, SendOTPForEmailVerificationModelResponse>> excute(
      String otp) async {
    return await repository.sendOTPForEmailVerification(otp);
  }
}
