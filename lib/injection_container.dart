import 'package:dio/dio.dart';
import 'package:egy_akin/features/all_doctor_posts/data/datasources/all_doctor_posts_datasource.dart';
import 'package:egy_akin/features/all_doctor_posts/data/repositories/all_doctor_posts_repo_impl.dart';
import 'package:egy_akin/features/all_doctor_posts/domain/repositories/all_doctor_posts_repo.dart';
import 'package:egy_akin/features/all_doctor_posts/domain/usecases/get_all_doctor_posts_usecase.dart';
import 'package:egy_akin/features/all_doctor_posts/presentation/cubit/all_doctor_posts_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/data/datasources/all_groups_in_community_datasource.dart';
import 'package:egy_akin/features/all_groups_in_community/data/repositories/all_groups_in_community_repo_impl.dart';
import 'package:egy_akin/features/all_groups_in_community/domain/repositories/all_groups_in_community_repo.dart';
import 'package:egy_akin/features/all_groups_in_community/domain/usecases/get_all_groups_usecase.dart';
import 'package:egy_akin/features/all_groups_in_community/domain/usecases/get_my_groups_usecase.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/cubit/my_groups_in_community_cubit.dart';
import 'package:egy_akin/features/community/domain/usecases/add_option_on_poll_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/add_vote_and_unvote_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/get_groups_tab_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/get_trending_posts_in_community_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/join_group_in_community_usecase.dart';
import 'package:egy_akin/features/community/presentation/cubit/groups_cubit/groups_cubit.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_cubit.dart';
import 'package:egy_akin/features/community_search/data/datasources/community_search_datasource.dart';
import 'package:egy_akin/features/community_search/data/repositories/community_search_repo_impl.dart';
import 'package:egy_akin/features/community_search/domain/repositories/community_search_repo.dart';
import 'package:egy_akin/features/community_search/domain/usecases/get_response_of_search_in_community_usecase.dart';
import 'package:egy_akin/features/community_search/presentation/cubit/community_search_cubit.dart';
import 'package:egy_akin/features/create_group_in_community/data/datasources/create_group_in_community_datasource.dart';
import 'package:egy_akin/features/create_group_in_community/data/repositories/create_group_in_community_repo_impl.dart';
import 'package:egy_akin/features/create_group_in_community/domain/repositories/create_group_in_community_repo.dart';
import 'package:egy_akin/features/create_group_in_community/domain/usecases/create_group_in_community_usecase.dart';
import 'package:egy_akin/features/create_group_in_community/domain/usecases/update_group_header_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_group_in_community/domain/usecases/update_group_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_group_in_community/domain/usecases/update_group_texts_in_community_usecase.dart';
import 'package:egy_akin/features/create_group_in_community/presentation/cubit/create_group_in_community_cubit.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/edit_post_with_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/edit_post_with_text_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/data/datasources/group_details_in_community_datasource.dart';
import 'package:egy_akin/features/group_details_in_community/data/repositories/group_details_in_community_repo_impl.dart';
import 'package:egy_akin/features/group_details_in_community/domain/repositories/group_details_in_community_repo.dart';
import 'package:egy_akin/features/group_details_in_community/domain/usecases/delete_group_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/domain/usecases/get_group_details_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/domain/usecases/leave_group_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/presentation/cubit/group_details_in_community_cubit.dart';
import 'package:egy_akin/features/group_members/data/datasources/group_members_datasource.dart';
import 'package:egy_akin/features/group_members/data/repositories/group_members_repo_impl.dart';
import 'package:egy_akin/features/group_members/domain/repositories/group_members_repo.dart';
import 'package:egy_akin/features/group_members/domain/usecases/get_group_members_usecase.dart';
import 'package:egy_akin/features/group_members/domain/usecases/get_post_likes_usecase.dart';
import 'package:egy_akin/features/group_members/domain/usecases/remove_member_from_group_usecase.dart';
import 'package:egy_akin/features/group_members/presentation/cubit/group_members_cubit.dart';
import 'package:egy_akin/features/invite_member_to_group_in_community/presentation/cubit/invite_member_to_group_in_community_cubit.dart';
import 'package:egy_akin/features/saved_posts/data/datasources/saved_posts_datasource.dart';
import 'package:egy_akin/features/saved_posts/data/repositories/saved_posts_repo_impl.dart';
import 'package:egy_akin/features/saved_posts/domain/repositories/saved_posts_repo.dart';
import 'package:egy_akin/features/saved_posts/domain/usecases/get_saved_posts_usecase.dart';
import 'package:egy_akin/features/saved_posts/presentation/cubit/saved_posts_cubit.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/send_group_invitation_usecase.dart';
import 'package:egy_akin/features/show_single_feed/domain/usecases/create_reply_on_comment_in_community_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'exports.dart';

