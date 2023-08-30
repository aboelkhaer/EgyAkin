import '../../../app/shared_widgets/custom_outline_botton.dart';
import '../../../exports.dart';

class OnbordingScreen extends GetView<OnboardingController> {
  const OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: NoGlow(),
            child: PageView.builder(
              itemCount: controller.onboardingList.length,
              controller: controller.pageController,
              onPageChanged: controller.selectedIndex,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      controller.onboardingList[index].image,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: size.height * 0.45,
                    ),
                    Text(
                      controller.onboardingList[index].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.title,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      controller.onboardingList[index].description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.description,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Positioned(
          //     bottom: size.height * 0.27,
          //     left: 0,
          //     right: 0,
          //     child: const ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20) +
                EdgeInsets.only(bottom: size.height * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const OnboardingDots(),
                SizedBox(
                  height: size.height * 0.07,
                ),
                CustomElevatedButton(
                  size: size,
                  onPressed: () {},
                  title: AppStrings.createAccount,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomOutlineBotton(
                  onPressed: () => Get.offNamed(AppRoutes.signIn),
                  title: AppStrings.signIn,
                  size: size,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Join us',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.description,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
