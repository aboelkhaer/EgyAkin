import '../../../exports.dart'; // Ensure you have the Lottie package added in pubspec.yaml

class NetworkImageWithErrorHandler extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  // Constructor
  const NetworkImageWithErrorHandler({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child; // Show the image when it's loaded
        } else {
          return Center(
            child: Lottie.asset(
              AppImages.imageLoader, // Use the Lottie loader from AppImages
              width: 100.w, // Adjust the size of the loader as needed
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ); // Show Lottie animation for loading
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Lottie.asset(
            AppImages.imageLoader, // Use the same Lottie loader for errors
            width: 100, // Adjust the size as needed
            height: 100,
            fit: BoxFit.cover,
          ),
        ); // Show Lottie animation for error
      },
    );
  }
}
