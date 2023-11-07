import '../../../exports.dart';

class RegisterController extends GetxController {
  AuthRepository authRepository = Get.find<AuthRepository>();

  RxBool isRegisterLoading = false.obs;

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
    if (value.length < 6) {
      return 'Password must be of 6 characters';
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
      phone: phone,
      job: job,
      highestDegree: highestDegree,
      isRegisterLoading: isRegisterLoading,
    );
  }
}
