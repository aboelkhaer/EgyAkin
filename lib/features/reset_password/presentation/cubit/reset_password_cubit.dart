import '../../../../exports.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(
      this._sendEmailForResetPasswordUsecase,
      this._verifyOTPForResetPasswordUsecase,
      this._changePasswordForResetPasswordUsecase)
      : super(const ResetPasswordState.initial());
  final SendEmailForResetPasswordUsecase _sendEmailForResetPasswordUsecase;
  final VerifyOTPForResetPasswordUsecase _verifyOTPForResetPasswordUsecase;
  final ChangePasswordForResetPasswordUsecase
      _changePasswordForResetPasswordUsecase;
  static ResetPasswordCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> firstStepFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> secondStepFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> thirdStepFormKey = GlobalKey<FormState>();
  String? pin1, pin2, pin3, pin4;
  bool isResendBottonShow = false;
  bool isOTPDone = false;
  // bool isVerifyOTP = false;
  // FocusNode firstOTPFocusNode = FocusNode();

  String email = '';
  int currentStep = 0;
  TextEditingController newPasswordController = TextEditingController();

  late Timer _timer;
  int countdown = AppStrings.resendTimer;

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      if (countdown <= 0) {
        _timer.cancel();
        isResendBottonShow = true;
        emit(const ResetPasswordState.countDowncompleted());
      } else {
        isResendBottonShow = false;
        emit(ResetPasswordState.countDownInProgress(countdown));
      }
    });
    isResendBottonShow = false;
    emit(ResetPasswordState.countDownInProgress(countdown));
  }

  @override
  Future<void> close() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    newPasswordController.dispose();
    // firstOTPFocusNode.dispose();
    return super.close();
  }

  String getFormattedTime(int countDownState) {
    int minutes = countDownState ~/ 60;
    int seconds = countDownState % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  List<Step> getSteps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text(AppStrings.email),
        content: const FirstStep(),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text(AppStrings.verify),
        content: const SecondStep(),
      ),
      Step(
        state: StepState.complete,
        isActive: currentStep >= 2,
        title: const Text(AppStrings.password),
        content: const ThirdStep(),
      ),
    ];
  }

  void resendOtp(context) async {
    isResendBottonShow = false;
    countdown = AppStrings.resendTimer;
    startCountdown();
    final result = await _sendEmailForResetPasswordUsecase.excute(email);
    result.fold(
      (l) => emit(ResetPasswordState.error(l.message)),
      (r) {
        emit(const ResetPasswordState.loaded());
      },
    );
  }

  sendEmailForResetPassword() async {
    if (firstStepFormKey.currentState!.validate()) {
      emit(const ResetPasswordState.loading());

      final result = await _sendEmailForResetPasswordUsecase.excute(email);
      result.fold(
        (l) => emit(ResetPasswordState.error(l.message)),
        (r) {
          currentStep += 1;
          emit(const ResetPasswordState.loaded());
          startCountdown();
        },
      );
    }
  }

  backToSetEmail() {
    currentStep = 0;
    emit(const ResetPasswordState.initial());
  }

  verifyOTP() async {
    if (secondStepFormKey.currentState!.validate()) {
      if (_timer.isActive) {
        _timer.cancel();
      }
      emit(const ResetPasswordState.loading());

      final result = await _verifyOTPForResetPasswordUsecase.excute(
        VerifyOTPForResetPasswordUseCaseInput(
          email: email,
          otp: '$pin1$pin2$pin3$pin4',
        ),
      );
      result.fold(
        (l) => emit(ResetPasswordState.error(l.message)),
        (r) {
          currentStep += 1;
          emit(const ResetPasswordState.loaded());
        },
      );
    }
  }

  changePassword(context) async {
    if (thirdStepFormKey.currentState!.validate()) {
      emit(const ResetPasswordState.loading());

      final result = await _changePasswordForResetPasswordUsecase.excute(
        ChangePasswordForResetPasswordUseCaseInput(
          email: email,
          password: newPasswordController.text,
        ),
      );
      result.fold(
        (l) => emit(ResetPasswordState.error(l.message)),
        (r) => emit(const ResetPasswordState.passwordChagedSuccessfully()),
      );
    }
  }
}
