import '../../exports.dart';

customSnackBar({required String message, required BuildContext context}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: AppStrings.snackBarDelay),
    action: SnackBarAction(
      label: AppStrings.ok,
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
