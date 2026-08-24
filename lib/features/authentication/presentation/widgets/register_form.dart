import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class RegisterForm extends StatelessWidget {
  final AuthenticationCubit cubit;
  final bool isDark;

  const RegisterForm({
    super.key,
    required this.cubit,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final titleStyle = TextStyle(
      fontSize: 12.sp,
      color: HomeDashboardColors.title(isDark),
    );

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
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: HomeDashboardColors.surfaceBg(isDark),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: HomeDashboardColors.border(isDark).withOpacity(0.8),
                  ),
                ),
                child: Row(
                  children: [
                    _OptionChip(
                      label: context.tr(AppStrings.member),
                      icon: Icons.person_outline_rounded,
                      selected: !cubit.isMedicalStatistics,
                      isDark: isDark,
                      primary: primary,
                      onTap: () => cubit.toggleMedicalStatistics(false),
                    ),
                    SizedBox(width: 6.w),
                    _OptionChip(
                      label: context.tr(AppStrings.researchMember),
                      icon: Icons.analytics_outlined,
                      selected: cubit.isMedicalStatistics,
                      isDark: isDark,
                      primary: primary,
                      onTap: () => cubit.toggleMedicalStatistics(true),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      title: '${context.tr(AppStrings.firstName)} *',
                      style: titleStyle,
                      textInputType: TextInputType.text,
                      onChanged: (value) {
                        cubit.registerFirstName = value;
                      },
                      enableSuggestions: true,
                      validator: (value) =>
                          AppValidators.firstAndLastNameValidation(
                        value!,
                        context,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomTextFormField(
                      title: '${context.tr(AppStrings.lastName)} *',
                      style: titleStyle,
                      onChanged: (value) {
                        cubit.registerLastName = value;
                      },
                      enableSuggestions: true,
                      textInputType: TextInputType.text,
                      validator: (value) =>
                          AppValidators.firstAndLastNameValidation(
                        value!,
                        context,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                title: '${context.tr(AppStrings.email)} *',
                style: titleStyle,
                enableSuggestions: true,
                onChanged: (value) {
                  cubit.registerEmail = value;
                },
                textInputType: TextInputType.emailAddress,
                validator: (value) => AppValidators.emailValidator(value),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      title: '${context.tr(AppStrings.password)} *',
                      style: titleStyle,
                      textFormFieldController: cubit.registerPasswordController,
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) =>
                          AppValidators.passwordValidateForRegister(
                        value!,
                        context,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomTextFormField(
                      title: '${context.tr(AppStrings.confirmPassword)} *',
                      style: titleStyle,
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
              TranslatablePasswordValidator(
                controller: cubit.registerPasswordController,
                minLength: 6,
                uppercaseCharCount: 1,
                numericCharCount: 2,
                specialCharCount: 1,
                width: double.infinity,
                onSuccess: () {},
                onFail: () {},
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: cubit.isMedicalStatistics
                    ? Column(
                        children: [
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  title: context.tr(AppStrings.phone),
                                  textInputType: TextInputType.phone,
                                  style: titleStyle,
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
                                  title: context.tr(AppStrings.age),
                                  textInputType: TextInputType.number,
                                  style: titleStyle,
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
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  title: '${context.tr(AppStrings.job)} *',
                                  style: titleStyle,
                                  onChanged: (value) {
                                    cubit.registerJop = value;
                                  },
                                  textInputType: TextInputType.text,
                                  validator: (value) =>
                                      AppValidators.fieldsIsEmptyValidation(
                                    value ?? '',
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: CustomTextFormField(
                                  title:
                                      '${context.tr(AppStrings.workplace)} *',
                                  style: titleStyle,
                                  onChanged: (value) {
                                    cubit.registerWorkplace = value;
                                  },
                                  textInputType: TextInputType.text,
                                  validator: (value) =>
                                      AppValidators.fieldsIsEmptyValidation(
                                    value ?? '',
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            title:
                                '${context.tr(AppStrings.fullRegisterationNumber)} *',
                            style: titleStyle,
                            onChanged: (value) {
                              cubit.registerRegistrationNumber = value;
                            },
                            textInputType: TextInputType.number,
                            validator: (value) =>
                                AppValidators.fieldsIsEmptyValidation(
                              value ?? '',
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  title:
                                      '${context.tr(AppStrings.specialty)} *',
                                  style: titleStyle,
                                  onChanged: (value) {
                                    cubit.registerSpecialty = value;
                                  },
                                  textInputType: TextInputType.text,
                                  validator: (value) =>
                                      AppValidators.fieldsIsEmptyValidation(
                                    value ?? '',
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Container(
                                  height: 40.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: HomeDashboardColors.surfaceBg(
                                      isDark,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: HomeDashboardColors.border(isDark),
                                    ),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    hint: Text(
                                      '${context.tr(AppStrings.chooseDegree)} *',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: HomeDashboardColors.subtitle(
                                          isDark,
                                        ),
                                      ),
                                    ),
                                    items: highestDegreeList.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: HomeDashboardColors.title(
                                              isDark,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      cubit.registerHighestDegree =
                                          value.toString();
                                    },
                                    validator: (value) =>
                                        AppValidators.fieldsIsEmptyValidation(
                                      value ?? '',
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: HomeDashboardColors.surfaceBg(
                                        isDark,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: HomeDashboardColors.subtitle(
                                        isDark,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: HomeDashboardColors.title(isDark),
                                    ),
                                    dropdownColor:
                                        HomeDashboardColors.cardBg(isDark),
                                    menuMaxHeight: 200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OptionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final bool isDark;
  final Color primary;
  final VoidCallback onTap;

  const _OptionChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.isDark,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
          decoration: BoxDecoration(
            color: selected
                ? primary.withOpacity(isDark ? 0.2 : 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: selected
                  ? primary
                  : HomeDashboardColors.border(isDark).withOpacity(0.7),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15.sp,
                color: selected
                    ? primary
                    : HomeDashboardColors.subtitle(isDark),
              ),
              SizedBox(width: 5.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? primary
                        : HomeDashboardColors.title(isDark),
                  ),
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
