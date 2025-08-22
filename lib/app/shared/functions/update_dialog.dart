import '../../../exports.dart';

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
      return AlertDialog(
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
              Text('What\'s New',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
              SizedBox(height: 5.h),
              HtmlWidget(
                '''<ul>
  <li><strong>Discharge Recommendations</strong>: New section providing comprehensive discharge planning and recommendations for better patient care transitions.</li>
  <li><strong>Enhanced Community Features</strong>: Improved URL handling in community posts with better link previews and clickable content.</li>
  <li><strong>Share Post Feature</strong>: Share interesting community posts with others through various platforms and messaging apps.</li>
  <li><strong>Bug Fixes & Performance</strong>: Enjoy a smoother and more reliable app experience with various fixes and optimizations.</li>
</ul>''',
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
                  color: Colors.grey.shade600,
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
            child: const Text('Close'),
          ),
        ],
      );
    },
  ).then((_) {
    _isUpdateDialogOpen = false; // Reset the flag when dialog is dismissed
    onDismissed();
  });
}
