import '../../../../exports.dart';

class ResetPasswordBotton extends StatelessWidget {
  const ResetPasswordBotton({
    super.key,
    required this.cubit,
  });

  final ResetPasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: CustomElevatedButton(
                isDisable: cubit.currentStep == 0
                    ? false
                    : cubit.currentStep == 1 && cubit.isOTPDone
                        ? false
                        : false,
                onPressed: () {
                  if (cubit.currentStep == 0) {
                    cubit.sendEmailForResetPassword();
                  } else if (cubit.currentStep == 1) {
                    cubit.verifyOTP();
                  } else if (cubit.currentStep == 2) {
                    cubit.changePassword(context);
                  }
                },
                title: cubit.currentStep == 0
                    ? context.tr(AppStrings.continueText)
                    : cubit.currentStep == 1
                        ? context.tr(AppStrings.confirm)
                        : context.tr(AppStrings.save)),
          ),
          const SizedBox(height: 5),
          cubit.currentStep == 0
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 50,
                  child: cubit.isResendBottonShow
                      ? CustomOutlineBotton(
                          onPressed: () {
                            if (cubit.currentStep == 0) {
                            } else if (cubit.currentStep == 1) {
                              cubit.isResendBottonShow =
                                  !cubit.isResendBottonShow;
                              cubit.resendOtp(context);
                            } else if (cubit.currentStep == 2) {}
                          },
                          title: cubit.currentStep == 0
                              ? context.tr(AppStrings.cancel)
                              : cubit.currentStep == 1
                                  ? context.tr(AppStrings.resend)
                                  : context.tr(AppStrings.back),

                          isFlatBotton: true,
                        )
                      : const SizedBox.shrink(),
                ),
        ],
      ),
    );
  }
}
