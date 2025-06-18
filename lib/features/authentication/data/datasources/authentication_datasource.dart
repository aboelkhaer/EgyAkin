import '../../../../exports.dart';

abstract class AuthenticationDataSource {
  Future<AuthenticationModelResponse> signIn({
    required String email,
    required String password,
    required String fcmToken,
    required String deviceId,
  });
  Future<AuthenticationModelResponse> register({
    required DoctorModel doctorModel,
    required String deviceId,
  });
  Future<SendFCMTokenModelResponse> sendFCMToken({
    required String fcmToken,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final ApiServices _apiServices;

  AuthenticationDataSourceImpl(this._apiServices);

  @override
  Future<AuthenticationModelResponse> signIn({
    required String email,
    required String password,
    required String fcmToken,
    required String deviceId,
  }) async {
    return await _apiServices.signIn(email, password, fcmToken, deviceId);
  }

  @override
  Future<AuthenticationModelResponse> register({
    required DoctorModel doctorModel,
    required String deviceId,
  }) async {
    return await _apiServices.register(
      doctorModel.toJson(),
      deviceId,
    );
  }

  @override
  Future<SendFCMTokenModelResponse> sendFCMToken(
      {required String fcmToken}) async {
    return await _apiServices.sendFCMToken(fcmToken);
  }
}
