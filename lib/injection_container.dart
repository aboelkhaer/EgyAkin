import 'package:dio/dio.dart';
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
  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => EmailVerificationCubit());
  sl.registerFactory(() => NotificationCubit(sl(), sl()));
  sl.registerFactory(() => ProfileCubit(sl(), sl()));

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
  if (!GetIt.I.isRegistered<GetNotificationsUsecase>()) {
    sl.registerFactory<GetNotificationsUsecase>(
        () => GetNotificationsUsecase(sl()));
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
}




// Future<void> diInit() async {
//   // Core
//   Get.lazyPut(() => GetStorage(), fenix: true);
//   Get.lazyPut(() => GetStorageLib(), fenix: true);
//   Get.lazyPut(() => DioFactory(getStorageLib: Get.find()), fenix: true);
//   initNetworking();
//   Get.lazyPut<InternetConnectionChecker>(() => InternetConnectionChecker(),
//       fenix: true);
//   Get.lazyPut<NetworkInfoImpl>(() => NetworkInfoImpl(Get.find()), fenix: true);
//   Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);

//   // Repository
//   Get.lazyPut(() => AuthRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => HomeRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => SearchRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => ProfileRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => SectionDetailsRepository(apiServices: Get.find()),
//       fenix: true);
//   Get.lazyPut(() => PatientSectionRepository(apiServices: Get.find()),
//       fenix: true);
//   Get.lazyPut(() => AddPatientRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => OutcomeRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => CommentRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => ContactUsRepository(apiServices: Get.find()), fenix: true);
//   Get.lazyPut(() => ResetPasswordRepository(apiServices: Get.find()),
//       fenix: true);
//   Get.lazyPut(() => PostDetailsRepository(apiServices: Get.find()),
//       fenix: true);
//   Get.lazyPut(() => NotificationRepository(apiServices: Get.find()),
//       fenix: true);
//   Get.lazyPut(() => EmailVerificationRepository(apiServices: Get.find()),
//       fenix: true);

//   Get.lazyPut(() => SplashController(), fenix: true);
//   Get.lazyPut(() => OnboardingController());
//   Get.lazyPut(() => WelcomeController());
//   Get.lazyPut(() => SignInController());
//   Get.lazyPut(() => RegisterController());
//   Get.lazyPut(() => HomeController());
//   Get.lazyPut(() => LogoutController());
//   Get.lazyPut(() => DoctroProfileController());
//   Get.lazyPut(() => SectionDetailsController());
//   Get.lazyPut(() => SearchHomeController());
//   Get.lazyPut(() => CurrentPatientsController());
//   Get.lazyPut(() => AllPatientsController());
//   Get.lazyPut(() => SectionDetailsController());
//   Get.lazyPut(() => AddPatientController());
//   Get.lazyPut(() => PatientSectionController());
//   Get.lazyPut(() => OutcomeController());
//   Get.lazyPut(() => CommentsController());
//   Get.lazyPut(() => ContactUsController());
//   Get.lazyPut(() => PostDetailsController());
//   Get.lazyPut(() => NotificationController());
//   Get.lazyPut(() => ResetPasswordController());
//   Get.lazyPut(() => EmailVerificationController());
// }

// initNetworking() async {
//   Dio dio = await Get.find<DioFactory>().getDio();

//   Get.lazyPut<ApiServices>(() => ApiServices(dio), fenix: true);
// }
