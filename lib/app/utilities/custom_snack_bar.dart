import '../../exports.dart';

void customSnackBar({required BuildContext context, required String message}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  if (!scaffoldMessenger.mounted) {
    return; // Return if the ScaffoldMessenger is not mounted
  }

  scaffoldMessenger.hideCurrentSnackBar();

  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: AppStrings.snackBarDelay),
    action: SnackBarAction(
      label: AppStrings.ok,
      onPressed: () {},
    ),
  );

  scaffoldMessenger.showSnackBar(snackBar);
}
