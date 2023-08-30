import '../../../exports.dart';

class SignInScreen extends GetView<AuthController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  // Image.asset(
                  //   AppImages.signIn,
                  //   width: double.infinity,
                  //   height: size.height * 0.45,
                  // ),
                  //
                  SizedBox(height: size.height * 0.2),
                  const Row(
                    children: [
                      Text(
                        AppStrings.signIn,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  Form(
                    key: controller.signInFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          title: 'Email',
                          textFormFieldController:
                              controller.emailSignInController,
                          textInputType: TextInputType.emailAddress,
                          authController: controller,
                          // validator: (value) =>
                          //     controller.emailValidate(value!),
                          validator: (value) => null,
                        ),
                        SizedBox(height: size.height * 0.03),
                        Obx(
                          () => CustomTextFormField(
                            title: 'Password',
                            textFormFieldController:
                                controller.passwordSignInController,
                            textInputType: TextInputType.visiblePassword,
                            authController: controller,
                            isPassword:
                                controller.showPassword.value ? false : true,
                            showPasswordFunction: () {
                              controller.showPassword.value =
                                  !controller.showPassword.value;
                            },
                            validator: (value) => null,
                            // validator: (value) =>
                            //     controller.passwordValidate(value!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.07),
                  CustomElevatedButton(
                    size: size,
                    onPressed: () {
                      // if (controller.signInFormKey.currentState!.validate()) {}
                      controller.signIn();
                    },
                    title: AppStrings.signIn,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
