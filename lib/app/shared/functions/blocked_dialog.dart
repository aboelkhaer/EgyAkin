import 'package:egy_akin/app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Assuming you're using screenutil for responsive sizing
import 'package:url_launcher/url_launcher.dart'; // To launch the email client

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
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              SizedBox(height: 10.h),
              Text(
                'You are blocked!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppColors.title,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Please contact support if you think this is a mistake.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.title, // Assuming you have a subtitle color
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
                      const SnackBar(
                          content: Text('Could not open email client')),
                    );
                  }
                },
                child: Text(
                  'support@egyakin.com', // Use your support email
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors
                        .primary, // Highlight the email in primary color
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
            child: const Text('Close'),
          ),
        ],
      );
    },
  ).then((_) {
    _isDialogOpen = false; // Reset the flag when dialog is dismissed
    onDismissed();
  });
}
