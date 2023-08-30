import '../../exports.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController textFormFieldController;
  final TextInputType textInputType;
  final VoidCallback? showPasswordFunction;
  final AuthController authController;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;

  final bool isPassword;
  const CustomTextFormField(
      {super.key,
      required this.title,
      required this.textFormFieldController,
      this.isPassword = false,
      required this.textInputType,
      this.showPasswordFunction,
      required this.authController,
      required this.validator,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      child: TextFormField(
        controller: textFormFieldController,
        keyboardType: textInputType,
        onChanged: onChanged,
        autofocus: false,
        maxLines: 1,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(color: Colors.grey),
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
          suffixIcon: title == 'Password'
              ? GestureDetector(
                  onTap: showPasswordFunction,
                  child: authController.showPassword.value
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
