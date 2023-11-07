import '../../../exports.dart';

class SignInController extends GetxController {
  RxBool showPasswordInSignIn = false.obs;
  RxBool isSignInLoading = false.obs;
  int signInErrorValidCounter = 0;
  AuthRepository authRepository = Get.find<AuthRepository>();

  // @override
  // void onInit() {
  //   // resetTextFieldController();
  //   signInFormKey = GlobalKey<FormState>();
  //   super.onInit();
  // }

  // void resetTextFieldController() {
  //   signInEmailController?.dispose();
  //   signInPasswordController?.dispose();
  //   signInEmailController = TextEditingController(text: 'moatz@moatz.com');
  //   signInPasswordController = TextEditingController(text: '12345678');
  // }

  // void loginDispose() {
  //   signInEmailController?.dispose();
  //   signInPasswordController?.dispose();
  //   passwordFocusNode.dispose();
  //   if (signInFormKey.currentState != null) {
  //     signInFormKey.currentState!.reset();
  //   }
  // }

  // @override
  // void onClose() {
  //   loginDispose();
  //   super.onClose();
  // }

  String? emailValidate(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Provide a valid email, please';
    }
    return null;
  }

  String? passwordValidate(String value) {
    if (value.length <= 6) {
      return 'Password must be of 6 characters';
    }
    return null;
  }

  signIn({
    required String email,
    required String password,
  }) {
    signInErrorValidCounter += 1;

    authRepository.login(
      email: email,
      password: password,
      isSignInLoading: isSignInLoading,
    );
  }
}
