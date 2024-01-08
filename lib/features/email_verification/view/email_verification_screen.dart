import '../../../exports.dart';
import '../../reset_password/view/widgets/otp_all_content.dart';
import '../controller/email_verification_controller.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  EmailVerificationController controller =
      Get.find<EmailVerificationController>();
  @override
  void initState() {
    controller.sendEmailForResetPassword(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Obx(
        () => controller.isSendEmailLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Image.asset(
                          AppImages.emailVerification,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      OTPAllContent(
                        emailAddress: RxString(controller
                            .homeController.currentDoctorEmail
                            .toString()),
                        formKey: controller.emailVerificationOTPFormKey,
                        firstOTPFocusNode: controller.firstOTPFocusNode,
                        firstOTPOnChanged: (value) {
                          if (value.length == 1) {
                            controller.pin1 = value;
                            if ((controller.pin1 != null &&
                                    controller.pin1!.isNotEmpty) &&
                                (controller.pin2 != null &&
                                    controller.pin2!.isNotEmpty) &&
                                (controller.pin3 != null &&
                                    controller.pin3!.isNotEmpty) &&
                                (controller.pin4 != null &&
                                    controller.pin4!.isNotEmpty)) {
                              controller.isOTPDone(true);
                            } else {
                              controller.isOTPDone(false);
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        secondOTPOnChanged: (value) {
                          if (value.length == 1) {
                            controller.pin2 = value;
                            if ((controller.pin1 != null &&
                                    controller.pin1!.isNotEmpty) &&
                                (controller.pin2 != null &&
                                    controller.pin2!.isNotEmpty) &&
                                (controller.pin3 != null &&
                                    controller.pin3!.isNotEmpty) &&
                                (controller.pin4 != null &&
                                    controller.pin4!.isNotEmpty)) {
                              controller.isOTPDone(true);
                            } else {
                              controller.isOTPDone(false);
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        thirdOTPOnChanged: (value) {
                          if (value.length == 1) {
                            controller.pin3 = value;
                            if ((controller.pin1 != null &&
                                    controller.pin1!.isNotEmpty) &&
                                (controller.pin2 != null &&
                                    controller.pin2!.isNotEmpty) &&
                                (controller.pin3 != null &&
                                    controller.pin3!.isNotEmpty) &&
                                (controller.pin4 != null &&
                                    controller.pin4!.isNotEmpty)) {
                              controller.isOTPDone(true);
                            } else {
                              controller.isOTPDone(false);
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        fourthOTPOnChanged: (value) {
                          if (value.length == 1) {
                            controller.pin4 = value;
                            if ((controller.pin1 != null &&
                                    controller.pin1!.isNotEmpty) &&
                                (controller.pin2 != null &&
                                    controller.pin2!.isNotEmpty) &&
                                (controller.pin3 != null &&
                                    controller.pin3!.isNotEmpty) &&
                                (controller.pin4 != null &&
                                    controller.pin4!.isNotEmpty)) {
                              controller.isOTPDone(true);
                              // controller.verifyOTP();
                            } else {
                              controller.isOTPDone(false);
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        firstOTPValidator: (value) {
                          return controller.registerController
                              .fieldsIsEmptyValidation(value!);
                        },
                        secondOTPValidator: (value) {
                          return controller.registerController
                              .fieldsIsEmptyValidation(value!);
                        },
                        thirdOTPValidator: (value) {
                          return controller.registerController
                              .fieldsIsEmptyValidation(value!);
                        },
                        fourthOTPValidator: (value) {
                          return controller.registerController
                              .fieldsIsEmptyValidation(value!);
                        },
                        timerWidget: Obx(
                          () => Text(
                            controller.getFormattedTime(),
                            style: TextStyle(
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),
                        changeEmailFunction: () {
                          Get.toNamed(AppRoutes.doctorProfile);
                        },
                      ),
                      const SizedBox(height: 50),
                      controller.isVerifyOTP.value
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
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: CustomElevatedButton(
                                    size: size,
                                    onPressed: () {
                                      controller.emailVerificationOTP();
                                    },
                                    title: 'Confirm',
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: controller.isResendBottonShow.value
                                      ? CustomOutlineBotton(
                                          onPressed: () {},
                                          title: 'Resend',
                                          isFlatBotton: true,
                                          size: size,
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
