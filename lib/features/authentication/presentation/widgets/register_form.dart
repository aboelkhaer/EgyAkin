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
          SizedBox(height: 5.h),
          FlutterPwValidator(
              controller: cubit.registerPasswordController,
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
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  title: AppStrings.phone,
                  textInputType: TextInputType.phone,
                  onChanged: (value) {
                    cubit.registerPhone = value;
                  },
                  validator: (value) =>
                      AppValidators.validatePhoneNumber(value!),
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
                  onChanged: (value) {
                    cubit.registerAge = value;
                  },
                  validator: (value) => AppValidators.validateAge(value!),
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
                  onChanged: (value) {
                    cubit.registerJop = value;
                  },
                  textInputType: TextInputType.text,
                  validator: (value) =>
                      AppValidators.fieldsIsEmptyValidation(value!),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomTextFormField(
                  title: AppStrings.workplace,
                  onChanged: (value) {
                    cubit.registerWorkplace = value;
                  },
                  textInputType: TextInputType.text,
                  validator: (value) =>
                      AppValidators.fieldsIsEmptyValidation(value!),
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
                  onChanged: (value) {
                    cubit.registerRegistrationNumber = value;
                  },
                  textInputType: TextInputType.number,
                  validator: (value) =>
                      AppValidators.fieldsIsEmptyValidation(value!),
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
                      onChanged: (value) {
                        cubit.registerSpecialty = value;
                      },
                      textInputType: TextInputType.text,
                      validator: (value) =>
                          AppValidators.fieldsIsEmptyValidation(value!),
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<dynamic>(
                    hint: const Text(AppStrings.choose),
                    items: cubit.highestDegreeList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.registerHighestDegree = value;
                    },
                    validator: (value) =>
                        AppValidators.fieldsIsEmptyValidation(value),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
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
