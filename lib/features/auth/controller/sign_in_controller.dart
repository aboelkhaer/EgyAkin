import '../../../exports.dart';

class SignInController extends GetxController {
  late TextEditingController signInEmailController;
  late TextEditingController signInPasswordController;
  RxBool showPasswordInSignIn = false.obs;
  RxBool isSignInLoading = false.obs;
  int signInErrorValidCounter = 0;
  AuthRepository authRepository = Get.find<AuthRepository>();
  late GlobalKey<FormState> signInFormKey;
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void onInit() {
    signInEmailController = TextEditingController(text: 'moatz@moatz.com');
    signInPasswordController = TextEditingController(text: '12345678');
    signInFormKey = GlobalKey<FormState>();
    super.onInit();
  }

  void loginDispose() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    passwordFocusNode.dispose();
    if (signInFormKey.currentState != null) {
      signInFormKey.currentState!.reset();
    }
  }

  @override
  void onClose() {
    loginDispose();
    super.onClose();
  }

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

  signIn() {
    signInErrorValidCounter += 1;

    authRepository.login(
      email: signInEmailController.text,
      password: signInPasswordController.text,
      isSignInLoading: isSignInLoading,
    );
  }
}
