import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/features/group_members/data/models/get_post_likes_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/get_post_by_id_model_response.dart';
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
    @Field("registration_number") String registrationNumber,
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

  @GET('${ApiEndPoint.getAIConsultationHistory}/{patientId}')
  Future<GetAiConsultationHistoryModelResponse> getAIConsultationHistory(
    @Path("patientId") String patientId,
    @Query("page") int page,
  );

  @POST('${ApiEndPoint.sendAIConsultationRequest}/{patientId}')
  Future<SendAIConsultationRequestModelResponse> sendAIConsultationRequest(
    @Path("patientId") String patientId,
  );

  @DELETE('${ApiEndPoint.deletePostInFeeds}/{postId}')
  Future<DeletePostModelResponse> deletePostInFeeds(
    @Path("postId") String postId,
  );

  @POST(ApiEndPoint.createPostInCommunity)
  @MultiPart()
  Future<CreatePostInCommunityModelResponse> createPostWithImageInCommunity(
    @Part(name: 'content') String? postContent,
    @Part(name: "media_type") String mediaType,
    @Part(name: "visibility") String visibility,
    @Part(name: "group_id") String? groupId,
    @Part(name: "media_path[]") List<MultipartFile> images,
  );

  @POST(ApiEndPoint.createPostInCommunity)
  Future<CreatePostInCommunityModelResponse> createPostWithTextInCommunity(
    @Field('content') String postContent,
    @Field("media_type") String? mediaType,
    @Field("visibility") String visibility,
    @Field("group_id") String? groupId,
    @Field("poll") Map<String, dynamic>? pollModel,
  );
  @GET('${ApiEndPoint.getCommentsInCommunity}/{postId}/comments')
  Future<GetCommentsInCommunityModelResponse> getCommentsInCommunity(
    @Path('postId') String postId,
    @Query('page') int pageNumber,
  );

  @POST(
      '${ApiEndPoint.addLikeAndUnlikeOnCommentInCommunity}/{commentId}/likeOrUnlikeComment')
  Future<AddLikeOrUnlikeOnCommentInCommunityModelResponse>
      addLikeAndUnlikeOnCommentInCommunity(
    @Path('commentId') String commentId,
    @Field('status') String status,
  );

  @POST('${ApiEndPoint.createCommentOnPostInCommunity}/{postId}/comment')
  Future<CreateCommentOnPostInCommunityModelResponse>
      createCommentOnPostInCommunity(
    @Path('postId') String postId,
    @Field('comment') String comment,
    @Field('parent_id') int? parentId,
  );

  @DELETE('${ApiEndPoint.deleteCommentOnPostInCommunity}/{commentId}')
  Future<DeleteCommentOnPostInCommunityModelResponse>
      deleteCommentOnPostInCommunity(
    @Path('commentId') String commentId,
  );

  @POST('${ApiEndPoint.editPostInCommunity}/{postId}')
  Future<EditPostInCommunityModelResponse> editPostWithTextInCommunity(
    @Path('postId') String postId,
    @Field('content') String postContent,
    @Field("media_type") String? mediaType,
    @Field("visibility") String visibility,
    @Field("group_id") String? groupId,
    @Field("poll") Map<String, dynamic>? pollModel,
  );

  @POST('${ApiEndPoint.editPostInCommunity}/{postId}')
  @MultiPart()
  Future<EditPostInCommunityModelResponse> editPostWithImageInCommunity(
    @Path('postId') String postId,
    @Part(name: 'content') String? postContent,
    @Part(name: "media_type") String mediaType,
    @Part(name: "visibility") String visibility,
    @Part(name: "group_id") String? groupId,
    @Part(name: "media_path[]") List<MultipartFile> images,
    @Part(name: "existing_media_path[]") List<String> existingMediaPath,
  );

  // @POST('${ApiEndPoint.editPostInCommunity}/{postId}')
  // Future<EditPostInCommunityModelResponse> editPostWithImageLinksInCommunity(
  //   @Path('postId') String postId,
  //   @Field('content') String postContent,
  //   @Field("media_type") String? mediaType,
  //   @Field("visibility") String visibility,
  //   @Field("group_id") String? groupId,
  //   @Field("existing_media_path") String existingMediaPath,
  // );

  @POST('${ApiEndPoint.createReplyOnCommentInCommunity}/{postId}/comment')
  Future<CreateReplyOnCommentInCommunityModelResponse>
      createReplyOnCommentInCommunity(
    @Path('postId') String postId,
    @Field('comment') String comment,
    @Field('parent_id') int? parentId,
  );

  @GET('${ApiEndPoint.getGroupDetailsInCommunity}/{groupId}/detailsWithPosts')
  Future<GetGroupDetailsInCommunityModelResponse> getGroupDetailsInCommunity(
    @Path('groupId') String groupId,
    @Query('page') int pageNumber,
  );

  @GET(ApiEndPoint.getGroupsTab)
  Future<GetGroupsTabModelResponse> getGroupsTab(
    @Query('page') int pageNumber,
  );

  @POST('${ApiEndPoint.joinGroupInCommunity}/{groupId}/join')
  Future<JoinGroupModelResponse> joinGroupInCommunity(
    @Path('groupId') String groupId,
  );
  @POST('${ApiEndPoint.leaveGroupInCommunity}/{groupId}/leave')
  Future<LeaveGroupModelResponse> leaveGroupInCommunity(
    @Path('groupId') String groupId,
  );

  @GET('${ApiEndPoint.getGroupMembers}/{groupId}/members')
  Future<GetGroupMembersModelResponse> getGroupMembers(
    @Query('page') int pageNumber,
    @Path('groupId') String groupId,
  );
  @GET('${ApiEndPoint.getPostLikes}/{postId}/likes')
  Future<GetPostLikesModelResponse> getPostLikes(
    @Query('page') int pageNumber,
    @Path('postId') String postId,
  );
  @GET(ApiEndPoint.getMyGroups)
  Future<GetAllGroupsInCommunityModelResponse> getMyGroup(
    @Query('page') int pageNumber,
  );

  @POST('${ApiEndPoint.sendGroupInvitation}/{groupId}/invite')
  Future<SendInvitationModelResponse> sendGroupInvitation(
    @Path('groupId') String groupId,
    @Field("message") String message,
    @Field("doctor_ids") List<String> doctorsIDS,
  );

  @POST('${ApiEndPoint.removeMemberFromGroup}/{groupId}/removeMember')
  Future<RemoveMemberFromGroupModelResponse> removeMemberFromGroup(
    @Path('groupId') String groupId,
    @Field("doctor_id") String doctorId,
  );

  @GET(ApiEndPoint.getAllGroups)
  Future<GetAllGroupsInCommunityModelResponse> getAllGroups(
    @Query('page') int pageNumber,
  );

  @POST(ApiEndPoint.createGroupInCommunity)
  @MultiPart()
  Future<CreateGroupInCommunityModelResponse> createGroupInCommunity(
    @Part(name: "name") String name,
    @Part(name: "header_picture") File headerImage,
    @Part(name: "group_image") File groupImage,
    @Part(name: "description") String description,
    @Part(name: "privacy") String privacy,
  );

  @DELETE('${ApiEndPoint.getAllGroups}/{groupId}')
  Future<DeleteGroupInCommunityModelResponse> deleteGroupInCommunity(
    @Path('groupId') String groupId,
  );

  @GET(ApiEndPoint.getTrendingPostsInCommunity)
  Future<GetTrendingTabInCommunityModelResponse> getTrendingPostsInCommunity(
    @Query('page') int page,
  );

  @POST(ApiEndPoint.getCommunitySearchResponse)
  Future<GetResponseOfSearchModel> getCommunitySearchResponse(
    @Query('page') int page,
    @Field("query") String searchContent,
  );

  @GET('${ApiEndPoint.getAllDoctorPosts}/{doctorId}')
  Future<GetAllDoctorPostsModelResponse> getAllDoctorPosts(
    @Path('doctorId') String doctorId,
    @Query('page') int pageNumber,
  );

  @GET('${ApiEndPoint.getSavedPosts}/{doctorId}')
  Future<GetSavedPostsModelResponse> getSavedPosts(
    @Path('doctorId') String doctorId,
    @Query('page') int pageNumber,
  );
  @POST('${ApiEndPoint.addVoteForPollInPosts}/{pollId}/vote')
  Future<AddVoteAndUnvoteModelResponse> addVoteForPollInPosts(
    @Path('pollId') String pollId,
    @Field("option_id") int optionId,
  );

  @POST('${ApiEndPoint.addOptionOnPoll}/{pollId}/options')
  Future<AddOptionInPollModelResponse> addOptionOnPoll(
    @Path('pollId') String pollId,
    @Field("option_text") String option,
  );

  @POST('${ApiEndPoint.updateGroupInCommunity}/{groupId}')
  Future<UpdateGroupInCommunityModelResponse> updateGroupTextsInCommunity(
    @Path('groupId') String groupId,
    @Field("name") String name,
    @Field("description") String description,
    @Field("privacy") String privacy,
  );
  @POST('${ApiEndPoint.updateGroupInCommunity}/{groupId}')
  @MultiPart()
  Future<UpdateGroupInCommunityModelResponse> updateGroupHeaderImageInCommunity(
    @Path('groupId') String groupId,
    @Part(name: "name") String name,
    @Part(name: "header_picture") File headerImage,
    @Part(name: "description") String description,
    @Part(name: "privacy") String privacy,
  );
  @POST('${ApiEndPoint.updateGroupInCommunity}/{groupId}')
  @MultiPart()
  Future<UpdateGroupInCommunityModelResponse> updateGroupImageInCommunity(
    @Path('groupId') String groupId,
    @Part(name: "name") String name,
    @Part(name: "group_image") File groupImage,
    @Part(name: "description") String description,
    @Part(name: "privacy") String privacy,
  );

  @GET('${ApiEndPoint.getPollVoters}/{pollId}/options/{optionId}/voters')
  Future<GetPollVotersModelResponse> getPollVoters(
    @Path('pollId') String pollId,
    @Path('optionId') String optionId,
    @Query('page') int page,
  );

  @GET('${ApiEndPoint.getDoctorInvitationsForGroups}/{doctorId}')
  Future<GetDoctorInvitationForGroupsModelResponse>
      getDoctorInvitationsForGroups(
    @Path('doctorId') String doctorId,
    @Query('page') int page,
  );

  @POST('${ApiEndPoint.acceptOrDeclineMemberInGroup}/{groupId}/invitation')
  Future<AcceptOrDeclineMemberModelResponse> acceptOrDeclineMemberInGroup(
    @Path('groupId') String groupId,
    @Field('status') String status,
    @Field('invitation_id') int invitationId,
  );

  @GET('${ApiEndPoint.getPostById}/{postId}')
  Future<GetPostByIdModelResponse> getPostById(
    @Path('postId') String postId,
  );
}
