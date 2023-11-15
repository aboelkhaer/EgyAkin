import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../exports.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @POST(ApiEndPoint.logout)
  Future<LogoutModel> logout(
    @Field("token") String token,
  );

  @POST(ApiEndPoint.login)
  Future<GetDoctorWithTokenModelResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
  @POST(ApiEndPoint.register)
  Future<GetDoctorWithTokenModelResponse> register(
    @Field("name") String firstName,
    @Field("lname") String lastName,
    @Field("email") String email,
    @Field("password") String password,
    @Field("password_confirmation") String passwordConfirmation,
    @Field("age") String age,
    @Field("specialty") String specialty,
    @Field("workingplace") String workingPlace,
    @Field("phone") String phone,
    @Field("job") String job,
    @Field("highestdegree") String highestDegree,
  );

  @GET(ApiEndPoint.allPatients)
  Future<GetAllBasPatientstModelResponse> getAllPatients(
    @Field("token") String token,
  );

  @GET(ApiEndPoint.currentPatientsHome)
  Future<GetCurrentPatientstModelResponse> getCurrentPatients(
    @Field("token") String token,
  );
  @GET('${ApiEndPoint.search}/{searchContent}')
  Future<GetAllBasPatientstModelResponse> searchHome(
    @Path("searchContent") String searchContent,
  );
  @PUT('${ApiEndPoint.updateProfile}/{doctorID}')
  Future<GetDoctorModelResponse> updateProfile(
    @Path("doctorID") int doctorID,
    @Field("name") String firstName,
    @Field("lname") String lastName,
    @Field("email") String email,
    // @Field("password") String password,
    // @Field("password_confirmation") String passwordConfirmation,
    @Field("age") String age,
    @Field("specialty") String specialty,
    @Field("workingplace") String workingPlace,
    @Field("phone") String phone,
    @Field("job") String job,
    @Field("highestdegree") String highestDegree,
  );

  @GET('${ApiEndPoint.sections}/{patientId}')
  Future<GetBaseSectionsModelResponse> getPatientSections(
    @Path("patientId") String patientId,
  );

  @GET('${ApiEndPoint.question}/{sectionId}/{patientId}')
  Future<GetQuestionsModelResponse> getSectionDetails(
    @Path("sectionId") String sectionId,
    @Path("patientId") String patientId,
  );

  @DELETE('${ApiEndPoint.deletePatient}/{patientId}')
  Future<DeletePatientModelResponse> deletePatient(
    @Path("patientId") String patientId,
  );

  @PUT('${ApiEndPoint.updateSectionDetails}/{sectionId}/{patientId}')
  Future<UpdateSectionDetailsModelResponse> updateSectionDetails(
    @Path("sectionId") String sectionId,
    @Path("patientId") String patientId,
    @Body() Map<String, dynamic> map,
  );
  @GET('${ApiEndPoint.getAddPatientsQuestions}/{sectionId}')
  Future<GetQuestionsModelResponse> getPatientHistoryForAddPatient(
    @Path("sectionId") String sectionId,
  );
  @POST(ApiEndPoint.addPatientForFirstTime)
  Future<SemiPatientModel> addPatientForFirstTime(
    // @Field("doctor_id") String doctorId,
    @Body() Map<String, dynamic> map,
  );
  @POST(ApiEndPoint.outcome)
  Future<AddOutcometModelResponse> submitOutcome(
    @Field("patient_id") String patientId,
    @Field("outcome_of_the_patient") String outcomeOfThePatient,
    @Field("creatinine_on_discharge") String creatinineOnDischarge,
    @Field("final_status") String finalStatus,
    @Field("other") String other,
  );

  @GET('${ApiEndPoint.outcome}/{patientId}')
  Future<GetOutcomeModelResponse> getOutcome(
    @Path("patientId") String patientId,
  );
  @PUT('${ApiEndPoint.finalSubmit}/{patientId}')
  Future<UpdateSectionDetailsModelResponse> finalSubmit(
    @Path("patientId") String patientId,
  );
  @GET('${ApiEndPoint.comment}/{patientId}')
  Future<GetCommentstModelResponse> getComments(
    @Path("patientId") String patientId,
  );
  @POST(ApiEndPoint.comment)
  Future<AddCommentModelResponse> addComment(
    @Field("patient_id") String patientId,
    @Field("content") String content,
  );
  @DELETE('${ApiEndPoint.comment}/{commentId}')
  Future<DeleteCommentModelResponse> deleteComment(
    @Path("commentId") String commentId,
  );
  @POST(ApiEndPoint.contactUs)
  Future<AddContactUsModelResponse> addContactUs(
    @Field("message") String message,
  );

  @GET(ApiEndPoint.post)
  Future<GetPostsModelResponse> getHomePosts();

  @GET('${ApiEndPoint.postComments}/{postId}')
  Future<GetPostCommentsModelResponse> getHomePostComments(
    @Path("postId") String postId,
  );
  @DELETE('${ApiEndPoint.postComments}/{commentId}')
  Future<DeletePostCommentModelResponse> deletePostComment(
    @Path("commentId") String postId,
  );

  @GET(ApiEndPoint.notification)
  Future<GetNotificationModelResponse> getNotifications();

  @PUT(ApiEndPoint.notification)
  Future<UpdateNotificationsModelResponse> updateNotifications();

  @POST(ApiEndPoint.postComments)
  Future<AddCommentOnPostModelResponse> addCommentOnPost(
    @Field("post_id") String postId,
    @Field("content") String content,
  );
}
