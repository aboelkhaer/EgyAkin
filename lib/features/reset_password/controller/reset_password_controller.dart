import '../../../exports.dart';
import 'reset_password_repo.dart';

class ResetPasswordController extends GetxController {
  ResetPasswordRepository resetPasswordRepository =
      Get.find<ResetPasswordRepository>();
  GlobalKey<FormState> firstStepFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> secondStepFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> thirdStepFormKey = GlobalKey<FormState>();
  RegisterController registerController = Get.find<RegisterController>();
  FocusNode firstOTPFocusNode = FocusNode();
  String? pin1, pin2, pin3, pin4;
  RxBool isOTPDone = false.obs;
  RxBool isResendBottonShow = false.obs;

  TextEditingController newPasswordController = TextEditingController();
  // String newPassword = '';
  // String confirmPassword = '';
  final RxInt countdown = AppStrings.resendTimer.obs;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        isResendBottonShow(false);
        countdown.value--;
      } else {
        // Timer has ended, perform your action here
        print('Timer has ended. Perform your action.');
        isResendBottonShow(true);

        // Cancel the timer
        _timer!.cancel();
      }
    });
  }

  void resendOtp(context) async {
    isResendBottonShow(false);
    // Implement the logic to resend OTP here
    await resetPasswordRepository.sendEmailForResetPassword(
      email: email.value,
      context: context,
    );

    // Reset the countdown timer
    countdown.value = AppStrings.resendTimer;
    startTimer();
    update();
  }

  String getFormattedTime() {
    // Convert seconds to mm:ss format
    int minutes = countdown.value ~/ 60;
    int seconds = countdown.value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    firstOTPFocusNode.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    newPasswordController.dispose();
    super.onClose();
  }

  RxString email = ''.obs;
  RxInt currentStep = 0.obs;

  RxBool isSendEmailLoading = false.obs;
  sendEmailForResetPassword(context) async {
    if (firstStepFormKey.currentState!.validate()) {
      isSendEmailLoading(true);

      await resetPasswordRepository.sendEmailForResetPassword(
        email: email.value,
        context: context,
      );

      isSendEmailLoading(false);
    }

    update();
  }

  RxBool isVerifyOTP = false.obs;
  verifyOTP() async {
    if (secondStepFormKey.currentState!.validate()) {
      isVerifyOTP(true);
      await resetPasswordRepository.verifyOTP(
        email: email.value,
        otp: '$pin1$pin2$pin3$pin4',
      );
      isVerifyOTP(false);
    }

    update();
  }

  RxBool isChangePassword = false.obs;
  changePassword() async {
    if (secondStepFormKey.currentState!.validate()) {
      isChangePassword(true);
      await resetPasswordRepository.changePassword(
        email: email.value,
        newPassword: newPasswordController.text,
      );
      isChangePassword(false);
    }

    update();
  }
}
