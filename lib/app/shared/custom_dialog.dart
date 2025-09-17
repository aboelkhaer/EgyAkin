import '../../../exports.dart';
import '../services/theme_bloc.dart';

showCustomDialog(
    {required BuildContext context,
    required String title,
    required var description,
    VoidCallback? noColoredButtonOnTap,
    required String coloredButtonText,
    String? noColoredButtonText,
    bool isNoColorShow = true,
    TextInputType textInputType = TextInputType.text,
    bool isWithTextField = false,
    Function(String)? onChangedTextFormField,
    int? textFormFieldMaxLines,
    bool isColoredButtonDisable = false,
    required VoidCallback coloredButtonOnTap}) {
  Size size = MediaQuery.of(context).size;

  // Get theme state from context
  final themeBloc = context.read<ThemeBloc>();
  final themeState = themeBloc.state;
  final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

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
              title: Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? AppColors.darkTitle : AppColors.title,
                ),
              ),
              scrollable: true,
              backgroundColor: isDarkMode ? AppColors.darkCardBG : Colors.white,
              content: descriptionWidget(
                  description,
                  isWithTextField,
                  onChangedTextFormField,
                  textFormFieldMaxLines,
                  textInputType,
                  isDarkMode),
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
                            color: isDarkMode
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ))
                    : const SizedBox.shrink(),
                SizedBox(
                  width: size.width * 0.23,
                  child: CustomElevatedButton(
                    onPressed: coloredButtonOnTap,
                    title: coloredButtonText,
                    isDisable: isColoredButtonDisable,
                  ),
                ),
              ],
              actionsPadding: EdgeInsets.only(
                  bottom: 20,
                  right: context.currentLocale?.languageCode == 'ar' ? 0 : 20,
                  left: context.currentLocale?.languageCode == 'ar' ? 20 : 0),
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

Widget descriptionWidget(
    var description,
    bool isWithTextField,
    Function(String)? onChangedTextFormField,
    int? textFormFieldMaxLines,
    TextInputType textInputType,
    bool isDarkMode) {
  if (isWithTextField) {
    return Column(
      children: [
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode ? AppColors.darkTitle : AppColors.title,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 70.h,
          child: CustomTextFormField(
            title: '',
            textInputType: textInputType,
            autoFocus: true,
            validator: (value) => null,
            maxLines: textFormFieldMaxLines,
            onChanged: onChangedTextFormField,
          ),
        ),
      ],
    );
  }
  if (description is String) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isDarkMode ? AppColors.darkTitle : AppColors.title,
      ),
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
            style: TextStyle(
              color: isDarkMode ? AppColors.darkTitle : AppColors.title,
            ),
          );
        },
      ),
    );
  }
  return const SizedBox.shrink();
}
