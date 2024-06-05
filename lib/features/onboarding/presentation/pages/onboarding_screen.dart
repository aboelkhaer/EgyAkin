import '../../../../exports.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = OnboardingCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return CarouselSlider.builder(
                itemCount: cubit.onboardingList.length,
                carouselController: cubit.carouselController,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  return Container(
                    width: size.width * 0.8,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          cubit.onboardingList[index].image,
                          width: size.width,
                          height: size.height * 0.35,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          cubit.onboardingList[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.title,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          cubit.onboardingList[index].description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: AppColors.description,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.22),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: size.height,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  onPageChanged: (index, reason) {
                    cubit.dotsPosition = index;
                    // if (cubit.dotsController.hasClients) {
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     if (cubit.dotsController.hasClients) {
                    //       // cubit.dotsController.jumpToPage(index);
                    //     }
                    //   });
                    // }
                    cubit.changeOnboardingDots();
                  },
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 600),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20) +
                EdgeInsets.only(bottom: size.height * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OnboardingDots(
                  cubit: cubit,
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.register);
                    },
                    title: AppStrings.createAccount,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomOutlineBotton(
                    onPressed: () {
                      // Get.offNamed(AppRoutes.signIn)
                      Navigator.of(context).pushNamed(AppRoutes.signIn);
                    },
                    title: AppStrings.signIn,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  AppStrings.joinUs,
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
