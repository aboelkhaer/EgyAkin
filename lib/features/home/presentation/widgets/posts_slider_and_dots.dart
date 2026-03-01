import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/exports.dart';

class PostsSliderAndDots extends StatefulWidget {
  final HomeCubit cubit;
  final bool isDarkMode;
  const PostsSliderAndDots({
    super.key,
    required this.cubit,
    required this.isDarkMode,
  });

  @override
  State<PostsSliderAndDots> createState() => _PostsSliderAndDotsState();
}

class _PostsSliderAndDotsState extends State<PostsSliderAndDots> {
  @override
  void initState() {
    super.initState();
    // Ensure permission cache is loaded so canPermission returns correct value
    PermissionHelper.refreshPermissions().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Show slider only when we have permission and state is loaded
        final hasPermission =
            PermissionHelper.canPermission(AppPermissions.viewHomeSlider);
        if (!hasPermission) return const SizedBox.shrink();

        return state.maybeWhen(
          orElse: () {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Lottie.asset(AppImages.imageLoader),
            );
          },
          loaded: (
            homeData,
            currentDoctorModel,
            dotsPosition,
            homeIndex,
            isUploadingSyndicateCard,
            isUploadedSyndicateCard,
            message,
            checkUpdateMessageCounter,
            isUserBlocked,
            changesCounter,
          ) {
            final feeds = homeData.data?.feeds;
            if (feeds == null || feeds.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                SizedBox(height: 13.h),
                FadeIn(
                  duration: const Duration(seconds: 2),
                  child: CarouselSlider.builder(
                    itemCount: feeds.length,
                    carouselController: widget.cubit.carouselController,
                    itemBuilder:
                        (BuildContext context, int index, int pageViewIndex) {
                      return checkPostType(
                        cubit: widget.cubit,
                        postModel: feeds[index],
                        isDarkMode: widget.isDarkMode,
                      );
                    },
                    options: CarouselOptions(
                      height: 150.h,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: feeds.length <= 1 ? false : true,
                      reverse: false,
                      onPageChanged: (index, reason) {
                        widget.cubit.dotsPosition = index;
                        widget.cubit.changeDotsPositions();
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
                DotsIndicator(
                  dotsCount: feeds.length,
                  position: widget.cubit.dotsPosition,
                  decorator: DotsDecorator(
                    activeColor: widget.isDarkMode
                        ? AppColors.darkPrimary.withOpacity(0.6)
                        : AppColors.primary.withOpacity(0.6),
                    color: widget.isDarkMode
                        ? Colors.grey.shade600
                        : Colors.grey.shade300,
                    size: const Size(5, 5),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Widget checkPostType({
  required HomeCubit cubit,
  required PostCommunityModel postModel,
  required bool isDarkMode,
}) {
  return PostType(
    cubit: cubit,
    postModel: postModel,
    isDarkMode: isDarkMode,
  );
}
