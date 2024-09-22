import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';

import '../../../../exports.dart';

class RegisterForm extends StatelessWidget {
  final AuthenticationCubit cubit;

  const RegisterForm({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
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
                  title: AppStrings.firstName,
                  style: TextStyle(fontSize: 12.sp),
                  textInputType: TextInputType.text,
                  onChanged: (value) {
                    cubit.registerFirstName = value;
                  },
                  enableSuggestions: true,
                  validator: (value) =>
                      AppValidators.firstAndLastNameValidation(value!),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomTextFormField(
                  title: AppStrings.lastName,
                  style: TextStyle(fontSize: 12.sp),
                  onChanged: (value) {
                    cubit.registerLastName = value;
                  },
                  enableSuggestions: true,
                  textInputType: TextInputType.text,
                  validator: (value) =>
                      AppValidators.firstAndLastNameValidation(value!),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          CustomTextFormField(
            title: AppStrings.email,
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
                  title: AppStrings.password,
                  style: TextStyle(fontSize: 12.sp),
                  textFormFieldController: cubit.registerPasswordController,
                  obscureText: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) =>
                      AppValidators.passwordValidateForRegister(value!),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomTextFormField(
                  title: AppStrings.confirmPassword,
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
                child: FlutterPwValidator(
                    controller: cubit.registerPasswordController,
                    minLength: 6,
                    uppercaseCharCount: 1,
                    numericCharCount: 2,
                    specialCharCount: 1,
                    width: 200.w,
                    height: 100.h,
                    onSuccess: () {},
                    onFail: () {
                      return null;
                    }),
              ),
              SizedBox(width: 10.w),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  title: AppStrings.phone,
                  textInputType: TextInputType.phone,
                  style: TextStyle(fontSize: 12.sp),
                  onChanged: (value) {
                    cubit.registerPhone = value;
                  },
                  // validator: (value) =>
                  //     AppValidators.validatePhoneNumber(value!),
                  validator: (value) =>
                      AppValidators.validatePhoneNumber(value ?? ''),

                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomTextFormField(
                  title: AppStrings.age,
                  textInputType: TextInputType.number,
                  style: TextStyle(fontSize: 12.sp),
                  onChanged: (value) {
                    cubit.registerAge = value;
                  },
                  // validator: (value) => AppValidators.validateAge(value!),
                  validator: (value) => AppValidators.validateAge(value ?? ''),
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
                  title: AppStrings.job,
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
                  title: AppStrings.workplace,
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
                  title: AppStrings.fullRegisterationNumber,
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
          SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      title: AppStrings.specialty,
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
                child: Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    hint: Text(
                      AppStrings.choose,
                      style: TextStyle(
                          fontSize: 12.sp, color: Colors.grey.shade600),
                    ),
                    items: highestDegreeList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.registerHighestDegree = value.toString();
                    },
                    validator: (value) => null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                    ),
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors.grey.shade600),
                    style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    dropdownColor: Colors.white,
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
