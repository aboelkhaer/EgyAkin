import '../../../exports.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary.withOpacity(0.8),
          ),
        ),
        child: Obx(
          () => Stepper(
            type: StepperType.horizontal,
            currentStep: controller.currentStep.value,
            controlsBuilder: (context, details) {
              return Obx(
                () => Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: controller.isSendEmailLoading.value ||
                          controller.isVerifyOTP.value ||
                          controller.isChangePassword.value
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 50,
                              child: CustomElevatedButton(
                                  size: size,
                                  isDisable: controller.currentStep.value == 0
                                      ? false
                                      : controller.currentStep.value == 1 &&
                                              controller.isOTPDone.value
                                          ? false
                                          : false,
                                  onPressed: () {
                                    if (controller.currentStep.value == 0) {
                                      controller
                                          .sendEmailForResetPassword(context);
                                    } else if (controller.currentStep.value ==
                                        1) {
                                      controller.verifyOTP();
                                    } else if (controller.currentStep.value ==
                                        2) {
                                      controller.changePassword();
                                    }
                                  },
                                  title: controller.currentStep.value == 0
                                      ? 'Continue'
                                      : controller.currentStep.value == 1
                                          ? 'Confirm'
                                          : 'Save'),
                            ),
                            const SizedBox(height: 5),
                            controller.currentStep.value == 0
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: 50,
                                    child: controller.isResendBottonShow.value
                                        ? CustomOutlineBotton(
                                            onPressed: () {
                                              // if (controller.currentStep.value > 0) {
                                              //   controller.currentStep.value -= 1;
                                              //   log(controller.currentStep.value
                                              //       .toString());
                                              // } else {
                                              //   Get.back();
                                              // }
                                              if (controller
                                                      .currentStep.value ==
                                                  0) {
                                              } else if (controller
                                                      .currentStep.value ==
                                                  1) {
                                                controller.isResendBottonShow
                                                        .value =
                                                    !controller
                                                        .isResendBottonShow
                                                        .value;
                                                controller.resendOtp(context);
                                              } else if (controller
                                                      .currentStep.value ==
                                                  2) {}
                                            },
                                            title:
                                                controller.currentStep.value ==
                                                        0
                                                    ? 'Cancel'
                                                    : controller.currentStep
                                                                .value ==
                                                            1
                                                        ? 'Resend'
                                                        : 'Back',
                                            isFlatBotton: true,
                                            size: size,
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                          ],
                        ),
                ),
              );
            },
            steps: getSteps(),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: controller.currentStep >= 0,
        title: const Text('Email'),
        content: const FirstStep(),
      ),
      Step(
        state:
            controller.currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: controller.currentStep >= 1,
        title: const Text('Verity'),
        content: const SecondStep(),
      ),
      Step(
        state: StepState.complete,
        isActive: controller.currentStep >= 2,
        title: const Text('Password'),
        content: const ThirdStep(),
      ),
    ];
  }
}
