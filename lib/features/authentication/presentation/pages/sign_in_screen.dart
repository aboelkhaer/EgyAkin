import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';
import '../widgets/social_login_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _introController;
  late final Animation<double> _heroFade;
  late final Animation<Offset> _heroSlide;
  late final Animation<double> _cardFade;
  late final Animation<Offset> _cardSlide;
  late final Animation<double> _footerFade;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _heroFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );
    _heroSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );
    _cardFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.22, 0.72, curve: Curves.easeOut),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.22, 0.78, curve: Curves.easeOutCubic),
      ),
    );
    _footerFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
    );

    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AuthenticationCubit.get(context);

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
                  top: -80,
                  right: -40,
                  child: IgnorePointer(
                    child: Container(
                      width: 220.w,
                      height: 220.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            primary.withOpacity(isDark ? 0.22 : 0.14),
                            primary.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: -70,
                  child: IgnorePointer(
                    child: Container(
                      width: 200.w,
                      height: 200.w,
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
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 420.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FadeTransition(
                              opacity: _heroFade,
                              child: SlideTransition(
                                position: _heroSlide,
                                child: _SignInHero(
                                  isDark: isDark,
                                  primary: primary,
                                ),
                              ),
                            ),
                            SizedBox(height: 22.h),
                            FadeTransition(
                              opacity: _cardFade,
                              child: SlideTransition(
                                position: _cardSlide,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                    16.w,
                                    18.h,
                                    16.w,
                                    16.h,
                                  ),
                                  decoration: HomeDashboardDecor.card(isDark)
                                      .copyWith(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        context.tr(AppStrings.signIn),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w800,
                                          color: HomeDashboardColors.title(
                                            isDark,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        context.tr(
                                          AppStrings.accessYourClinicalWorkspace,
                                        ),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: HomeDashboardColors.subtitle(
                                            isDark,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      SignInForm(
                                        cubit: cubit,
                                        isDark: isDark,
                                      ),
                                      SizedBox(height: 16.h),
                                      SignInBotton(
                                        cubit: cubit,
                                        isDark: isDark,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            FadeTransition(
                              opacity: _footerFade,
                              child: Column(
                                children: [
                                  SocialLoginButtons(isDark: isDark),
                                  SizedBox(height: 18.h),
                                  DontHaveAnAccountLine(isDark: isDark),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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

class _SignInHero extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _SignInHero({
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72.r,
          height: 72.r,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(isDark ? 0.28 : 0.16),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset(
            AppImages.appIcon,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          context.tr(AppStrings.welcomeBack),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          context.tr(AppStrings.signInToContinueCollaborating),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            height: 1.4,
            fontWeight: FontWeight.w500,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
      ],
    );
  }
}
