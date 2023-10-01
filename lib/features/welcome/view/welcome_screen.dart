import '../../../exports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => WelcomeController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  AppStrings.welcomeTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                const Text(
                  AppStrings.welcomeDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.description,
                  ),
                ),
              ],
            ),
            Image.asset(
              AppImages.welcomeImage,
              width: double.infinity,
              height: size.height * 0.4,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      size: size,
                      onPressed: () => Get.offAllNamed(AppRoutes.onboarding),
                      title: AppStrings.getStarted,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                const Text(
                  'You can start right away',
                  style: TextStyle(
                    color: AppColors.description,
                  ),
                ),
                SizedBox(height: size.height * 0.06),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
