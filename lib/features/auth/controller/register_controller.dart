import '../../../exports.dart';

class RegisterController extends GetxController {
  AuthRepository authRepository = Get.find<AuthRepository>();
  late TextEditingController registerFirstNameController;
  late TextEditingController registerLastNameController;
  late TextEditingController registerEmailController;
  late TextEditingController registerPasswordController;
  late TextEditingController registerConfirmPasswordController;
  late TextEditingController registerPhoneController;
  late TextEditingController registerJopController;
  late TextEditingController registerSpecialtyController;
  late TextEditingController registerWorkingPlaceController;
  late TextEditingController registerHighestDegreeController;
  late TextEditingController registerAgeController;
  late GlobalKey<FormState> registerFormKey;
  RxBool isRegisterLoading = false.obs;
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode specialtyFocusNode = FocusNode();
  final FocusNode highestDegreeFocusNode = FocusNode();
  final FocusNode jobFocusNode = FocusNode();
  final FocusNode workPlaceFocusNode = FocusNode();

  @override
  void onInit() {
    registerFirstNameController = TextEditingController();
    registerLastNameController = TextEditingController();
    registerEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    registerConfirmPasswordController = TextEditingController();
    registerPhoneController = TextEditingController();
    registerJopController = TextEditingController();
    registerSpecialtyController = TextEditingController();
    registerWorkingPlaceController = TextEditingController();
    registerHighestDegreeController = TextEditingController();
    registerAgeController = TextEditingController();
    registerFormKey = GlobalKey<FormState>();
    super.onInit();
  }

  void registerDispose() {
    registerFirstNameController.dispose();
    registerLastNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerPhoneController.dispose();
    registerJopController.dispose();
    registerSpecialtyController.dispose();
    registerWorkingPlaceController.dispose();
    registerHighestDegreeController.dispose();
    registerAgeController.dispose();
    if (registerFormKey.currentState != null) {
      registerFormKey.currentState!.reset();
    }
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    phoneFocusNode.dispose();
    ageFocusNode.dispose();
    specialtyFocusNode.dispose();
    highestDegreeFocusNode.dispose();
    jobFocusNode.dispose();
    workPlaceFocusNode.dispose();
  }

  @override
  void onClose() {
    registerDispose();
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

  String? confirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm your passowrd, please';
    }
    if (value != registerPasswordController.text) {
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

  register() async {
    registerErrorValid += 1;
    await authRepository.register(
      firstName: registerFirstNameController.text,
      lastName: registerLastNameController.text,
      email: registerEmailController.text,
      age: int.parse(registerAgeController.text),
      specialty: registerSpecialtyController.text,
      password: registerPasswordController.text,
      passwordConfirmation: registerConfirmPasswordController.text,
      workingPlace: registerWorkingPlaceController.text,
      phone: registerPhoneController.text,
      job: registerJopController.text,
      highestDegree: registerHighestDegreeController.text,
      isRegisterLoading: isRegisterLoading,
    );
  }
}
