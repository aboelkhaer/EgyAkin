import 'package:egy_akin/exports.dart';

class PostsSliderAndDots extends StatelessWidget {
  final HomeCubit cubit;
  final bool isDarkMode;
  const PostsSliderAndDots({
    super.key,
    required this.cubit,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return SizedBox(
                  height: size.height * 0.2,
                  child: Lottie.asset(AppImages.imageLoader),
                );
              },
              loaded: (
                homeData,
                dotsPosition,
                notificationData,
                homeIndex,
                isUploadingSyndicateCard,
                isUploadedSyndicateCard,
                message,
                checkUpdateMessageCounter,
                isUserBlocked,
                changesCounter,
              ) {
                if (homeData.data!.feeds == null) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: [
                    SizedBox(height: 13.h),
                    FadeIn(
                      duration: const Duration(seconds: 2),
                      child: homeData.data!.feeds!.isEmpty
                          ? const SizedBox.shrink()
                          : CarouselSlider.builder(
                              itemCount: homeData.data!.feeds!.length,
                              carouselController: cubit.carouselController,
                              itemBuilder: (BuildContext context, int index,
                                  int pageViewIndex) {
                                return checkPostType(
                                  cubit: cubit,
                                  postModel: homeData.data!.feeds![index],
                                  isDarkMode: isDarkMode,
                                );
                              },
                              options: CarouselOptions(
                                height: 150.h,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll:
                                    homeData.data!.feeds!.length <= 1
                                        ? false
                                        : true,
                                reverse: false,
                                onPageChanged: (index, reason) {
                                  cubit.dotsPosition = index;
                                  cubit.changeDotsPositions();
                                },
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: false,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                    ),
                    SizedBox(height: 7.h),
                  ],
                );
              },
            );
          },
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
              loaded: (
                homeData,
                dotsPosition,
                notificationData,
                homeIndex,
                isUploadingSyndicateCard,
                isUploadedSyndicateCard,
                message,
                checkUpdateMessageCounter,
                isUserBlocked,
                changesCounter,
              ) {
                return homeData.data!.feeds == null ||
                        homeData.data!.feeds!.isEmpty
                    ? const SizedBox.shrink()
                    : DotsIndicator(
                        dotsCount: homeData.data!.feeds!.length,
                        position: cubit.dotsPosition,
                        decorator: DotsDecorator(
                          activeColor: isDarkMode
                              ? AppColors.darkPrimary.withOpacity(0.6)
                              : AppColors.primary.withOpacity(0.6),
                          color: isDarkMode
                              ? Colors.grey.shade600
                              : Colors.grey.shade300,
                          size: const Size(5, 5),
                        ),
                      );
              },
            );
          },
        ),
      ],
    );
  }
}

Widget checkPostType(
    {required HomeCubit cubit,
    required PostCommunityModel postModel,
    required bool isDarkMode}) {
  return PostType(
    cubit: cubit,
    postModel: postModel,
    isDarkMode: isDarkMode,
  );
}
