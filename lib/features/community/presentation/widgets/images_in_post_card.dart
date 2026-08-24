import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../exports.dart';

class ImagesInPostCard extends StatefulWidget {
  final PostCommunityModel feed;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final String showPostFrom;

  const ImagesInPostCard({
    super.key,
    required this.feed,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.showPostFrom,
  });

  @override
  _ImagesInPostCardState createState() => _ImagesInPostCardState();
}

class _ImagesInPostCardState extends State<ImagesInPostCard> {
  // Declare the PageController
  final PageController _pageController = PageController();

  @override
  void dispose() {
    // Dispose the PageController when the widget is removed
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = widget.feed;
    final homeDataModel = widget.homeDataModel;
    final currentDoctorModel = widget.currentDoctorModel;

    return feed.mediaPath == null || feed.mediaPath!.isEmpty
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () {
              navigatorKey.currentState?.pushNamed(
                AppRoutes.showSingleFeed,
                arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                  homeDataModel: homeDataModel,
                  currentDoctorModel: currentDoctorModel,
                  feed: feed,
                  isComeFromNotification: false,
                  feedId: '',
                  showPostFrom: widget.showPostFrom,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Hero(
                tag: feed.id.toString(),
                child: SizedBox(
                  height: 180.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: feed.mediaPath!.length,
                        itemBuilder: (context, index) {
                          final imageUrl = feed.mediaPath![index];
                          if (imageUrl.isEmpty) {
                            return const Placeholder();
                          }
                          return CustomCachedNetworkImage(
                            imageUrl: imageUrl,
                            width: double.infinity,
                            height: 180.h,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 12.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                context.tr(AppStrings.figure),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (feed.mediaPath!.length > 1)
                        Positioned(
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 6,
                              right: 6,
                              top: 4,
                              bottom: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: feed.mediaPath!.length,
                              effect: WormEffect(
                                activeDotColor: AppColors.primary,
                                dotColor: Colors.grey.shade400,
                                dotHeight: 6,
                                dotWidth: 6,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
