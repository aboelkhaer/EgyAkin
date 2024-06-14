import 'dart:developer';

import 'package:egy_akin/features/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:egy_akin/features/change_password/presentation/cubit/change_password_state.dart';

import '../../../../exports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordCubit cubit = ChangePasswordCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
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
                    title: 'Old Password',
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) =>
                        AppValidators.fieldsIsEmptyValidation(value!),
                    onChanged: (value) {
                      cubit.oldPassword = value;
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    title: 'New Password',
                    textInputType: TextInputType.visiblePassword,
                    textFormFieldController: cubit.newPasswordController,
                    obscureText: true,
                    validator: (value) =>
                        AppValidators.passwordValidateForRegister(value!),
                  ),
                  SizedBox(height: 5.h),
                  FlutterPwValidator(
                      controller: cubit.newPasswordController,
                      minLength: 6,
                      uppercaseCharCount: 1,
                      numericCharCount: 2,
                      specialCharCount: 1,
                      width: 310.w,
                      height: 100.h,
                      onSuccess: () {},
                      onFail: () {
                        return null;
                      }),
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
                        title: 'Save',
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
