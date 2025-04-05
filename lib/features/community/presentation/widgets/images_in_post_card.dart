import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../exports.dart';

class ImagesInPostCard extends StatefulWidget {
  final PostCommunityModel feed;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;

  const ImagesInPostCard({
    super.key,
    required this.feed,
    required this.homeDataModel,
    required this.currentDoctorModel,
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
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Hero(
                tag: feed.id.toString(),
                child: SizedBox(
                  height: 150.h, // Fixed height for the PageView
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Horizontal swipeable list of images
                      PageView.builder(
                        controller: _pageController, // Use the PageController
                        itemCount: feed.mediaPath!.length,
                        itemBuilder: (context, index) {
                          final imageUrl = feed.mediaPath![index];
                          // Ensure the URL is valid and not null
                          if (imageUrl.isEmpty) {
                            return const Placeholder(); // Fallback for invalid URLs
                          }
                          return CustomCachedNetworkImage(
                            imageUrl: imageUrl,
                            width: double.infinity,
                            height: 150.h,
                            fit: BoxFit.cover,
                          );
                        },
                      ),

                      // Page indicator (optional)
                      if (feed.mediaPath!.length > 1)
                        Positioned(
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 6,
                              right: 6,
                              top: 4,
                              bottom: 4,
                            ), // Add some padding around the indicator
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                  0.4), // Semi-transparent black background
                              borderRadius: BorderRadius.circular(
                                  20), // Circular background
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 9,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: SmoothPageIndicator(
                              controller:
                                  _pageController, // Use the same PageController
                              count: feed.mediaPath!.length,
                              effect: WormEffect(
                                activeDotColor: AppColors
                                    .primary, // Color of the active dot
                                dotColor: Colors.grey
                                    .shade400, // Color of the inactive dots
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
