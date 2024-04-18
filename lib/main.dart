import 'exports.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.diInit();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: AppStrings.appName,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: Themes().lightTheme,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
