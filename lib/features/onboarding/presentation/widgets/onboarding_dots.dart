import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class OnboardingDots extends StatelessWidget {
  const OnboardingDots({
    super.key,
    required this.cubit,
    required this.isDark,
  });

  final OnboardingCubit cubit;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cubit.onboardingList.length,
            (index) {
              final active = cubit.dotsPosition == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                width: active ? 22.w : 7.w,
                height: 7.h,
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: active
                      ? primary
                      : HomeDashboardColors.border(isDark).withOpacity(0.9),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
