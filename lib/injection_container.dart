import 'package:dio/dio.dart';

import 'exports.dart';
import 'features/home/controller/home_repo.dart';

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
}

initNetworking() async {
  Dio dio = await Get.find<DioFactory>().getDio();

  Get.lazyPut<ApiServices>(() => ApiServices(dio), fenix: true);
}
