import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
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
      begin: const Offset(0, 0.16),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );
    _cardFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.2, 0.72, curve: Curves.easeOut),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.2, 0.78, curve: Curves.easeOutCubic),
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
          value:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: scaffold,
            body: Stack(
              children: [
                Positioned(
                  top: -80,
                  left: -50,
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
                  bottom: 60,
                  right: -70,
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
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.w, 4.h, 16.w, 0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18.sp,
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                            Text(
                              context.tr(AppStrings.register),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 420.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FadeTransition(
                                    opacity: _heroFade,
                                    child: SlideTransition(
                                      position: _heroSlide,
                                      child: _RegisterHero(
                                        isDark: isDark,
                                        primary: primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 18.h),
                                  FadeTransition(
                                    opacity: _cardFade,
                                    child: SlideTransition(
                                      position: _cardSlide,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                          16.w,
                                          16.h,
                                          16.w,
                                          16.h,
                                        ),
                                        decoration:
                                            HomeDashboardDecor.card(isDark)
                                                .copyWith(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              context.tr(
                                                AppStrings.createYourAccount,
                                              ),
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w800,
                                                color:
                                                    HomeDashboardColors.title(
                                                  isDark,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              context.tr(
                                                AppStrings
                                                    .joinClinicalCollaborationNetwork,
                                              ),
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                color: HomeDashboardColors
                                                    .subtitle(isDark),
                                              ),
                                            ),
                                            SizedBox(height: 14.h),
                                            RegisterForm(
                                              cubit: cubit,
                                              isDark: isDark,
                                            ),
                                            SizedBox(height: 12.h),
                                            _PrivacyAgreementRow(
                                              cubit: cubit,
                                              isDark: isDark,
                                            ),
                                            SizedBox(height: 14.h),
                                            RegisterBotton(
                                              cubit: cubit,
                                              isDark: isDark,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  FadeTransition(
                                    opacity: _footerFade,
                                    child: AlreadyHaveAnAccountLine(
                                      isDark: isDark,
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
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RegisterHero extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _RegisterHero({
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 68.r,
          height: 68.r,
          padding: EdgeInsets.all(11.r),
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(isDark ? 0.28 : 0.16),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Image.asset(
            AppImages.appIcon,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          context.tr(AppStrings.getStarted),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          context.tr(AppStrings.createAccountToCollaborate),
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

class _PrivacyAgreementRow extends StatelessWidget {
  final AuthenticationCubit cubit;
  final bool isDark;

  const _PrivacyAgreementRow({
    required this.cubit,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                cubit.isConfirmationChecked = !cubit.isConfirmationChecked;
                cubit.refreshScreen();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 16,
                height: 16,
                margin: EdgeInsetsDirectional.only(end: 8.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cubit.isConfirmationChecked
                      ? primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(3.5),
                  border: Border.all(
                    color: cubit.isConfirmationChecked
                        ? primary
                        : HomeDashboardColors.border(isDark),
                    width: 1.5,
                  ),
                ),
                child: cubit.isConfirmationChecked
                    ? const Icon(
                        Icons.check_rounded,
                        size: 12,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '${context.tr(AppStrings.iHaveReadAndAgreeToThe)} ',
                    style: TextStyle(
                      fontSize: 10.sp,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchURL(
                        url: 'https://egyakin.com/policy',
                        onError: (error) {
                          showErrorDialog(context, error);
                        },
                      );
                    },
                    child: Text(
                      context.tr(AppStrings.privacyPolicy),
                      style: TextStyle(
                        color: primary,
                        fontSize: 10.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
