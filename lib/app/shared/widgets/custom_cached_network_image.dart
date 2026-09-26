import '../../../exports.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double? height;
  final BoxFit fit;

  /// When false, skip Lottie and use a quiet fill (better for already-cached
  /// feed → detail transitions).
  final bool showLoaderPlaceholder;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.showLoaderPlaceholder = true,
  });

  /// Decode width shared across feed cards and detail so Flutter's image
  /// cache can reuse the same decoded bitmap (avoids a second "load").
  static int sharedMemCacheWidth(BuildContext context, {double? layoutWidth}) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final screenW = MediaQuery.sizeOf(context).width;
    final logical = (layoutWidth != null && layoutWidth.isFinite && layoutWidth > 0)
        ? layoutWidth
        : screenW;
    // Cap at screen width so feed (cropped) and detail (taller) share one key.
    final capped = logical.clamp(1.0, screenW);
    return (capped * dpr).round().clamp(1, 2048);
  }

  @override
  Widget build(BuildContext context) {
    final memW = sharedMemCacheWidth(
      context,
      layoutWidth: width.isFinite ? width : null,
    );
    final placeholder = showLoaderPlaceholder
        ? Lottie.asset(AppImages.imageLoader)
        : ColoredBox(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1C1C1E)
                : const Color(0xFFE8E8ED),
          );

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width.isFinite ? width : null,
      height: height != null && height!.isFinite ? height : null,
      // Only width — height differs between feed (180) and detail (aspect),
      // and would force a separate memory decode / visible reload.
      memCacheWidth: memW,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      fit: fit,
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => placeholder,
      errorListener: (_) {},
    );
  }
}
