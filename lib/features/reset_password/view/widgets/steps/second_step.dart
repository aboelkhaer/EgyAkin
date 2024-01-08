import '../../../../../exports.dart';
import '../otp_all_content.dart';

class SecondStep extends GetView<ResetPasswordController> {
  const SecondStep({super.key});

  @override
  Widget build(BuildContext context) {
    return OTPAllContent(
      emailAddress: controller.email,
      changeEmailFunction: () {
        controller.currentStep.value = 0;
      },
      formKey: controller.secondStepFormKey,
      firstOTPFocusNode: controller.firstOTPFocusNode,
      firstOTPOnChanged: (value) {
        if (value.length == 1) {
          controller.pin1 = value;
          if ((controller.pin1 != null && controller.pin1!.isNotEmpty) &&
              (controller.pin2 != null && controller.pin2!.isNotEmpty) &&
              (controller.pin3 != null && controller.pin3!.isNotEmpty) &&
              (controller.pin4 != null && controller.pin4!.isNotEmpty)) {
            controller.isOTPDone(true);
            // controller.verifyOTP();
          } else {
            controller.isOTPDone(false);
          }
          FocusScope.of(context).nextFocus();
        }
      },
      secondOTPOnChanged: (value) {
        if (value.length == 1) {
          controller.pin2 = value;
          if ((controller.pin1 != null && controller.pin1!.isNotEmpty) &&
              (controller.pin2 != null && controller.pin2!.isNotEmpty) &&
              (controller.pin3 != null && controller.pin3!.isNotEmpty) &&
              (controller.pin4 != null && controller.pin4!.isNotEmpty)) {
            controller.isOTPDone(true);
            // controller.verifyOTP();
          } else {
            controller.isOTPDone(false);
          }
          FocusScope.of(context).nextFocus();
        }
      },
      thirdOTPOnChanged: (value) {
        if (value.length == 1) {
          controller.pin3 = value;
          if ((controller.pin1 != null && controller.pin1!.isNotEmpty) &&
              (controller.pin2 != null && controller.pin2!.isNotEmpty) &&
              (controller.pin3 != null && controller.pin3!.isNotEmpty) &&
              (controller.pin4 != null && controller.pin4!.isNotEmpty)) {
            controller.isOTPDone(true);
            // controller.verifyOTP();
          } else {
            controller.isOTPDone(false);
          }
          FocusScope.of(context).nextFocus();
        }
      },
      fourthOTPOnChanged: (value) {
        if (value.length == 1) {
          controller.pin4 = value;
          if ((controller.pin1 != null && controller.pin1!.isNotEmpty) &&
              (controller.pin2 != null && controller.pin2!.isNotEmpty) &&
              (controller.pin3 != null && controller.pin3!.isNotEmpty) &&
              (controller.pin4 != null && controller.pin4!.isNotEmpty)) {
            controller.isOTPDone(true);
            // controller.verifyOTP();
          } else {
            controller.isOTPDone(false);
          }
          FocusScope.of(context).nextFocus();
        }
      },
      firstOTPValidator: (value) {
        return controller.registerController.fieldsIsEmptyValidation(value!);
      },
      secondOTPValidator: (value) {
        return controller.registerController.fieldsIsEmptyValidation(value!);
      },
      thirdOTPValidator: (value) {
        return controller.registerController.fieldsIsEmptyValidation(value!);
      },
      fourthOTPValidator: (value) {
        return controller.registerController.fieldsIsEmptyValidation(value!);
      },
      timerWidget: Obx(
        () => Text(
          Get.find<ResetPasswordController>().getFormattedTime(),
          style: TextStyle(
            color: Colors.blue.shade600,
          ),
        ),
      ),
    );
  }
}
