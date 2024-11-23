import '../../../exports.dart';

enum DialogType { error, information, success }

Future<void> showHintDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String message,
}) {
  // Map dialog type to corresponding icon and color
  IconData icon;
  Color iconColor;

  switch (dialogType) {
    case DialogType.error:
      icon = Icons.error;
      iconColor = Colors.red.shade700;
      break;
    case DialogType.information:
      icon = Icons.info;
      iconColor = Colors.blue;
      break;
    case DialogType.success:
      icon = Icons.check_circle;
      iconColor = Colors.green;
      break;
  }

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 48,
                color: iconColor,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, // Takes all available width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
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
}
