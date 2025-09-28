import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';
import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_state.dart';
import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class DoctorProfileViewScreen extends StatelessWidget {
  const DoctorProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorProfileViewCubit cubit = DoctorProfileViewCubit.get(context);
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: AppBar(
            title: Text(
              context.tr(AppStrings.editProfile),
              style: TextStyle(
                color: isDarkMode ? AppColors.darkTitle : Colors.white,
              ),
            ),
            backgroundColor:
                isDarkMode ? AppColors.darkCardBG : AppColors.primary,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: BlocConsumer<DoctorProfileViewCubit, DoctorProfileViewState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (currentDoctorModel, isProfileHasChanged, message,
                    isUpdating, isSubmit) {
                  if (message.isNotEmpty) {
                    customSnackBar(context: context, message: message);
                  }
                  if (isSubmit) {
                    navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.home, arguments: 2)
                        .then((_) {
                      if (!context.read<DoctorProfileViewCubit>().isClosed) {
                        navigatorKey.currentState
                            ?.pushReplacementNamed(AppRoutes.doctorProfile);
                        customSnackBar(context: context, message: message);
                      }
                    });
                  }
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const Center(child: CircularProgressIndicator()),
                loaded: (currentDoctorModel, isProfileHasChanged, message,
                    isUpdating, isSubmit) {
                  if (isUpdating) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: size.height * 0.05),
                          Form(
                            key: cubit.formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '${context.tr(AppStrings.firstName)} *',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      '${context.tr(AppStrings.lastName)} *',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: context.tr(AppStrings.firstName),
                                        initialValue:
                                            currentDoctorModel.firstName ?? '',
                                        textInputType: TextInputType.text,
                                        onChanged: (value) {
                                          cubit.firstName = value;
                                          cubit.checkForChanges();
                                        },
                                        enableSuggestions: true,
                                        validator: (value) {
                                          return AppValidators
                                              .firstAndLastNameValidation(
                                                  value ?? '', context);
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: context.tr(AppStrings.lastName),
                                        initialValue:
                                            currentDoctorModel.lastName ?? '',
                                        onChanged: (value) {
                                          cubit.lastName = value;
                                          cubit.checkForChanges();
                                        },
                                        enableSuggestions: true,
                                        textInputType: TextInputType.text,
                                        validator: (value) => AppValidators
                                            .firstAndLastNameValidation(
                                                value ?? '', context),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Text(
                                      '${context.tr(AppStrings.email)} *',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                CustomTextFormField(
                                  title: context.tr(AppStrings.email),
                                  initialValue: currentDoctorModel.email ?? '',
                                  enableSuggestions: true,
                                  textInputType: TextInputType.text,
                                  validator: (value) =>
                                      AppValidators.emailValidator(value ?? ''),
                                  onChanged: (value) {
                                    cubit.email = value;
                                    cubit.checkForChanges();
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: size.height * 0.01),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      context.tr(AppStrings.phone),
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      context.tr(AppStrings.age),
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: context.tr(AppStrings.phone),
                                        initialValue:
                                            currentDoctorModel.phone ?? '',
                                        onChanged: (value) {
                                          cubit.phone = value;
                                          cubit.checkForChanges();
                                        },
                                        textInputType: TextInputType.phone,
                                        validator: (value) =>
                                            AppValidators.validatePhoneNumber(
                                                value ?? ''),
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(11)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: context.tr(AppStrings.age),
                                        initialValue:
                                            currentDoctorModel.age ?? '',
                                        onChanged: (value) {
                                          cubit.age = value;
                                          cubit.checkForChanges();
                                        },
                                        textInputType: TextInputType.number,
                                        validator: (value) =>
                                            AppValidators.validateAge(
                                                value ?? ''),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      context.tr(AppStrings.job),
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      context.tr(AppStrings.workplace),
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: context.tr(AppStrings.job),
                                        initialValue:
                                            currentDoctorModel.job ?? '',
                                        textInputType: TextInputType.text,
                                        onChanged: (value) {
                                          cubit.job = value;
                                          cubit.checkForChanges();
                                        },
                                        validator: (value) => AppValidators
                                            .fieldsIsEmptyValidation(
                                                value ?? ''),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: context.tr(AppStrings.workplace),
                                        initialValue:
                                            currentDoctorModel.workingplace ??
                                                '',
                                        textInputType: TextInputType.text,
                                        validator: (value) => AppValidators
                                            .fieldsIsEmptyValidation(
                                                value ?? ''),
                                        onChanged: (value) {
                                          cubit.workplace = value;
                                          cubit.checkForChanges();
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Registration Number (رقم القيد الخاص بالنقابة)',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        title:
                                            'Registration Number (رقم القيد الخاص بالنقابة)',
                                        enabled: true,
                                        onChanged: (value) {
                                          cubit.registrationNumber = value;
                                          cubit.checkForChanges();
                                        },
                                        initialValue: currentDoctorModel
                                                .registrationNumber ??
                                            '',
                                        textInputType: TextInputType.number,
                                        validator: (value) => AppValidators
                                            .fieldsIsEmptyValidation(
                                                value ?? ''),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      context.tr(AppStrings.specialty),
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      context.tr(AppStrings.highestDegree),
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkTitle
                                            : Colors.black87,
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: context.tr(AppStrings.specialty),
                                        initialValue:
                                            currentDoctorModel.specialty ?? '',
                                        textInputType: TextInputType.text,
                                        validator: (value) => AppValidators
                                            .fieldsIsEmptyValidation(
                                                value ?? ''),
                                        onChanged: (value) {
                                          cubit.specialty = value;
                                          cubit.checkForChanges();
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isDarkMode
                                              ? AppColors.darkCardBG
                                              : AppColors.subBG,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: DropdownButtonFormField<String>(
                                          value: currentDoctorModel
                                                          .highestdegree !=
                                                      null &&
                                                  currentDoctorModel
                                                      .highestdegree!
                                                      .isNotEmpty &&
                                                  highestDegreeList.contains(
                                                      currentDoctorModel
                                                          .highestdegree)
                                              ? currentDoctorModel.highestdegree
                                              : null,
                                          hint: Text(
                                            context.tr(AppStrings.choose),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: isDarkMode
                                                  ? Colors.grey.shade300
                                                  : Colors.grey.shade600,
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
                                          onChanged: (val) {
                                            cubit.highestDegree = val ?? '';
                                            cubit.checkForChanges();
                                          },
                                          validator: (value) => AppValidators
                                              .fieldsIsEmptyValidation(
                                                  value ?? ''),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: isDarkMode
                                                    ? AppColors.darkBorder
                                                    : Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: isDarkMode
                                                    ? AppColors.darkPrimary
                                                    : AppColors.primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 8.0),
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
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.05),
                                SizedBox(
                                  width: double.infinity,
                                  child: CustomElevatedButton(
                                    onPressed: () {
                                      if (cubit.formKey.currentState
                                              ?.validate() ??
                                          false) {
                                        cubit.updateDoctorProfile();
                                      } else {}
                                    },
                                    title: context.tr(AppStrings.save),
                                    isDisable: !isProfileHasChanged,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                BlocBuilder<DoctorProfileViewCubit,
                                    DoctorProfileViewState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                      orElse: () {
                                        return const SizedBox.shrink();
                                      },
                                      loaded: (currentDoctorModel,
                                          isProfileHasChanged,
                                          message,
                                          isUpdateing,
                                          isSubmit) {
                                        if (currentDoctorModel.email
                                                .toString() ==
                                            'moatz2163@gmail.com') {
                                          return SizedBox(
                                            width: double.infinity,
                                            child: CustomElevatedButton(
                                              onPressed: () {
                                                customSnackBar(
                                                    context: context,
                                                    message:
                                                        '30 days to delete your account.');
                                              },
                                              title: 'Delete Account',
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
