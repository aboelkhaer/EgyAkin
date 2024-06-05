import '../../exports.dart';

class CustomOutlineBotton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isFlatBotton;
  final bool isDisable;
  const CustomOutlineBotton({
    super.key,
    required this.onPressed,
    this.isFlatBotton = false,
    this.isDisable = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      height: 40.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            foregroundColor: isFlatBotton ? Colors.grey.shade200 : null,
            side: BorderSide(
              width: 2.0,
              color: isFlatBotton ? AppColors.subBG : AppColors.primary,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          title,
          style: TextStyle(
              color: isFlatBotton ? Colors.grey.shade600 : AppColors.primary),
        ),
      ),
    );
  }
}
