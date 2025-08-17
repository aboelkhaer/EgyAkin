import 'package:egy_akin/exports.dart';
import 'package:egy_akin/injection_container.dart' as di;
import 'package:egy_akin/app/services/deep_link_handler.dart';
import 'package:egy_akin/app/services/deep_link_navigation_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'EgyAkin');
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await di.diInit();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NotificationServices notificationServices;
  final DeepLinkHandler _deepLinkHandler = DeepLinkHandler();
  final DeepLinkNavigationService _deepLinkNavigationService = DeepLinkNavigationService();

  @override
  void initState() {
    super.initState();

    notificationServices = NotificationServices();

    // Call post frame callback to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotificationServices();
      _initializeDeepLinks();
    });
  }

  Future<void> _initializeNotificationServices() async {
    await notificationServices.requestNotificationPermissions();
    notificationServices.firebaseInit(navigatorKey.currentContext!);
    await notificationServices.getDeviceToken();
  }

  Future<void> _initializeDeepLinks() async {
    _deepLinkHandler.initialize(navigatorKey.currentContext!);
    
    // Don't process deep links immediately - wait for home screen to be ready
    // The deep link will be processed when the home screen finishes loading
  }

  void _handlePendingDeepLink(String postId) {
    // This will be called when the app is ready to handle deep links
    // We'll implement this after the app is fully initialized
    debugPrint('Handling pending deep link for post: $postId');
    
    // Use the navigation service to handle the deep link
    if (navigatorKey.currentContext != null) {
      _deepLinkNavigationService.navigateToPostFromDeepLink(
        postId, 
        navigatorKey.currentContext!
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: MaterialApp(
          title: AppStrings.appName,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: Themes().lightTheme,
          onGenerateRoute: (settings) {
            debugPrint('Route requested: ${settings.name}');
            return RouteGenerator.getRoute(settings);
          },
        ),
      ),
    );
  }
}


