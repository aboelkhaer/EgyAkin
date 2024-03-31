import 'package:egy_akin/features/email_verification/presentation/cubit/email_verification_cubit.dart';
import 'package:egy_akin/features/email_verification/presentation/pages/email_verification_screen.dart';
import 'package:egy_akin/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:egy_akin/features/profile/presentation/cubit/profile_cubit.dart';

import '../../exports.dart';
import 'package:egy_akin/injection_container.dart' as di;

class AppRoutes {
  static const String splash = '/';

  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
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
  static const String postDetails = '/postDetails';
  static const String notification = '/notification';
  static const String resetPassword = '/resetPassword';
  static const String emailVerification = '/emailVerification';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashCubit>(
            create: (context) => di.sl<SplashCubit>()..loadData(),
            child: const SplashScreen(),
          ),
        );
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<WelcomeCubit>(
            create: (context) => di.sl<WelcomeCubit>(),
            child: const WelcomeScreen(),
          ),
        );
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OnboardingCubit>(
            create: (context) => di.sl<OnboardingCubit>(),
            child: const OnboardingScreen(),
          ),
        );
      case AppRoutes.signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthenticationCubit>(
            create: (context) => di.sl<AuthenticationCubit>(),
            child: const SignInScreen(),
          ),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthenticationCubit>(
            create: (context) => di.sl<AuthenticationCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ResetPasswordCubit>(
            create: (context) => di.sl<ResetPasswordCubit>(),
            child: const ResetPasswordScreen(),
          ),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                  create: (context) => di.sl<HomeCubit>()
                    ..getDoctorDataFromLocal()
                    ..getHome()
                  // ..getNotifications(),
                  ),
              BlocProvider<NotificationCubit>(
                create: (context) =>
                    di.sl<NotificationCubit>()..getAllNotifications(),
              ),
              BlocProvider<ProfileCubit>(
                create: (context) => di.sl<ProfileCubit>(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );
      case AppRoutes.emailVerification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<EmailVerificationCubit>(
            create: (context) => di.sl<EmailVerificationCubit>(),
            child: const EmailVerifciationScreen(),
          ),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
