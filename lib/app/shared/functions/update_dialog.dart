import '../../../exports.dart';

void showUpdateDialog({
  required BuildContext context,
  required VoidCallback onDismissed, // Add a parameter for the action
}) {
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
                '''<ul><li><strong>Doctor Consultations</strong>: Doctors can now consult one or more colleagues for advice on their patients.</li><li><strong>User Achievements</strong>: Earn achievements by adding a set number of patients or completing specific outcomes.</li></ul>''',
                onTapUrl: (url) {
                  launchURL(
                      url: url,
                      onError: (error) {
                        showErrorDialog(context, error);
                      });
                  return true;
                },
                textStyle:
                    TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
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
    // Call the action when the dialog is dismissed
    onDismissed();
  });
}
