import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import 'package:egy_akin/features/community/data/models/add_like_on_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/community/data/models/save_or_unsave_post_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/block_user_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/verify_user_email_model_response.dart';
import 'package:retrofit/retrofit.dart';
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
    @Field("fcmToken") String fcmToken,
  );
  @POST(ApiEndPoint.register)
  Future<AuthenticationModelResponse> register(
    @Body() Map<String, dynamic> doctorModel,
  );

  @GET(ApiEndPoint.allPatients)
  Future<GetAllDoctorsPatientsModelResponse> getAllPatients(
    @Query('page') int pageNumber,
  );

  @GET('${ApiEndPoint.doctorProfileGetPatients}/{doctorId}')
  Future<GetProfilePatientsModelResponse> getProfilePatients(
    @Query('page') int pageNumber,
    @Path("doctorId") String doctorId,
  );

  @GET(ApiEndPoint.currentPatientsHome)
  Future<GetDoctorPatientsModelResponse> getCurrentPatients(
    @Query('page') int pageNumber,
  );

  @POST(ApiEndPoint.search)
  Future<GetSearchModelResponse> searchHome(
    @Field("patient") String patient,
    @Field("dose") String dose,
  );
  @PUT(ApiEndPoint.updateProfile)
  Future<UpdateDoctorProfileModelResponse> updateProfile(
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
  Future<GetPatientSectionsModelResponse> getPatientSections(
    @Path("patientId") String patientId,
  );

  @GET('${ApiEndPoint.getPatientSectionDetails}/{sectionId}/{patientId}')
  Future<GetPatientSectionDetailsModelResponse> getSectionDetails(
    @Path("sectionId") String sectionId,
    @Path("patientId") String patientId,
  );

  @DELETE('${ApiEndPoint.deletePatient}/{patientId}')
  Future<DeletePatientModelResponse> deletePatient(
    @Path("patientId") String patientId,
  );

  @PUT('${ApiEndPoint.updateSectionDetails}/{sectionId}/{patientId}')
  // @POST(ApiEndPoint.updateSectionDetails)
  Future<UpdatePatientSectionDetailsModelResponse> updateSectionDetails(
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
  Future<AddPatientForFirstTimeModelResponse> addPatientForFirstTime(
    @Body() Map<String, dynamic> map,
  );
  @PUT('${ApiEndPoint.submitOutcome}/{sectionId}/{patientId}')
  Future<SubmitOutcomeModelResponse> submitOutcome(
    @Path("sectionId") String sectionId,
    @Path("patientId") String patientId,
    @Body() Map<String, dynamic> map,
  );

  // @GET('${ApiEndPoint.outcome}/{patientId}')
  // Future<GetOutcomeModelResponse> getOutcome(
  //   @Path("patientId") String patientId,
  // );

  @GET('${ApiEndPoint.outcome}/{sectionId}/{patientId}')
  Future<GetOutcomeModelResponse> getOutcome(
    @Path("sectionId") String sectionId,
    @Path("patientId") String patientId,
  );

  @PUT('${ApiEndPoint.finalSubmit}/{patientId}')
  Future<FinalSubmitModelResponse> finalSubmit(
    @Path("patientId") String patientId,
  );
  @GET('${ApiEndPoint.comment}/{patientId}')
  Future<GetPatientCommentsModelResponse> getPatientComments(
    @Path("patientId") String patientId,
  );
  @POST(ApiEndPoint.comment)
  Future<AddPatientCommentsModelResponse> addComment(
    @Field("patient_id") String patientId,
    @Field("content") String content,
  );
  @DELETE('${ApiEndPoint.comment}/{commentId}')
  Future<DeletePatientCommentsModelResponse> deleteComment(
    @Path("commentId") String commentId,
  );
  @POST(ApiEndPoint.contactUs)
  Future<ContactUsModelResponseModelResponse> addContactUs(
    @Field("message") String message,
  );

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
    @Query('page') int pageNumber,
  );

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

  @GET('${ApiEndPoint.getDoctorInfoView}/{doctorId}')
  Future<DoctorInfoViewModelResponse> getDoctorInfoView(
    @Path("doctorId") String doctorId,
  );

  @GET('${ApiEndPoint.downloadPatientReport}/{patientId}')
  Future<DownloadPatientReportModelResponse> downloadPatientReport(
    @Path("patientId") String patientId,
  );

  @GET(ApiEndPoint.appSettings)
  Future<GetAppSettingsModelResponse> getAppSettings();

  @POST(ApiEndPoint.uploadSyndicateCard)
  @MultiPart()
  Future<UploadSyndicateCardModelResponse> uploadSyndicateCard(
    @Part(name: "syndicate_card") File image,
  );

  @POST(ApiEndPoint.changePasswordFeature)
  Future<ChangePasswordModelResponse> changePasswordFeature(
    @Field("current_password") String oldPassword,
    @Field("new_password") String newPassword,
  );
  @POST(ApiEndPoint.sendFCMToken)
  Future<SendFCMTokenModelResponse> sendFCMToken(
    @Field("token") String fcmToken,
  );

  @GET('${ApiEndPoint.doctorProfileGetScoreHistory}/{doctorId}')
  Future<GetDoctorProfileScoreModelResponse> getDoctorProfileScoreHistory(
    @Query('page') int pageNumber,
    @Path("doctorId") String doctorId,
  );

  @POST('${ApiEndPoint.consultationDoctorSearch}/{searchContent}')
  Future<GetConsultationSearchModelResponse> consultationDoctorSearch(
    @Path("searchContent") String searchContent,
  );

  @POST(ApiEndPoint.createConsultation)
  Future<SendConsultationModelResponse> sendConsultation(
    @Field("patient_id") String patientId,
    @Field("consult_message") String message,
    @Field("consult_doctor_ids") List<String> doctorsIDS,
  );

  @GET(ApiEndPoint.getCurrentDoctorConsultation)
  Future<List<GetCurrentDoctorConsultationModelResponse>>
      getCurrentDoctorConsultation();

  @GET(ApiEndPoint.getReceivedConsultation)
  Future<List<GetCurrentDoctorConsultationModelResponse>>
      getReceivedConsultation();

  @GET('${ApiEndPoint.getConsultationDetails}/{consultationId}')
  Future<GetConsultationDetailsModelResponse> getConsultationDetails(
    @Path("consultationId") String consultationId,
  );

  @PUT('${ApiEndPoint.addConsultationReply}/{consultationId}')
  Future<AddConsultationReplyModelResponse> addConsultationReply(
    @Path("consultationId") String consultationId,
    @Field("reply") String reply,
  );

  @GET('${ApiEndPoint.updateProfile}/{doctorId}/achievements')
  Future<List<GetAchievementsModelResponse>> getAchievements(
    @Path("doctorId") String doctorId,
  );

  @PUT('${ApiEndPoint.syndicateCardVerifyRequest}/{doctorId}')
  Future<SyndicateCardVerifyModelResponse> changeSyndicateCardStatus(
    @Field("isSyndicateCardRequired") String status,
    @Path("doctorId") String doctorId,
  );

  @PUT('${ApiEndPoint.blockDoctor}/{doctorId}')
  Future<BlockUserModelResponse> blockDoctor(
    @Field("blocked") bool status,
    @Path("doctorId") String doctorId,
  );

  @PUT('${ApiEndPoint.verifyDoctorEmail}/{doctorId}')
  Future<VerifyUserEmailModelResponse> verifyDoctorEmail(
    @Field("email_verified_at") dynamic timestamp,
    @Path("doctorId") String doctorId,
  );

  @POST(ApiEndPoint.applyPatientsFilter)
  Future<ApplyPatientFiltersModelResponse> applyPatientFilters(
    @Body() Map<String, dynamic> map,
    @Query("page") int page,
  );

  @GET(ApiEndPoint.getAllFeeds)
  Future<GetPostsCommunityModelResponse> getAllFeeds(
    @Query('page') int pageNumber,
  );

  @POST('${ApiEndPoint.addLikeOnPost}/{postId}/likeOrUnlikePost')
  Future<AddLikeOnPostModelResponse> addLikeOrUnlikeOnPost(
    @Path("postId") String postId,
    @Field("status") String likeOrUnlike,
  );

  @POST('${ApiEndPoint.saveOrUnsavePost}/{postId}/saveOrUnsavePost')
  Future<SaveOrUnsavePostModelResponse> saveOrUnsavePost(
    @Path("postId") String postId,
    @Field("status") String saveOrUnsave,
  );
}
