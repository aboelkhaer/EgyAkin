import 'injection_container.dart' as di;
import 'exports.dart';

void main() async {
  await GetStorage.init();
  await di.setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      title: 'EgyAkin',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(useMaterial3: true),
      getPages: AppRoutes.routes,
    );
  }
}
