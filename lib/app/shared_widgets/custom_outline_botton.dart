import '../../exports.dart';

class CustomOutlineBotton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Size size;
  const CustomOutlineBotton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.06,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 2.0,
              color: AppColors.primary,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(
          title,
          style: const TextStyle(color: AppColors.primary),
        ),
      ),
    );
  }
}
