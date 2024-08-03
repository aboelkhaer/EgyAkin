import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool _isUpToDate = true;
  // NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: AppStrings.splashDelay));
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    sl<NotificationServices>().requestNotificationPermisions();
    sl<NotificationServices>().forgroundMessage();
    sl<NotificationServices>().firebaseInit(context);
    sl<NotificationServices>().setupInteractMessage(context);
    sl<NotificationServices>().getDeviceToken().then((value) {
      debugPrint(value);
    });
    sl<NotificationServices>().isRefreshToken();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> checkForUpdates() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      _checkForAndroidUpdate();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      _checkForiOSUpdate();
    }
  }

  Future<void> _checkForAndroidUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        _isUpToDate = false; // Update available
        if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
        }
      }
    } catch (e) {
      debugPrint('Failed to check for updates on Android: $e');
      _showErrorDialog(
          'Failed to check for updates on Android. Please try again later.');
    }
  }

  Future<void> _checkForiOSUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final bundleId = packageInfo.packageName;

    debugPrint('Current version: $currentVersion');
    debugPrint('Bundle ID: $bundleId');

    try {
      final response = await http
          .get(Uri.parse('https://itunes.apple.com/lookup?bundleId=$bundleId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        debugPrint('API response: $jsonData');

        if (jsonData['resultCount'] > 0 && jsonData['results'].isNotEmpty) {
          final appStoreVersion = jsonData['results'][0]['version'];
          debugPrint('App Store version: $appStoreVersion');

          if (appStoreVersion != currentVersion) {
            _isUpToDate = false; // Update available
            _showUpdateDialog();
          }
        } else {
          debugPrint('No results found in App Store response');
        }
      } else {
        debugPrint('Failed to fetch App Store data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while checking for iOS update: $e');
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Available'),
          backgroundColor: Colors.grey.shade100,
          content: const Text(
              'A new version of the app is available. Please update to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                const url =
                    'https://apps.apple.com/app/id1234567890'; // Replace with your actual App Store ID
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  _showErrorDialog(
                      'Could not launch the App Store. Please try again later.');
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToNextScreen() {
    if (_isUpToDate) {
      final SplashCubit cubit = SplashCubit.get(context);

      cubit.state.maybeWhen(
        loaded: (isAuthentication, isWelcomed, isAppFreeze, isForceUpdate) {
          if (isAppFreeze) {
            return _showErrorDialog(
                'EgyAkin is currently experiencing a technical issue. Please try accessing the application again at a later time.');
          }
          if (isForceUpdate) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              checkForUpdates();
            });
          }
          if (isAuthentication && isWelcomed) {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.home, arguments: 0);
          } else if (isWelcomed) {
            log('welcome true');
            Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
          } else {
            log('welcome false');
            Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
          }
        },
        orElse: () {
          Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
        },
      );
    }
    // If the app is not up-to-date, the update dialog will already be shown
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    animationController.forward();
    // ignore: unused_local_variable
    SplashCubit cubit = SplashCubit.get(context);
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          _navigateToNextScreen();
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FadeTransition(
                opacity: animation,
                child: Image.asset(
                  AppImages.logoForSplash,
                  width: double.infinity,
                  height: 150.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
