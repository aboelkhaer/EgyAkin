import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../../exports.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController controller = Get.put(RegisterController());
  late TextEditingController registerFirstNameController,
      registerLastNameController,
      registerEmailController,
      registerPasswordController,
      registerConfirmPasswordController,
      registerPhoneController,
      registerJopController,
      registerSpecialtyController,
      registerWorkingPlaceController,
      registerRegisterationNumberController,
      registerAgeController;

  String highestDegree = '';
  GlobalKey<FormState>? registerFormKey;

  initTextFieldController() {
    registerFormKey = GlobalKey<FormState>();
    registerFirstNameController = TextEditingController();
    registerLastNameController = TextEditingController();
    registerEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    registerConfirmPasswordController = TextEditingController();
    registerPhoneController = TextEditingController();
    registerJopController = TextEditingController();
    registerSpecialtyController = TextEditingController();
    registerWorkingPlaceController = TextEditingController();
    registerRegisterationNumberController = TextEditingController();
    registerAgeController = TextEditingController();
  }

  resetRegisterForm() {
    if (registerFormKey?.currentState != null) {
      registerFormKey?.currentState!.reset();
    }
    registerFirstNameController.clear();
    registerLastNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    registerPhoneController.clear();
    registerJopController.clear();
    registerSpecialtyController.clear();
    registerWorkingPlaceController.clear();
    registerRegisterationNumberController.clear();
    registerAgeController.clear();
  }

  disposeControllers() {
    registerFirstNameController.dispose();
    registerLastNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerPhoneController.dispose();
    registerJopController.dispose();
    registerSpecialtyController.dispose();
    registerWorkingPlaceController.dispose();
    registerRegisterationNumberController.dispose();
    registerAgeController.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    phoneFocusNode.dispose();
    ageFocusNode.dispose();
    specialtyFocusNode.dispose();
    jobFocusNode.dispose();
    registerationNumberFocusNode.dispose();
    workPlaceFocusNode.dispose();
  }

  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode specialtyFocusNode = FocusNode();
  FocusNode jobFocusNode = FocusNode();
  FocusNode registerationNumberFocusNode = FocusNode();
  FocusNode workPlaceFocusNode = FocusNode();

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
                        AppImages.register,
                        width: double.infinity,
                        height: size.height * 0.45,
                      ),
                      Form(
                        key: registerFormKey,
                        autovalidateMode: controller.registerErrorValid == 0
                            ? AutovalidateMode.disabled
                            : AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: AppStrings.firstName,
                                    textFormFieldController:
                                        registerFirstNameController,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context)
                                            .requestFocus(lastNameFocusNode),
                                    enableSuggestions: true,
                                    validator: (value) => controller
                                        .firstAndLastNameValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: AppStrings.lastName,
                                    textFormFieldController:
                                        registerLastNameController,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context)
                                            .requestFocus(emailFocusNode),
                                    focusNode: lastNameFocusNode,
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
                              title: AppStrings.email,
                              textFormFieldController: registerEmailController,
                              onFieldSubmitted: (v) => FocusScope.of(context)
                                  .requestFocus(passwordFocusNode),
                              focusNode: emailFocusNode,
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
                                    title: AppStrings.password,
                                    textFormFieldController:
                                        registerPasswordController,
                                    focusNode: passwordFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            confirmPasswordFocusNode),
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
                                    title: AppStrings.confirmPassword,
                                    textFormFieldController:
                                        registerConfirmPasswordController,
                                    focusNode: confirmPasswordFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context)
                                            .requestFocus(phoneFocusNode),
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    isPassword: true,
                                    validator: (value) =>
                                        controller.confirmPassword(
                                      value!,
                                      registerPasswordController.text,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            FlutterPwValidator(
                                controller: registerPasswordController,
                                minLength: 6,
                                uppercaseCharCount: 1,
                                numericCharCount: 2,
                                specialCharCount: 1,
                                width: 400,
                                height: 150,
                                onSuccess: () {},
                                onFail: () {
                                  return null;
                                }),
                            SizedBox(height: size.height * 0.04),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: AppStrings.phone,
                                    textFormFieldController:
                                        registerPhoneController,
                                    focusNode: phoneFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context)
                                            .requestFocus(ageFocusNode),
                                    textInputType: TextInputType.phone,
                                    validator: (value) =>
                                        controller.validatePhoneNumber(value!),
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: AppStrings.age,
                                    textFormFieldController:
                                        registerAgeController,
                                    focusNode: ageFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context)
                                            .requestFocus(jobFocusNode),
                                    textInputType: TextInputType.number,
                                    validator: (value) =>
                                        controller.validateAge(value!),
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
                                    title: AppStrings.job,
                                    textFormFieldController:
                                        registerJopController,
                                    focusNode: jobFocusNode,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context)
                                            .requestFocus(workPlaceFocusNode),
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: AppStrings.workplace,
                                    textFormFieldController:
                                        registerWorkingPlaceController,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            registerationNumberFocusNode),
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    focusNode: workPlaceFocusNode,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: const [
                                      // LengthLimitingTextInputFormatter(11),
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
                                    title: AppStrings.fullRegisterationNumber,
                                    textFormFieldController:
                                        registerRegisterationNumberController,
                                    focusNode: registerationNumberFocusNode,
                                    textInputType: TextInputType.number,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context)
                                            .requestFocus(specialtyFocusNode),
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
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      CustomTextFormField(
                                        title: AppStrings.specialty,
                                        textFormFieldController:
                                            registerSpecialtyController,
                                        textInputType: TextInputType.text,
                                        // onFieldSubmitted: (v) =>
                                        //     FocusScope.of(context).requestFocus(
                                        //         highestDegreeFocusNode),
                                        validator: (value) => controller
                                            .fieldsIsEmptyValidation(value!),
                                        focusNode: specialtyFocusNode,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  // child: CustomTextFormField(
                                  //   title: 'Highest Degree',
                                  //   textFormFieldController:
                                  //       registerHighestDegreeController,
                                  //   enableSuggestions: true,
                                  //   textInputType: TextInputType.text,
                                  //   focusNode: highestDegreeFocusNode,
                                  //   validator: (value) => controller
                                  //       .fieldsIsEmptyValidation(value!),
                                  //   textInputAction: TextInputAction.done,
                                  // ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primary.withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButtonFormField<dynamic>(
                                      hint: const Text(AppStrings.choose),

                                      items: controller.highestDegreeList
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),

                                      onChanged: (val) {
                                        if (val != null) {
                                          highestDegree = val;
                                        }
                                        setState(() {});
                                      },
                                      validator: (val) {
                                        if ((val == null || val == '')) {
                                          return AppStrings.thisFieldIsRequired;
                                        }

                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                      // decoration: const InputDecoration(label: Text('Choose')),
                                    ),
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
                                          if (registerFormKey!.currentState!
                                              .validate()) {
                                            controller.register(
                                              firstName:
                                                  registerFirstNameController
                                                      .text,
                                              lastName:
                                                  registerLastNameController
                                                      .text,
                                              age: registerAgeController.text,
                                              email:
                                                  registerEmailController.text,
                                              highestDegree: highestDegree,
                                              job: registerJopController.text,
                                              password:
                                                  registerPasswordController
                                                      .text,
                                              passwordConfirmation:
                                                  registerConfirmPasswordController
                                                      .text,
                                              phone:
                                                  registerPhoneController.text,
                                              registrationNumber:
                                                  registerRegisterationNumberController
                                                      .text,
                                              specialty:
                                                  registerSpecialtyController
                                                      .text,
                                              workingPlace:
                                                  registerWorkingPlaceController
                                                      .text,
                                            );
                                          }
                                        },
                                        title: AppStrings.register,
                                      ),
                                    ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.alreadyHaveAnAccount,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed(AppRoutes.signIn);
                                    // resetRegisterForm();
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
                                      AppStrings.signInNow,
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
