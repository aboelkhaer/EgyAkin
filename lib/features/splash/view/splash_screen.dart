import '../../../exports.dart';

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
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () async {
        String? token =
            await GetStorageLib().getString(AppLocalStrings.keyToken);
        if (token != null && token != '') {
          Get.offNamed(AppRoutes.home);
        } else {
          Get.offNamed(AppRoutes.welcome);
        }
      });
    });

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: AppColors.primary,
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FadeTransition(
        opacity: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const SizedBox(
            //   height: 20,
            //   width: 20,
            //   child: CircularProgressIndicator(
            //     color: AppColors.primary,
            //   ),
            // ),
            Image.asset(
              AppImages.fullBlackLogo,
              width: double.infinity,
              height: size.height * 0.3,
              fit: BoxFit.contain,
              // color: AppColors.primary,
            ),
            SizedBox(height: size.height * 0.1),
            // const Text(
            //   AppStrings.appName,
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 25,
            //     color: AppColors.white,
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}
