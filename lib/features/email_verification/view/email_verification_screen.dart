import 'package:EgyAkin/features/email_verification/controller/email_verification_controller.dart';

import '../../../exports.dart';

class EmailVerificationScreen extends GetView<EmailVerificationController> {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
    );
  }
}
