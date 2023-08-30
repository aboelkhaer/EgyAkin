import '../../../exports.dart';
import '../../../injection_container.dart';
import 'repo.dart';

class AuthController extends GetxController {
  late TextEditingController emailSignInController;
  late TextEditingController passwordSignInController;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  RxBool showPassword = false.obs;

  AuthRepository authRepository = sl<AuthRepository>();

  @override
  void onInit() {
    emailSignInController = TextEditingController();
    passwordSignInController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    emailSignInController.dispose();
    passwordSignInController.dispose();
    super.onClose();
  }

  String? emailValidate(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Provide valid email, please';
    }
    return null;
  }

  String? passwordValidate(String value) {
    if (value.length <= 6) {
      return 'Password must be of 6 characters';
    }
    return null;
  }

  // signIn() async {
  //   var response = await dio.post(ApiEndPoint.login,
  //       options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: AppStrings.applicationJson
  //       }),
  //       data: {'email': 'info@egyakin.com', 'password': '123'});
  //   var retrievedUser = UserModel.fromJson(response.data);
  //   log(retrievedUser.data.toString());
  // }

  signIn() async {
    await authRepository.login('info@egyakin.com', '123');
  }
}
