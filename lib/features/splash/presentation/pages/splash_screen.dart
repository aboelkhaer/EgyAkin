import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

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
    _checkConnection();

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
          // Force an immediate update
          await InAppUpdate.performImmediateUpdate();
        } else {
          // Immediate update not allowed, show custom force update dialog
          _showForceUpdateDialog();
        }
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Failed to check for updates on Android: $e');
      }
    }
  }

  Future<void> _checkForiOSUpdate() async {
    debugPrint('Starting iOS update check...');

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(packageInfo.version);
    final bundleId = packageInfo.packageName;

    debugPrint('Current version: $currentVersion');
    debugPrint('Bundle ID: $bundleId');

    if (!mounted) return;

    setState(() {
      currentUserVersion = packageInfo.version;
    });

    try {
      final response = await http.get(
        Uri.parse(ApiEndPoint.baseUrl == 'https://api.egyakin.com'
            ? 'https://itunes.apple.com/lookup?bundleId=$bundleId'
            : ''),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        debugPrint('Decoded JSON: $jsonData');

        if (jsonData['resultCount'] > 0 && jsonData['results'].isNotEmpty) {
          final appStoreVersion =
              Version.parse(jsonData['results'][0]['version']);
          debugPrint('App Store version: $appStoreVersion');

          if (appStoreVersion > currentVersion) {
            debugPrint('App is outdated. Showing update dialog...');
            if (mounted) {
              setState(() {
                _isUpToDate = false;
              });
            }
            _showForceUpdateDialog();
          } else {
            debugPrint('App is up-to-date.');
            if (mounted) {
              setState(() {
                _isUpToDate = true;
              });
            }
          }
        } else {
          debugPrint('No results found in the App Store.');
        }
      } else {
        debugPrint(
            'Failed to fetch App Store data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while checking for iOS update: $e');
    }

    debugPrint('Finished iOS update check.');
  }

  void _showForceUpdateDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (BuildContext context) {
        return PopScope(
          onPopInvokedWithResult: (bool success, dynamic result) {
            // Prevent the dialog from being dismissed
          },
          child: AlertDialog(
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
                        'https://apps.apple.com/eg/app/egyakin/id6738606085'; // Replace with your App Store URL
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
          ),
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

  bool _isConnected = true;
  Future<void> _checkConnection() async {
    _isConnected = await InternetConnectionChecker().hasConnection;
    setState(() {}); // Update the UI based on connection status
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_isConnected)
                    const Text(
                      'Check your connection and try again later.',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
