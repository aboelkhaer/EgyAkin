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
  State<ImagesInSinglePost> createState() => _ImagesInSinglePostState();
}

class _ImagesInSinglePostState extends State<ImagesInSinglePost>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fixed height matching the feed card — animates opacity only so the
    // page transition never fights a layout resize.
    final pageHeight = 180.h;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        return FadeTransition(
          opacity: _fade,
          child: SizedBox(
            height: pageHeight,
            width: width,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.mediaPaths.length,
                  itemBuilder: (context, index) {
                    final imageUrl = widget.mediaPaths[index];
                    if (imageUrl.isEmpty) {
                      return const Placeholder();
                    }

                    return GestureDetector(
                      onTap: () {
                        navigatorKey.currentState?.push(
                          FullScreenImage.route(
                            imageUrls: widget.mediaPaths,
                            initialIndex: index,
                            heroTagBase: widget.heroTag,
                          ),
                        );
                      },
                      child: ColoredBox(
                        color: Colors.black,
                        child: CustomCachedNetworkImage(
                          imageUrl: imageUrl,
                          width: width,
                          height: pageHeight,
                          fit: BoxFit.contain,
                          showLoaderPlaceholder: false,
                        ),
                      ),
                    );
                  },
                ),
                if (widget.mediaPaths.length > 1)
                  Positioned(
                    bottom: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.mediaPaths.length,
                        effect: const WormEffect(
                          activeDotColor: AppColors.primary,
                          dotColor: Colors.grey,
                          dotHeight: 5,
                          dotWidth: 5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
