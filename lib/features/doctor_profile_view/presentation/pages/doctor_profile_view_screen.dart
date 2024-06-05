import 'package:egy_akin/app/shared/functions/hightest_degree_list.dart';
import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_cubit.dart';
import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_state.dart';

import '../../../../exports.dart';

class DoctorProfileViewScreen extends StatelessWidget {
  const DoctorProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorProfileViewCubit cubit = DoctorProfileViewCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: BlocConsumer<DoctorProfileViewCubit, DoctorProfileViewState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (currentDoctorModel, isProfileHasChanged, message,
                  isUpdateing, isSubmit) {
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
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              loaded: (currentDoctorModel, isProfileHasChanged, message,
                  isUpdateing, isSubmit) {
                if (isUpdateing) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: size.height * 0.05),
                        // SizedBox(height: size.height * 0.02),
                        Form(
                          key: cubit.formKey,
                          autovalidateMode: cubit.profileErrorValid == 0
                              ? AutovalidateMode.disabled
                              : AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'First name',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Last name',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'First name',
                                      initialValue:
                                          currentDoctorModel.firstName,

                                      textInputType: TextInputType.text,
                                      // onFieldSubmitted: (v) =>
                                      //     FocusScope.of(context).requestFocus(
                                      //         controller.lastNameFocusNode),
                                      onChanged: (value) {
                                        // if (value !=
                                        //     controller.homeController
                                        //         .currentDoctorFirstName) {
                                        //   controller.isProfileHasChanged.value =
                                        //       true;
                                        // } else {
                                        //   controller.isProfileHasChanged.value =
                                        //       false;
                                        // }

                                        cubit.firstName = value;
                                      },
                                      enableSuggestions: true,
                                      validator: (value) => AppValidators
                                          .firstAndLastNameValidation(value!),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'Last name',
                                      // textFormFieldController:
                                      //     controller.profileLastNameController,
                                      // onFieldSubmitted: (v) =>
                                      //     FocusScope.of(context).requestFocus(
                                      //         controller.emailFocusNode),
                                      // focusNode: controller.lastNameFocusNode,
                                      initialValue: currentDoctorModel.lastName,
                                      onChanged: (value) {
                                        cubit.lastName = value;
                                      },
                                      enableSuggestions: true,
                                      textInputType: TextInputType.text,
                                      validator: (value) => AppValidators
                                          .firstAndLastNameValidation(value!),
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
                                // textFormFieldController:
                                //     controller.profileEmailController,
                                // onFieldSubmitted: (v) => FocusScope.of(context)
                                //     .requestFocus(controller.phoneFocusNode),
                                // focusNode: controller.emailFocusNode,
                                initialValue: currentDoctorModel.email,
                                enableSuggestions: true,
                                textInputType: TextInputType.text,
                                validator: (value) =>
                                    AppValidators.emailValidator(value),
                                onChanged: (value) {
                                  // if (value !=
                                  //     controller
                                  //         .homeController.currentDoctorEmail) {
                                  //   controller.isProfileHasChanged.value = true;
                                  // } else {
                                  //   controller.isProfileHasChanged.value =
                                  //       false;
                                  // }
                                  cubit.email = value;
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(height: size.height * 0.01),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Phone',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Age',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'Phone',
                                      // textFormFieldController:
                                      //     controller.profilePhoneController,
                                      // focusNode: controller.phoneFocusNode,
                                      // onFieldSubmitted: (v) =>
                                      //     FocusScope.of(context).requestFocus(
                                      //         controller.ageFocusNode),
                                      initialValue: currentDoctorModel.phone,
                                      onChanged: (value) {
                                        // if (value !=
                                        //     controller.homeController
                                        //         .currentDoctorPhone) {
                                        //   controller.isProfileHasChanged.value =
                                        //       true;
                                        // } else {
                                        //   controller.isProfileHasChanged.value =
                                        //       false;
                                        // }
                                        cubit.phone = value;
                                      },
                                      textInputType: TextInputType.phone,
                                      validator: (value) =>
                                          AppValidators.validatePhoneNumber(
                                              value!),
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(11),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'Age',
                                      initialValue: currentDoctorModel.age,
                                      // textFormFieldController:
                                      //     controller.profileAgeController,
                                      // focusNode: controller.ageFocusNode,
                                      // onFieldSubmitted: (v) =>
                                      //     FocusScope.of(context).requestFocus(
                                      //         controller.jobFocusNode),
                                      onChanged: (value) {
                                        // if (value !=
                                        //     controller.homeController
                                        //         .currentDoctorAge) {
                                        //   controller.isProfileHasChanged.value =
                                        //       true;
                                        // } else {
                                        //   controller.isProfileHasChanged.value =
                                        //       false;
                                        // }
                                        cubit.age = value;
                                      },
                                      textInputType: TextInputType.number,
                                      validator: (value) =>
                                          AppValidators.validateAge(value!),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Job',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Workplace',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'Job',
                                      initialValue: currentDoctorModel.job,
                                      textInputType: TextInputType.text,
                                      onChanged: (value) {
                                        cubit.job = value;
                                      },
                                      validator: (value) =>
                                          AppValidators.fieldsIsEmptyValidation(
                                              value!),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'Workplace',
                                      initialValue:
                                          currentDoctorModel.workingplace,
                                      textInputType: TextInputType.text,
                                      validator: (value) =>
                                          AppValidators.fieldsIsEmptyValidation(
                                              value!),
                                      onChanged: (value) {
                                        cubit.workplace = value;
                                      },
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(11),
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
                                      'Registeration Number (رقم القيد الخاص بالنقابة)',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      title:
                                          'Registeration Number (رقم القيد الخاص بالنقابة)',
                                      enabled: false,
                                      initialValue:
                                          currentDoctorModel.registrationNumber,
                                      textInputType: TextInputType.number,
                                      validator: (value) =>
                                          AppValidators.fieldsIsEmptyValidation(
                                              value!),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Specialty',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Highest Degree',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'Specialty',
                                      initialValue:
                                          currentDoctorModel.specialty,
                                      textInputType: TextInputType.text,
                                      validator: (value) =>
                                          AppValidators.fieldsIsEmptyValidation(
                                              value!),
                                      onChanged: (value) {
                                        cubit.specialty = value;
                                      },
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
                                        hint: Text(
                                            currentDoctorModel.highestdegree ??
                                                'Choose'),
                                        items: highestDegreeList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          cubit.highestDegree = val;
                                        },
                                        validator: (value) => AppValidators
                                            .fieldsIsEmptyValidation(value!),
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
                                    cubit.updateDoctorProfile();
                                  },
                                  // isDisable:
                                  //     !controller.isProfileHasChanged.value,
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
        ));
  }
}
