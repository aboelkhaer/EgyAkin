import 'package:egy_akin/features/authentication/data/models/authentication_with_google_model_response.dart';

import '../../../../exports.dart';

abstract class AuthenticationDataSource {
  Future<AuthenticationModelResponse> signIn({
    required String email,
    required String password,
    required String? fcmToken,
    required String deviceId,
  });
  Future<AuthenticationModelResponse> register({
    required DoctorModel doctorModel,
  });
  Future<SendFCMTokenModelResponse> sendFCMToken({
    required String? fcmToken,
  });
  Future<AuthenticationWithGoogleModelResponse> signInWithGoogle({
    required String? accessToken,
    required String deviceId,
    required String? fcmToken,
  });
  Future<AuthenticationWithGoogleModelResponse> signInWithApple({
    required String? identityToken,
    required String? authorizationCode,
    required String deviceId,
    required String? fcmToken,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final ApiServices _apiServices;

  AuthenticationDataSourceImpl(this._apiServices);

  @override
  Future<AuthenticationModelResponse> signIn({
    required String email,
    required String password,
    required String? fcmToken,
    required String deviceId,
  }) async {
    return await _apiServices.signIn(email, password, fcmToken, deviceId);
  }

  @override
  Future<AuthenticationModelResponse> register({
    required DoctorModel doctorModel,
  }) async {
    return await _apiServices.register(
      doctorModel.toJson(),
    );
  }

  @override
  Future<SendFCMTokenModelResponse> sendFCMToken(
      {required String? fcmToken}) async {
    return await _apiServices.sendFCMToken(fcmToken);
  }

  @override
  Future<AuthenticationWithGoogleModelResponse> signInWithGoogle({
    required String? accessToken,
    required String deviceId,
    required String? fcmToken,
  }) async {
    return await _apiServices.signInWithGoogle(accessToken, deviceId, fcmToken);
  }

  @override
  Future<AuthenticationWithGoogleModelResponse> signInWithApple({
    required String? identityToken,
    required String? authorizationCode,
    required String deviceId,
    required String? fcmToken,
  }) async {
    return await _apiServices.signInWithApple(identityToken, authorizationCode, deviceId, fcmToken);
  }
}
