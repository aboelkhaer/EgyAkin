import '../../../../exports.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.cubit,
  });

  final AuthenticationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.signInFormKey,
      autovalidateMode: cubit.signInErrorValidCounter == 0
          ? AutovalidateMode.disabled
          : AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextFormField(
            title: context.tr(AppStrings.email),  
            enableSuggestions: true,
            style: TextStyle(fontSize: 12.sp),
            textInputType: TextInputType.emailAddress,
            onChanged: (value) {
              cubit.signInEmail = value;
            },
            validator: (value) => AppValidators.emailValidator(value),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return state.maybeWhen(
                changePasswordVisibility:
                    (signInObscureText, signInVisiblePasswordIcon) {
                  return CustomTextFormField(
                    title: context.tr(AppStrings.password),
                    style: TextStyle(fontSize: 12.sp),
                    textInputType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      cubit.signInPassword = value;
                    },
                    textInputAction: TextInputAction.done,
                    obscureText: signInObscureText,
                    visiblePasswordIcon: signInVisiblePasswordIcon,
                    visiblePasswordIconFunction: () =>
                        cubit.showPasswordFunction(),
                    unVisiblePasswordIconFunction: () =>
                        cubit.showPasswordFunction(),
                    validator: (value) =>
                        AppValidators.passwordValidator(value),
                  );
                },
                orElse: () {
                  return CustomTextFormField(
                    title: context.tr(AppStrings.password),
                    textInputType: TextInputType.visiblePassword,
                    style: TextStyle(fontSize: 12.sp),
                    onChanged: (value) {
                      cubit.signInPassword = value;
                    },
                    textInputAction: TextInputAction.done,
                    obscureText: cubit.signInObscureText,
                    enableSuggestions: false,
                    visiblePasswordIcon: cubit.signInVisiblePasswordIcon,
                    visiblePasswordIconFunction: () =>
                        cubit.showPasswordFunction(),
                    unVisiblePasswordIconFunction: () =>
                        cubit.showPasswordFunction(),
                    validator: (value) =>
                        AppValidators.passwordValidator(value),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.resetPassword);
                },
                child: SizedBox(
                  child: Text(
                    context.tr(AppStrings.forgotPassword),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
