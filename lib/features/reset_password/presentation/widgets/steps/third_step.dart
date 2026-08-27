import '../../../../../exports.dart';

class ThirdStep extends StatelessWidget {
  const ThirdStep({super.key});

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
          child: Form(
            key: cubit.thirdStepFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(9.w),
                      decoration: BoxDecoration(
                        color:
                            AppColors.primary.withOpacity(isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
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
                            context.tr(AppStrings.newPassword),
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
                            context.tr(
                              AppStrings.changePasswordRequirementsTitle,
                            ),
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
                CustomTextFormField(
                  title: context.tr(AppStrings.newPassword),
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  textFormFieldController: cubit.newPasswordController,
                  onChanged: (value) {},
                  textInputAction: TextInputAction.done,
                  validator: (value) =>
                      AppValidators.passwordValidateForRegister(
                    value!,
                    context,
                  ),
                ),
                SizedBox(height: 10.h),
                TranslatablePasswordValidator(
                  controller: cubit.newPasswordController,
                  minLength: 6,
                  uppercaseCharCount: 1,
                  numericCharCount: 2,
                  specialCharCount: 1,
                  width: double.infinity,
                  onSuccess: () {},
                  onFail: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
