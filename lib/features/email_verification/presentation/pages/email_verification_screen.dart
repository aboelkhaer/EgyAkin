import 'package:egy_akin/features/email_verification/presentation/cubit/email_verification_cubit.dart';

import '../../../../exports.dart';

class EmailVerifciationScreen extends StatelessWidget {
  const EmailVerifciationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EmailVerificationCubit cubit = EmailVerificationCubit.get(context);
    return const Scaffold();
  }
}
