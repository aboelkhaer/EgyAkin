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
        title: const Text('Edit Profile'),
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
                            const Row(
                              children: [
                                Expanded(child: Text('First name')),
                                SizedBox(width: 10),
                                Expanded(child: Text('Last name')),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'First name',
                                    initialValue:
                                        currentDoctorModel.firstName ?? '',
                                    textInputType: TextInputType.text,
                                    onChanged: (value) =>
                                        cubit.firstName = value,
                                    enableSuggestions: true,
                                    validator: (value) {
                                      print('Validating First Name: $value');
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
                                    title: 'Last name',
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
                            const Row(
                              children: [
                                Text('Email'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              title: 'Email',
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
                            const Row(
                              children: [
                                Expanded(child: Text('Phone')),
                                SizedBox(width: 10),
                                Expanded(child: Text('Age')),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Phone',
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
                                    title: 'Age',
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
                            const Row(
                              children: [
                                Expanded(child: Text('Job')),
                                SizedBox(width: 10),
                                Expanded(child: Text('Workplace')),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Job',
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
                                    title: 'Workplace',
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
                                    enabled: false,
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
                            const Row(
                              children: [
                                Expanded(child: Text('Specialty')),
                                SizedBox(width: 10),
                                Expanded(child: Text('Highest Degree')),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Specialty',
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
                                      // hint: Text(
                                      //     currentDoctorModel.highestdegree ??
                                      //         'Choose'),
                                      value: currentDoctorModel.highestdegree ??
                                          'Choose',

                                      items: highestDegreeList.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (val) =>
                                          cubit.highestDegree = val ?? '',
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
                                  print("Button Pressed");
                                  if (cubit.formKey.currentState?.validate() ??
                                      false) {
                                    cubit.updateDoctorProfile();
                                  } else {
                                    print("Form validation failed");
                                  }
                                },
                                title: 'Save',
                              ),
                            ),
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
