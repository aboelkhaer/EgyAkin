import 'package:egy_akin/app/services/theme_bloc.dart';

import '../../../exports.dart';

bool _isDialogOpen = false; // Flag to check if the dialog is open

void showBlockedDialog({
  required BuildContext context,
  required VoidCallback onDismissed, // Add a parameter for the action
}) {
  // Check if the dialog is already open
  if (_isDialogOpen) return;

  _isDialogOpen = true; // Set the flag to true when dialog opens

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
                  SizedBox(height: 10.h),
                  Text(
                    LocalizationService.instance
                        .translate(AppStrings.youAreBlocked),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: isDarkMode ? AppColors.darkTitle : AppColors.title,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    LocalizationService.instance.translate(AppStrings
                        .pleaseContactSupportIfYouThinkThisIsAMistake),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color:
                          isDarkMode ? Colors.grey.shade300 : AppColors.title,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () async {
                      const email = 'mailto:support@egyakin.com';
                      if (await canLaunch(email)) {
                        await launch(email);
                      } else {
                        // Handle error when email client can't be launched
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(LocalizationService.instance
                                  .translate(
                                      AppStrings.couldNotOpenEmailClient))),
                        );
                      }
                    },
                    child: Text(
                      'support@egyakin.com', // Use your support email
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors
                            .primary, // Keep primary color for email link
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  LocalizationService.instance.translate(AppStrings.close),
                  style: TextStyle(
                    color: isDarkMode ? AppColors.darkTitle : AppColors.primary,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  ).then((_) {
    _isDialogOpen = false; // Reset the flag when dialog is dismissed
    onDismissed();
  });
}
