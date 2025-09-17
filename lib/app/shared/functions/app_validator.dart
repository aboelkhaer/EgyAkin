import '../../../exports.dart';

class AppValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourEmail;
    }
    if (!_isValidEmail(value)) {
      return AppStrings.pleaseEnterAVlidEmail;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourPassword;
    }
    if (value.length <= 6) {
      return 'Please enter a valid password';
    }
    return null;
  }

  static bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static String? passwordValidateForRegister(String value,BuildContext context) {
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return context.tr(AppStrings.pleaseEnterYourPassword);
    }

    // Password must contain at least one numeric number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return context.tr(AppStrings.pleaseEnterAVlidPassword);
    }

    // Password must contain at least one special character
    if (!RegExp(r'[!@#$%^&*()\-_=+{}|:;<>,.?~]').hasMatch(value)) {
      return context.tr(AppStrings.pleaseEnterAVlidPassword);
    }

    // Password must have a minimum length of 6 characters
    if (value.length < 6) {
      // return 'Password must have a minimum length of 6 characters';
      return context.tr(AppStrings.pleaseEnterAVlidPassword);
    }

    return null;
  }

  static String? firstAndLastNameValidation(String value,BuildContext context) {
    if (value.isEmpty) {
      return context.tr(AppStrings.provideAValidNamePlease);
    } else {
      RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$').hasMatch(value)
          ? context.tr(AppStrings.arabicCharactersOnly)
          : null;
    }
    return null;
  }

  static String? confirmPassword(String value, String textController) {
    if (value.isEmpty) {
      return 'Confirm your password, please';
    }
    if (value != textController) {
      return 'Password not match';
    }
    return null;
  }

  static String? fieldsIsEmptyValidation(String value) {
    if (value.trim().isEmpty) {
      return 'Provide this field, please';
    }
    return null;
  }

  static String? validateAge(String value) {
    // Check if the entered value is a number
    if (int.tryParse(value) == null) {
      return 'Enter a valid number';
    }

    int age = int.parse(value);

    // Check if the number is between 18 and 99
    if (age < 18 || age > 99) {
      return 'Age between 18 and 99';
    }

    return null; // Return null for a valid age
  }

  static String? validatePhoneNumber(String value) {
    // Check if the entered value is a number
    if (int.tryParse(value) == null) {
      return 'Enter a valid phone';
    }

    // Check if the length is exactly 11 digits
    if (value.length != 11) {
      return 'Phone must be 11 digits';
    }

    return null; // Return null for a valid phone number
  }
}
