import '../../exports.dart';

customSnackBar({required bool isError, required String title, dynamic body}) {
  if (Get.isSnackbarOpen) {
    return null;
  } else {
    Get.snackbar(
      title,
      body,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      colorText: Colors.red,
    );
  }
}
