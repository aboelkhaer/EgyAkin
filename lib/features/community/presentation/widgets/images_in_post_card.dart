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
  final PageController _pageController = PageController();

  @override
  void dispose() {
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
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final w = constraints.maxWidth.isFinite
                                ? constraints.maxWidth
                                : MediaQuery.sizeOf(context).width;
                            return CustomCachedNetworkImage(
                              imageUrl: imageUrl,
                              width: w,
                              height: 180.h,
                              fit: BoxFit.cover,
                              showLoaderPlaceholder: false,
                            );
                          },
                        );
                      },
                    ),
                    if (feed.mediaPath!.length > 1)
                      Positioned(
                        bottom: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.35),
                              width: 0.8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: feed.mediaPath!.length,
                            effect: WormEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.white.withOpacity(0.45),
                              dotHeight: 7,
                              dotWidth: 7,
                              spacing: 6,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}
