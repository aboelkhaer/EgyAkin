import '../../exports.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDisable;
  final bool isDelete;
  final IconData? icon;
  final bool hasIcon;
  final String title;
  const CustomElevatedButton({
    super.key,
    required this.size,
    required this.onPressed,
    this.hasIcon = false,
    this.icon,
    this.isDelete = false,
    required this.title,
    this.isDisable = false,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: isDisable ? null : onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: isDelete
                ? Colors.red.shade800
                : AppColors.primary.withOpacity(0.7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon
                ? const Row(
                    children: [
                      Icon(Icons.date_range),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
