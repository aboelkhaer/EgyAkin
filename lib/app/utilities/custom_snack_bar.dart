import '../../exports.dart';

customSnackBar({required bool isError, required String title, dynamic body}) {
  if (Get.isSnackbarOpen) {
    return null;
  } else {
    Get.snackbar(
      title,
      body,
      overlayBlur: 2,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1000),
      margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      colorText: isError ? Colors.red : Colors.green,
    );
  }
}
