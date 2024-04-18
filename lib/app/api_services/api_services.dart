import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:egy_akin/features/email_verification/data/models/send_email_for_verification_model_response.dart';
import 'package:egy_akin/features/email_verification/data/models/send_otp_for_email_verification_model_response.dart';
import 'package:egy_akin/features/post_details/data/models/add_comment_on_post_model_response.dart';
import 'package:egy_akin/features/profile/data/models/sign_out_model_response.dart';
import 'package:egy_akin/features/profile/data/models/upload_profile_image_model_response.dart';
import 'package:retrofit/http.dart';
import '../../exports.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @POST(ApiEndPoint.signOut)
  Future<SignOutModelResponse> signOut();

  @POST(ApiEndPoint.signIn)
  Future<AuthenticationModelResponse> signIn(
    @Field("email") String email,
    @Field("password") String password,
  );
  @POST(ApiEndPoint.register)
  Future<AuthenticationModelResponse> register(
    @Body() Map<String, dynamic> doctorModel,
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
  Future<GetPatientHistoryForAddPatientModelResponse>
      getPatientHistoryForAddPatient(
    @Path("sectionId") String sectionId,
  );
  @POST(ApiEndPoint.addPatientForFirstTime)
  Future<SemiPatientModel> addPatientForFirstTime(
    @Body() Map<String, dynamic> map,
  );
  @POST(ApiEndPoint.outcome)
  Future<AddOutcometModelResponse> submitOutcome(
    @Field("patient_id") String patientId,
    @Field("outcome_of_the_patient") String outcomeOfThePatient,
    @Field("creatinine_on_discharge") String creatinineOnDischarge,
    @Field("duration_of_admission") String durationField,
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
  Future<PostCommentsModelResponse> getPostComments(
    @Path("postId") String postId,
  );
  @DELETE('${ApiEndPoint.postComments}/{commentId}')
  Future<DeletePostCommentModelResponse> deletePostComment(
    @Path("commentId") String commentId,
  );

  // @GET(ApiEndPoint.notification)
  // Future<NotificationModelResponse> getNotifications();

  @GET(ApiEndPoint.getAllNotifications)
  Future<GetAllNotificationsModelResponse> getAllNotifications(
      @Query('page') int pageNumber);

  @PUT(ApiEndPoint.notification)
  Future<UpdateNotificationModelResponse> updateNotifications();

  @POST(ApiEndPoint.postComments)
  Future<AddCommentOnPostModelResponse> addCommentOnPost(
    @Field("post_id") String postId,
    @Field("content") String content,
  );

  @POST(ApiEndPoint.forgetPassword)
  Future<ResetPasswordModelResponse> sendEmailForForgetPassword(
    @Field("email") String email,
  );
  @POST(ApiEndPoint.resetPasswordVerification)
  Future<ResetPasswordModelResponse> verifyOTP(
    @Field("email") String email,
    @Field("otp") String otp,
  );
  @POST(ApiEndPoint.changePassword)
  Future<ResetPasswordModelResponse> changePassword(
    @Field("email") String email,
    @Field("password") String newPassword,
  );
  @POST(ApiEndPoint.sendEmailVerification)
  Future<SendEmailForVerificationModelResponse> sendEmailVerification();

  @POST(ApiEndPoint.sendOTPForEmailVerification)
  Future<SendOTPForEmailVerificationModelResponse> sendOTPForEmailVerification(
    @Field("otp") String otp,
  );

  @GET(ApiEndPoint.home)
  Future<HomeModelResponse> getHome();

  @POST(ApiEndPoint.uploadProfileImage)
  @MultiPart()
  Future<UploadProfileImageModelResponse> uploadProfileImage(
    @Part() File image,
  );
}
