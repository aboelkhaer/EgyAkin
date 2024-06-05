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
            title: 'New password',
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            textFormFieldController: cubit.newPasswordController,
            onChanged: (value) {},
            textInputAction: TextInputAction.done,
            validator: (value) =>
                AppValidators.passwordValidateForRegister(value!),
          ),
          FlutterPwValidator(
              controller: cubit.newPasswordController,
              minLength: 6,
              uppercaseCharCount: 1,
              numericCharCount: 2,
              specialCharCount: 1,
              width: 400,
              height: 150,
              onSuccess: () {},
              onFail: () {}),
        ],
      ),
    );
  }
}
