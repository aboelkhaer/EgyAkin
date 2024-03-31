import 'package:egy_akin/features/email_verification/presentation/cubit/email_verification_state.dart';

import '../../../../exports.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit() : super(const EmailVerificationState.initial());
  static EmailVerificationCubit get(context) => BlocProvider.of(context);
}
