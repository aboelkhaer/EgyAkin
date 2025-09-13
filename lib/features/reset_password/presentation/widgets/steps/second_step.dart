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
              firstOTPFocusNode: cubit.firstOTPFocusNode,
              secondOTPFocusNode: cubit.secondOTPFocusNode,
              thirdOTPFocusNode: cubit.thirdOTPFocusNode,
              fourthOTPFocusNode: cubit.fourthOTPFocusNode,
              firstOTPOnChanged: (value) {
                cubit.pin1 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  // If field is cleared, focus stays on current field
                  cubit.isOTPDone = false;
                }
              },
              secondOTPOnChanged: (value) {
                cubit.pin2 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  // If field is cleared, move focus to previous field
                  cubit.firstOTPFocusNode.requestFocus();
                  cubit.isOTPDone = false;
                }
              },
              thirdOTPOnChanged: (value) {
                cubit.pin3 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  // If field is cleared, move focus to previous field
                  cubit.secondOTPFocusNode.requestFocus();
                  cubit.isOTPDone = false;
                }
              },
              fourthOTPOnChanged: (value) {
                cubit.pin4 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                } else if (value.isEmpty) {
                  // If field is cleared, move focus to previous field
                  cubit.thirdOTPFocusNode.requestFocus();
                  cubit.isOTPDone = false;
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
              firstOTPFocusNode: cubit.firstOTPFocusNode,
              secondOTPFocusNode: cubit.secondOTPFocusNode,
              thirdOTPFocusNode: cubit.thirdOTPFocusNode,
              fourthOTPFocusNode: cubit.fourthOTPFocusNode,
              firstOTPOnChanged: (value) {
                cubit.pin1 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  // If field is cleared, focus stays on current field
                  cubit.isOTPDone = false;
                }
              },
              secondOTPOnChanged: (value) {
                cubit.pin2 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  // If field is cleared, move focus to previous field
                  cubit.firstOTPFocusNode.requestFocus();
                  cubit.isOTPDone = false;
                }
              },
              thirdOTPOnChanged: (value) {
                cubit.pin3 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  // If field is cleared, move focus to previous field
                  cubit.secondOTPFocusNode.requestFocus();
                  cubit.isOTPDone = false;
                }
              },
              fourthOTPOnChanged: (value) {
                cubit.pin4 = value;
                if (value.length == 1) {
                  if ((cubit.pin1 != null && cubit.pin1!.isNotEmpty) &&
                      (cubit.pin2 != null && cubit.pin2!.isNotEmpty) &&
                      (cubit.pin3 != null && cubit.pin3!.isNotEmpty) &&
                      (cubit.pin4 != null && cubit.pin4!.isNotEmpty)) {
                    cubit.isOTPDone = true;
                  } else {
                    cubit.isOTPDone = false;
                  }
                } else if (value.isEmpty) {
                  // If field is cleared, move focus to previous field
                  cubit.thirdOTPFocusNode.requestFocus();
                  cubit.isOTPDone = false;
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
                cubit.getFormattedTime(cubit.countdown),
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
