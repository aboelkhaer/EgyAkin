import '../../../exports.dart';

class OnboardingController extends GetxController {
  CarouselController carouselController = CarouselController();
  RxInt dotsPosition = 0.obs;
  PageController dotsController = PageController();

  // late PageController pageController;
  RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    // pageController = PageController();
    super.onInit();
  }

  List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: AppImages.onboarding1,
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDescription1,
    ),
    OnboardingModel(
      image: AppImages.onboarding2,
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDescription2,
    ),
    OnboardingModel(
      image: AppImages.onboarding3,
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDescription3,
    ),
  ];
}
