import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../exports.dart';
import '../../features/home/model/all_patients_home_model.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @POST(ApiEndPoint.logout)
  Future<LogoutModel> logout(
    @Field("token") String token,
  );

  @POST(ApiEndPoint.login)
  Future<DoctorModelResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
  @POST(ApiEndPoint.register)
  Future<DoctorModelResponse> register(
    @Field("name") String firstName,
    @Field("lname") String lastName,
    @Field("email") String email,
    @Field("password") String password,
    @Field("password_confirmation") String passwordConfirmation,
    @Field("age") int age,
    @Field("specialty") String specialty,
    @Field("workingplace") String workingPlace,
    @Field("phone") String phone,
    @Field("job") String job,
    @Field("highestdegree") String highestDegree,
  );

  @GET(ApiEndPoint.allPatients)
  Future<AllPatientHomeModelResponse> getAllPatients(
    @Field("token") String token,
  );

  @GET(ApiEndPoint.currentPatientsHome)
  Future<PatientHomeModelResponse> getCurrentPatients(
    @Field("token") String token,
  );
}
