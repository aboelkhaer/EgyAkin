import '../../exports.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController? textFormFieldController;
  final TextInputType textInputType;
  final VoidCallback? visiblePasswordIconFunction;
  final VoidCallback? unVisiblePasswordIconFunction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableSuggestions;
  final String? initialValue;
  final int? maxLines;
  final bool? visiblePasswordIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool enabled;
  final TextAlign textAlign;
  final bool obscureText;
  final bool isOTP;
  final bool readOnly;
  final Function(String?)? onSave;
  final int? maxLength;
  final TextStyle? style;

  const CustomTextFormField(
      {super.key,
      required this.title,
      this.textFormFieldController,
      this.unVisiblePasswordIconFunction,
      this.visiblePasswordIcon,
      this.readOnly = false,
      this.obscureText = false,
      this.enabled = true,
      this.isOTP = false,
      this.initialValue,
      this.autoFocus = false,
      this.onFieldSubmitted,
      this.onSave,
      this.style,
      this.textAlign = TextAlign.start,
      this.maxLength,
      this.maxLines = 1,
      required this.textInputType,
      this.focusNode,
      this.enableSuggestions = false,
      this.visiblePasswordIconFunction,
      this.textInputAction,
      required this.validator,
      this.onChanged,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: textFormFieldController,
        initialValue: initialValue,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        enableSuggestions: enableSuggestions,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        enabled: enabled,
        autofocus: autoFocus,
        onSaved: onSave,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        onChanged: onChanged,
        maxLength: maxLength,
        maxLines: maxLines,
        textAlign: textAlign,
        style: style,
        obscureText: obscureText,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 11, right: 3, top: 14, bottom: 14),
          counterText: '',
          hintText: title,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),
          errorStyle: isOTP
              ? const TextStyle(height: 0, fontSize: 0)
              : const TextStyle(fontSize: 9, height: 0.3),
          filled: true,
          fillColor: AppColors.subBG,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: isOTP ? Colors.red : Colors.grey.shade300),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          suffixIcon: visiblePasswordIcon == true
              ? GestureDetector(
                  onTap: visiblePasswordIconFunction,
                  child: const Icon(
                    Icons.visibility_off,
                  ),
                )
              : visiblePasswordIcon == false
                  ? GestureDetector(
                      onTap: unVisiblePasswordIconFunction,
                      child: const Icon(
                        Icons.visibility,
                      ),
                    )
                  : null,
        ),
        readOnly: readOnly,
        validator: validator,
      ),
    );
  }
}
