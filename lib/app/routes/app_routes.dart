import '../../exports.dart';

class AppRoutes {
  static const String splash = '/';

  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String signIn = '/signIn';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() async {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: onboarding,
      page: () => const OnbordingScreen(),
      binding: BindingsBuilder(() {
        Get.put(OnboardingController());
      }),
    ),
    GetPage(
      name: welcome,
      page: () => const WelcomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(WelcomeController());
      }),
    ),
    GetPage(
      name: signIn,
      page: () => const SignInScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
  ];
}
