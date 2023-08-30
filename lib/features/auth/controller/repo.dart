import 'dart:developer';

import '../../../exports.dart';

class AuthRepository {
  ApiServices apiServices;
  AuthRepository({required this.apiServices});
  // ApiServices apiServices = sl<ApiServices>();

  login(String email, String password) async {
    var response = await apiServices.login(email, password);
    log(response.token!);
  }
}
