import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';

import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class RegisterForm extends StatelessWidget {
  final AuthenticationCubit cubit;

  const RegisterForm({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return Form(
              key: cubit.registerFormKey,
              autovalidateMode: cubit.registerErrorValid == 0
                  ? AutovalidateMode.disabled
                  : AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.darkCardBG
                          : AppColors.subBG.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode
                            ? AppColors.darkBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        _OptionChip(
                          label: 'Member',
                          icon: Icons.person_outline,
                          selected: !cubit.isMedicalStatistics,
                          isDarkMode: isDarkMode,
                          onTap: () => cubit.toggleMedicalStatistics(false),
                        ),
                        SizedBox(width: 8.w),
                        _OptionChip(
                          label: 'Research Member',
                          icon: Icons.analytics_outlined,
                          selected: cubit.isMedicalStatistics,
                          isDarkMode: isDarkMode,
                          onTap: () => cubit.toggleMedicalStatistics(true),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          title: '${context.tr(AppStrings.firstName)} *',
                          style: TextStyle(fontSize: 12.sp),
                          textInputType: TextInputType.text,
                          onChanged: (value) {
                            cubit.registerFirstName = value;
                          },
                          enableSuggestions: true,
                          validator: (value) =>
                              AppValidators.firstAndLastNameValidation(
                                  value!, context),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomTextFormField(
                          title: '${context.tr(AppStrings.lastName)} *',
                          style: TextStyle(fontSize: 12.sp),
                          onChanged: (value) {
                            cubit.registerLastName = value;
                          },
                          enableSuggestions: true,
                          textInputType: TextInputType.text,
                          validator: (value) =>
                              AppValidators.firstAndLastNameValidation(
                                  value!, context),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  CustomTextFormField(
                    title: '${context.tr(AppStrings.email)} *',
                    style: TextStyle(fontSize: 12.sp),
                    enableSuggestions: true,
                    onChanged: (value) {
                      cubit.registerEmail = value;
                    },
                    textInputType: TextInputType.text,
                    validator: (value) => AppValidators.emailValidator(value),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          title: '${context.tr(AppStrings.password)} *',
                          style: TextStyle(fontSize: 12.sp),
                          textFormFieldController:
                              cubit.registerPasswordController,
                          obscureText: true,
                          textInputType: TextInputType.visiblePassword,
                          validator: (value) =>
                              AppValidators.passwordValidateForRegister(
                                  value!, context),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomTextFormField(
                          title: '${context.tr(AppStrings.confirmPassword)} *',
                          style: TextStyle(fontSize: 12.sp),
                          onChanged: (value) {
                            cubit.registerPasswordConformation = value;
                          },
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) => AppValidators.confirmPassword(
                            value!,
                            cubit.registerPasswordController.text,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: TranslatablePasswordValidator(
                            controller: cubit.registerPasswordController,
                            minLength: 6,
                            uppercaseCharCount: 1,
                            numericCharCount: 2,
                            specialCharCount: 1,
                            width: double.infinity,
                            onSuccess: () {},
                            onFail: () {}),
                      ),
                    ],
                  ),
                  if (cubit.isMedicalStatistics) ...[
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            title: cubit.isMedicalStatistics
                                ? context.tr(AppStrings.phone)
                                : context.tr(AppStrings.phone),
                            textInputType: TextInputType.phone,
                            style: TextStyle(fontSize: 12.sp),
                            onChanged: (value) {
                              cubit.registerPhone = value;
                            },
                            validator: (value) => null,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomTextFormField(
                            title: cubit.isMedicalStatistics
                                ? context.tr(AppStrings.age)
                                : context.tr(AppStrings.age),
                            textInputType: TextInputType.number,
                            style: TextStyle(fontSize: 12.sp),
                            onChanged: (value) {
                              cubit.registerAge = value;
                            },
                            validator: (value) => null,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            title: cubit.isMedicalStatistics
                                ? '${context.tr(AppStrings.job)} *'
                                : context.tr(AppStrings.job),
                            style: TextStyle(fontSize: 12.sp),
                            onChanged: (value) {
                              cubit.registerJop = value;
                            },
                            textInputType: TextInputType.text,
                            validator: (value) => cubit.isMedicalStatistics
                                ? AppValidators.fieldsIsEmptyValidation(
                                    value ?? '')
                                : null,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomTextFormField(
                            title: cubit.isMedicalStatistics
                                ? '${context.tr(AppStrings.workplace)} *'
                                : context.tr(AppStrings.workplace),
                            style: TextStyle(fontSize: 12.sp),
                            onChanged: (value) {
                              cubit.registerWorkplace = value;
                            },
                            textInputType: TextInputType.text,
                            validator: (value) => cubit.isMedicalStatistics
                                ? AppValidators.fieldsIsEmptyValidation(
                                    value ?? '')
                                : null,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            title: cubit.isMedicalStatistics
                                ? '${context.tr(AppStrings.fullRegisterationNumber)} *'
                                : context
                                    .tr(AppStrings.fullRegisterationNumber),
                            style: TextStyle(fontSize: 12.sp),
                            onChanged: (value) {
                              cubit.registerRegistrationNumber = value;
                            },
                            textInputType: TextInputType.number,
                            validator: (value) => cubit.isMedicalStatistics
                                ? AppValidators.fieldsIsEmptyValidation(
                                    value ?? '')
                                : null,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                title: cubit.isMedicalStatistics
                                    ? '${context.tr(AppStrings.specialty)} *'
                                    : context.tr(AppStrings.specialty),
                                style: TextStyle(fontSize: 12.sp),
                                onChanged: (value) {
                                  cubit.registerSpecialty = value;
                                },
                                textInputType: TextInputType.text,
                                validator: (value) => cubit.isMedicalStatistics
                                    ? AppValidators.fieldsIsEmptyValidation(
                                        value ?? '')
                                    : null,
                                textInputAction: TextInputAction.next,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.darkCardBG
                                      : AppColors.subBG,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonFormField<String>(
                                  hint: Text(
                                    cubit.isMedicalStatistics
                                        ? '${context.tr(AppStrings.chooseDegree)} *'
                                        : context.tr(AppStrings.chooseDegree),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: isDarkMode
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                  items: highestDegreeList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    cubit.registerHighestDegree =
                                        value.toString();
                                  },
                                  validator: (value) => cubit
                                          .isMedicalStatistics
                                      ? AppValidators.fieldsIsEmptyValidation(
                                          value ?? '')
                                      : null,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: isDarkMode
                                        ? AppColors.darkCardBG
                                        : AppColors.subBG,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: isDarkMode
                                            ? AppColors.darkBorder
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: isDarkMode
                                            ? AppColors.darkBorder
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: isDarkMode
                                            ? AppColors.darkPrimary
                                            : AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: isDarkMode
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade600,
                                  ),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  dropdownColor: isDarkMode
                                      ? AppColors.darkCardBG
                                      : Colors.white,
                                  menuMaxHeight: 200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _OptionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final bool isDarkMode;
  final VoidCallback onTap;

  const _OptionChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = selected
        ? AppColors.primary
        : (isDarkMode ? AppColors.darkBorder : Colors.grey.shade300);
    final Color bgColor = selected
        ? (isDarkMode
            ? AppColors.darkPrimary.withOpacity(0.15)
            : AppColors.primary.withOpacity(0.12))
        : Colors.transparent;
    final Color textColor = selected
        ? (isDarkMode ? Colors.white : AppColors.primary)
        : (isDarkMode ? Colors.white70 : Colors.black87);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.sp, color: textColor),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
