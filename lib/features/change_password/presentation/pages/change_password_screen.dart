import 'package:egy_akin/features/change_password/presentation/cubit/change_password_state.dart';
import 'package:egy_akin/features/change_password/presentation/widgets/change_password_ui.dart';

import '../../../../exports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ChangePasswordCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffoldBg =
            isDarkMode ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;
        final appBarForeground =
            isDarkMode ? AppColors.darkTitle : AppColors.title;
        final inputFill = isDarkMode ? AppColors.darkSurface : Colors.white;

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: scaffoldBg,
            foregroundColor: appBarForeground,
            iconTheme: IconThemeData(color: appBarForeground),
            title: Text(
              context.tr(AppStrings.changePassword),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
                color: appBarForeground,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ChangePasswordHeroBanner(),
                    SizedBox(height: 16.h),
                    ChangePasswordSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ChangePasswordSectionHeader(
                            icon: Icons.vpn_key_outlined,
                            title: context.tr(AppStrings.changePassword),
                            subtitle:
                                context.tr(AppStrings.changePasswordFormHint),
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            title: context.tr(AppStrings.oldPassword),
                            textInputType: TextInputType.visiblePassword,
                            obscureText: true,
                            enableSuggestions: false,
                            fillColor: inputFill,
                            validator: (value) =>
                                AppValidators.passwordValidateForRegister(
                              value!,
                              context,
                            ),
                            onChanged: (value) {
                              cubit.oldPassword = value;
                            },
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            title: context.tr(AppStrings.newPassword),
                            textInputType: TextInputType.visiblePassword,
                            textFormFieldController:
                                cubit.newPasswordController,
                            enableSuggestions: false,
                            obscureText: true,
                            fillColor: inputFill,
                            validator: (value) =>
                                AppValidators.passwordValidateForRegister(
                              value!,
                              context,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          BlocBuilder<ThemeBloc, ThemeState>(
                            builder: (context, innerTheme) {
                              final innerDark = innerTheme is ThemeLoaded &&
                                  innerTheme.isDarkMode;

                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: innerDark
                                      ? AppColors.darkSurface
                                      : const Color(0xFFF5F6FA),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: innerDark
                                        ? AppColors.darkBorder
                                        : Colors.grey.shade200,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.tr(AppStrings
                                          .changePasswordRequirementsTitle),
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w700,
                                        color: innerDark
                                            ? AppColors.darkTitle
                                            : Colors.grey.shade800,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
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
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    const ChangePasswordSecurityTip(),
                    SizedBox(height: 20.h),
                    BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: (message) {
                            if (message.isNotEmpty) {
                              customSnackBar(
                                context: context,
                                message: message,
                              );
                              navigatorKey.currentState?.pop();
                            }
                          },
                          error: (message) {
                            customSnackBar(
                              context: context,
                              message: message,
                            );
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () => Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                          orElse: () => CustomElevatedButton(
                            onPressed: cubit.changePassword,
                            title: context.tr(AppStrings.save),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
