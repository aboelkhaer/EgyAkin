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
  static const String patientSectionDetails = '/patientSectionDetails';
  static const String contactUs = '/contactUs';
  static const String addPatient = '/addPatient';
  static const String outcome = '/outcome';
  static const String comments = '/comments';
  static const String postDetails = '/postDetails';
  static const String notification = '/notification';
  static const String resetPassword = '/resetPassword';
  static const String emailVerification = '/emailVerification';
  static const String doctorInfoView = '/doctorInfoView';
  static const String gfrCalculator = '/gfrCalculator';
  static const String changePassword = '/changePassword';
  static const String profilePatients = '/profilePatients';
  static const String aboutUs = '/aboutUs';
  static const String sendConsultation = '/sendConsultation';
  static const String consultation = '/consultation';
  static const String consultationDetails = '/consultationDetails';
  static const String community = '/community';
  static const String showSingleFeed = '/showSingleFeed';
  static const String consultationFromAi = '/consultationFromAi';
  static const String createPostInCommunity = '/createPostInCommunity';
  static const String groupDetailsInCommunity = '/groupDetailsInCommunity';
  static const String allGroupsInCommunity = '/allGroupsInCommunity';
  static const String inviteMemberToGroupInCommunity =
      '/inviteMemberToGroupInCommunity';
  static const String createGroupInCommunity = '/createGroupInCommunity';
  static const String communitySearch = '/communitySearch';
  static const String savedPosts = '/savedPosts';
  static const String allDoctorPosts = '/allDoctorPosts';
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
            create: (context) => di.sl<AuthenticationCubit>()..getFCMToken(),
            child: const SignInScreen(),
          ),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthenticationCubit>(
            create: (context) => di.sl<AuthenticationCubit>()..getFCMToken(),
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
        final arguments = settings.arguments;
        if (arguments is int) {
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                // BlocProvider<HomeCubit>(
                //     create: (context) => di.sl<HomeCubit>()..getHome()),
                BlocProvider.value(value: di.sl<HomeCubit>()),

                BlocProvider<NotificationCubit>(
                  create: (context) =>
                      di.sl<NotificationCubit>()..getAllNotifications(),
                ),
                BlocProvider<ProfileCubit>(
                  create: (context) => di.sl<ProfileCubit>(),
                ),
                BlocProvider<MoreCubit>(
                  create: (context) => di.sl<MoreCubit>(),
                ),
              ],
              child: HomeScreen(
                page: arguments,
              ),
            ),
          );
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.emailVerification:
        final arguments = settings.arguments;
        if (arguments is DoctorModel) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailVerificationCubit>(
              create: (context) => di.sl<EmailVerificationCubit>(),
              child: EmailVerifciationScreen(currentDoctorModel: arguments),
            ),
          );
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.postDetails:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('postModel') &&
              args.containsKey('doctorModel') &&
              args.containsKey('accountVerification') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<PostDetailsCubit>(
                create: (context) => di.sl<PostDetailsCubit>(),
                child: PostDetailsScreen(
                  postModel: args['postModel'] as PostModel,
                  currentDoctorModel: args['doctorModel'] as DoctorModel,
                  accountVerification: args['accountVerification'] as bool,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.addPatient:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<AddPatientCubit>(
                create: (context) =>
                    di.sl<AddPatientCubit>()..getPatientHistoryForAddPatient(),
                child: AddPatientScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.patientSections:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('patientId') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('isAllDataOpen')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<PatientSectionsCubit>(
                create: (context) => di.sl<PatientSectionsCubit>(),
                child: PatientSectionsScreen(
                  patientId: args['patientId'] as String,
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  isAllDataOpen: args['isAllDataOpen'] as bool,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.comments:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('patientId') &&
              args.containsKey('accountVerification') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<PatientCommentsCubit>(
                create: (context) => di.sl<PatientCommentsCubit>(),
                child: PatientCommentsScreen(
                  patientId: args['patientId'] as String,
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  accountVerification: args['accountVerification'] as bool,
                  patientName: args['patientName'] as String,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.search:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('accountVerification') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<SearchCubit>(
                create: (context) => di.sl<SearchCubit>(),
                child: SearchScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  accountVerification: args['accountVerification'] as bool,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.outcome:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('accountVerification') &&
              args.containsKey('outcomeStatus') &&
              args.containsKey('patientName') &&
              args.containsKey('patientId') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('currentDoctorModel') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<OutcomeCubit>(
                create: (context) => di.sl<OutcomeCubit>(),
                child: OutcomeScreen(
                  outcomeStatus: args['outcomeStatus'] as bool,
                  patientName: args['patientName'] as String,
                  patientId: args['patientId'] as String,
                  doctorId: args['doctorId'] as String,
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  accountVerification: args['accountVerification'] as bool,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.currentPatients:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('accountVerification') &&
              args.containsKey('currentDoctorModel') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<CurrentDoctorPatientsCubit>(
                create: (context) => di.sl<CurrentDoctorPatientsCubit>()
                  ..getCurrentDoctorPatients(),
                child: CurrentDoctorPatientsScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  accountVerification: args['accountVerification'] as bool,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.allPatients:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('accountVerification') &&
              args.containsKey('currentDoctorModel') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<AllDoctorsPatientsCubit>(
                create: (context) => di.sl<AllDoctorsPatientsCubit>()
                  ..getCurrentDoctorPatients(),
                child: AllDoctorsPatientsScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  accountVerification: args['accountVerification'] as bool,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.patientSectionDetails:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('sectionModel') &&
              args.containsKey('finalSubmitStatus') &&
              args.containsKey('currentDoctorModel') &&
              args.containsKey('patientId') &&
              args.containsKey('doctorId') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('isAllDataOpen')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<PatientSectionDetailsCubit>(
                create: (context) => di.sl<PatientSectionDetailsCubit>(),
                child: PatientSectionDetailsScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  sectionModel: args['sectionModel'] as SectionModel,
                  finalSubmitStatus: args['finalSubmitStatus'] as bool,
                  patientId: args['patientId'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  doctorId: args['doctorId'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  isAllDataOpen: args['isAllDataOpen'] as bool,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.doctorProfile:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<DoctorProfileViewCubit>(
                create: (context) => di.sl<DoctorProfileViewCubit>()
                  ..getCurrentDoctorModelFromLocal(),
              ),
              BlocProvider<ProfileCubit>(
                create: (context) => di.sl<ProfileCubit>(),
              ),
              BlocProvider<HomeCubit>(
                create: (context) => di.sl<HomeCubit>(),
              ),
            ],
            child: const DoctorProfileViewScreen(),
          ),
        );

      case AppRoutes.doctorInfoView:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('doctorId') &&
              args.containsKey('currentDoctorModel') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('accountVerification') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('initialIndex') &&
              args.containsKey('isNavigateToTheButtonOfInformationTab')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<DoctorInfoViewCubit>(
                      create: (context) => di.sl<DoctorInfoViewCubit>()),
                  BlocProvider<HomeCubit>(
                      create: (context) => di.sl<HomeCubit>()),
                ],
                child: DoctorInfoViewScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  doctorId: args['doctorId'] as String,
                  accountVerification: args['accountVerification'] as bool,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  initialIndex: args['initialIndex'] as int,
                  isNavigateToTheButtonOfInformationTab:
                      args['isNavigateToTheButtonOfInformationTab'] as bool,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.contactUs:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ContactUsCubit>(
            create: (context) => di.sl<ContactUsCubit>(),
            child: const ContactUsScreen(),
          ),
        );
      case AppRoutes.gfrCalculator:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<GfrCalculatorCubit>(
                create: (context) => di.sl<GfrCalculatorCubit>(),
                child: GfrCalculatorScreen(
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ChangePasswordCubit>(
            create: (context) => di.sl<ChangePasswordCubit>(),
            child: const ChangePasswordScreen(),
          ),
        );
      case AppRoutes.profilePatients:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('doctorId') &&
              args.containsKey('accountVerification') &&
              args.containsKey('currentDoctorModel') &&
              args.containsKey('isSyndicateCardRequired') &&
              args.containsKey('doctorFirstName') &&
              args.containsKey('currentDoctorRole') &&
              args.containsKey('currentDoctorPoints') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<ProfilePatientsCubit>(
                create: (context) => di.sl<ProfilePatientsCubit>(),
                child: ProfilePatientsScreen(
                  doctorId: args['doctorId'] as String,
                  accountVerification: args['accountVerification'] as bool,
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  isSyndicateCardRequired:
                      args['isSyndicateCardRequired'] as String,
                  doctorFirstName: args['doctorFirstName'] as String,
                  currentDoctorRole: args['currentDoctorRole'] as String,
                  currentDoctorPoints: args['currentDoctorPoints'] as int,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.aboutUs:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AboutUsCubit>(
            create: (context) => di.sl<AboutUsCubit>(),
            child: const AboutUsScreen(),
          ),
        );

      case AppRoutes.sendConsultation:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('homeDataModel') &&
              args.containsKey('currentDoctorModel') &&
              args.containsKey('patientId')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<SendConsultationCubit>(
                create: (context) => di.sl<SendConsultationCubit>(),
                child: SendConsultationScreen(
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  patientId: args['patientId'] as String,
                  isSendConsultation: args['isSendConsultation'] as bool,
                  groupId: args['groupId'] as String,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.consultation:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('homeDataModel') &&
              args.containsKey('currentDoctorModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<ConsultationCubit>(
                create: (context) => di.sl<ConsultationCubit>(),
                child: ConsultationScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  initialTab: args['initialTab'] as int,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.consultationDetails:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('consultationId') &&
              args.containsKey('patientName') &&
              args.containsKey('isReceivedConsultation')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<ConsultationDetailsCubit>(
                create: (context) => di.sl<ConsultationDetailsCubit>(),
                child: ConsultationDetailsScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  consultationId: args['consultationId'] as String,
                  patientName: args['patientName'] as String,
                  isReceivedConsultation:
                      args['isReceivedConsultation'] as bool,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.community:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('initialTab')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                  BlocProvider.value(value: di.sl<TrendingCubit>()),
                  BlocProvider.value(value: di.sl<GroupsCubit>()),
                  BlocProvider.value(
                      value: di.sl<GroupDetailsInCommunityCubit>()),
                ],
                child: CommunityScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  initialTab: args['initialTab'] as int,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.showSingleFeed:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: di
                        .sl<ShowSingleFeedCubit>(), // Reuse the existing Cubit
                  ),
                  // BlocProvider.value(
                  //   value: di.sl<CommunityCubit>(), // Reuse the existing Cubit
                  // ),
                  BlocProvider<CommunityCubit>(
                    create: (context) => di.sl<CommunityCubit>(),
                  ),
                ],
                child: ShowSingleFeedScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  feed: args['feed'] as PostCommunityModel,
                  isComeFromNotification:
                      args['isComeFromNotification'] as bool,
                  feedId: args['feedId'] as String,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.consultationFromAi:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('patientId')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<ConsultationFromAICubit>(
                create: (context) => di.sl<ConsultationFromAICubit>(),
                child: ConsultationFromAiScreen(
                  patientId: args['patientId'] as String,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.createPostInCommunity:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<CreatePostInCommunityCubit>(
                    create: (context) => di.sl<CreatePostInCommunityCubit>(),
                  ),
                  // Add more providers here if needed, e.g., another Cubit
                  BlocProvider<CommunityCubit>(
                    create: (context) => di.sl<CommunityCubit>(),
                  ),
                ],
                child: CreatePostInCommunityScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  feed: args['feed'] as PostCommunityModel?,
                  groupId: args['groupId'] as String?,
                  onPostUploaded: args['onPostUploaded'] as VoidCallback?,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.groupDetailsInCommunity:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('groupId')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  // BlocProvider(
                  //   create: (context) => di.sl<GroupDetailsInCommunityCubit>(),
                  // ),
                  BlocProvider.value(
                      value: di.sl<GroupDetailsInCommunityCubit>()),
                  BlocProvider.value(value: di.sl<GroupsCubit>()),
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                ],
                child: GroupDetailsInCommunityScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  groupId: args['groupId'] as String,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.allGroupsInCommunity:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => di.sl<AllGroupsInCommunityCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => di.sl<MyGroupsInCommunityCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => di.sl<GroupMembersCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => di.sl<GroupsInvitationsCubit>(),
                  ),
                  BlocProvider.value(value: di.sl<GroupsCubit>()),
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                  BlocProvider.value(value: di.sl<TrendingCubit>()),
                  BlocProvider.value(
                      value: di.sl<GroupDetailsInCommunityCubit>()),
                ],
                child: AllGroupsInCommunityScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.inviteMemberToGroupInCommunity:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        di.sl<InviteMemberToGroupInCommunityCubit>(),
                  ),
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                  BlocProvider.value(value: di.sl<TrendingCubit>()),
                  BlocProvider.value(value: di.sl<GroupsCubit>()),
                ],
                child: InviteMemberToGroupInCommunityScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.createGroupInCommunity:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) =>
                          di.sl<CreateGroupInCommunityCubit>()),
                  BlocProvider.value(value: di.sl<MyGroupsInCommunityCubit>()),
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                  BlocProvider.value(value: di.sl<TrendingCubit>()),
                  BlocProvider.value(value: di.sl<GroupsCubit>()),
                ],
                child: CreateGroupInCommunityScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  isCreateNewGroup: args['isCreateNewGroup'] as bool,
                  groupModel: args['groupModel'] as GroupModel?,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.communitySearch:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => di.sl<CommunitySearchCubit>()),
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                  BlocProvider.value(value: di.sl<TrendingCubit>()),
                  BlocProvider.value(value: di.sl<GroupsCubit>()),
                ],
                child: CommunitySearchScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  initialValueInSearch: args['initialValueInSearch'] as String?,
                ),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              transitionDuration: const Duration(
                  milliseconds: 300), // Adjust duration as needed
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.savedPosts:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('doctorId') &&
              args.containsKey('doctorName')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => di.sl<SavedPostsCubit>()),
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                ],
                child: SavedPostsScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  doctorId: args['doctorId'] as String,
                  doctorName: args['doctorName'] as String,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.allDoctorPosts:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('doctorId') &&
              args.containsKey('doctorName')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => di.sl<AllDoctorPostsCubit>()),
                  // BlocProvider(create: (context) => di.sl<CommunityCubit>()),
                  BlocProvider.value(value: di.sl<CommunityCubit>()),
                ],
                child: AllDoctorPostsScreen(
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  doctorId: args['doctorId'] as String,
                  doctorName: args['doctorName'] as String,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

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
