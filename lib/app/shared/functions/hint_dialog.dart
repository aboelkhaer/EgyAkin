import '../../../exports.dart';
import '../../../app/services/theme_bloc.dart';

enum DialogType { error, information, success }

bool _isDialogVisible = false;

Future<void> showHintDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String message,
}) async {
  if (_isDialogVisible) return;

  _isDialogVisible = true; // Mark as visible
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

          return Dialog(
            backgroundColor: isDarkMode ? AppColors.darkCardBG : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getIcon(dialogType),
                    size: 48,
                    color: _getIconColor(dialogType, isDarkMode),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColors.darkTitle : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 100.w, // Takes all available width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? AppColors.darkPrimary
                            : AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color:
                              isDarkMode ? AppColors.darkTitle : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
  _isDialogVisible = false; // Reset visibility
}

IconData _getIcon(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.error:
      return Icons.error;
    case DialogType.information:
      return Icons.info;
    case DialogType.success:
      return Icons.check_circle;
  }
}

Color _getIconColor(DialogType dialogType, bool isDarkMode) {
  switch (dialogType) {
    case DialogType.error:
      return isDarkMode ? Colors.red.shade300 : Colors.red.shade700;
    case DialogType.information:
      return isDarkMode ? AppColors.darkPrimary : AppColors.primary;
    case DialogType.success:
      return isDarkMode ? Colors.green.shade300 : Colors.green;
  }
}
