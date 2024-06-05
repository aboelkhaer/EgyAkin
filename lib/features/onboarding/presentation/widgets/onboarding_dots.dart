import 'package:egy_akin/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:egy_akin/features/onboarding/presentation/cubit/onboarding_state.dart';

import '../../../../exports.dart';

class OnboardingDots extends StatelessWidget {
  const OnboardingDots({super.key, required this.cubit});
  final OnboardingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cubit.onboardingList.length,
            (index) => Container(
              width: 15,
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: (cubit.dotsPosition == index)
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
        );
      },
    );
  }
}
