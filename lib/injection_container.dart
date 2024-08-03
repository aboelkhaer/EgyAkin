import 'package:dio/dio.dart';
import 'package:egy_akin/features/change_password/data/datasources/change_password_datasource.dart';
import 'package:egy_akin/features/change_password/data/repositories/change_password_repo_impl.dart';
import 'package:egy_akin/features/change_password/domain/repositories/change_password_repo.dart';
import 'package:egy_akin/features/change_password/domain/usecases/change_password_usecase.dart';
import 'package:egy_akin/features/doctor_info_view/domain/usecases/get_score_history_usecase.dart';
import 'package:egy_akin/features/home/domain/usecases/upload_syndicate_card_usecase.dart';
import 'package:egy_akin/features/patient_sections/domain/usecases/download_patient_report_usecase.dart';
import 'package:egy_akin/features/profile_patients/data/datasources/profile_patients_datasource.dart';
import 'package:egy_akin/features/profile_patients/data/repositories/profile_patients_repo_impl.dart';
import 'package:egy_akin/features/profile_patients/domain/repositories/profile_patients_repo.dart';
import 'package:egy_akin/features/profile_patients/domain/usecases/get_profile_patients_usecase.dart';
import 'package:egy_akin/features/score_history/presentation/cubit/score_history_cubit.dart';
import 'package:egy_akin/features/send_consultation/data/datasources/send_consultation_datasource.dart';
import 'package:egy_akin/features/send_consultation/data/repositories/send_consultation_repo_impl.dart';
import 'package:egy_akin/features/send_consultation/domain/repositories/send_consultation_repo.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/get_consultation_search_usecase.dart';
import 'package:egy_akin/features/splash/data/datasources/splash_datasource.dart';
import 'package:egy_akin/features/splash/data/repositories/splash_repo_impl.dart';
import 'package:egy_akin/features/splash/domain/repositories/splash_repo.dart';
import 'package:egy_akin/features/splash/domain/usecases/get_app_settings_usecase.dart';
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
  sl.registerFactory(() => HomeCubit(sl(), sl()));
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
  sl.registerFactory(() => AllDoctorsPatientsCubit(sl()));
  sl.registerFactory(() => DoctorProfileViewCubit(sl()));
  sl.registerFactory(() => MoreCubit());
  sl.registerFactory(() => DoctorInfoViewCubit(sl()));
  sl.registerFactory(() => ContactUsCubit(sl()));
  sl.registerFactory(() => GfrCalculatorCubit());
  sl.registerFactory(() => ChangePasswordCubit(sl()));
  sl.registerFactory(() => ProfilePatientsCubit(sl()));
  sl.registerFactory(() => ScoreHistoryCubit(sl()));
  sl.registerFactory(() => AboutUsCubit());
  sl.registerFactory(() => SendConsultationCubit(sl()));

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
}
