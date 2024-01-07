import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../../../../exports.dart';

class ThirdStep extends GetView<ResetPasswordController> {
  const ThirdStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.thirdStepFormKey,
      child: Column(
        children: [
          // SizedBox(
          //   width: double.infinity,
          //   height: 200,
          //   child: Image.asset(
          //     AppImages.reset2,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          CustomTextFormField(
            title: 'New password',
            textInputType: TextInputType.visiblePassword,
            textFormFieldController: controller.newPasswordController,
            isPassword: true,
            onChanged: (value) {},
            textInputAction: TextInputAction.done,
            validator: (value) =>
                controller.registerController.passwordValidate(value!),
          ),
          FlutterPwValidator(
              controller: controller.newPasswordController,
              minLength: 6,
              uppercaseCharCount: 1,
              numericCharCount: 2,
              specialCharCount: 1,
              width: 400,
              height: 150,
              onSuccess: () {
                // controller.isPassowordValidation = true;
              },
              onFail: () {
                // controller.isPassowordValidation = false;
              }),
          // CustomTextFormField(
          //   title: 'Confirm password',
          //   textInputType: TextInputType.visiblePassword,
          //   onChanged: (value) {},
          //   validator: (value) => controller.registerController.confirmPassword(
          //     value!,
          //     controller.confirmPassword,
          //   ),
          // ),
        ],
      ),
    );
  }
}
