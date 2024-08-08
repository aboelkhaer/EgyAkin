import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';
import 'package:egy_akin/features/authentication/data/models/send_fcm_token_model_response.dart';
import 'package:egy_akin/features/change_password/data/models/change_password_model_response.dart';
import 'package:egy_akin/features/contact_us/data/models/contact_us_model_response.dart';
import 'package:egy_akin/features/current_doctor_patients/data/models/get_current_doctor_patients_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/get_doctor_profile_score_history_model_response.dart';
import 'package:egy_akin/features/doctor_profile_view/data/models/update_doctor_profile_model_response.dart';
import 'package:egy_akin/features/home/data/models/upload_syndicate_card_model_response.dart';
import 'package:egy_akin/features/outcome/data/models/sumbit_outcome_model_response.dart';
import 'package:egy_akin/features/patient_comments/data/models/add_patient_comment_model_response.dart';
import 'package:egy_akin/features/patient_comments/data/models/delete_patient_comment_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_patient_section_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_section_details_model_response.dart';
import 'package:egy_akin/features/patient_sections/data/models/delete_patient_model_response.dart';
import 'package:egy_akin/features/patient_sections/data/models/download_patient_report_model_response.dart';
import 'package:egy_akin/features/patient_sections/data/models/final_submit_model_response.dart';
import 'package:egy_akin/features/post_details/data/models/delete_post_comment_model_response.dart';
import 'package:egy_akin/features/profile_patients/data/models/get_profile_patients_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/send_consultation_model_response.dart';
import 'package:egy_akin/features/splash/data/models/get_app_settings_model_response.dart';

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
  Future<GetCurrentDoctorConsultationModelResponse>
      getCurrentDoctorConsultation();
}
