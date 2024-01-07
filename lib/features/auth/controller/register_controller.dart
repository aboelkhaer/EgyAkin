import '../../../exports.dart';

class RegisterController extends GetxController {
  AuthRepository authRepository = Get.find<AuthRepository>();

  RxBool isRegisterLoading = false.obs;
  // bool isPassowordValidation = false;

  List<String> highestDegreeList = [
    'MBBCH',
    'Master Degree',
    'Fellowship',
    'MD',
    'Other'
  ];

  // @override
  // void onInit() {
  //   registerFormKey = GlobalKey<FormState>();
  //   resetTextFieldController();
  //   super.onInit();
  // }

  @override
  void onClose() {
    // registerDispose();
    super.onClose();
  }

  // validation
  String? emailValidate(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Provide a valid email, please';
    }
    return null;
  }

  String? passwordValidate(String value) {
    // if (value.length < 6) {
    //   return 'Password must be of 6 characters';
    // }

    // return null;
    // Password must contain at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      // return 'Password must contain at least one uppercase letter';
      return 'PPassword must meet the criteria';
    }

    // Password must contain at least one numeric number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      // return 'Password must contain at least one numeric number';
      return 'PPassword must meet the criteria';
    }

    // Password must contain at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      // return 'Password must contain at least one special character';
      return 'PPassword must meet the criteria';
    }

    // Password must have a minimum length of 6 characters
    if (value.length < 6) {
      // return 'Password must have a minimum length of 6 characters';
      return 'PPassword must meet the criteria';
    }

    return null;
  }

  String? firstAndLastNameValidation(String value) {
    if (value.isEmpty) {
      return 'Provide a valid name, please';
    } else {
      RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$').hasMatch(value)
          ? 'Arabic characters only'
          : null;
    }
    return null;
  }

  String? confirmPassword(String value, String textController) {
    if (value.isEmpty) {
      return 'Confirm your passowrd, please';
    }
    if (value != textController) {
      return 'Password not match';
    }
    return null;
  }

  String? fieldsIsEmptyValidation(String value) {
    if (value.isEmpty) {
      return 'Provide this field, please';
    }
    return null;
  }

  String? validateAge(String value) {
    // Check if the entered value is a number
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }

    int age = int.parse(value);

    // Check if the number is between 18 and 99
    if (age < 18 || age > 99) {
      return 'Age between 18 and 99';
    }

    return null; // Return null for a valid age
  }

  String? validatePhoneNumber(String value) {
    // Check if the entered value is a number
    if (int.tryParse(value) == null) {
      return 'Please enter a valid phone number';
    }

    // Check if the length is exactly 11 digits
    if (value.length != 11) {
      return 'Phone number must be 11 digits';
    }

    return null; // Return null for a valid phone number
  }

  int registerErrorValid = 0;

  register({
    required String firstName,
    required String lastName,
    required String email,
    required String specialty,
    required String age,
    required String password,
    required String passwordConfirmation,
    required String workingPlace,
    required String registrationNumber,
    required String phone,
    required String job,
    required String highestDegree,
  }) async {
    registerErrorValid += 1;
    await authRepository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      age: age,
      specialty: specialty,
      password: password,
      passwordConfirmation: passwordConfirmation,
      workingPlace: workingPlace,
      registrationNumber: registrationNumber,
      phone: phone,
      job: job,
      highestDegree: highestDegree,
      isRegisterLoading: isRegisterLoading,
    );
  }
}
