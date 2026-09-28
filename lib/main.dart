import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat/data/services/chat_push_delivery_ack.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/injection_container.dart' as di;
import 'package:egy_akin/app/services/deep_link_handler.dart';
import 'package:egy_akin/app/services/deep_link_navigation_service.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// FCM background isolate — must be a top-level function registered
/// *before* [runApp]. Posts delivered receipt per backend contract.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Background isolate has its own binding + prefs.
  WidgetsFlutterBinding.ensureInitialized();
  await _ensureFirebaseInitialized();
  await ChatPushDeliveryAck.ackFromRemoteMessageData(message.data);
}

/// AppDelegate already calls `FirebaseApp.configure()` on iOS. Dart may still
/// see `Firebase.apps` as empty, then hit `[core/duplicate-app]` — treat that
/// as success so Messaging keeps using `[DEFAULT]`.
Future<void> _ensureFirebaseInitialized() async {
  if (Firebase.apps.isNotEmpty) return;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    final message = e.toString();
    if (message.contains('duplicate-app') || Firebase.apps.isNotEmpty) {
      return;
    }
    debugPrint('Firebase.initializeApp failed: $e');
    rethrow;
  }
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep the native splash up until Flutter splash is ready (avoids white flash).
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Safety net: never leave TestFlight users stuck on the dark native splash
  // if startup hangs before SplashScreen can call remove().
  Future<void>.delayed(const Duration(seconds: 4), () {
    try {
      FlutterNativeSplash.remove();
    } catch (_) {}
  });

  // Set up global error handlers to prevent app crashes
  FlutterError.onError = (FlutterErrorDetails details) {
    final message = details.exceptionAsString();
    // Broken OG / CDN URLs often return HTML or empty bytes labeled as .png.
    // UI already falls back via CachedNetworkImage.errorWidget — don't dump.
    if (message.contains('Invalid image data')) {
      debugPrint('Skipped invalid image decode: $message');
      return;
    }
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

  try {
    await _ensureFirebaseInitialized()
        .timeout(const Duration(seconds: 8));
  } catch (e) {
    debugPrint('Firebase init skipped/failed at startup: $e');
  }

  // Register BEFORE runApp (backend requirement for delivery receipts).
  try {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    debugPrint('FCM background handler register failed: $e');
  }

  try {
    await di.diInit().timeout(const Duration(seconds: 12));
    Bloc.observer = MyBlocObserver();
  } catch (e) {
    debugPrint('diInit failed at startup: $e');
  }

  // Load saved language + translations before first frame so splash
  // does not briefly show English keys.
  try {
    await LocalizationService.instance
        .initialize()
        .timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint('Localization init failed at startup: $e');
  }

  // Do NOT await cold-start push capture here. Initializing
  // flutter_local_notifications before runApp can deadlock the iOS
  // main isolate (blank dark splash forever on TestFlight). MyApp
  // already captures cold-start after the first frame.
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

    notificationServices = di.sl<NotificationServices>();
    _localizationBloc = LocalizationBloc();
    _themeBloc = ThemeBloc();

    // Call post frame callback to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotificationServices();
      _initializeDeepLinks();
      // App-wide online for any route (Splash, Home, deep link, etc.).
      _bootstrapChatPresence();
    });
    // Locale is already loaded in main(); sync bloc state immediately
    // (don't wait for first frame or English keys flash on splash).
    _initializeLocalization();
    _initializeTheme();
  }

  void _bootstrapChatPresence() {
    if (!di.sl.isRegistered<ChatRealtimeService>()) return;
    unawaited(di.sl<ChatRealtimeService>().bootstrapFromLocalSession());
  }

  Future<void> _initializeNotificationServices() async {
    // Cold-start capture after first frame — never block UI startup.
    try {
      await notificationServices
          .captureColdStartLaunch()
          .timeout(const Duration(seconds: 6));
    } catch (e) {
      debugPrint('Cold-start capture failed/timed out: $e');
    }
    try {
      await notificationServices.requestNotificationPermissions();
      notificationServices.firebaseInit();
      await notificationServices.getDeviceToken();
    } catch (e) {
      debugPrint('Notification services init failed: $e');
    }
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
                      navigatorObservers: [appRouteObserver],
                      debugShowCheckedModeBanner: false,
                      theme: Themes.lightTheme,
                      darkTheme: Themes.darkTheme,
                      themeMode: themeState is ThemeLoaded
                          ? themeState.themeMode
                          : ThemeMode.system,
                      locale: state is LocalizationLoaded
                          ? state.locale
                          : (LocalizationService.instance.isInitialized
                              ? LocalizationService.instance.currentLocale
                              : const Locale('en')),
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
