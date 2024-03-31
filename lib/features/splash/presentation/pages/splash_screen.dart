import 'dart:developer';

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
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: AppStrings.splashDelay));
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    // ignore: unused_local_variable
    SplashCubit cubit = SplashCubit.get(context);
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (isAuthentication, isWelcomed) {
              if (isAuthentication && isWelcomed) {
                return Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.home);
              }
              if (isWelcomed) {
                log('welcome true');
                return Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.signIn);
              }

              log('welcome false');
              return Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.welcome);
            },
            orElse: () {
              return Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.welcome);
            },
          );
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
                  AppImages.fullBlackLogo,
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
