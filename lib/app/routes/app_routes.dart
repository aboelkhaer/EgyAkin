import '../../exports.dart';
import '../../features/all_patients/view/all_patients_screen.dart';
import '../../features/doctor_profile/view/doctor_profile_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../bindings/all_patients_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/onboarding_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/register_binding.dart';
import '../bindings/sign_in_biniding.dart';
import '../bindings/welcome_binding.dart';

class AppRoutes {
  // static const String splash = '/';

  static const String onboarding = '/onboarding';
  static const String welcome = '/';
  static const String signIn = '/signIn';
  static const String register = '/register';
  static const String home = '/home';
  static const String currentPatients = '/currentPatients';
  static const String allPatients = '/allPatients';
  static const String doctorProfile = '/doctorProfile';

  static List<GetPage> routes = [
    // GetPage(
    //   name: splash,
    //   page: () => const SplashScreen(),
    //   // binding: BindingsBuilder(() async {
    //   //   Get.find<SplashController>();
    //   // }),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: onboarding,
      page: () => const OnbordingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: welcome,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: signIn,
      page: () => const SignInScreen(),
      transition: Transition.fadeIn,
      binding: SignInBinding(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      transition: Transition.fadeIn,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: currentPatients,
      page: () => const CurrentPatientsScreen(),
      binding: CurrentPatientsBinding(),
    ),
    GetPage(
      name: allPatients,
      page: () => const AllPatientsScreen(),
      binding: AllPatientsBinding(),
    ),
    GetPage(
      name: doctorProfile,
      page: () => const DoctorProfileScreen(),
      binding: DoctorProfileBinding(),
    ),
  ];
}
