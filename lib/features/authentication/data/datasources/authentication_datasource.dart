import 'package:egy_akin/features/authentication/data/models/send_fcm_token_model_response.dart';

import '../../../../exports.dart';

abstract class AuthenticationDataSource {
  Future<AuthenticationModelResponse> signIn({
    required String email,
    required String password,
    required String fcmToken,
  });
  Future<AuthenticationModelResponse> register({
    required DoctorModel doctorModel,
  });
  Future<SendFCMTokenModelResponse> sendFCMToken({
    required String fcmToken,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final ApiServices _apiServices;

  AuthenticationDataSourceImpl(this._apiServices);

  @override
  Future<AuthenticationModelResponse> signIn(
      {required String email,
      required String password,
      required String fcmToken}) async {
    return await _apiServices.signIn(email, password, fcmToken);
  }

  @override
  Future<AuthenticationModelResponse> register(
      {required DoctorModel doctorModel}) async {
    return await _apiServices.register(doctorModel.toJson());
  }

  @override
  Future<SendFCMTokenModelResponse> sendFCMToken(
      {required String fcmToken}) async {
    return await _apiServices.sendFCMToken(fcmToken);
  }
}
