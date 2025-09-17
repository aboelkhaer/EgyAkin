import '../../../../../exports.dart';

class ThirdStep extends StatelessWidget {
  const ThirdStep({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit cubit = ResetPasswordCubit.get(context);
    return Form(
      key: cubit.thirdStepFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            title: context.tr(AppStrings.newPassword),
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            textFormFieldController: cubit.newPasswordController,
            onChanged: (value) {},
            textInputAction: TextInputAction.done,
            validator: (value) =>
                AppValidators.passwordValidateForRegister(value!, context),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: TranslatablePasswordValidator(
                    controller: cubit.newPasswordController,
                    minLength: 6,
                    uppercaseCharCount: 1,
                    numericCharCount: 2,
                    specialCharCount: 1,
                    width: 200.w,
                    onSuccess: () {},
                    onFail: () {}),
              ),
              SizedBox(width: 10.w),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ],
      ),
    );
  }
}
