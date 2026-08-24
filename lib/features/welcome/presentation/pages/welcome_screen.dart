import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _pulseController;

  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _imageFade;
  late final Animation<Offset> _imageSlide;
  late final Animation<double> _ctaFade;
  late final Animation<Offset> _ctaSlide;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _logoFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.84, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutBack),
      ),
    );
    _titleFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.2, 0.55, curve: Curves.easeOut),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.22),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.2, 0.58, curve: Curves.easeOutCubic),
      ),
    );
    _imageFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.35, 0.75, curve: Curves.easeOut),
    );
    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.35, 0.78, curve: Curves.easeOutCubic),
      ),
    );
    _ctaFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
    );
    _ctaSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = WelcomeCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: scaffold,
            body: Stack(
              children: [
                Positioned(
                  top: -100,
                  right: -60,
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, _) {
                        final t = _pulseController.value;
                        return Container(
                          width: (240 + 20 * t).w,
                          height: (240 + 20 * t).w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                primary.withOpacity(
                                  (isDark ? 0.2 : 0.13) * (0.75 + 0.25 * t),
                                ),
                                primary.withOpacity(0),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: -80,
                  child: IgnorePointer(
                    child: Container(
                      width: 220.w,
                      height: 220.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            primary.withOpacity(isDark ? 0.12 : 0.08),
                            primary.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 20.h),
                    child: Column(
                      children: [
                        FadeTransition(
                          opacity: _logoFade,
                          child: ScaleTransition(
                            scale: _logoScale,
                            child: Row(
                              children: [
                                Container(
                                  width: 42.r,
                                  height: 42.r,
                                  padding: EdgeInsets.all(7.r),
                                  decoration: BoxDecoration(
                                    color: HomeDashboardColors.cardBg(isDark),
                                    borderRadius: BorderRadius.circular(13.r),
                                    border: Border.all(
                                      color: HomeDashboardColors.border(isDark)
                                          .withOpacity(0.8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary.withOpacity(
                                          isDark ? 0.25 : 0.14,
                                        ),
                                        blurRadius: 14,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    AppImages.appIcon,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'EgyAkin',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                    color: HomeDashboardColors.title(isDark),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(flex: 2),
                        FadeTransition(
                          opacity: _titleFade,
                          child: SlideTransition(
                            position: _titleSlide,
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.welcomeTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.4,
                                    color: HomeDashboardColors.title(isDark),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  AppStrings.welcomeDescription,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    height: 1.45,
                                    fontWeight: FontWeight.w500,
                                    color: HomeDashboardColors.subtitle(isDark),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        FadeTransition(
                          opacity: _imageFade,
                          child: SlideTransition(
                            position: _imageSlide,
                            child: Container(
                              width: double.infinity,
                              height: 240.h,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: HomeDashboardColors.cardBg(isDark),
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(
                                  color: HomeDashboardColors.border(isDark)
                                      .withOpacity(0.8),
                                ),
                                boxShadow: isDark
                                    ? null
                                    : [
                                        BoxShadow(
                                          color: primary.withOpacity(0.08),
                                          blurRadius: 24,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                              ),
                              child: Image.asset(
                                AppImages.welcomeImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 3),
                        FadeTransition(
                          opacity: _ctaFade,
                          child: SlideTransition(
                            position: _ctaSlide,
                            child: Column(
                              children: [
                                WeclomeBotton(
                                  cubit: cubit,
                                  isDark: isDark,
                                ),
                                SizedBox(height: 12.h),
                                YouCanStartRightAwayLine(isDark: isDark),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
