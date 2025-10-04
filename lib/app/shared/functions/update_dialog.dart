import '../../../exports.dart';
import '../../services/theme_bloc.dart';
import '../../utilities/translation_extension.dart';

bool _isUpdateDialogOpen = false; // Flag to check if the update dialog is open

void showUpdateDialog({
  required BuildContext context,
  required VoidCallback onDismissed, // Add a parameter for the action
}) {
  // Check if the dialog is already open
  if (_isUpdateDialogOpen) return;

  _isUpdateDialogOpen = true; // Set the flag to true when dialog opens

  showDialog(
    context: context,
    builder: (context) {
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

          return AlertDialog(
            backgroundColor: isDarkMode ? AppColors.darkCardBG : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.asset(
                      AppImages.whatsNew,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(context.tr(AppStrings.whatsNew),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: isDarkMode ? AppColors.darkTitle : Colors.black,
                      )),
                  SizedBox(height: 5.h),
                  HtmlWidget(
                    context.tr(AppStrings.updateDialogContent),
                    onTapUrl: (url) {
                      launchURL(
                        url: url,
                        onError: (error) {
                          showErrorDialog(context, error);
                        },
                      );
                      return true;
                    },
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      color: isDarkMode
                          ? AppColors.darkTitle
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  context.tr(AppStrings.close),
                  style: const TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  ).then((_) {
    _isUpdateDialogOpen = false; // Reset the flag when dialog is dismissed
    onDismissed();
  });
}
