import 'package:egy_akin/app/services/theme_bloc.dart';
import '../../../exports.dart';

class TranslatablePasswordValidator extends StatefulWidget {
  final TextEditingController controller;
  final int minLength;
  final int uppercaseCharCount;
  final int numericCharCount;
  final int specialCharCount;
  final double width;
  final double height;
  final VoidCallback onSuccess;
  final VoidCallback onFail;

  const TranslatablePasswordValidator({
    super.key,
    required this.controller,
    this.minLength = 6,
    this.uppercaseCharCount = 1,
    this.numericCharCount = 2,
    this.specialCharCount = 1,
    this.width = 200,
    this.height = 100,
    required this.onSuccess,
    required this.onFail,
  });

  @override
  State<TranslatablePasswordValidator> createState() =>
      _TranslatablePasswordValidatorState();
}

class _TranslatablePasswordValidatorState
    extends State<TranslatablePasswordValidator> {
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumeric = false;
  bool _hasSpecial = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validatePassword);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validatePassword);
    super.dispose();
  }

  void _validatePassword() {
    final password = widget.controller.text;

    setState(() {
      _hasMinLength = password.length >= widget.minLength;
      _hasUppercase = RegExp(r'[A-Z]').allMatches(password).length >=
          widget.uppercaseCharCount;
      _hasNumeric = RegExp(r'[0-9]').allMatches(password).length >=
          widget.numericCharCount;
      _hasSpecial =
          RegExp(r'[!@#$%^&*()\-_=+{}|:;<>,.?~]').allMatches(password).length >=
              widget.specialCharCount;
    });

    if (_hasMinLength && _hasUppercase && _hasNumeric && _hasSpecial) {
      widget.onSuccess();
    } else {
      widget.onFail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.darkCardBG : Colors.grey[100],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildValidationItem(
                context.tr(AppStrings.passwordValidationMinLength),
                _hasMinLength,
                isDarkMode,
              ),
              _buildValidationItem(
                context.tr(AppStrings.passwordValidationUppercase),
                _hasUppercase,
                isDarkMode,
              ),
              _buildValidationItem(
                context.tr(AppStrings.passwordValidationNumeric),
                _hasNumeric,
                isDarkMode,
              ),
              _buildValidationItem(
                context.tr(AppStrings.passwordValidationSpecial),
                _hasSpecial,
                isDarkMode,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildValidationItem(String text, bool isValid, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.circle_outlined,
            size: 14,
            color: isValid
                ? Colors.green
                : isDarkMode
                    ? AppColors.darkDescription
                    : Colors.grey,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11,
                color: isValid
                    ? Colors.green
                    : isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
