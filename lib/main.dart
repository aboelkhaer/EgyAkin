import 'package:egy_akin/exports.dart';
import 'package:egy_akin/injection_container.dart' as di;
import 'package:egy_akin/app/services/deep_link_handler.dart';
import 'package:egy_akin/app/services/deep_link_navigation_service.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up global error handlers to prevent app crashes
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };

  // Handle errors outside of Flutter framework
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('PlatformDispatcher error: $error');
    debugPrint('Stack trace: $stack');
    return true; // Return true to prevent app from crashing
  };

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
  final DeepLinkNavigationService _deepLinkNavigationService =
      DeepLinkNavigationService();
  late LocalizationBloc _localizationBloc;
  late ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();

    notificationServices = NotificationServices();
    _localizationBloc = LocalizationBloc();
    _themeBloc = ThemeBloc();

    // Call post frame callback to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotificationServices();
      _initializeDeepLinks();
      _initializeLocalization();
      _initializeTheme();
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
          postId, navigatorKey.currentContext!);
    }
  }

  Future<void> _initializeLocalization() async {
    _localizationBloc.add(InitializeLocalization());
  }

  Future<void> _initializeTheme() async {
    _themeBloc.add(InitializeTheme());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _localizationBloc),
        BlocProvider(create: (context) => _themeBloc),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return ScreenUtilInit(
                designSize: const Size(360, 640),
                minTextAdapt: true,
                splitScreenMode: true,
                child: MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: AnimatedTheme(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    data: themeState is ThemeLoaded && themeState.isDarkMode
                        ? Themes.darkTheme
                        : Themes.lightTheme,
                    child: MaterialApp(
                      title: AppStrings.appName,
                      navigatorKey: navigatorKey,
                      debugShowCheckedModeBanner: false,
                      theme: Themes.lightTheme,
                      darkTheme: Themes.darkTheme,
                      themeMode: themeState is ThemeLoaded
                          ? themeState.themeMode
                          : ThemeMode.system,
                      locale: state is LocalizationLoaded ? state.locale : null,
                      supportedLocales: LocalizationService.supportedLocales,
                      localizationsDelegates: const [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      onGenerateRoute: (settings) {
                        debugPrint('Route requested: ${settings.name}');
                        return RouteGenerator.getRoute(settings);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
