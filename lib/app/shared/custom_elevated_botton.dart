import 'package:egy_akin/app/services/theme_bloc.dart';
import '../../exports.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDisable;
  final bool isDelete;
  final IconData? icon;
  final bool hasIcon;
  final String title;
  final Color? color;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.hasIcon = false,
    this.icon,
    this.isDelete = false,
    required this.title,
    this.isDisable = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return SizedBox(
          height: 40.h,
          
          child: ElevatedButton(
            onPressed: isDisable ? null : onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: color ??
                    (isDelete
                        ? Colors.red.shade800
                        : isDarkMode
                            ? AppColors.darkPrimary.withOpacity(0.7)
                            : AppColors.primary.withOpacity(0.7)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hasIcon
                    ? Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: isDisable
                                ? Colors.grey.shade600
                                : isDarkMode
                                    ? AppColors.darkTitle
                                    : Colors.white,
                          ),
                          SizedBox(
                            width: 3.w,
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: isDisable
                        ? Colors.grey.shade600
                        : isDarkMode
                            ? AppColors.darkTitle
                            : Colors.white,
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
