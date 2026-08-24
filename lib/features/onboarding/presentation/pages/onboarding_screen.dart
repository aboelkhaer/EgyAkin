import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _introController;
  late final Animation<double> _topFade;
  late final Animation<Offset> _topSlide;
  late final Animation<double> _contentFade;
  late final Animation<double> _bottomFade;
  late final Animation<Offset> _bottomSlide;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _topFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _topSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
      ),
    );
    _contentFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.18, 0.7, curve: Curves.easeOut),
    );
    _bottomFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
    );
    _bottomSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.45, 1.0, curve: Curves.easeOutCubic),
      ),
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
    final cubit = OnboardingCubit.get(context);
    final size = MediaQuery.sizeOf(context);

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
                  top: -90,
                  right: -50,
                  child: IgnorePointer(
                    child: Container(
                      width: 240.w,
                      height: 240.w,
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
                  bottom: 120,
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
                  child: Column(
                    children: [
                      FadeTransition(
                        opacity: _topFade,
                        child: SlideTransition(
                          position: _topSlide,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 36.r,
                                  height: 36.r,
                                  padding: EdgeInsets.all(6.r),
                                  decoration: BoxDecoration(
                                    color: HomeDashboardColors.cardBg(isDark),
                                    borderRadius: BorderRadius.circular(11.r),
                                    border: Border.all(
                                      color: HomeDashboardColors.border(isDark)
                                          .withOpacity(0.8),
                                    ),
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                    color: HomeDashboardColors.title(isDark),
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.signIn);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: primary,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  child: Text(
                                    context.tr(AppStrings.signIn),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FadeTransition(
                          opacity: _contentFade,
                          child: BlocBuilder<OnboardingCubit, OnboardingState>(
                            builder: (context, state) {
                              return CarouselSlider.builder(
                                itemCount: cubit.onboardingList.length,
                                carouselController: cubit.carouselController,
                                itemBuilder: (context, index, pageViewIndex) {
                                  final item = cubit.onboardingList[index];
                                  return _OnboardingPage(
                                    isDark: isDark,
                                    primary: primary,
                                    image: item.image,
                                    title: item.title,
                                    description: item.description,
                                    size: size,
                                  );
                                },
                                options: CarouselOptions(
                                  height: double.infinity,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  onPageChanged: (index, reason) {
                                    cubit.dotsPosition = index;
                                    cubit.changeOnboardingDots();
                                  },
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 700),
                                  autoPlayCurve: Curves.easeOutCubic,
                                  enlargeCenterPage: false,
                                  scrollDirection: Axis.horizontal,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _bottomFade,
                        child: SlideTransition(
                          position: _bottomSlide,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                            child: Column(
                              children: [
                                OnboardingDots(
                                  cubit: cubit,
                                  isDark: isDark,
                                ),
                                SizedBox(height: 18.h),
                                _PrimaryCta(
                                  isDark: isDark,
                                  label: AppStrings.createAccount,
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.register);
                                  },
                                ),
                                SizedBox(height: 10.h),
                                _SecondaryCta(
                                  isDark: isDark,
                                  label: AppStrings.signIn,
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.signIn);
                                  },
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  AppStrings.joinUs,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: HomeDashboardColors.subtitle(isDark),
                                  ),
                                ),
                              ],
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

class _OnboardingPage extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String image;
  final String title;
  final String description;
  final Size size;

  const _OnboardingPage({
    required this.isDark,
    required this.primary,
    required this.image,
    required this.title,
    required this.description,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.32,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: HomeDashboardColors.cardBg(isDark),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: HomeDashboardColors.border(isDark).withOpacity(0.8),
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
              image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
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
    );
  }
}

class _PrimaryCta extends StatelessWidget {
  final bool isDark;
  final String label;
  final VoidCallback onTap;

  const _PrimaryCta({
    required this.isDark,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return SizedBox(
      width: double.infinity,
      height: 46.h,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  Color.lerp(primary, const Color(0xFF1F2937), 0.22)!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(isDark ? 0.35 : 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 22.r,
                    height: 22.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryCta extends StatelessWidget {
  final bool isDark;
  final String label;
  final VoidCallback onTap;

  const _SecondaryCta({
    required this.isDark,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: HomeDashboardColors.title(isDark),
          side: BorderSide(
            color: HomeDashboardColors.border(isDark),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
