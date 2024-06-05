import '../../../../../exports.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit cubit = ResetPasswordCubit.get(context);
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        return state.maybeWhen(
          countDownInProgress: (remainingSeconds) {
            return OTPAllContent(
              emailAddress: cubit.email,
              changeEmailFunction: () => cubit.backToSetEmail(),
              formKey: cubit.secondStepFormKey,
              // firstOTPFocusNode: cubit.firstOTPFocusNode,
              firstOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin1 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              secondOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin2 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                    // controller.verifyOTP();
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              thirdOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin3 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                    // controller.verifyOTP();
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              fourthOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin4 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                    // controller.verifyOTP();
                  } else {
                    cubit.isOTPDone = true;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              firstOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              secondOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              thirdOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              fourthOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              timerWidget: Text(
                cubit.getFormattedTime(remainingSeconds),
                style: TextStyle(
                  color: Colors.blue.shade600,
                ),
              ),
            );
          },
          orElse: () {
            return OTPAllContent(
              emailAddress: cubit.email,
              changeEmailFunction: () => cubit.backToSetEmail(),
              formKey: cubit.secondStepFormKey,
              // firstOTPFocusNode: cubit.firstOTPFocusNode,
              firstOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin1 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              secondOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin2 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                    // controller.verifyOTP();
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              thirdOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin3 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                    // controller.verifyOTP();
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              fourthOTPOnChanged: (value) {
                if (value.length == 1) {
                  cubit.pin4 = value;
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                    // controller.verifyOTP();
                  } else {
                    cubit.isOTPDone = true;
                  }
                  FocusScope.of(context).nextFocus();
                }
              },
              firstOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              secondOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              thirdOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              fourthOTPValidator: (value) {
                return AppValidators.fieldsIsEmptyValidation(value!);
              },
              timerWidget: Text(
                cubit.getFormattedTime(0),
                style: TextStyle(
                  color: Colors.blue.shade600,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
