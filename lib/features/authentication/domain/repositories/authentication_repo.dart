import 'package:egy_akin/features/authentication/data/models/authentication_with_google_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationModelResponse>> signIn({
    required String email,
    required String password,
    required String? fcmToken,
    required String deviceId,
  });
  Future<Either<Failure, AuthenticationModelResponse>> register({
    required DoctorModel doctorModel,
  });
  Future<Either<Failure, SendFCMTokenModelResponse>> sendFCMToken({
    required String? fcmToken,
  });
  Future<Either<Failure, AuthenticationWithGoogleModelResponse>>
      signInWithGoogle({
    required String? accessToken,
    required String deviceId,
    required String? fcmToken,
  });
  Future<Either<Failure, AuthenticationWithGoogleModelResponse>>
      signInWithApple({
    required String? identityToken,
    required String? authorizationCode,
    required String deviceId,
    required String? fcmToken,
  });
}
