import 'package:dio/dio.dart';
import 'package:egy_akin/features/add_patient/data/datasources/add_patient_datasource.dart';
import 'package:egy_akin/features/add_patient/data/repositories/add_patient_repo_impl.dart';
import 'package:egy_akin/features/add_patient/domain/repositories/add_patient_repo.dart';
import 'package:egy_akin/features/add_patient/domain/usecases/get_patient_history_for_add_patient_usecase.dart';
import 'package:egy_akin/features/add_patient/presentation/cubit/add_patient_cubit.dart';
import 'package:egy_akin/features/email_verification/domain/usecases/send_otp_for_email_verification_usecase.dart';
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
  sl.registerLazySingleton<ApiServices>(() => ApiServices(dio));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! Cubit
  sl.registerFactory(() => AuthenticationCubit(sl(), sl()));
  sl.registerFactory(() => SplashCubit());
  sl.registerFactory(() => WelcomeCubit());
  sl.registerFactory(() => OnboardingCubit());
  sl.registerFactory(() => ResetPasswordCubit(sl(), sl(), sl()));
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => EmailVerificationCubit(sl(), sl()));
  sl.registerFactory(() => NotificationCubit(sl(), sl()));
  sl.registerFactory(() => ProfileCubit(sl(), sl()));
  sl.registerFactory(() => PostDetailsCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AddPatientCubit(sl()));

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
}
