import 'package:egy_akin/exports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesInSinglePost extends StatefulWidget {
  final List<String> mediaPaths;
  final String heroTag;

  const ImagesInSinglePost({
    super.key,
    required this.mediaPaths,
    required this.heroTag,
  });

  @override
  _ImagesInSinglePostState createState() => _ImagesInSinglePostState();
}

class _ImagesInSinglePostState extends State<ImagesInSinglePost> {
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
    return Column(
      children: [
        SizedBox(
          height: 300.h, // Fixed height for the PageView
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Horizontal swipeable list of images
              PageView.builder(
                controller: _pageController, // Use the PageController
                itemCount: widget.mediaPaths.length,
                itemBuilder: (context, index) {
                  final imageUrl = widget.mediaPaths[index];
                  // Ensure the URL is valid and not null
                  if (imageUrl.isEmpty) {
                    return const Placeholder(); // Fallback for invalid URLs
                  }
                  return GestureDetector(
                    onTap: () {
                      navigatorKey.currentState?.push(
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            imageUrl: widget
                                .mediaPaths[index], // Pass the single image URL
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: widget.heroTag,
                      child: CustomCachedNetworkImage(
                        imageUrl: widget.mediaPaths[index],
                        width: double.infinity,
                        height: 300.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              // Page indicator (optional)
              if (widget.mediaPaths.length > 1)
                Positioned(
                  bottom: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w, // Responsive padding
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4), // Background color
                      borderRadius:
                          BorderRadius.circular(20), // Circular background
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
                      count: widget.mediaPaths.length,
                      effect: const WormEffect(
                        activeDotColor: AppColors.primary, // Active dot color
                        dotColor: Colors.grey, // Inactive dots color
                        dotHeight: 5,
                        dotWidth: 5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
