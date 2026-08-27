import '../../../../../exports.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({super.key});

  void _syncOtpDone(ResetPasswordCubit cubit) {
    cubit.isOTPDone = [
      cubit.pin1,
      cubit.pin2,
      cubit.pin3,
      cubit.pin4,
    ].every((pin) => pin != null && pin.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ResetPasswordCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 16.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCardBG : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(9.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.pin_outlined,
                      color: primary,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr(AppStrings.verificationCode),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.darkTitle
                                : Colors.grey.shade900,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          context.tr(AppStrings.enterThe4DigitCode),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDark
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              OTPRow(
                formKey: cubit.secondStepFormKey,
                firstOTPFocusNode: cubit.firstOTPFocusNode,
                secondOTPFocusNode: cubit.secondOTPFocusNode,
                thirdOTPFocusNode: cubit.thirdOTPFocusNode,
                fourthOTPFocusNode: cubit.fourthOTPFocusNode,
                firstOTPOnChanged: (value) {
                  cubit.pin1 = value;
                  _syncOtpDone(cubit);
                },
                secondOTPOnChanged: (value) {
                  cubit.pin2 = value;
                  _syncOtpDone(cubit);
                },
                thirdOTPOnChanged: (value) {
                  cubit.pin3 = value;
                  _syncOtpDone(cubit);
                },
                fourthOTPOnChanged: (value) {
                  cubit.pin4 = value;
                  _syncOtpDone(cubit);
                },
                firstOTPValidator: (value) =>
                    AppValidators.fieldsIsEmptyValidation(value!),
                secondOTPValidator: (value) =>
                    AppValidators.fieldsIsEmptyValidation(value!),
                thirdOTPValidator: (value) =>
                    AppValidators.fieldsIsEmptyValidation(value!),
                fourthOTPValidator: (value) =>
                    AppValidators.fieldsIsEmptyValidation(value!),
              ),
            ],
          ),
        );
      },
    );
  }
}
