import 'dart:convert';
import 'dart:math' as math;

import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../../../exports.dart';
import '../../../../app/services/deep_link_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _pulseController;
  late final AnimationController _orbitController;

  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _wordmarkFade;
  late final Animation<Offset> _wordmarkSlide;
  late final Animation<double> _taglineFade;
  late final Animation<double> _footerFade;

  bool _isUpToDate = true;
  String currentUserVersion = '';
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    debugPrint('=== SPLASH SCREEN: initState called ===');

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _logoFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
      ),
    );
    _wordmarkFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.28, 0.7, curve: Curves.easeOut),
    );
    _wordmarkSlide = Tween<Offset>(
      begin: const Offset(0, 0.28),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.28, 0.72, curve: Curves.easeOutCubic),
      ),
    );
    _taglineFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.48, 0.88, curve: Curves.easeOut),
    );
    _footerFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.62, 1.0, curve: Curves.easeOut),
    );

    _introController.forward();
    _checkConnection();
    checkForUpdates();
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
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
          title: Text(context.tr(AppStrings.updateRequired)),
          content: Text(
            context.tr(AppStrings.aNewVersionIsAvailablePleaseUpdate),
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
                        SnackBar(
                          content: Text(
                            context.tr(AppStrings.couldNotLaunchAppStore),
                          ),
                        ),
                      );
                    }
                  }
                }
              },
              child: Text(context.tr(AppStrings.updateNow)),
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
          _showErrorDialog(
            context.tr(AppStrings.appIsCurrentlyUnavailablePleaseTryLater),
          );
          return;
        }

        if (!_isConnected) return;

        final deepLinkHandler = DeepLinkHandler();
        final hasPendingDeepLink = deepLinkHandler.hasPendingDeepLink();

        if (hasPendingDeepLink) {
          debugPrint(
              'Splash screen: Found pending deep link, navigating to home to process it');
        }

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
        title: Text(context.tr(AppStrings.error)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.tr(AppStrings.ok)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, _) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
            final bg =
                isDark ? const Color(0xFF120F1F) : const Color(0xFFF5F5F7);
            final subtitleColor = isDark
                ? Colors.white.withOpacity(0.72)
                : const Color(0xFF6B7280);
            final mutedColor = isDark
                ? Colors.white.withOpacity(0.55)
                : const Color(0xFF9CA3AF);
            final versionColor = isDark
                ? Colors.white.withOpacity(0.35)
                : const Color(0xFF9CA3AF);
            final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
            final glowColor = primary.withOpacity(isDark ? 0.55 : 0.28);

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value:
                  (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
                      .copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: bg,
                systemNavigationBarIconBrightness:
                    isDark ? Brightness.light : Brightness.dark,
              ),
              child: Scaffold(
                backgroundColor: bg,
                body: BlocListener<SplashCubit, SplashState>(
                  listener: (context, state) => _navigateToNextScreen(),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _SplashAtmosphere(isDark: isDark),
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _orbitController,
                          _pulseController,
                        ]),
                        builder: (context, _) {
                          return CustomPaint(
                            painter: _SplashOrbitsPainter(
                              progress: _orbitController.value,
                              pulse: _pulseController.value,
                              isDark: isDark,
                            ),
                          );
                        },
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Column(
                            children: [
                              const Spacer(flex: 3),
                              FadeTransition(
                                opacity: _logoFade,
                                child: ScaleTransition(
                                  scale: _logoScale,
                                  child: AnimatedBuilder(
                                    animation: _pulseController,
                                    builder: (context, child) {
                                      final glow =
                                          0.14 + (_pulseController.value * 0.08);
                                      return Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: glowColor.withOpacity(glow),
                                              blurRadius: isDark ? 28 : 22,
                                              spreadRadius: 0,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: child,
                                      );
                                    },
                                    child: Image.asset(
                                      AppImages.appIcon,
                                      width: 72.r,
                                      height: 72.r,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 18.h),
                              FadeTransition(
                                opacity: _wordmarkFade,
                                child: SlideTransition(
                                  position: _wordmarkSlide,
                                  child: Container(
                                    width: 36.w,
                                    height: 3.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(99),
                                      gradient: LinearGradient(
                                        colors: isDark
                                            ? const [
                                                Color(0xFF9B82F0),
                                                Color(0xFF6B47E6),
                                              ]
                                            : const [
                                                Color(0xFF8B6FE8),
                                                Color(0xFF6B47E6),
                                              ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              FadeTransition(
                                opacity: _taglineFade,
                                child: Text(
                                  context.tr(
                                    AppStrings
                                        .kidneyCareIntelligenceForClinicalTeams,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    height: 1.45,
                                    fontWeight: FontWeight.w500,
                                    color: subtitleColor,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 4),
                              FadeTransition(
                                opacity: _footerFade,
                                child: Column(
                                  children: [
                                    if (!_isConnected) ...[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14.w,
                                          vertical: 10.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEF4444)
                                              .withOpacity(isDark ? 0.14 : 0.08),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: const Color(0xFFEF4444)
                                                .withOpacity(
                                                    isDark ? 0.35 : 0.25),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.wifi_off_rounded,
                                              size: 16.sp,
                                              color: isDark
                                                  ? const Color(0xFFFCA5A5)
                                                  : const Color(0xFFDC2626),
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              context.tr(
                                                AppStrings.noInternetConnection,
                                              ),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? const Color(0xFFFCA5A5)
                                                    : const Color(0xFFDC2626),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 18.h),
                                    ] else ...[
                                      SizedBox(
                                        width: 22.sp,
                                        height: 22.sp,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            primary,
                                          ),
                                          backgroundColor: primary.withOpacity(
                                            isDark ? 0.18 : 0.12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 14.h),
                                      Text(
                                        context.tr(
                                          AppStrings.preparingYourWorkspace,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: mutedColor,
                                        ),
                                      ),
                                      SizedBox(height: 18.h),
                                    ],
                                    if (currentUserVersion.isNotEmpty)
                                      Text(
                                        'v$currentUserVersion',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.4,
                                          color: versionColor,
                                        ),
                                      ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SplashAtmosphere extends StatelessWidget {
  final bool isDark;

  const _SplashAtmosphere({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final gradientColors = isDark
        ? const [
            Color(0xFF1A1428),
            Color(0xFF120F1F),
            Color(0xFF0E0B18),
          ]
        : const [
            Color(0xFFEDE7FF),
            Color(0xFFF5F5F7),
            Color(0xFFEEF2FF),
          ];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -80,
            right: -60,
            child: _GlowBlob(
              size: 260,
              color: const Color(0xFF6B47E6).withOpacity(isDark ? 0.34 : 0.16),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -70,
            child: _GlowBlob(
              size: 220,
              color: const Color(0xFF3B82F6).withOpacity(isDark ? 0.18 : 0.10),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.38,
            left: -40,
            child: _GlowBlob(
              size: 140,
              color: const Color(0xFF8B5CF6).withOpacity(isDark ? 0.16 : 0.10),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowBlob({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashOrbitsPainter extends CustomPainter {
  final double progress;
  final double pulse;
  final bool isDark;

  _SplashOrbitsPainter({
    required this.progress,
    required this.pulse,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.38);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final ringBase = isDark ? Colors.white : const Color(0xFF6B47E6);
    final dotColor =
        isDark ? const Color(0xFFC4B5FD) : const Color(0xFF6B47E6);

    for (var i = 0; i < 3; i++) {
      final radius = 70.0 + (i * 34) + (pulse * 4);
      paint.color = ringBase.withOpacity(
        isDark ? (0.045 + (i * 0.015)) : (0.08 + (i * 0.02)),
      );
      canvas.drawCircle(center, radius, paint);

      final angle = (progress * math.pi * 2) + (i * 1.7);
      final dot = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      canvas.drawCircle(
        dot,
        2.2,
        Paint()
          ..color = dotColor.withOpacity(
            isDark ? (0.55 - (i * 0.12)) : (0.45 - (i * 0.1)),
          ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SplashOrbitsPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.pulse != pulse ||
        oldDelegate.isDark != isDark;
  }
}
