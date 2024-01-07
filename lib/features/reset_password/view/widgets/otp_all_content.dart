import '../../../../exports.dart';
import 'otp_row.dart';

class OTPAllContent extends StatelessWidget {
  final RxString emailAddress;
  final Function() changeEmailFunction;
  final Key formKey;
  final FocusNode firstOTPFocusNode;
  final Function(String) firstOTPOnChanged;
  final Function(String) secondOTPOnChanged;
  final Function(String) thirdOTPOnChanged;
  final Function(String) fourthOTPOnChanged;
  final String? Function(String?) firstOTPValidator;
  final String? Function(String?) secondOTPValidator;
  final String? Function(String?) thirdOTPValidator;
  final String? Function(String?) fourthOTPValidator;

  const OTPAllContent({
    super.key,
    required this.emailAddress,
    required this.changeEmailFunction,
    required this.formKey,
    required this.firstOTPFocusNode,
    required this.firstOTPOnChanged,
    required this.secondOTPOnChanged,
    required this.thirdOTPOnChanged,
    required this.fourthOTPOnChanged,
    required this.firstOTPValidator,
    required this.secondOTPValidator,
    required this.thirdOTPValidator,
    required this.fourthOTPValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Verification code',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Row(
          children: [
            Text(
              'We have sent the code verification to',
              style: TextStyle(fontSize: 16, color: AppColors.description),
            ),
          ],
        ),
        Row(
          children: [
            Obx(
              () => Text(
                emailAddress.value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.title,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: changeEmailFunction,
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent,
                ),
              ),
              child: Text(
                'Change your email?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade600,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        OTPRow(
          formKey: formKey,
          firstOTPFocusNode: firstOTPFocusNode,
          firstOTPOnChanged: firstOTPOnChanged,
          secondOTPOnChanged: secondOTPOnChanged,
          thirdOTPOnChanged: thirdOTPOnChanged,
          fourthOTPOnChanged: fourthOTPOnChanged,
          firstOTPValidator: firstOTPValidator,
          secondOTPValidator: secondOTPValidator,
          thirdOTPValidator: thirdOTPValidator,
          fourthOTPValidator: fourthOTPValidator,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Resend code after',
              style: TextStyle(color: AppColors.description),
            ),
            const SizedBox(width: 5),
            Obx(
              () => Text(
                Get.find<ResetPasswordController>().getFormattedTime(),
                style: TextStyle(
                  color: Colors.blue.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
