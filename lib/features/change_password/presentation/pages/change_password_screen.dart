import 'package:egy_akin/features/change_password/presentation/cubit/change_password_state.dart';

import '../../../../exports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordCubit cubit = ChangePasswordCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(AppStrings.changePassword)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    title: context.tr(AppStrings.oldPassword),
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    enableSuggestions: false,
                    validator: (value) =>
                        AppValidators.passwordValidateForRegister(value!,context),
                    onChanged: (value) {
                      cubit.oldPassword = value;
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    title: context.tr(AppStrings.newPassword),
                    textInputType: TextInputType.visiblePassword,
                    textFormFieldController: cubit.newPasswordController,
                    enableSuggestions: false,
                    obscureText: true,
                    validator: (value) =>
                        AppValidators.passwordValidateForRegister(value!,context),
                  ),
                  SizedBox(height: 5.h),
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
                      SizedBox(
                        width: 10.w,
                      ),
                      const Expanded(child: SizedBox.shrink())
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 0,
              right: 0,
              child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (message) {
                      if (message.isNotEmpty) {
                        customSnackBar(context: context, message: message);
                        navigatorKey.currentState?.pop();
                      }
                    },
                    error: (message) {
                      customSnackBar(context: context, message: message);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return CustomElevatedButton(
                        onPressed: () {
                          cubit.changePassword();
                        },
                        title: context.tr(AppStrings.save),
                      );
                    },
                    loading: () {
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
