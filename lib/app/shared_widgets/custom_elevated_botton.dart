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
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary.withOpacity(0.7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          title,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
