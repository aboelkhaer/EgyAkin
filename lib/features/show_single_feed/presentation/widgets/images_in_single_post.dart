import 'dart:math' as math;

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

class _ImagesInSinglePostState extends State<ImagesInSinglePost> {
  final PageController _pageController = PageController();
  final Map<int, double> _aspectRatios = {};
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.mediaPaths.length; i++) {
      _resolveAspectRatio(i, widget.mediaPaths[i]);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _resolveAspectRatio(int index, String url) {
    if (url.isEmpty || _aspectRatios.containsKey(index)) return;

    final provider = CachedNetworkImageProvider(url);
    provider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          if (!mounted) return;
          final w = info.image.width.toDouble();
          final h = info.image.height.toDouble();
          if (h <= 0) return;
          setState(() => _aspectRatios[index] = w / h);
        },
        onError: (_, __) {
          if (!mounted) return;
          setState(() => _aspectRatios[index] = 1);
        },
      ),
    );
  }

  double _naturalHeight(double width, int pageIndex) {
    final ratio = _aspectRatios[pageIndex];
    if (ratio != null && ratio > 0) return width / ratio;
    for (final r in _aspectRatios.values) {
      if (r > 0) return width / r;
    }
    return width;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    // Keep tall images from blowing past the viewport / stretching the action bar.
    final maxHeight = screenHeight * 0.52;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final natural = _naturalHeight(width, _currentPage);
        final pageHeight = math.min(natural, maxHeight);

        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
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
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final imageUrl = widget.mediaPaths[index];
                    if (imageUrl.isEmpty) {
                      return const Placeholder();
                    }

                    return GestureDetector(
                      onTap: () {
                        navigatorKey.currentState?.push(
                          FullScreenImage.route(imageUrl: imageUrl),
                        );
                      },
                      child: Hero(
                        tag: widget.heroTag,
                        child: ColoredBox(
                          color: Colors.black,
                          child: CustomCachedNetworkImage(
                            imageUrl: imageUrl,
                            width: width,
                            height: pageHeight,
                            // Contain keeps full chart visible; height is already capped.
                            fit: BoxFit.contain,
                          ),
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
