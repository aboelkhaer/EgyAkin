import '../../../../exports.dart';

abstract class AuthenticationDataSource {
  Future<AuthenticationModelResponse> signIn({
    required String email,
    required String password,
  });
  Future<AuthenticationModelResponse> register({
    required DoctorModel doctorModel,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final ApiServices _apiServices;

  AuthenticationDataSourceImpl(this._apiServices);

  @override
  Future<AuthenticationModelResponse> signIn(
      {required String email, required String password}) async {
    return await _apiServices.signIn(email, password);
  }

  @override
  Future<AuthenticationModelResponse> register(
      {required DoctorModel doctorModel}) async {
    return await _apiServices.register(doctorModel.toJson());
  }
}
