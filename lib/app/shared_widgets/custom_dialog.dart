import 'dart:developer';

import '../../exports.dart';

showCustomDialog(
    {required BuildContext context,
    required String title,
    required var description,
    required VoidCallback noColoredBottonOnTap,
    required String coloredBottonText,
    required String noColoredBottonText,
    bool isNoColorShow = true,
    bool isColoredBottonDisable = false,
    required VoidCallback coloredBottonOnTap}) {
  Size size = MediaQuery.of(context).size;
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Text(title),
              scrollable: true,
              content: discriptionWidget(description),
              actions: [
                isNoColorShow
                    ? TextButton(
                        onPressed: noColoredBottonOnTap,
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent,
                          ),
                        ),
                        child: Text(
                          noColoredBottonText,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ))
                    : const SizedBox.shrink(),
                SizedBox(
                  width: size.width * 0.23,
                  child: CustomElevatedButton(
                    size: size,
                    onPressed: coloredBottonOnTap,
                    title: coloredBottonText,
                    isDisable: isColoredBottonDisable,
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

Widget discriptionWidget(var description) {
  if (description is String) {
    log('String');
    return Text(
      description,
      textAlign: TextAlign.center,
    );
  }
  if (description is List<dynamic>) {
    log('list');
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
  log('nothing');
  return const SizedBox.shrink();
}
