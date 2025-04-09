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
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: AppStrings.splashDelay),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    _checkConnection();
    checkForUpdates();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> checkForUpdates() async {
    await getCurrentVersion();
    await sl<AppPreferences>().setData('userAppVersion', currentUserVersion);

    if (!mounted) return;

    if (Theme.of(context).platform == TargetPlatform.android) {
      await _checkForAndroidUpdate();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      await _checkForiOSUpdate();
    }
  }

  Future<void> getCurrentVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() {
        currentUserVersion = packageInfo.version;
      });
    } catch (e) {
      debugPrint('Failed to get package info: $e');
    }
  }

  Future<void> _checkForAndroidUpdate() async {
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (!mounted) return;
        setState(() => _isUpToDate = false);

        if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else {
          _showForceUpdateDialog(isAndroid: true);
        }
      }
    } catch (e) {
      debugPrint('Android update check failed: $e');
    }
  }

  Future<void> _checkForiOSUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final response = await http.get(
        Uri.parse(
            'https://itunes.apple.com/lookup?bundleId=${packageInfo.packageName}'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['resultCount'] > 0) {
          final appStoreVersion =
              _parseVersion(jsonData['results'][0]['version']);
          final currentVersion = _parseVersion(packageInfo.version);
          final appStoreUrl = jsonData['results'][0]['trackViewUrl'];

          if (appStoreVersion != null &&
              currentVersion != null &&
              appStoreVersion > currentVersion) {
            if (!mounted) return;
            setState(() => _isUpToDate = false);
            _showForceUpdateDialog(
              isAndroid: false,
              appStoreUrl: appStoreUrl,
            );
          }
        }
      }
    } catch (e) {
      debugPrint('iOS update check failed: $e');
    }
  }

  Version? _parseVersion(String? versionString) {
    if (versionString == null) return null;
    try {
      return Version.parse(versionString.split('.').take(3).join('.'));
    } catch (e) {
      debugPrint('Version parse error: $e');
      return null;
    }
  }

  void _showForceUpdateDialog({required bool isAndroid, String? appStoreUrl}) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Update Required'),
          content: const Text(
            'A new version is available. Please update to continue using the app.',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (isAndroid) {
                  await InAppUpdate.performImmediateUpdate();
                } else {
                  final url =
                      appStoreUrl ?? 'https://apps.apple.com/app/id6738606085';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Could not launch app store')),
                      );
                    }
                  }
                }
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkConnection() async {
    _isConnected = await InternetConnectionChecker().hasConnection;
    if (mounted) setState(() {});
  }

  void _navigateToNextScreen() {
    if (!_isUpToDate) return;

    final cubit = SplashCubit.get(context);
    cubit.state.maybeWhen(
      loaded: (isAuth, isWelcomed, isAppFreeze, isForceUpdate) {
        if (isAppFreeze) {
          _showErrorDialog('App is currently unavailable. Please try later.');
          return;
        }

        if (!_isConnected) return;

        if (isAuth && isWelcomed) {
          Navigator.pushReplacementNamed(context, AppRoutes.home, arguments: 0);
        } else if (isWelcomed) {
          Navigator.pushReplacementNamed(context, AppRoutes.signIn);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.welcome);
        }
      },
      orElse: () => Navigator.pushReplacementNamed(context, AppRoutes.welcome),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) => _navigateToNextScreen(),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FadeTransition(
                opacity: animation,
                child: Image.asset(
                  'assets/images/splash.png',
                  width: double.infinity,
                  height: 80.h,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),
              if (!_isConnected)
                const Text(
                  'No internet connection',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
