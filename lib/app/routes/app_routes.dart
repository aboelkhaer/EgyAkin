import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_cubit.dart';
import 'package:egy_akin/features/chat_room/presentation/pages/chat_forward_picker_screen.dart';
import 'package:egy_akin/features/chat_room/presentation/pages/chat_info_screen.dart';
import 'package:egy_akin/features/chat_room/presentation/pages/chat_add_members_screen.dart';
import 'package:egy_akin/features/chat_room/presentation/pages/chat_media_gallery_screen.dart';
import 'package:egy_akin/features/chat_room/presentation/pages/chat_room_screen.dart';
import 'package:egy_akin/features/chat_room/presentation/pages/chat_search_screen.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_member_search_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/pages/inbox_archived_screen.dart';
import 'package:egy_akin/features/inbox/presentation/pages/inbox_global_search_screen.dart';
import 'package:egy_akin/features/inbox/presentation/pages/inbox_group_create_screen.dart';
import 'package:egy_akin/features/inbox/presentation/pages/inbox_member_search_screen.dart';
import 'package:egy_akin/features/marked_patients/presentation/cubit/marked_patients_cubit.dart';
import 'package:egy_akin/features/marked_patients/presentation/pages/marked_patients_screen.dart';
import 'package:egy_akin/app/routes/fade_swipe_back_page_route.dart';
import 'package:egy_akin/app/routes/slide_from_right_page_route.dart';
import 'package:flutter/cupertino.dart';

import '../../exports.dart';
import 'package:egy_akin/injection_container.dart' as di;
import 'package:egy_akin/app/services/deep_link_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/webview/presentation/pages/webview_screen.dart';

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
  static const String webview = '/webview';
  static const String markedPatients = '/markedPatients';
  static const String chatRoom = '/chatRoom';
  static const String inboxMemberSearch = '/inboxMemberSearch';
  static const String inboxGroupCreate = '/inboxGroupCreate';
  static const String inboxArchived = '/inboxArchived';
  static const String inboxGlobalSearch = '/inboxGlobalSearch';
  static const String chatInfo = '/chatInfo';
  static const String chatAddMembers = '/chatAddMembers';
  static const String chatForward = '/chatForward';
  static const String chatSearch = '/chatSearch';
  static const String chatMediaGallery = '/chatMediaGallery';
}

