import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SendFCMTokenUsecase
    implements BaseUseCase<String, SendFCMTokenModelResponse> {
  final AuthenticationRepository repository;

  SendFCMTokenUsecase(this.repository);

  @override
  Future<Either<Failure, SendFCMTokenModelResponse>> execute(
      String fcmToken) async {
    return await repository.sendFCMToken(fcmToken: fcmToken);
  }
}
