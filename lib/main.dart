import 'package:egy_akin/exports.dart';
import 'package:egy_akin/injection_container.dart' as di;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

  @override
  void initState() {
    super.initState();

    notificationServices = NotificationServices();

    // Call post frame callback to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotificationServices();
    });
  }

  Future<void> _initializeNotificationServices() async {
    await notificationServices.requestNotificationPermissions();
    notificationServices.firebaseInit(navigatorKey.currentContext!);
    await notificationServices.getDeviceToken();
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
          onGenerateRoute: RouteGenerator.getRoute,
        ),
      ),
    );
  }
}
