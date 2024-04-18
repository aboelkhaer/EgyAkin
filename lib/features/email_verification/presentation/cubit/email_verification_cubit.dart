import 'package:egy_akin/features/email_verification/domain/usecases/send_otp_for_email_verification_usecase.dart';
import 'package:egy_akin/features/email_verification/presentation/cubit/email_verification_state.dart';

import '../../../../exports.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit(
    this._sendEmailForVerificationUsecase,
    this._sendOTPForEmailVerificationUsecase,
  ) : super(const EmailVerificationState.initial());
  static EmailVerificationCubit get(context) => BlocProvider.of(context);
  final SendEmailForVerificationUsecase _sendEmailForVerificationUsecase;
  final SendOTPForEmailVerificationUsecase _sendOTPForEmailVerificationUsecase;
  String? pin1, pin2, pin3, pin4;
  bool isResendBottonShow = false;
  GlobalKey<FormState> emailVerificationOTPFormKey = GlobalKey<FormState>();
  FocusNode firstOTPFocusNode = FocusNode();

  late Timer _timer;
  int countdown = AppStrings.resendTimer;
  bool isOTPDone = false;

  @override
  Future<void> close() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    firstOTPFocusNode.dispose();
    return super.close();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      if (countdown <= 0) {
        _timer.cancel();
        // isResendBottonShow = true;
        emit(const EmailVerificationState.countDowncompleted());
      } else {
        // isResendBottonShow = false;
        emit(EmailVerificationState.countDownInProgress(countdown));
      }
    });
    // isResendBottonShow = false;
    emit(EmailVerificationState.countDownInProgress(countdown));
  }

  String getFormattedTime(int countDownState) {
    int minutes = countDownState ~/ 60;
    int seconds = countDownState % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void resendOtp() async {
    // isResendBottonShow = false;
    countdown = AppStrings.resendTimer;
    startCountdown();
    final result = await _sendEmailForVerificationUsecase.excute(NoParams());
    result.fold(
      (l) => emit(EmailVerificationState.error(l.message)),
      (r) {
        emit(const EmailVerificationState.loaded());
      },
    );
  }

  sendEmailForVerification() async {
    emit(const EmailVerificationState.loading());

    final result = await _sendEmailForVerificationUsecase.excute(NoParams());
    result.fold(
      (l) => emit(EmailVerificationState.error(l.message)),
      (r) {
        emit(const EmailVerificationState.loaded());
        startCountdown();
      },
    );
  }

  sendOTPForEmailVerification() async {
    emit(const EmailVerificationState.loading());

    final result = await _sendOTPForEmailVerificationUsecase
        .excute('$pin1$pin2$pin3$pin4');
    result.fold(
      (l) => emit(EmailVerificationState.error(l.message)),
      (r) {
        emit(const EmailVerificationState.emailVerificationComplete());
      },
    );
  }
}
