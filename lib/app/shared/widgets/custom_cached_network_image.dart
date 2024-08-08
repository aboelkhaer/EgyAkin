import '../../../exports.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fadeInCurve: Curves.easeIn,
        fit: fit,
        placeholder: (context, url) => Lottie.asset(AppImages.imageLoader),
        errorWidget: (context, url, error) {
          return const SizedBox.shrink();
        },
      );
    } catch (error) {
      // Handle the error
      return Container(
        color: Colors.transparent,
        child: const Center(
          child: Icon(
            Icons.error_outline,
            color: AppColors.primary,
            size: 40.0,
          ),
        ),
      );
    }
  }
}
