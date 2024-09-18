import 'package:egy_akin/exports.dart';

class PostsSliderAndDots extends StatelessWidget {
  final HomeCubit cubit;
  const PostsSliderAndDots({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 13.h),
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
              ) {
                return FadeIn(
                  duration: const Duration(seconds: 2),
                  child: CarouselSlider.builder(
                    itemCount: homeData.data!.posts!.length,
                    carouselController: cubit.carouselController,
                    itemBuilder:
                        (BuildContext context, int index, int pageViewIndex) {
                      return checkPostType(
                        cubit: cubit,
                        postModel: homeData.data!.posts![index],
                      );
                    },
                    options: CarouselOptions(
                      height: 150.h,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll:
                          homeData.data!.posts!.length <= 1 ? false : true,
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
                );
              },
            );
          },
        ),
        SizedBox(height: 7.h),
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
              ) {
                return homeData.data!.posts!.isEmpty
                    ? const SizedBox.shrink()
                    : DotsIndicator(
                        dotsCount: homeData.data!.posts!.length,
                        position: cubit.dotsPosition,
                        decorator: DotsDecorator(
                          activeColor: AppColors.primary.withOpacity(0.6),
                          color: Colors.grey.shade300,
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

Widget checkPostType({required HomeCubit cubit, required PostModel postModel}) {
  switch (postModel.postType) {
    case 'webinar':
      return WebinarType(
        cubit: cubit,
        postModel: postModel,
      );
    case 'article':
      return PostType(
        cubit: cubit,
        postModel: postModel,
      );
    case 'post':
      return PostType(
        cubit: cubit,
        postModel: postModel,
      );

    default:
      return const Center(
          child: Text(
        AppStrings.somethingWentWrong,
        style: TextStyle(color: AppColors.title),
      ));
  }
}
