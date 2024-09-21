import '../../../../exports.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState.changed(0));
  static OnboardingCubit get(context) => BlocProvider.of(context);

  CarouselSliderController carouselController = CarouselSliderController();
  int dotsPosition = 0;
  PageController dotsController = PageController();

  changeOnboardingDots() {
    emit(OnboardingState.changed(dotsPosition));
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
