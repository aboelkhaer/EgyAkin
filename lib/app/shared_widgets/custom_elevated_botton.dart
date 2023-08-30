import '../../exports.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const CustomElevatedButton({
    super.key,
    required this.size,
    required this.onPressed,
    required this.title,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
