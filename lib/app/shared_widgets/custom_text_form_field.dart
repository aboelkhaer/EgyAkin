import '../../exports.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController? textFormFieldController;
  final TextInputType textInputType;
  final VoidCallback? showPasswordFunction;
  final String? Function(String?)? validator;
  final bool? showPasswordInSignIn;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableSuggestions;
  final String? initialValue;
  final int? maxLines;
  final bool? isSignInPasswordField;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;

  final bool isPassword;
  const CustomTextFormField(
      {super.key,
      required this.title,
      this.textFormFieldController,
      this.initialValue,
      this.onFieldSubmitted,
      this.isPassword = false,
      this.maxLines = 1,
      required this.textInputType,
      this.focusNode,
      this.enableSuggestions = false,
      this.showPasswordFunction,
      required this.textInputAction,
      this.showPasswordInSignIn = false,
      required this.validator,
      this.isSignInPasswordField = false,
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
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        onChanged: onChanged,
        maxLines: maxLines,
        obscureText: isPassword ? true : false,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 11, right: 3, top: 14, bottom: 14),
          hintText: title,
          hintStyle: const TextStyle(color: Colors.grey),
          errorStyle: const TextStyle(fontSize: 9, height: 0.3),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          suffixIcon: isSignInPasswordField == true && isPassword == true
              ? GestureDetector(
                  onTap: showPasswordFunction,
                  child: showPasswordInSignIn!
                      ? const Icon(
                          Icons.visibility_off,
                        )
                      : const Icon(
                          Icons.visibility,
                        ),
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }
}
