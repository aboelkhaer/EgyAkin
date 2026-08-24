import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.cubit,
    required this.isDark,
  });

  final AuthenticationCubit cubit;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

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
            style: TextStyle(
              fontSize: 13.sp,
              color: HomeDashboardColors.title(isDark),
            ),
            textInputType: TextInputType.emailAddress,
            onChanged: (value) {
              cubit.signInEmail = value;
            },
            validator: (value) => AppValidators.emailValidator(value),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 10.h),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return state.maybeWhen(
                changePasswordVisibility:
                    (signInObscureText, signInVisiblePasswordIcon) {
                  return CustomTextFormField(
                    title: context.tr(AppStrings.password),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: HomeDashboardColors.title(isDark),
                    ),
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
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: HomeDashboardColors.title(isDark),
                    ),
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
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.resetPassword);
              },
              child: Text(
                context.tr(AppStrings.forgotPassword),
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
