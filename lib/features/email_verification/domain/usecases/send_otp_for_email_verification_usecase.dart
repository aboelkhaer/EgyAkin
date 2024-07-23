import 'package:dartz/dartz.dart';
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
