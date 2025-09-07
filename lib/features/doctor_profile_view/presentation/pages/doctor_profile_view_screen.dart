import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';
import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_state.dart';
import '../../../../exports.dart';

class DoctorProfileViewScreen extends StatelessWidget {
  const DoctorProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorProfileViewCubit cubit = DoctorProfileViewCubit.get(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title:  Text(context.tr(AppStrings.editProfile),),
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
                                Expanded(child: Text(context.tr(AppStrings.firstName))),
                                SizedBox(width: 10),
                                Expanded(child: Text(context.tr(AppStrings.lastName))),
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
                                    onChanged: (value) =>
                                        cubit.firstName = value,
                                    enableSuggestions: true,
                                    validator: (value) {
                                      return AppValidators
                                          .firstAndLastNameValidation(
                                              value ?? '');
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
                                    onChanged: (value) =>
                                        cubit.lastName = value,
                                    enableSuggestions: true,
                                    textInputType: TextInputType.text,
                                    validator: (value) => AppValidators
                                        .firstAndLastNameValidation(
                                            value ?? ''),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                             Row(
                              children: [
                                Text(context.tr(AppStrings.email)),
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
                              onChanged: (value) => cubit.email = value,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: size.height * 0.01),
                            SizedBox(height: size.height * 0.01),
                             Row(
                              children: [
                                Expanded(child: Text(context.tr(AppStrings.phone))),
                                SizedBox(width: 10),
                                Expanded(child: Text(context.tr(AppStrings.age))),
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
                                    onChanged: (value) => cubit.phone = value,
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
                                    initialValue: currentDoctorModel.age ?? '',
                                    onChanged: (value) => cubit.age = value,
                                    textInputType: TextInputType.number,
                                    validator: (value) =>
                                        AppValidators.validateAge(value ?? ''),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                             Row(
                              children: [
                                Expanded(child: Text(context.tr(AppStrings.job))),
                                SizedBox(width: 10),
                                Expanded(child: Text(context.tr(AppStrings.workplace))),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: context.tr(AppStrings.job),
                                    initialValue: currentDoctorModel.job ?? '',
                                    textInputType: TextInputType.text,
                                    onChanged: (value) => cubit.job = value,
                                    validator: (value) =>
                                        AppValidators.fieldsIsEmptyValidation(
                                            value ?? ''),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: context.tr(AppStrings.workplace),
                                    initialValue:
                                        currentDoctorModel.workingplace ?? '',
                                    textInputType: TextInputType.text,
                                    validator: (value) =>
                                        AppValidators.fieldsIsEmptyValidation(
                                            value ?? ''),
                                    onChanged: (value) =>
                                        cubit.workplace = value,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        'Registration Number (رقم القيد الخاص بالنقابة)')),
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
                                    onChanged: (value) =>
                                        cubit.registrationNumber = value,
                                    initialValue:
                                        currentDoctorModel.registrationNumber ??
                                            '',
                                    textInputType: TextInputType.number,
                                    validator: (value) =>
                                        AppValidators.fieldsIsEmptyValidation(
                                            value ?? ''),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                             Row(
                              children: [
                                Expanded(child: Text(context.tr(AppStrings.specialty))),
                                SizedBox(width: 10),
                                Expanded(child: Text(context.tr(AppStrings.highestDegree))),
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
                                    validator: (value) =>
                                        AppValidators.fieldsIsEmptyValidation(
                                            value ?? ''),
                                    onChanged: (value) =>
                                        cubit.specialty = value,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primary.withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButtonFormField<dynamic>(
                                      value: currentDoctorModel.highestdegree ??
                                          context.tr(AppStrings.choose),
                                      items: [context.tr(AppStrings.choose), ...highestDegreeList]
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (val) =>
                                          cubit.highestDegree = val ?? context.tr(AppStrings.choose),
                                      validator: (value) =>
                                          AppValidators.fieldsIsEmptyValidation(
                                              value ?? ''),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
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
                                  if (cubit.formKey.currentState?.validate() ??
                                      false) {
                                    cubit.updateDoctorProfile();
                                  } else {
                                  }
                                },
                                title: context.tr(AppStrings.save),
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
                                    if (currentDoctorModel.email.toString() ==
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
  }
}
