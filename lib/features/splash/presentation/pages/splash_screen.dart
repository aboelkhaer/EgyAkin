import 'package:egy_akin/app/shared/functions/force_update_dialog.dart';
import 'package:egy_akin/app/shared/functions/store_version_lookup.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../../../exports.dart';
import '../../../../app/services/deep_link_handler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:math' as math;

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

  String currentUserVersion = '';
  bool _isConnected = true;

  bool _settingsReady = false;
  bool _updateCheckDone = false;
  bool _forceUpdateRequired = false;
  bool _forceUpdateDialogShown = false;
  bool _appFreeze = false;
  bool _appFreezeDialogShown = false;
  bool _hasNavigated = false;
  String? _storeUrl;
  String? _latestStoreVersion;

  bool? _isAuth;
  bool? _isWelcomed;

  @override
  void initState() {
    super.initState();
    debugPrint('=== SPLASH SCREEN: initState called ===');

    // Drop the native splash once Flutter splash is on screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

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
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await _checkConnection();
    await checkForUpdates();
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
    if (currentUserVersion.isNotEmpty) {
      await sl<AppPreferences>().setData('userAppVersion', currentUserVersion);
    }

    if (!mounted) return;

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        await _checkForAndroidUpdate();
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        await _checkForiOSUpdate();
      }
    } finally {
      if (mounted) {
        _updateCheckDone = true;
        await _tryProceed();
      }
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
      final storeInfo = await StoreVersionLookup.fetch(isAndroid: true);
      if (storeInfo != null) {
        _latestStoreVersion = storeInfo.version;
        _storeUrl = storeInfo.storeUrl;
      } else {
        _storeUrl = kAndroidPlayStoreUrl;
      }

      // Prefer semver compare against the live Play Store version name.
      // Play's in-app update flag alone is not enough (can disagree with versionName).
      _forceUpdateRequired = _isStoreNewerThanCurrent();
    } catch (e) {
      // Debug / sideload builds often fail Play update checks — that's OK.
      debugPrint('Android update check failed: $e');
    }
  }

  Future<void> _checkForiOSUpdate() async {
    try {
      final storeInfo = await StoreVersionLookup.fetch(isAndroid: false);
      if (storeInfo == null) return;

      _latestStoreVersion = storeInfo.version;
      _storeUrl = storeInfo.storeUrl;
      _forceUpdateRequired = _isStoreNewerThanCurrent();
    } catch (e) {
      debugPrint('iOS update check failed: $e');
    }
  }

  Version? _parseVersion(String? versionString) {
    if (versionString == null || versionString.trim().isEmpty) return null;
    try {
      return Version.parse(versionString.split('.').take(3).join('.'));
    } catch (e) {
      debugPrint('Version parse error: $e');
      return null;
    }
  }

  /// True only when the store marketing version is strictly greater than installed.
  bool _isStoreNewerThanCurrent() {
    final current = _parseVersion(currentUserVersion);
    final store = _parseVersion(_latestStoreVersion);
    if (current == null || store == null) return false;
    return store > current;
  }

  Future<void> _ensureStoreVersionLoaded({required bool isAndroid}) async {
    if ((_latestStoreVersion ?? '').isNotEmpty) return;
    final storeInfo = await StoreVersionLookup.fetch(isAndroid: isAndroid);
    if (storeInfo == null) return;
    _latestStoreVersion = storeInfo.version;
    _storeUrl ??= storeInfo.storeUrl;
  }

  Future<void> _showForceUpdateIfNeeded() async {
    if (!mounted || _forceUpdateDialogShown) return;

    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    await _ensureStoreVersionLoaded(isAndroid: isAndroid);
    if (!mounted) return;

    // Never block users when their installed version is already >= store.
    if (!_isStoreNewerThanCurrent()) {
      _forceUpdateRequired = false;
      await _navigateToNextScreen();
      return;
    }

    _forceUpdateDialogShown = true;
    await showForceUpdateDialog(
      context: context,
      isAndroid: isAndroid,
      storeUrl: _storeUrl,
      currentVersion: currentUserVersion,
      latestVersion: _latestStoreVersion,
      onAndroidInAppUpdate: isAndroid
          ? () async {
              final result = await InAppUpdate.performImmediateUpdate();
              if (result == AppUpdateResult.success) return;
              throw StateError('In-app update result: $result');
            }
          : null,
    );
  }

  Future<void> _checkConnection() async {
    _isConnected = await InternetConnectionChecker().hasConnection;
    if (mounted) setState(() {});
  }

  Future<void> _onSplashLoaded({
    required bool isAuth,
    required bool isWelcomed,
    required bool isAppFreeze,
    required bool isForceUpdate,
  }) async {
    _isAuth = isAuth;
    _isWelcomed = isWelcomed;
    _appFreeze = isAppFreeze;

    // Backend force_update only applies when the store version is actually newer.
    if (isForceUpdate) {
      _storeUrl ??= Theme.of(context).platform == TargetPlatform.android
          ? kAndroidPlayStoreUrl
          : kIosAppStoreUrl;
      final isAndroid = Theme.of(context).platform == TargetPlatform.android;
      await _ensureStoreVersionLoaded(isAndroid: isAndroid);
      _forceUpdateRequired = _isStoreNewerThanCurrent();
    }

    _settingsReady = true;
    await _tryProceed();
  }

  Future<void> _tryProceed() async {
    if (!mounted || _hasNavigated) return;
    if (!_settingsReady || !_updateCheckDone) return;

    if (_appFreeze) {
      if (!_appFreezeDialogShown) {
        _appFreezeDialogShown = true;
        _showErrorDialog(
          context.tr(AppStrings.appIsCurrentlyUnavailablePleaseTryLater),
        );
      }
      return;
    }

    // Final guard: only force update when store > current.
    if (_forceUpdateRequired && !_isStoreNewerThanCurrent()) {
      _forceUpdateRequired = false;
    }

    if (_forceUpdateRequired) {
      await _showForceUpdateIfNeeded();
      return;
    }

    await _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    if (!mounted || _hasNavigated || _forceUpdateRequired || _appFreeze) {
      return;
    }
    if (!_isConnected) return;

    final isAuth = _isAuth ?? false;
    final isWelcomed = _isWelcomed ?? false;
    _hasNavigated = true;

    final deepLinkHandler = DeepLinkHandler();
    final hasPendingDeepLink = deepLinkHandler.hasPendingDeepLink();
    final inviteToken =
        await deepLinkHandler.getPendingInviteToken(clear: false);

    if (!mounted) return;

    if (hasPendingDeepLink) {
      debugPrint(
        'Splash screen: Found pending deep link, navigating to home to process it',
      );
    }

    if (inviteToken != null && inviteToken.isNotEmpty) {
      if (isAuth) {
        debugPrint(
          'Splash: invite link while logged in — show message on home',
        );
        await sl<AppPreferences>().setData(
          AppLocalStrings.pendingInviteConsultationId,
          '__logged_in_invite__',
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
          arguments: 0,
        );
        return;
      }
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.register);
      return;
    }

    if (isAuth && isWelcomed) {
      Navigator.pushReplacementNamed(context, AppRoutes.home, arguments: 0);
    } else if (isWelcomed) {
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.welcome);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(context.tr(AppStrings.error)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.tr(AppStrings.ok)),
            ),
          ],
        ),
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
                  listener: (context, state) {
                    state.maybeWhen(
                      loaded:
                          (isAuth, isWelcomed, isAppFreeze, isForceUpdate) {
                        _onSplashLoaded(
                          isAuth: isAuth,
                          isWelcomed: isWelcomed,
                          isAppFreeze: isAppFreeze,
                          isForceUpdate: isForceUpdate,
                        );
                      },
                      orElse: () {},
                    );
                  },
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
