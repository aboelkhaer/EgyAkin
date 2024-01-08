import 'package:dio/dio.dart';

import 'exports.dart';
import 'features/email_verification/controller/email_verification_controller.dart';
import 'features/reset_password/controller/reset_password_repo.dart';

Future<void> diInit() async {
  // Core
  //  Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  // Get.find<DioFactory>().getDio();
  Get.lazyPut(() => GetStorage(), fenix: true);
  Get.lazyPut(() => GetStorageLib(), fenix: true);
  Get.lazyPut(() => DioFactory(getStorageLib: Get.find()), fenix: true);
  initNetworking();
  Get.lazyPut<InternetConnectionChecker>(() => InternetConnectionChecker(),
      fenix: true);
  Get.lazyPut<NetworkInfoImpl>(() => NetworkInfoImpl(Get.find()), fenix: true);
  Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);

  // Repository
  // Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => AuthRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => HomeRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => SearchRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => ProfileRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => SectionDetailsRepository(apiServices: Get.find()),
      fenix: true);
  Get.lazyPut(() => PatientSectionRepository(apiServices: Get.find()),
      fenix: true);
  Get.lazyPut(() => AddPatientRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => OutcomeRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => CommentRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => ContactUsRepository(apiServices: Get.find()), fenix: true);
  Get.lazyPut(() => ResetPasswordRepository(apiServices: Get.find()),
      fenix: true);
  Get.lazyPut(() => PostDetailsRepository(apiServices: Get.find()),
      fenix: true);
  Get.lazyPut(() => NotificationRepository(apiServices: Get.find()),
      fenix: true);
  Get.lazyPut(() => EmailVerificationRepository(apiServices: Get.find()),
      fenix: true);

  // Controller
  // Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(), fenix: true);
  Get.lazyPut(() => OnboardingController());
  // Get.lazyPut(() => AuthController());
  Get.lazyPut(() => WelcomeController());
  Get.lazyPut(() => SignInController());
  Get.lazyPut(() => RegisterController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => LogoutController());
  Get.lazyPut(() => DoctroProfileController());
  Get.lazyPut(() => SectionDetailsController());
  Get.lazyPut(() => SearchHomeController());
  Get.lazyPut(() => CurrentPatientsController());
  Get.lazyPut(() => AllPatientsController());
  Get.lazyPut(() => SectionDetailsController());
  Get.lazyPut(() => AddPatientController());
  Get.lazyPut(() => PatientSectionController());
  Get.lazyPut(() => OutcomeController());
  Get.lazyPut(() => CommentsController());
  Get.lazyPut(() => ContactUsController());
  Get.lazyPut(() => PostDetailsController());
  Get.lazyPut(() => NotificationController());
  Get.lazyPut(() => ResetPasswordController());
  Get.lazyPut(() => EmailVerificationController());
}

initNetworking() async {
  Dio dio = await Get.find<DioFactory>().getDio();

  Get.lazyPut<ApiServices>(() => ApiServices(dio), fenix: true);
}
