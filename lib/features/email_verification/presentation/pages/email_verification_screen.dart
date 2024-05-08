import '../../../../exports.dart';

class EmailVerifciationScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  const EmailVerifciationScreen({super.key, required this.currentDoctorModel});

  @override
  State<EmailVerifciationScreen> createState() =>
      _EmailVerifciationScreenState();
}

class _EmailVerifciationScreenState extends State<EmailVerifciationScreen> {
  @override
  void initState() {
    context.read<EmailVerificationCubit>().sendEmailForVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EmailVerificationCubit cubit = EmailVerificationCubit.get(context);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.emailVerification)),
      body: BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            emailVerificationComplete: () {
              navigatorKey.currentState?.pushReplacementNamed(AppRoutes.home);
            },
            error: (message) {
              customSnackBar(message: message, context: context);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return SingleChildScrollView(
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
                        emailAddress: widget.currentDoctorModel.email!,
                        formKey: cubit.emailVerificationOTPFormKey,
                        firstOTPFocusNode: cubit.firstOTPFocusNode,
                        firstOTPOnChanged: (value) {
                          if (value.length == 1) {
                            cubit.pin1 = value;
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
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
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
                              cubit.isOTPDone = true;
                            } else {
                              cubit.isOTPDone = false;
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        thirdOTPOnChanged: (value) {
                          if (value.length == 1) {
                            cubit.pin3 = value;
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
                              cubit.isOTPDone = true;
                            } else {
                              cubit.isOTPDone = false;
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        fourthOTPOnChanged: (value) {
                          if (value.length == 1) {
                            cubit.pin4 = value;
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
                              cubit.isOTPDone = true;
                              // controller.verifyOTP();
                            } else {
                              cubit.isOTPDone = false;
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
                        timerWidget: BlocBuilder<EmailVerificationCubit,
                            EmailVerificationState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Text(
                                  cubit.getFormattedTime(0),
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                  ),
                                );
                              },
                              countDownInProgress: (remainingSeconds) {
                                return Text(
                                  cubit.getFormattedTime(remainingSeconds),
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        changeEmailFunction: () {
                          navigatorKey.currentState
                              ?.pushReplacementNamed(AppRoutes.home);
                        },
                      ),
                      const SizedBox(height: 50),
                      // controller.isVerifyOTP.value
                      //     ? const Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           SizedBox(
                      //             height: 30,
                      //             width: 30,
                      //             child: CircularProgressIndicator(),
                      //           ),
                      //         ],
                      //       )
                      //     :
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: CustomElevatedButton(
                              onPressed: () {
                                cubit.sendOTPForEmailVerification();
                              },
                              title: AppStrings.confirm,
                            ),
                          ),
                          BlocBuilder<EmailVerificationCubit,
                              EmailVerificationState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return SizedBox(
                                    height: 50,
                                    child: CustomOutlineBotton(
                                      onPressed: () {
                                        cubit.resendOtp();
                                      },
                                      title: AppStrings.resend,
                                      isFlatBotton: true,
                                    ),
                                  );
                                },
                                countDownInProgress: (remainingSeconds) {
                                  return const SizedBox.shrink();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (message) {
              return SingleChildScrollView(
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
                        emailAddress: widget.currentDoctorModel.email!,
                        formKey: cubit.emailVerificationOTPFormKey,
                        firstOTPFocusNode: cubit.firstOTPFocusNode,
                        firstOTPOnChanged: (value) {
                          if (value.length == 1) {
                            cubit.pin1 = value;
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
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
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
                              cubit.isOTPDone = true;
                            } else {
                              cubit.isOTPDone = false;
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        thirdOTPOnChanged: (value) {
                          if (value.length == 1) {
                            cubit.pin3 = value;
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
                              cubit.isOTPDone = true;
                            } else {
                              cubit.isOTPDone = false;
                            }
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        fourthOTPOnChanged: (value) {
                          if (value.length == 1) {
                            cubit.pin4 = value;
                            if ((cubit.pin1 != null &&
                                    cubit.pin1!.isNotEmpty) &&
                                (cubit.pin2 != null &&
                                    cubit.pin2!.isNotEmpty) &&
                                (cubit.pin3 != null &&
                                    cubit.pin3!.isNotEmpty) &&
                                (cubit.pin4 != null &&
                                    cubit.pin4!.isNotEmpty)) {
                              cubit.isOTPDone = true;
                              // controller.verifyOTP();
                            } else {
                              cubit.isOTPDone = false;
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
                        timerWidget: BlocBuilder<EmailVerificationCubit,
                            EmailVerificationState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Text(
                                  cubit.getFormattedTime(0),
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                  ),
                                );
                              },
                              countDownInProgress: (remainingSeconds) {
                                return Text(
                                  cubit.getFormattedTime(remainingSeconds),
                                  style: TextStyle(
                                    color: Colors.blue.shade600,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        changeEmailFunction: () {
                          navigatorKey.currentState
                              ?.pushNamed(AppRoutes.doctorProfile);
                        },
                      ),
                      const SizedBox(height: 50),
                      // controller.isVerifyOTP.value
                      //     ? const Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           SizedBox(
                      //             height: 30,
                      //             width: 30,
                      //             child: CircularProgressIndicator(),
                      //           ),
                      //         ],
                      //       )
                      //     :
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: CustomElevatedButton(
                              onPressed: () {
                                cubit.sendOTPForEmailVerification();
                              },
                              title: AppStrings.confirm,
                            ),
                          ),
                          BlocBuilder<EmailVerificationCubit,
                              EmailVerificationState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return SizedBox(
                                    height: 50,
                                    child: CustomOutlineBotton(
                                      onPressed: () {
                                        cubit.resendOtp();
                                      },
                                      title: AppStrings.resend,
                                      isFlatBotton: true,
                                    ),
                                  );
                                },
                                countDownInProgress: (remainingSeconds) {
                                  return const SizedBox.shrink();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () {
              return const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
