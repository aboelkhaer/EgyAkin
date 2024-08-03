import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/authentication/data/models/send_fcm_token_model_response.dart';
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
