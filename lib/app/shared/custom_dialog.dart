import '../../exports.dart';

showCustomDialog(
    {required BuildContext context,
    required String title,
    required var description,
    VoidCallback? noColoredButtonOnTap,
    required String coloredButtonText,
    String? noColoredButtonText,
    bool isNoColorShow = true,
    bool isColoredButtonDisable = false,
    required VoidCallback coloredButtonOnTap}) {
  Size size = MediaQuery.of(context).size;
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.grey.shade100,
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Text(title),
              scrollable: true,
              content: descriptionWidget(description),
              actions: [
                isNoColorShow
                    ? TextButton(
                        onPressed: noColoredButtonOnTap,
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent,
                          ),
                        ),
                        child: Text(
                          noColoredButtonText!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ))
                    : const SizedBox.shrink(),
                SizedBox(
                  width: size.width * 0.25,
                  child: CustomElevatedButton(
                    onPressed: coloredButtonOnTap,
                    title: coloredButtonText,
                    isDisable: isColoredButtonDisable,
                  ),
                ),
              ],
              actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
}

Widget descriptionWidget(var description) {
  if (description is String) {
    return Text(
      description,
      textAlign: TextAlign.center,
    );
  }
  if (description is List<dynamic>) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: description.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Text(
            '  ${index + 1} - ${description[index]}',
          );
        },
      ),
    );
  }
  return const SizedBox.shrink();
}