GetIt sl = GetIt.instance;

Future<void> diInit() async {
  //! Core
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));
  sl.registerLazySingleton<DioFactory>(() => DioFactory(appPreferences: sl()));
  Dio dio = await sl<DioFactory>().getDio();
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton<ApiServices>(() => ApiServices(dio));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<NotificationServices>(() => NotificationServices());

  //! Cubit
  sl.registerFactory(() => AuthenticationCubit(sl(), sl()));
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerFactory(() => WelcomeCubit());
  sl.registerFactory(() => OnboardingCubit());
  sl.registerFactory(() => ResetPasswordCubit(sl(), sl(), sl()));
  // sl.registerFactory(() => HomeCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => HomeCubit(sl(), sl(), sl()));

  sl.registerFactory(() => EmailVerificationCubit(sl(), sl()));
  sl.registerFactory(() => NotificationCubit(sl(), sl()));
  sl.registerFactory(() => ProfileCubit(sl(), sl()));
  sl.registerFactory(() => PostDetailsCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AddPatientCubit(sl(), sl()));
  sl.registerFactory(() => PatientSectionsCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => PatientCommentsCubit(sl(), sl(), sl()));
  sl.registerFactory(() => SearchCubit(sl()));
  sl.registerFactory(() => OutcomeCubit(sl(), sl()));
  sl.registerFactory(() => CurrentDoctorPatientsCubit(sl()));
  sl.registerFactory(() => PatientSectionDetailsCubit(sl(), sl()));
  sl.registerFactory(() => AllDoctorsPatientsCubit(sl(), sl()));
  sl.registerFactory(() => DoctorProfileViewCubit(sl()));
  sl.registerFactory(() => MoreCubit());
  sl.registerFactory(
      () => DoctorInfoViewCubit(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ContactUsCubit(sl()));
  sl.registerFactory(() => GfrCalculatorCubit());
  sl.registerFactory(() => ChangePasswordCubit(sl()));
  sl.registerFactory(() => ProfilePatientsCubit(sl()));
  sl.registerFactory(() => ScoreHistoryCubit(sl()));
  sl.registerFactory(() => AboutUsCubit());
  sl.registerFactory(() => SendConsultationCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ConsultationCubit(sl(), sl()));
  sl.registerFactory(() => ConsultationDetailsCubit(sl(), sl()));
  sl.registerLazySingleton(
      () => CommunityCubit(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(
      () => ShowSingleFeedCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ConsultationFromAICubit(sl(), sl()));
  sl.registerFactory(() => CreatePostInCommunityCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(
      () => GroupsCubit(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() =>
      GroupDetailsInCommunityCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => GroupMembersCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AllGroupsInCommunityCubit(sl(), sl()));
  sl.registerFactory(() => MyGroupsInCommunityCubit(sl(), sl()));
  sl.registerFactory(() => InviteMemberToGroupInCommunityCubit());
  sl.registerFactory(() => CreateGroupInCommunityCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => TrendingCubit(sl()));
  sl.registerFactory(() => CommunitySearchCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SavedPostsCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => AllDoctorPostsCubit(sl(), sl(), sl(), sl(), sl()));

  //! REMOTE DATASOURCE
  sl.registerLazySingleton<AuthenticationDataSource>(
      () => AuthenticationDataSourceImpl(sl()));
  sl.registerLazySingleton<ResetPasswordDataSource>(
      () => ResetPasswordDataSourceImpl(sl()));
  sl.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl(sl()));
  sl.registerLazySingleton<NotificationsDataSource>(
      () => NotificationsDataSourceImpl(sl()));
  sl.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(sl()));
  sl.registerLazySingleton<PostDetailsDataSource>(
      () => PostDetailsDataSourceImpl(sl()));
  sl.registerLazySingleton<EmailVerificationDataSource>(
      () => EmailVerificationDataSourceImpl(sl()));
  sl.registerLazySingleton<AddPatientDataSource>(
      () => AddPatientDataSourceImpl(sl()));
  sl.registerLazySingleton<PatientSectionsDataSource>(
      () => PatientSectionsDataSourceImpl(sl()));
  sl.registerLazySingleton<PatientCommentsDataSource>(
      () => PatientCommentsDataSourceImpl(sl()));
  sl.registerLazySingleton<SearchDataSource>(() => SearchDataSourceImpl(sl()));
  sl.registerLazySingleton<OutcomeDataSource>(
      () => OutcomeDataSourceImpl(sl()));
  sl.registerLazySingleton<CurrentDoctorPatientsDataSource>(
      () => CurrentDoctorPatientsDataSourceImpl(sl()));
  sl.registerLazySingleton<AllDoctorsPatientsDataSource>(
      () => AllDoctorsPatientsDataSourceImpl(sl()));
  sl.registerLazySingleton<PatientSectionDetailsDataSource>(
      () => PatientSectionDetailsDataSourceImpl(sl()));
  sl.registerLazySingleton<DoctorProfileViewDataSource>(
      () => DoctorProfileViewDataSourceImpl(sl()));
  sl.registerLazySingleton<DoctorInfoViewDataSource>(
      () => DoctorInfoViewDataSourceImpl(sl()));
  sl.registerLazySingleton<ContactUsDataSource>(
      () => ContactUsDataSourceImpl(sl()));
  sl.registerLazySingleton<SplashDataSource>(() => SplashDataSourceImpl(sl()));
  sl.registerLazySingleton<ChangePasswordDataSource>(
      () => ChangePasswordDataSourceImpl(sl()));
  sl.registerLazySingleton<ProfilePatientsDataSource>(
      () => ProfilePatientsDataSourceImpl(sl()));
  sl.registerLazySingleton<SendConsultationDataSource>(
      () => SendConsultationDataSourceImpl(sl()));

  sl.registerLazySingleton<ConsultationDataSource>(
      () => ConsultationDataSourceImpl(sl()));
  sl.registerLazySingleton<ConsultationDetailsDataSource>(
      () => ConsultationDetailsDataSourceImpl(sl()));
  sl.registerLazySingleton<CommunityDatasource>(
      () => CommunityDatasourceImpl(sl()));
  sl.registerLazySingleton<ConsultationFromAIDatasource>(
      () => ConsultationFromAIDatasourceImpl(sl()));
  sl.registerLazySingleton<CreatePostInCommunityDatasource>(
      () => CreatePostInCommunityDatasourceImpl(sl()));
  sl.registerLazySingleton<ShowSingleFeedDatasource>(
      () => ShowSingleFeedDatasourceImpl(sl()));
  sl.registerLazySingleton<GroupDetailsInCommunityDatasource>(
      () => GroupDetailsInCommunityDatasourceImpl(sl()));
  sl.registerLazySingleton<GroupMembersDatasource>(
      () => GroupMembersDatasourceImpl(sl()));
  sl.registerLazySingleton<AllGroupsInCommunityDatasource>(
      () => AllGroupsInCommunityDatasourceImpl(sl()));
  sl.registerLazySingleton<CreateGroupInCommunityDatasource>(
      () => CreateGroupInCommunityDatasourceImpl(sl()));
  sl.registerLazySingleton<CommunitySearchDatasource>(
      () => CommunitySearchDatasourceImpl(sl()));
  sl.registerLazySingleton<SavedPostsDataSource>(
      () => SavedPostsDataSourceImpl(sl()));
  sl.registerLazySingleton<AllDoctorPostsDatasource>(
      () => AllDoctorPostsDatasourceImpl(sl()));

  //! Repository
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ResetPasswordRepository>(
      () => ResetPasswordRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<PostDetailsRepository>(
      () => PostDetailsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<EmailVerificationRepository>(
      () => EmailVerificationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AddPatientRepository>(
      () => AddPatientRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<PatientSectionsRepository>(
      () => PatientSectionsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<PatientCommentsRepository>(
      () => PatientCommentsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<OutcomeRepository>(
      () => OutcomeRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CurrentDoctorPatientsRepository>(
      () => CurrentDoctorPatientsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AllDoctorsPatientsRepository>(
      () => AllDoctorsPatientsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<PatientSectionDetailsRepository>(
      () => PatientSectionDetailsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<DoctorProfileViewRepository>(
      () => DoctorProfileViewRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<DoctorInfoViewRepository>(
      () => DoctorInfoViewRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ContactUsRepository>(
      () => ContactUsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ProfilePatientsRepository>(
      () => ProfilePatientsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SendConsultationRepository>(
      () => SendConsultationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ConsultationRepository>(
      () => ConsultationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ConsultationDetailsRepository>(
      () => ConsultationDetailsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CommunityRepository>(
      () => CommunityRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ConsultationFromAIRepository>(
      () => ConsultationFromAIRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CreatePostInCommunityRepository>(
      () => CreatePostInCommunityRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ShowSingleFeedRepository>(
      () => ShowSingleFeedRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<GroupDetailsInCommunityRepository>(
      () => GroupDetailsInCommunityRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<GroupMembersRepository>(
      () => GroupMembersRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AllGroupsInCommunityRepository>(
      () => AllGroupsInCommunityRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CreateGroupInCommunityRepository>(
      () => CreateGroupInCommunityRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CommunitySearchRepository>(
      () => CommunitySearchRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SavedPostsRepository>(
      () => SavedPostsRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AllDoctorPostsRepository>(
      () => AllDoctorPostsRepositoryImpl(sl(), sl()));

  //! USECASES
  if (!GetIt.I.isRegistered<SignInUsecase>()) {
    sl.registerFactory<SignInUsecase>(() => SignInUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    sl.registerFactory<RegisterUsecase>(() => RegisterUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SendEmailForResetPasswordUsecase>()) {
    sl.registerFactory<SendEmailForResetPasswordUsecase>(
        () => SendEmailForResetPasswordUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<VerifyOTPForResetPasswordUsecase>()) {
    sl.registerFactory<VerifyOTPForResetPasswordUsecase>(
        () => VerifyOTPForResetPasswordUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<ChangePasswordForResetPasswordUsecase>()) {
    sl.registerFactory<ChangePasswordForResetPasswordUsecase>(
        () => ChangePasswordForResetPasswordUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetHomeUsecase>()) {
    sl.registerFactory<GetHomeUsecase>(() => GetHomeUsecase(sl()));
  }

  if (!GetIt.I.isRegistered<UpdateNotificationUsecase>()) {
    sl.registerFactory<UpdateNotificationUsecase>(
        () => UpdateNotificationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAllNotificationUsecase>()) {
    sl.registerFactory<GetAllNotificationUsecase>(
        () => GetAllNotificationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<UploadProfileImageUsecase>()) {
    sl.registerFactory<UploadProfileImageUsecase>(
        () => UploadProfileImageUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SignOutUsecase>()) {
    sl.registerFactory<SignOutUsecase>(() => SignOutUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetPostCommentsUsecase>()) {
    sl.registerFactory<GetPostCommentsUsecase>(
        () => GetPostCommentsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<DeletePostCommentUsecase>()) {
    sl.registerFactory<DeletePostCommentUsecase>(
        () => DeletePostCommentUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddCommentOnPostUsecase>()) {
    sl.registerFactory<AddCommentOnPostUsecase>(
        () => AddCommentOnPostUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SendEmailForVerificationUsecase>()) {
    sl.registerFactory<SendEmailForVerificationUsecase>(
        () => SendEmailForVerificationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SendOTPForEmailVerificationUsecase>()) {
    sl.registerFactory<SendOTPForEmailVerificationUsecase>(
        () => SendOTPForEmailVerificationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetPatientHistoryForAddPatientUsecase>()) {
    sl.registerFactory<GetPatientHistoryForAddPatientUsecase>(
        () => GetPatientHistoryForAddPatientUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddPatientForFirstTimetUsecase>()) {
    sl.registerFactory<AddPatientForFirstTimetUsecase>(
        () => AddPatientForFirstTimetUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetPatientSectionsUsecase>()) {
    sl.registerFactory<GetPatientSectionsUsecase>(
        () => GetPatientSectionsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetPatientCommentsUsecase>()) {
    sl.registerFactory<GetPatientCommentsUsecase>(
        () => GetPatientCommentsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddPatientCommentsUsecase>()) {
    sl.registerFactory<AddPatientCommentsUsecase>(
        () => AddPatientCommentsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<DeletePatientCommentsUsecase>()) {
    sl.registerFactory<DeletePatientCommentsUsecase>(
        () => DeletePatientCommentsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetSearchHomeUsecase>()) {
    sl.registerFactory<GetSearchHomeUsecase>(() => GetSearchHomeUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<DeletePatientUsecase>()) {
    sl.registerFactory<DeletePatientUsecase>(() => DeletePatientUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<FinalSubmitUsecase>()) {
    sl.registerFactory<FinalSubmitUsecase>(() => FinalSubmitUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetOutcomeUsecase>()) {
    sl.registerFactory<GetOutcomeUsecase>(() => GetOutcomeUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SubmitOutcomeUsecase>()) {
    sl.registerFactory<SubmitOutcomeUsecase>(() => SubmitOutcomeUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetCurrentDoctorPatientsUsecase>()) {
    sl.registerFactory<GetCurrentDoctorPatientsUsecase>(
        () => GetCurrentDoctorPatientsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAllDoctorsPatientsUsecase>()) {
    sl.registerFactory<GetAllDoctorsPatientsUsecase>(
        () => GetAllDoctorsPatientsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetPatientSectionDetailsUsecase>()) {
    sl.registerFactory<GetPatientSectionDetailsUsecase>(
        () => GetPatientSectionDetailsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<UpdatePatientSectionDetailsUsecase>()) {
    sl.registerFactory<UpdatePatientSectionDetailsUsecase>(
        () => UpdatePatientSectionDetailsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<UpdateDoctorProfileUsecase>()) {
    sl.registerFactory<UpdateDoctorProfileUsecase>(
        () => UpdateDoctorProfileUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetDoctorInfoViewUsecase>()) {
    sl.registerFactory<GetDoctorInfoViewUsecase>(
        () => GetDoctorInfoViewUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddContactUsUsecase>()) {
    sl.registerFactory<AddContactUsUsecase>(() => AddContactUsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<DownloadPatientReportUsecase>()) {
    sl.registerFactory<DownloadPatientReportUsecase>(
        () => DownloadPatientReportUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAppSettingsUsecase>()) {
    sl.registerFactory<GetAppSettingsUsecase>(
        () => GetAppSettingsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<UploadSyndicateCardUsecase>()) {
    sl.registerFactory<UploadSyndicateCardUsecase>(
        () => UploadSyndicateCardUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<ChangePasswordUsecase>()) {
    sl.registerFactory<ChangePasswordUsecase>(
        () => ChangePasswordUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetProfilePatientsUsecase>()) {
    sl.registerFactory<GetProfilePatientsUsecase>(
        () => GetProfilePatientsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetScoreHistoryUsecase>()) {
    sl.registerFactory<GetScoreHistoryUsecase>(
        () => GetScoreHistoryUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetConsultationSearchUsecase>()) {
    sl.registerFactory<GetConsultationSearchUsecase>(
        () => GetConsultationSearchUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SendConsultationUsecase>()) {
    sl.registerFactory<SendConsultationUsecase>(
        () => SendConsultationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SendConsultationUsecase>()) {
    sl.registerFactory<SendConsultationUsecase>(
        () => SendConsultationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetCurrentDoctorConsultationUsecase>()) {
    sl.registerFactory<GetCurrentDoctorConsultationUsecase>(
        () => GetCurrentDoctorConsultationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetReceivedConsultationUsecase>()) {
    sl.registerFactory<GetReceivedConsultationUsecase>(
        () => GetReceivedConsultationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetConsultationDetailsUsecase>()) {
    sl.registerFactory<GetConsultationDetailsUsecase>(
        () => GetConsultationDetailsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddConsultationReplyUsecase>()) {
    sl.registerFactory<AddConsultationReplyUsecase>(
        () => AddConsultationReplyUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAchievementsUsecase>()) {
    sl.registerFactory<GetAchievementsUsecase>(
        () => GetAchievementsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<ChangeSyndicateCardStatusUsecase>()) {
    sl.registerFactory<ChangeSyndicateCardStatusUsecase>(
        () => ChangeSyndicateCardStatusUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<BlockUserUsecase>()) {
    sl.registerFactory<BlockUserUsecase>(() => BlockUserUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<VerifyUserEmailUsecase>()) {
    sl.registerFactory<VerifyUserEmailUsecase>(
        () => VerifyUserEmailUsecase(sl()));
  }

  if (!GetIt.I.isRegistered<ApplyPatientsFiltersUsecase>()) {
    sl.registerFactory<ApplyPatientsFiltersUsecase>(
        () => ApplyPatientsFiltersUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAllFeedsUsecase>()) {
    sl.registerFactory<GetAllFeedsUsecase>(() => GetAllFeedsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddLikeOnPostUsecase>()) {
    sl.registerFactory<AddLikeOnPostUsecase>(() => AddLikeOnPostUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SaveOrUnsavePostUsecase>()) {
    sl.registerFactory<SaveOrUnsavePostUsecase>(
        () => SaveOrUnsavePostUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAiConsultationHistoryUsecase>()) {
    sl.registerFactory<GetAiConsultationHistoryUsecase>(
        () => GetAiConsultationHistoryUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SendAiConsultationRequestUsecase>()) {
    sl.registerFactory<SendAiConsultationRequestUsecase>(
        () => SendAiConsultationRequestUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<DeletePostInFeedsUsecase>()) {
    sl.registerFactory<DeletePostInFeedsUsecase>(
        () => DeletePostInFeedsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<CreatePostWithImageInCommunityUsecase>()) {
    sl.registerFactory<CreatePostWithImageInCommunityUsecase>(
        () => CreatePostWithImageInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<CreatePostWithTextInCommunityUsecase>()) {
    sl.registerFactory<CreatePostWithTextInCommunityUsecase>(
        () => CreatePostWithTextInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetCommentsInCommunityUsecase>()) {
    sl.registerFactory<GetCommentsInCommunityUsecase>(
        () => GetCommentsInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddLikeOrUnlikeOnCommentInCommunityUsecase>()) {
    sl.registerFactory<AddLikeOrUnlikeOnCommentInCommunityUsecase>(
        () => AddLikeOrUnlikeOnCommentInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<CreateCommentOnPostInCommunityUsecase>()) {
    sl.registerFactory<CreateCommentOnPostInCommunityUsecase>(
        () => CreateCommentOnPostInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<DeleteCommentOnPostInCommunityUsecase>()) {
    sl.registerFactory<DeleteCommentOnPostInCommunityUsecase>(
        () => DeleteCommentOnPostInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<EditPostWithImageInCommunityUsecase>()) {
    sl.registerFactory<EditPostWithImageInCommunityUsecase>(
        () => EditPostWithImageInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<EditPostWithTextInCommunityUsecase>()) {
    sl.registerFactory<EditPostWithTextInCommunityUsecase>(
        () => EditPostWithTextInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<CreateReplyOnCommentInCommunityUsecase>()) {
    sl.registerFactory<CreateReplyOnCommentInCommunityUsecase>(
        () => CreateReplyOnCommentInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetGroupDetailsInCommunityUsecase>()) {
    sl.registerFactory<GetGroupDetailsInCommunityUsecase>(
        () => GetGroupDetailsInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetGroupsTabUsecase>()) {
    sl.registerFactory<GetGroupsTabUsecase>(() => GetGroupsTabUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<JoinGroupInCommunityUsecase>()) {
    sl.registerFactory<JoinGroupInCommunityUsecase>(
        () => JoinGroupInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<LeaveGroupInCommunityUsecase>()) {
    sl.registerFactory<LeaveGroupInCommunityUsecase>(
        () => LeaveGroupInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetGroupMembersUsecase>()) {
    sl.registerFactory<GetGroupMembersUsecase>(
        () => GetGroupMembersUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetPostLikesUsecase>()) {
    sl.registerFactory<GetPostLikesUsecase>(() => GetPostLikesUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetMyGroupsUsecase>()) {
    sl.registerFactory<GetMyGroupsUsecase>(() => GetMyGroupsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<SendGroupInvitationUsecase>()) {
    sl.registerFactory<SendGroupInvitationUsecase>(
        () => SendGroupInvitationUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<RemoveMemberFromGroupUsecase>()) {
    sl.registerFactory<RemoveMemberFromGroupUsecase>(
        () => RemoveMemberFromGroupUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAllGroupsUsecase>()) {
    sl.registerFactory<GetAllGroupsUsecase>(() => GetAllGroupsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<CreateGroupInCommunityUsecase>()) {
    sl.registerFactory<CreateGroupInCommunityUsecase>(
        () => CreateGroupInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<DeleteGroupInCommunityUsecase>()) {
    sl.registerFactory<DeleteGroupInCommunityUsecase>(
        () => DeleteGroupInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetTrendingPostsInCommunityUsecase>()) {
    sl.registerFactory<GetTrendingPostsInCommunityUsecase>(
        () => GetTrendingPostsInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetResponseOfSearchInCommunityUsecase>()) {
    sl.registerFactory<GetResponseOfSearchInCommunityUsecase>(
        () => GetResponseOfSearchInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetAllDoctorPostsUsecase>()) {
    sl.registerFactory<GetAllDoctorPostsUsecase>(
        () => GetAllDoctorPostsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<GetSavedPostsUsecase>()) {
    sl.registerFactory<GetSavedPostsUsecase>(() => GetSavedPostsUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddVoteAndUnvoteUsecase>()) {
    sl.registerFactory<AddVoteAndUnvoteUsecase>(
        () => AddVoteAndUnvoteUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<AddOptionOnPollUsecase>()) {
    sl.registerFactory<AddOptionOnPollUsecase>(
        () => AddOptionOnPollUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<UpdateGroupTextsInCommunityUsecase>()) {
    sl.registerFactory<UpdateGroupTextsInCommunityUsecase>(
        () => UpdateGroupTextsInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<UpdateGroupHeaderImageInCommunityUsecase>()) {
    sl.registerFactory<UpdateGroupHeaderImageInCommunityUsecase>(
        () => UpdateGroupHeaderImageInCommunityUsecase(sl()));
  }
  if (!GetIt.I.isRegistered<UpdateGroupImageInCommunityUsecase>()) {
    sl.registerFactory<UpdateGroupImageInCommunityUsecase>(
        () => UpdateGroupImageInCommunityUsecase(sl()));
  }
}
