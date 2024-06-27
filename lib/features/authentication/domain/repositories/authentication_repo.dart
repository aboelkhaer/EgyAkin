import 'package:egy_akin/features/authentication/data/models/send_fcm_token_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationModelResponse>> signIn({
    required String email,
    required String password,
    required String fcmToken,
  });
  Future<Either<Failure, AuthenticationModelResponse>> register({
    required DoctorModel doctorModel,
  });
  Future<Either<Failure, SendFCMTokenModelResponse>> sendFCMToken({
    required String fcmToken,
  });
}
