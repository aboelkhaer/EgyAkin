import '../../../exports.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final DoctroProfileController controller = Get.put(DoctroProfileController());
  @override
  void initState() {
    controller.highestDegree =
        controller.homeController.currentDoctorHighestDegree.obs;
    controller.profileFirstNameController = TextEditingController(
        text: controller.homeController.currentDoctorFirstName);
    controller.profileLastNameController = TextEditingController(
        text: controller.homeController.currentDoctorLastName);
    controller.profileEmailController = TextEditingController(
        text: controller.homeController.currentDoctorEmail);
    controller.profilePhoneController = TextEditingController(
        text: controller.homeController.currentDoctorPhone);
    controller.profileAgeController =
        TextEditingController(text: controller.homeController.currentDoctorAge);
    controller.profileRegistrationNumberController = TextEditingController(
        text: controller.homeController.currentDoctorRegistrationNumber);
    controller.profileJobController =
        TextEditingController(text: controller.homeController.currentDoctorJob);
    controller.profileWorkingPlaceController = TextEditingController(
        text: controller.homeController.currentDoctorWorkPlace);
    controller.profileSpecialtyController = TextEditingController(
        text: controller.homeController.currentDoctorSpecialty);
    super.initState();
  }

  @override
  void dispose() {
    controller.doctorProfileDispose();
    // if (controller.isProfileHasChanged.value) {
    //   controller.homeController.homeInit();
    // }
    controller.isProfileHasChanged(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(
        () => controller.isUpdateLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      CircleAvatar(
                        backgroundColor: AppColors.subBG,
                        radius: 35,
                        child: Text(
                          controller.homeController.currentDoctorFirstName![0]
                                  .toUpperCase() +
                              controller
                                  .homeController.currentDoctorLastName![0]
                                  .toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 22),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      GetBuilder(
                        init: DoctroProfileController(),
                        builder: (profileController) {
                          var patientsCount = profileController
                              .homeController.currentPatinetList!.length;
                          return patientsCount == 0
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('You don\'t add any patients yet. '),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('You have been added'),
                                    const SizedBox(width: 5),
                                    Text(
                                      patientsCount.toString(),
                                      style: TextStyle(
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(patientsCount > 1
                                        ? 'patients'
                                        : 'patient'),
                                    const SizedBox(width: 5),
                                    const Text('and'),
                                    const SizedBox(width: 5),
                                    Text(
                                      controller.homeController
                                          .currentDoctorScoreValue
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('score'),
                                  ],
                                );
                        },
                      ),
                      SizedBox(height: size.height * 0.05),
                      Form(
                        key: controller.profileFormKey,
                        autovalidateMode: controller.profileErrorValid == 0
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
                                    textFormFieldController:
                                        controller.profileFirstNameController,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.lastNameFocusNode),
                                    onChanged: (value) {
                                      if (value !=
                                          controller.homeController
                                              .currentDoctorFirstName) {
                                        controller.isProfileHasChanged.value =
                                            true;
                                      } else {
                                        controller.isProfileHasChanged.value =
                                            false;
                                      }
                                    },
                                    enableSuggestions: true,
                                    validator: (value) => controller
                                        .firstAndLastNameValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Last name',
                                    textFormFieldController:
                                        controller.profileLastNameController,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.emailFocusNode),
                                    focusNode: controller.lastNameFocusNode,
                                    onChanged: (value) {
                                      if (value !=
                                          controller.homeController
                                              .currentDoctorLastName) {
                                        controller.isProfileHasChanged.value =
                                            true;
                                      } else {
                                        controller.isProfileHasChanged.value =
                                            false;
                                      }
                                    },
                                    enableSuggestions: true,
                                    textInputType: TextInputType.text,
                                    validator: (value) => controller
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
                              textFormFieldController:
                                  controller.profileEmailController,
                              onFieldSubmitted: (v) => FocusScope.of(context)
                                  .requestFocus(controller.phoneFocusNode),
                              focusNode: controller.emailFocusNode,
                              enableSuggestions: true,
                              textInputType: TextInputType.text,
                              validator: (value) =>
                                  controller.emailValidate(value!),
                              onChanged: (value) {
                                if (value !=
                                    controller
                                        .homeController.currentDoctorEmail) {
                                  controller.isProfileHasChanged.value = true;
                                } else {
                                  controller.isProfileHasChanged.value = false;
                                }
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
                                    textFormFieldController:
                                        controller.profilePhoneController,
                                    focusNode: controller.phoneFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.ageFocusNode),
                                    onChanged: (value) {
                                      if (value !=
                                          controller.homeController
                                              .currentDoctorPhone) {
                                        controller.isProfileHasChanged.value =
                                            true;
                                      } else {
                                        controller.isProfileHasChanged.value =
                                            false;
                                      }
                                    },
                                    textInputType: TextInputType.phone,
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
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
                                    textFormFieldController:
                                        controller.profileAgeController,
                                    focusNode: controller.ageFocusNode,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.jobFocusNode),
                                    onChanged: (value) {
                                      if (value !=
                                          controller.homeController
                                              .currentDoctorAge) {
                                        controller.isProfileHasChanged.value =
                                            true;
                                      } else {
                                        controller.isProfileHasChanged.value =
                                            false;
                                      }
                                    },
                                    textInputType: TextInputType.number,
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
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
                                    textFormFieldController:
                                        controller.profileJobController,
                                    focusNode: controller.jobFocusNode,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.workPlaceFocusNode),
                                    onChanged: (value) {
                                      if (value !=
                                          controller.homeController
                                              .currentDoctorJob) {
                                        controller.isProfileHasChanged.value =
                                            true;
                                      } else {
                                        controller.isProfileHasChanged.value =
                                            false;
                                      }
                                    },
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Workplace',
                                    textFormFieldController: controller
                                        .profileWorkingPlaceController,
                                    textInputType: TextInputType.text,
                                    onFieldSubmitted: (v) =>
                                        FocusScope.of(context).requestFocus(
                                            controller.specialtyFocusNode),
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    onChanged: (value) {
                                      if (value !=
                                          controller.homeController
                                              .currentDoctorWorkPlace) {
                                        controller.isProfileHasChanged.value =
                                            true;
                                      } else {
                                        controller.isProfileHasChanged.value =
                                            false;
                                      }
                                    },
                                    focusNode: controller.workPlaceFocusNode,
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

                                    textFormFieldController: controller
                                        .profileRegistrationNumberController,
                                    // focusNode: registerationNumberFocusNode,
                                    textInputType: TextInputType.number,
                                    // onFieldSubmitted: (v) =>
                                    // FocusScope.of(context)
                                    //     .requestFocus(specialtyFocusNode),
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
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
                                    textFormFieldController:
                                        controller.profileSpecialtyController,
                                    textInputType: TextInputType.text,
                                    validator: (value) => controller
                                        .fieldsIsEmptyValidation(value!),
                                    onChanged: (value) {
                                      if (value !=
                                          controller.homeController
                                              .currentDoctorSpecialty) {
                                        controller.isProfileHasChanged.value =
                                            true;
                                      } else {
                                        controller.isProfileHasChanged.value =
                                            false;
                                      }
                                    },
                                    focusNode: controller.specialtyFocusNode,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Expanded(
                                //   child: CustomTextFormField(
                                //     title: 'Highest Degree',
                                //     textFormFieldController: controller
                                //         .profileHighestDegreeController,
                                //     enableSuggestions: true,
                                //     textInputType: TextInputType.text,
                                //     focusNode:
                                //         controller.highestDegreeFocusNode,
                                //     onChanged: (value) {
                                //       if (value !=
                                //           controller.homeController
                                //               .currentDoctorHighestDegree) {
                                //         controller.isProfileHasChanged.value =
                                //             true;
                                //       } else {
                                //         controller.isProfileHasChanged.value =
                                //             false;
                                //       }
                                //     },
                                //     validator: (value) => controller
                                //         .fieldsIsEmptyValidation(value!),
                                //     textInputAction: TextInputAction.done,
                                //   ),
                                // ),
                                Expanded(
                                  // child: CustomTextFormField(
                                  //   title: 'Highest Degree',
                                  //   textFormFieldController:
                                  //       registerHighestDegreeController,
                                  //   enableSuggestions: true,
                                  //   textInputType: TextInputType.text,
                                  //   focusNode: highestDegreeFocusNode,
                                  //   validator: (value) => controller
                                  //       .fieldsIsEmptyValidation(value!),
                                  //   textInputAction: TextInputAction.done,
                                  // ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primary.withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButtonFormField<dynamic>(
                                      hint: Text(
                                          controller.highestDegree.value ??
                                              'Choose'),

                                      items: controller.highestDegreeList
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),

                                      onChanged: (val) {
                                        controller.highestDegree.value = val;
                                        controller.isProfileHasChanged.value =
                                            true;
                                      },
                                      validator: (val) {
                                        if ((val == null || val == '')) {
                                          return 'This field is required';
                                        }

                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                      // decoration: const InputDecoration(label: Text('Choose')),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.05),
                            Obx(
                              () => SizedBox(
                                width: double.infinity,
                                child: CustomElevatedButton(
                                  size: size,
                                  onPressed: () => controller.updateProfile(),
                                  isDisable:
                                      !controller.isProfileHasChanged.value,
                                  title: 'Save',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