class RouteGenerator {
  static void _storeDeepLinkPostId(String postId) {
    // Store the post ID in shared preferences for later processing
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('pending_post_id', postId);
      debugPrint('=== ROUTE GENERATOR: Stored deep link post ID: $postId ===');
    });
  }

  static Route<dynamic> getRoute(RouteSettings settings) {
    // Check if this is a deep link pattern (just a number or /post/number)
    final routeName = settings.name;
    if (routeName != null) {
      // External consultation invite: /invite/{token} or egyakin://invite/{token}
      final inviteMatch = RegExp(r'^/invite/([^/]+)/?$').firstMatch(routeName);
      if (inviteMatch != null) {
        final token = inviteMatch.group(1)!;
        DeepLinkHandler().storePendingInviteToken(token);
        debugPrint(
            '=== ROUTE GENERATOR: Invite deep link stored, redirecting to splash ===');
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashCubit>(
            create: (context) => di.sl<SplashCubit>()..loadData(),
            child: const SplashScreen(),
          ),
        );
      }
      // Check if it's just a number (like /46 from egyakin://post/46)
      if (RegExp(r'^/\d+$').hasMatch(routeName)) {
        debugPrint(
            '=== ROUTE GENERATOR: Deep link route detected: $routeName ===');
        // Extract post ID from route and store it before redirecting to splash
        final postId = routeName.substring(1); // Remove the leading '/'
        _storeDeepLinkPostId(postId);
        debugPrint('=== ROUTE GENERATOR: Redirecting to splash screen ===');
        // Redirect to splash screen which will handle the deep link after app initialization
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashCubit>(
            create: (context) => di.sl<SplashCubit>()..loadData(),
            child: const SplashScreen(),
          ),
        );
      }
      // Check if it's /post/number pattern
      if (RegExp(r'^/post/\d+$').hasMatch(routeName)) {
        debugPrint(
            'Deep link route detected: $routeName - redirecting to splash');
        // Extract post ID from route and store it before redirecting to splash
        final pathSegments = routeName.split('/');
        final postId = pathSegments.last; // Get the last segment (the post ID)
        _storeDeepLinkPostId(postId);
        // Redirect to splash screen which will handle the deep link after app initialization
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashCubit>(
            create: (context) => di.sl<SplashCubit>()..loadData(),
            child: const SplashScreen(),
          ),
        );
      }
    }

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
                BlocProvider.value(value: di.resolveHomeCubit()),

                BlocProvider<NotificationCubit>(
                  create: (context) =>
                      di.sl<NotificationCubit>()..ensureNotificationsLoaded(),
                ),
                BlocProvider<ProfileCubit>(
                  create: (context) => di.sl<ProfileCubit>(),
                ),
                BlocProvider<MoreCubit>(
                  create: (context) => di.sl<MoreCubit>(),
                ),
                BlocProvider.value(value: di.sl<TrendingCubit>()),
                BlocProvider.value(value: di.sl<GroupsCubit>()),
                BlocProvider.value(value: di.sl<CommunityCubit>()),
                BlocProvider.value(value: di.sl<InboxCubit>()),
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
                  patientsOnly: args['patientsOnly'] as bool? ?? false,
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
                  openFilterOnLoad: args['openFilterOnLoad'] as bool? ?? false,
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
            return SectionDetailsPageRoute(
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
              BlocProvider.value(value: di.resolveHomeCubit()),
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
                  BlocProvider.value(value: di.resolveHomeCubit()),
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
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<ProfilePatientsCubit>(
                    create: (context) => di.sl<ProfilePatientsCubit>(),
                  ),
                  BlocProvider<MarkedPatientsCubit>.value(
                    value: di.resolveMarkedPatientsCubit(),
                  ),
                  BlocProvider.value(value: di.resolveHomeCubit()),
                ],
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
                  initialShowMarked:
                      args['initialShowMarked'] as bool? ?? false,
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
              args.containsKey('patientId') &&
              args.containsKey('isForAddNewDoctors') &&
              args.containsKey('consultationId')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<SendConsultationCubit>(
                create: (context) => di.sl<SendConsultationCubit>(),
                child: SendConsultationScreen(
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                  patientId: args['patientId'] as String,
                  isSendConsultation: args['isSendConsultation'] as bool,
                  groupId: args['groupId'] as String,
                  isForAddNewDoctors: args['isForAddNewDoctors'] as bool,
                  consultationId: args['consultationId'] as String,
                  ownerOfConsultationId:
                      args['ownerOfConsultationId'] as String,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.notification:
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
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<NotificationCubit>(
                    create: (context) =>
                        di.sl<NotificationCubit>()..getAllNotifications(),
                  ),
                  BlocProvider.value(value: di.resolveHomeCubit()),
                ],
                child: NotificationScreen(
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

      case AppRoutes.consultation:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('homeDataModel') &&
              args.containsKey('currentDoctorModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider<ConsultationCubit>.value(
                value: di.resolveConsultationCubit(),
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
              args.containsKey('isReceivedConsultation') &&
              args.containsKey('isOpen')) {
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
                  isOpen: args['isOpen'] as bool,
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
            return CupertinoPageRoute(
              settings: settings,
              builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<ShowSingleFeedCubit>.value(
                      value: di.resolveShowSingleFeedCubit(),
                    ),
                    BlocProvider<CommunityCubit>(
                      create: (context) => di.sl<CommunityCubit>(),
                    ),
                  ],
                  child: ShowSingleFeedScreen(
                    currentDoctorModel:
                        args['currentDoctorModel'] as DoctorModel,
                    homeDataModel: args['homeDataModel'] as HomeModelResponse,
                    feed: args['feed'] as PostCommunityModel,
                    isComeFromNotification:
                        args['isComeFromNotification'] as bool,
                    feedId: args['feedId'] as String?,
                    showPostFrom: args['showPostFrom'] as String,
                  ),
                );
              },
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
                  groupName: args['groupName'] as String?,
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
                  BlocProvider.value(
                    value: di.resolveAllGroupsInCommunityCubit(),
                  ),
                  BlocProvider.value(
                    value: di.resolveMyGroupsInCommunityCubit(),
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
                  initialTab: (args['initialTab'] as int?) ?? 0,
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
                  BlocProvider.value(
                      value: di.resolveMyGroupsInCommunityCubit()),
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
            return FadeSwipeBackPageRoute(
              settings: settings,
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: di.sl<CommunitySearchCubit>()),
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
                  // BlocProvider(create: (context) => di.sl<SavedPostsCubit>()),
                  BlocProvider.value(value: di.resolveSavedPostsCubit()),
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
                  // BlocProvider(create: (context) => di.sl<CommunityCubit>()),
                  BlocProvider.value(value: di.sl<AllDoctorPostsCubit>()),
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

      case AppRoutes.webview:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          if (args.containsKey('url') && args.containsKey('title')) {
            return MaterialPageRoute(
              builder: (_) => WebViewScreen(
                url: args['url'] as String,
                title: args['title'] as String,
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.markedPatients:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: di.resolveHomeCubit()),
                  BlocProvider<MarkedPatientsCubit>.value(
                    value: di.resolveMarkedPatientsCubit(),
                  ),
                ],
                child: MarkedPatientsScreen(
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
      case AppRoutes.chatRoom:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            final doctor = args['currentDoctorModel'] as DoctorModel;
            final chatType = args['chatType'] as String?;
            final contextId = args['contextId'] as int?;
            // Use create (not .value) so the factory cubit is closed on pop —
            // otherwise Ably listeners + cubit state leak and can crash on
            // push-notification / repeated chat opens.
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) {
                  final cubit = di.sl<ChatRoomCubit>();
                  if (chatType != null && contextId != null) {
                    var userId = doctor.id;
                    if (userId == null || userId == 0) {
                      userId = di.sl<HomeCubit>().currentDoctorModel.id;
                    }
                    final myName = [
                      doctor.firstName,
                      doctor.lastName,
                    ]
                        .where((p) => (p ?? '').trim().isNotEmpty)
                        .join(' ')
                        .trim();
                    cubit.init(
                      contextId: contextId,
                      chatType: chatType,
                      currentUserId: userId ?? 0,
                      conversationId: args['conversationId'] as int?,
                      peerDisplayName: args['peerDisplayName'] as String?,
                      myDisplayName: myName.isEmpty ? null : myName,
                      myImageUrl: doctor.image,
                      peerIsOnline: args['peerIsOnline'] as bool?,
                      initialParticipants:
                          args['initialParticipants'] as List<ChatUserModel>?,
                    );
                  }
                  return cubit;
                },
                child: ChatRoomScreen(
                  currentDoctorModel:
                      args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  peerDisplayName: args['peerDisplayName'] as String?,
                  peerInitials: args['peerInitials'] as String?,
                  peerVerified: args['peerVerified'] as bool?,
                  peerIsOnline: args['peerIsOnline'] as bool?,
                  chatType: args['chatType'] as String?,
                  contextId: args['contextId'] as int?,
                  conversationId: args['conversationId'] as int?,
                  peerImageUrl: args['peerImageUrl'] as String?,
                  focusMessageId: args['focusMessageId'] as String?,
                ),
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }
      case AppRoutes.inboxMemberSearch:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => di.sl<InboxMemberSearchCubit>(),
                child: InboxMemberSearchScreen(
                  currentDoctorModel:
                      args['currentDoctorModel'] as DoctorModel,
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

      case AppRoutes.inboxGroupCreate:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => InboxGroupCreateScreen(
                currentDoctorModel:
                    args['currentDoctorModel'] as DoctorModel,
                homeDataModel: args['homeDataModel'] as HomeModelResponse,
              ),
            );
          } else {
            return unDefinedRoute();
          }
        } else {
          return unDefinedRoute();
        }

      case AppRoutes.inboxArchived:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: di.sl<InboxCubit>(),
                child: InboxArchivedScreen(
                  currentDoctorModel:
                      args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          }
          return unDefinedRoute();
        }
        return unDefinedRoute();

      case AppRoutes.inboxGlobalSearch:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return FadeSwipeBackPageRoute(
              settings: settings,
              builder: (_) => BlocProvider.value(
                value: di.sl<InboxCubit>(),
                child: InboxGlobalSearchScreen(
                  currentDoctorModel:
                      args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                ),
              ),
            );
          }
          return unDefinedRoute();
        }
        return unDefinedRoute();

      case AppRoutes.chatInfo:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return SlideFromRightPageRoute(
              settings: settings,
              builder: (_) => ChatInfoScreen(
                currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                homeDataModel: args['homeDataModel'] as HomeModelResponse,
                displayName: args['displayName'] as String? ?? '',
                imageUrl: args['imageUrl'] as String?,
                initials: args['initials'] as String?,
                isVerified: args['isVerified'] as bool? ?? false,
                chatType: args['chatType'] as String?,
                contextId: args['contextId'] as int?,
                conversationId: args['conversationId'] as int?,
                isGroup: args['isGroup'] as bool? ?? false,
                messages: (args['messages'] as List<ChatMessageItem>?) ??
                    const [],
              ),
            );
          }
          return unDefinedRoute();
        }
        return unDefinedRoute();

      case AppRoutes.chatAddMembers:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel') &&
              args.containsKey('conversationId') &&
              args.containsKey('chatType')) {
            final existing = <int>{};
            final raw = args['existingMemberIds'];
            if (raw is Set<int>) {
              existing.addAll(raw);
            } else if (raw is Iterable) {
              for (final id in raw) {
                if (id is int) existing.add(id);
                if (id is num) existing.add(id.toInt());
              }
            }
            return MaterialPageRoute(
              builder: (_) => ChatAddMembersScreen(
                currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                homeDataModel: args['homeDataModel'] as HomeModelResponse,
                conversationId: args['conversationId'] as int,
                chatType: args['chatType'] as String,
                existingMemberIds: existing,
              ),
            );
          }
          return unDefinedRoute();
        }
        return unDefinedRoute();

      case AppRoutes.chatForward:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel') &&
              (args.containsKey('messages') || args.containsKey('message'))) {
            final messagesArg = args['messages'];
            final List<ChatMessageItem> messages;
            if (messagesArg is List<ChatMessageItem>) {
              messages = messagesArg;
            } else if (messagesArg is List) {
              messages = messagesArg.whereType<ChatMessageItem>().toList();
            } else if (args['message'] is ChatMessageItem) {
              messages = [args['message'] as ChatMessageItem];
            } else {
              return unDefinedRoute();
            }
            if (messages.isEmpty) return unDefinedRoute();
            return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: di.sl<InboxCubit>(),
                child: ChatForwardPickerScreen(
                  currentDoctorModel:
                      args['currentDoctorModel'] as DoctorModel,
                  homeDataModel: args['homeDataModel'] as HomeModelResponse,
                  messages: messages,
                  sourceConversationId: args['sourceConversationId'] as int?,
                  excludeChatType: args['excludeChatType'] as String?,
                  excludeContextId: args['excludeContextId'] as int?,
                ),
              ),
            );
          }
          return unDefinedRoute();
        }
        return unDefinedRoute();

      case AppRoutes.chatSearch:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => ChatSearchScreen(
                currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                homeDataModel: args['homeDataModel'] as HomeModelResponse,
                peerDisplayName: args['peerDisplayName'] as String?,
                peerImageUrl: args['peerImageUrl'] as String?,
                messages: (args['messages'] as List<ChatMessageItem>?) ??
                    const [],
                chatType: args['chatType'] as String?,
                contextId: args['contextId'] as int?,
                conversationId: args['conversationId'] as int?,
              ),
            );
          }
          return unDefinedRoute();
        }
        return unDefinedRoute();

      case AppRoutes.chatMediaGallery:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          if (args.containsKey('currentDoctorModel') &&
              args.containsKey('homeDataModel')) {
            return MaterialPageRoute(
              builder: (_) => ChatMediaGalleryScreen(
                currentDoctorModel: args['currentDoctorModel'] as DoctorModel,
                homeDataModel: args['homeDataModel'] as HomeModelResponse,
                displayName: args['displayName'] as String? ?? '',
                messages: (args['messages'] as List<ChatMessageItem>?) ??
                    const [],
                chatType: args['chatType'] as String?,
                contextId: args['contextId'] as int?,
                conversationId: args['conversationId'] as int?,
                peerImageUrl: args['peerImageUrl'] as String?,
              ),
            );
          }
          return unDefinedRoute();
        }
        return unDefinedRoute();

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
