import '../../../exports.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  const CustomCachedNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fadeInCurve: Curves.easeIn,
        fit: BoxFit.cover,
        placeholder: (context, url) => Lottie.asset(AppImages.imageLoader),
        errorWidget: (context, url, error) {
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
