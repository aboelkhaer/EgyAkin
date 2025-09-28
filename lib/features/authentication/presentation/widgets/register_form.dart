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

        return Form(
          key: cubit.registerFormKey,
          autovalidateMode: cubit.registerErrorValid == 0
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
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
                      textFormFieldController: cubit.registerPasswordController,
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
                  // SizedBox(width: 10.w),
                  // const Expanded(child: SizedBox.shrink()),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      title: context.tr(AppStrings.phone),
                      textInputType: TextInputType.phone,
                      style: TextStyle(fontSize: 12.sp),
                      onChanged: (value) {
                        cubit.registerPhone = value;
                      },
                      // validator: (value) =>
                      //     AppValidators.validatePhoneNumber(value!),
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
                      style: TextStyle(fontSize: 12.sp),
                      onChanged: (value) {
                        cubit.registerAge = value;
                      },
                      // validator: (value) => AppValidators.validateAge(value!),
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
                      title: context.tr(AppStrings.job),
                      style: TextStyle(fontSize: 12.sp),
                      onChanged: (value) {
                        cubit.registerJop = value;
                      },
                      textInputType: TextInputType.text,
                      // validator: (value) =>
                      //     AppValidators.fieldsIsEmptyValidation(value!),
                      validator: (value) => null,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomTextFormField(
                      title: context.tr(AppStrings.workplace),
                      style: TextStyle(fontSize: 12.sp),
                      onChanged: (value) {
                        cubit.registerWorkplace = value;
                      },
                      textInputType: TextInputType.text,
                      // validator: (value) =>
                      //     AppValidators.fieldsIsEmptyValidation(value!),
                      validator: (value) => null,
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
                      title: context.tr(AppStrings.fullRegisterationNumber),
                      style: TextStyle(fontSize: 12.sp),
                      onChanged: (value) {
                        cubit.registerRegistrationNumber = value;
                      },
                      textInputType: TextInputType.number,
                      // validator: (value) =>
                      //     AppValidators.fieldsIsEmptyValidation(value!),
                      validator: (value) => null,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 5.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          title: context.tr(AppStrings.specialty),
                          style: TextStyle(fontSize: 12.sp),
                          onChanged: (value) {
                            cubit.registerSpecialty = value;
                          },
                          textInputType: TextInputType.text,
                          // validator: (value) =>
                          //     AppValidators.fieldsIsEmptyValidation(value!),
                          validator: (value) => null,
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
                              context.tr(AppStrings.chooseDegree),
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
                              cubit.registerHighestDegree = value.toString();
                            },
                            validator: (value) => null,
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
                              color: isDarkMode ? Colors.white : Colors.black,
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
          ),
        );
      },
    );
  }
}
