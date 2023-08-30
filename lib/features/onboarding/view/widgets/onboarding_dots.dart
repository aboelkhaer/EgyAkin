import '../../../../exports.dart';

class OnboardingDots extends GetView<OnboardingController> {
  const OnboardingDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.onboardingList.length,
        (index) => Obx(
          () => Container(
            width: 15,
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: (controller.selectedIndex.value == index)
                ? const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.primary,
                  )
                : BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
