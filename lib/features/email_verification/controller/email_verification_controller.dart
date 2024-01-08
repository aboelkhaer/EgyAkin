import '../../../exports.dart';

class EmailVerificationController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  RegisterController registerController = Get.find<RegisterController>();

  GlobalKey<FormState> emailVerificationOTPFormKey = GlobalKey<FormState>();
  FocusNode firstOTPFocusNode = FocusNode();
  String? pin1, pin2, pin3, pin4;
  RxBool isOTPDone = false.obs;
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    firstOTPFocusNode.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  final RxInt countdown = AppStrings.resendTimer.obs;
  Timer? _timer;

  RxBool isResendBottonShow = false.obs;
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
        if (_timer != null) {
          _timer!.cancel();
        }
      }
    });
  }

  void resendOtp(context) async {
    // Implement the logic to resend OTP here
    // await resetPasswordRepository.sendEmailForResetPassword(
    //   email: email.value,
    //   context: context,
    // );

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

  EmailVerificationRepository emailVerificationRepository =
      Get.find<EmailVerificationRepository>();

  RxBool isSendEmailLoading = false.obs;
  sendEmailForResetPassword(context) async {
    isSendEmailLoading(true);

    await emailVerificationRepository.sendEmailVerification(
      context: context,
      email: homeController.currentDoctorEmail!,
    );

    isSendEmailLoading(false);

    update();
  }

  RxBool isVerifyOTP = false.obs;
  emailVerificationOTP() async {
    if (emailVerificationOTPFormKey.currentState!.validate()) {
      isVerifyOTP(true);
      await emailVerificationRepository.emailVerificationOTP(
        otp: '$pin1$pin2$pin3$pin4',
      );
      isVerifyOTP(false);
    }

    update();
  }
}
