import '../../../exports.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => RegisterController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
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
                        key: controller.registerFormKey,
                        autovalidateMode: controller.registerErrorValid == 0
                            ? AutovalidateMode.disabled
                            : AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'First name',
                                    textFormFieldController:
                                        controller.registerFirstNameController,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.lastNameFocusNode),
                                    enableSuggestions: true,
                                    validator: (value) => controller
                                        .firstAndLastNameValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Last name',
                                    textFormFieldController:
                                        controller.registerLastNameController,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.emailFocusNode),
                                    focusNode: controller.lastNameFocusNode,
                                    enableSuggestions: true,
                                    textInputType: TextInputType.text,
                                    validator: (value) => controller
                                        .firstAndLastNameValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextFormField(
                              title: 'Email',
                              textFormFieldController:
                                  controller.registerEmailController,
                              onFieldSubmitted: (v) => FocusScope.of(context)
                                  .requestFocus(controller.passwordFocusNode),
                              focusNode: controller.emailFocusNode,
                              enableSuggestions: true,
                              textInputType: TextInputType.text,
                              validator: (value) =>
                                  controller.emailValidate(value!),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Password ',
                                    textFormFieldController:
                                        controller.registerPasswordController,
                                    focusNode: controller.passwordFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller
                                                .confirmPasswordFocusNode),
                                    isPassword: true,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    validator: (value) =>
                                        controller.passwordValidate(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Confirm password',
                                    textFormFieldController: controller
                                        .registerConfirmPasswordController,
                                    focusNode:
                                        controller.confirmPasswordFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.phoneFocusNode),
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    isPassword: true,
                                    validator: (value) =>
                                        controller.confirmPassword(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Phone',
                                    textFormFieldController:
                                        controller.registerPhoneController,
                                    focusNode: controller.phoneFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.ageFocusNode),
                                    textInputType: TextInputType.phone,
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Age',
                                    textFormFieldController:
                                        controller.registerAgeController,
                                    focusNode: controller.ageFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.jobFocusNode),
                                    textInputType: TextInputType.number,
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Job',
                                    textFormFieldController:
                                        controller.registerJopController,
                                    focusNode: controller.jobFocusNode,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.workPlaceFocusNode),
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Workplace',
                                    textFormFieldController: controller
                                        .registerWorkingPlaceController,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.specialtyFocusNode),
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    focusNode: controller.workPlaceFocusNode,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Specialty',
                                    textFormFieldController:
                                        controller.registerSpecialtyController,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.highestDegreeFocusNode),
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    focusNode: controller.specialtyFocusNode,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Highest Degree',
                                    textFormFieldController: controller
                                        .registerHighestDegreeController,
                                    enableSuggestions: true,
                                    textInputType: TextInputType.text,
                                    focusNode:
                                        controller.highestDegreeFocusNode,
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: size.height * 0.21),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.18,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => controller.isRegisterLoading.value
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
                                            if (controller
                                                .registerFormKey.currentState!
                                                .validate()) {
                                              controller.register();
                                            }
                                          },
                                          title: 'Register'),
                                    ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed(AppRoutes.signIn);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      bottom:
                                          1, // Space between underline and text
                                    ),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.blue,
                                      width: 1.0, // Underline thickness
                                    ))),
                                    child: const Text(
                                      "Sign in now!",
                                      style: TextStyle(
                                        color: Colors.blue,
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
                    ],
                  ),
                ),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
