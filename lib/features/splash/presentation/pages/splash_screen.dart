import 'dart:convert';
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
  String currentUserVersion = '';

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: AppStrings.splashDelay));
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    // Perform check for updates
    checkForUpdates();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> checkForUpdates() async {
    await getCurrentVersion(); // Ensure version is fetched before update check
    await sl<AppPreferences>().setData('userAppVersion', currentUserVersion);

    if (!mounted) return; // Check if widget is still mounted before continuing

    if (Theme.of(context).platform == TargetPlatform.android) {
      await _checkForAndroidUpdate();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      await _checkForiOSUpdate();
    }
  }

  Future<void> getCurrentVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (!mounted) return; // Avoid calling setState if widget is not mounted
      setState(() {
        currentUserVersion = packageInfo.version;
      });
    } catch (e) {
      debugPrint('Failed to get package info: $e');
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
          _showForceUpdateDialog(); // Show the forced update dialog
        }
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Failed to check for updates on Android: $e');
        // _showErrorDialog(
        //     'Failed to check for updates on Android. Please try again later.');
      }
    }
  }

  Future<void> _checkForiOSUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final bundleId = packageInfo.packageName;

    if (!mounted) return;
    setState(() {
      currentUserVersion = currentVersion;
    });

    try {
      final response = await http
          .get(Uri.parse('https://itunes.apple.com/lookup?bundleId=$bundleId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['resultCount'] > 0 && jsonData['results'].isNotEmpty) {
          final appStoreVersion = jsonData['results'][0]['version'];

          if (appStoreVersion != currentVersion) {
            _isUpToDate = false;
            _showForceUpdateDialog();
          }
        }
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error occurred while checking for iOS update: $e');
      }
    }
  }

  void _showForceUpdateDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mandatory Update'),
          content: const Text(
              'A new version of the app is available. You must update to continue using it.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (Theme.of(context).platform == TargetPlatform.android) {
                  await InAppUpdate.completeFlexibleUpdate();
                } else if (Theme.of(context).platform == TargetPlatform.iOS) {
                  const url =
                      'https://apps.apple.com/app/id1234567890'; // Replace with your App Store URL
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    _showErrorDialog(
                        'Could not launch the App Store. Please try again later.');
                  }
                }
              },
              child: const Text('Update Now'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
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
            Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
          }
        },
        orElse: () {
          Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
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
