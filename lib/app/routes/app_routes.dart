import 'package:egyakin/app/bindings/notification_binding.dart';
import 'package:egyakin/features/notification/view/notification_screen.dart';

import '../bindings/posts_binding.dart';
import '../../features/posts/view/posts_screen.dart';

import '../../exports.dart';
import '../../features/comments/view/comments_screen.dart';
import '../../features/outcome/view/outcome_screen.dart';
import '../bindings/comments_binding.dart';
import '../bindings/outcome_binding.dart';

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
  static const String search = '/search';
  static const String patientSections = '/patientSection';
  static const String sectionDetails = '/sectionDetails';
  static const String contactUs = '/contactUs';
  static const String addPatient = '/addPatient';
  static const String outcome = '/outcome';
  static const String comments = '/comments';
  static const String posts = '/posts';
  static const String notification = '/notification';

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
    GetPage(
      name: search,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: patientSections,
      page: () => const PatienSectionScreen(),
      binding: PatientSectionBinding(),
    ),
    GetPage(
      name: sectionDetails,
      page: () => const SectionDetailsScreen(),
      binding: SectionDetailsBinding(),
    ),

    GetPage(
      name: contactUs,
      page: () => ContactUsScreen(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: addPatient,
      page: () => const AddPatientScreen(),
      binding: AddPatientBinding(),
    ),
    GetPage(
      name: outcome,
      page: () => const OutcomeScreen(),
      binding: OutcomeBinding(),
    ),
    GetPage(
      name: comments,
      page: () => const CommentsScreen(),
      binding: CommentsBinding(),
    ),
    GetPage(
      name: comments,
      page: () => const PostsScreen(),
      binding: PostsBinding(),
    ),
    GetPage(
      name: notification,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
  ];
}
