import '../../../exports.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController controller = Get.put(SignInController());
  late TextEditingController signInEmailController;
  late TextEditingController signInPasswordController;
  GlobalKey<FormState>? signInFormKey;
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    initTextFieldController();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  initTextFieldController() {
    signInFormKey = GlobalKey<FormState>();

    signInEmailController = TextEditingController(text: 'admin@egyakin.com');
    signInPasswordController = TextEditingController(text: '12345678');
  }

  disposeControllers() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    passwordFocusNode.dispose();
  }

  resetLoginForm() {
    if (signInFormKey?.currentState != null) {
      signInFormKey?.currentState!.reset();
    }
    signInEmailController.clear();
    signInPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => SignInController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    AppImages.signIn,
                    width: double.infinity,
                    height: size.height * 0.45,
                  ),
                  Form(
                    key: signInFormKey,
                    autovalidateMode: controller.signInErrorValidCounter == 0
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          title: 'Email',
                          textFormFieldController: signInEmailController,
                          enableSuggestions: true,
                          textInputType: TextInputType.emailAddress,
                          onFieldSubmitted: (v) => FocusScope.of(context)
                              .requestFocus(passwordFocusNode),
                          validator: (value) =>
                              controller.emailValidate(value!),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: size.height * 0.01),
                        Obx(
                          () => CustomTextFormField(
                            title: 'Password',
                            textFormFieldController: signInPasswordController,
                            focusNode: passwordFocusNode,
                            textInputType: TextInputType.visiblePassword,
                            isSignInPasswordField: true,
                            textInputAction: TextInputAction.done,
                            isPassword: controller.showPasswordInSignIn.value
                                ? false
                                : true,
                            showPasswordFunction: () {
                              controller.showPasswordInSignIn.value =
                                  !controller.showPasswordInSignIn.value;
                            },
                            validator: (value) =>
                                controller.passwordValidate(value!),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.resetPassword);
                              },
                              child: SizedBox(
                                child: Text(
                                  'Forget Password ?',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.07),
                  Obx(
                    () => controller.isSignInLoading.value
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: CustomElevatedButton(
                              size: size,
                              onPressed: () {
                                if (signInFormKey!.currentState!.validate()) {
                                  controller.signIn(
                                    email: signInEmailController.text,
                                    password: signInPasswordController.text,
                                  );
                                }
                              },
                              title: AppStrings.signIn,
                            ),
                          ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(AppRoutes.register);
                          resetLoginForm();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 1, // Space between underline and text
                          ),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.blue,
                            width: 1.0, // Underline thickness
                          ))),
                          child: const Text(
                            "Register now!",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.06),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
