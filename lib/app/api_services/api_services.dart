import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../exports.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @POST(ApiEndPoint.login)
  Future<DoctorModelResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
}
