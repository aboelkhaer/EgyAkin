import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';
import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_state.dart';
import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

/// Builds a label with required asterisk (*) in red.
Widget _buildRequiredLabel(String label, bool isDarkMode) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: label,
          style: TextStyle(
            color: isDarkMode ? AppColors.darkTitle : Colors.black87,
          ),
        ),
        const TextSpan(
          text: ' *',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

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
                    isUpdating, isSubmit, isMedicalStatistics) {
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
                    isUpdating, isSubmit, isMedicalStatistics) {
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
                                // User Type Toggle
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
                                        label: context.tr(AppStrings.member),
                                        icon: Icons.person_outline,
                                        selected: !isMedicalStatistics,
                                        isDarkMode: isDarkMode,
                                        onTap: () => cubit
                                            .toggleMedicalStatistics(false),
                                      ),
                                      SizedBox(width: 8.w),
                                      _OptionChip(
                                        label: context
                                            .tr(AppStrings.researchMember),
                                        icon: Icons.analytics_outlined,
                                        selected: isMedicalStatistics,
                                        isDarkMode: isDarkMode,
                                        onTap: () =>
                                            cubit.toggleMedicalStatistics(true),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildRequiredLabel(
                                            context.tr(AppStrings.firstName),
                                            isDarkMode)),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: _buildRequiredLabel(
                                            context.tr(AppStrings.lastName),
                                            isDarkMode)),
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
                                    _buildRequiredLabel(
                                        context.tr(AppStrings.email),
                                        isDarkMode),
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
                                // Show medical statistics fields only if isMedicalStatistics is true
                                if (isMedicalStatistics) ...[
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
                                          validator: (value) => null,
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
                                          validator: (value) => null,
                                          textInputAction: TextInputAction.next,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: isMedicalStatistics
                                              ? _buildRequiredLabel(
                                                  context.tr(AppStrings.job),
                                                  isDarkMode)
                                              : Text(
                                                  context.tr(AppStrings.job),
                                                  style: TextStyle(
                                                    color: isDarkMode
                                                        ? AppColors.darkTitle
                                                        : Colors.black87,
                                                  ),
                                                )),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: isMedicalStatistics
                                              ? _buildRequiredLabel(
                                                  context
                                                      .tr(AppStrings.workplace),
                                                  isDarkMode)
                                              : Text(
                                                  context
                                                      .tr(AppStrings.workplace),
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
                                          title: isMedicalStatistics
                                              ? '${context.tr(AppStrings.job)} *'
                                              : context.tr(AppStrings.job),
                                          initialValue:
                                              currentDoctorModel.job ?? '',
                                          textInputType: TextInputType.text,
                                          onChanged: (value) {
                                            cubit.job = value;
                                            cubit.checkForChanges();
                                          },
                                          validator: (value) =>
                                              isMedicalStatistics
                                                  ? AppValidators
                                                      .fieldsIsEmptyValidation(
                                                          value ?? '')
                                                  : null,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: CustomTextFormField(
                                          title: isMedicalStatistics
                                              ? '${context.tr(AppStrings.workplace)} *'
                                              : context
                                                  .tr(AppStrings.workplace),
                                          initialValue:
                                              currentDoctorModel.workingplace ??
                                                  '',
                                          textInputType: TextInputType.text,
                                          validator: (value) =>
                                              isMedicalStatistics
                                                  ? AppValidators
                                                      .fieldsIsEmptyValidation(
                                                          value ?? '')
                                                  : null,
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
                                          child: isMedicalStatistics
                                              ? _buildRequiredLabel(
                                                  'Registration Number (رقم القيد الخاص بالنقابة)',
                                                  isDarkMode)
                                              : Text(
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
                                          title: isMedicalStatistics
                                              ? 'Registration Number (رقم القيد الخاص بالنقابة) *'
                                              : 'Registration Number (رقم القيد الخاص بالنقابة)',
                                          enabled: true,
                                          onChanged: (value) {
                                            cubit.registrationNumber = value;
                                            cubit.checkForChanges();
                                          },
                                          initialValue: currentDoctorModel
                                                  .registrationNumber ??
                                              '',
                                          textInputType: TextInputType.number,
                                          validator: (value) =>
                                              isMedicalStatistics
                                                  ? AppValidators
                                                      .fieldsIsEmptyValidation(
                                                          value ?? '')
                                                  : null,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: isMedicalStatistics
                                              ? _buildRequiredLabel(
                                                  context
                                                      .tr(AppStrings.specialty),
                                                  isDarkMode)
                                              : Text(
                                                  context
                                                      .tr(AppStrings.specialty),
                                                  style: TextStyle(
                                                    color: isDarkMode
                                                        ? AppColors.darkTitle
                                                        : Colors.black87,
                                                  ),
                                                )),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: isMedicalStatistics
                                              ? _buildRequiredLabel(
                                                  context.tr(
                                                      AppStrings.highestDegree),
                                                  isDarkMode)
                                              : Text(
                                                  context.tr(
                                                      AppStrings.highestDegree),
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
                                          title: isMedicalStatistics
                                              ? '${context.tr(AppStrings.specialty)} *'
                                              : context
                                                  .tr(AppStrings.specialty),
                                          initialValue:
                                              currentDoctorModel.specialty ??
                                                  '',
                                          textInputType: TextInputType.text,
                                          validator: (value) =>
                                              isMedicalStatistics
                                                  ? AppValidators
                                                      .fieldsIsEmptyValidation(
                                                          value ?? '')
                                                  : null,
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
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: currentDoctorModel
                                                            .highestdegree !=
                                                        null &&
                                                    currentDoctorModel
                                                        .highestdegree!
                                                        .isNotEmpty &&
                                                    highestDegreeList.contains(
                                                        currentDoctorModel
                                                            .highestdegree)
                                                ? currentDoctorModel
                                                    .highestdegree
                                                : null,
                                            hint: isMedicalStatistics
                                                ? Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: context.tr(
                                                              AppStrings
                                                                  .choose),
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: isDarkMode
                                                                ? Colors.grey
                                                                    .shade300
                                                                : Colors.grey
                                                                    .shade600,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' *',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text(
                                                    context
                                                        .tr(AppStrings.choose),
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: isDarkMode
                                                          ? Colors.grey.shade300
                                                          : Colors
                                                              .grey.shade600,
                                                    ),
                                                  ),
                                            items:
                                                highestDegreeList.map((value) {
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
                                            validator: (value) =>
                                                isMedicalStatistics
                                                    ? AppValidators
                                                        .fieldsIsEmptyValidation(
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
                                ],
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
                                          isSubmit,
                                          isMedicalStatistics) {
                                        if (currentDoctorModel.email
                                                .toString() ==
                                            'moatz2163@gmail.com') {
                                          return AdminOnlyBadge(
                                            badgeText: 'For Moatz only',
                                            style: BadgeStyle.premium,
                                            glowEffect: true,
                                            pulseAnimation: true,
                                            fontSize: 8.sp,
                                            badgePadding: EdgeInsets.symmetric(
                                                horizontal: 5.w, vertical: 1.h),
                                            child: SizedBox(
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
