import '../../../exports.dart';

class DoctroProfileController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  ProfileRepository profileRepository = Get.find<ProfileRepository>();
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  late TextEditingController profileFirstNameController;
  String? profileFirstName;
  late TextEditingController profileLastNameController;
  String? profileLastName;
  late TextEditingController profileEmailController;
  String? profileEmail;
  late TextEditingController profilePhoneController;
  String? profilePhone;
  late TextEditingController profileAgeController;
  String? profileAge;
  late TextEditingController profileJobController;
  String? profileJob;
  late TextEditingController profileWorkingPlaceController;
  String? profileWorkingPlace;
  late TextEditingController profileSpecialtyController;
  String? profileSpecialty;
  late TextEditingController profileHighestDegreeController;
  String? profileHighestDegree;
  RxBool isProfileHasChanged = false.obs;
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode jobFocusNode = FocusNode();
  FocusNode workPlaceFocusNode = FocusNode();
  FocusNode specialtyFocusNode = FocusNode();
  FocusNode highestDegreeFocusNode = FocusNode();
  @override
  void onInit() {
    super.onInit();
    // isProfileChanged();
    profileFirstNameController =
        TextEditingController(text: homeController.currentDoctorFirstName);
    profileLastNameController =
        TextEditingController(text: homeController.currentDoctorLastName);
    profileEmailController =
        TextEditingController(text: homeController.currentDoctorEmail);
    profilePhoneController =
        TextEditingController(text: homeController.currentDoctorPhone);
    profileAgeController =
        TextEditingController(text: homeController.currentDoctorAge);
    profileJobController =
        TextEditingController(text: homeController.currentDoctorJob);
    profileWorkingPlaceController =
        TextEditingController(text: homeController.currentDoctorWorkPlace);
    profileSpecialtyController =
        TextEditingController(text: homeController.currentDoctorSpecialty);
    profileHighestDegreeController =
        TextEditingController(text: homeController.currentDoctorHighestDegree);
  }

  @override
  void onClose() {
    doctorProfileDispose();
    super.onClose();
  }

  doctorProfileDispose() {
    profileFirstNameController.dispose();
    profileLastNameController.dispose();
    profileEmailController.dispose();
    profilePhoneController.dispose();
    profileAgeController.dispose();
    profileJobController.dispose();
    profileWorkingPlaceController.dispose();
    profileSpecialtyController.dispose();
    profileHighestDegreeController.dispose();
    if (profileFormKey.currentState != null) {
      profileFormKey.currentState!.reset();
    }
  }

  // validation
  String? emailValidate(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Provide a valid email, please';
    }
    return null;
  }

  String? firstAndLastNameValidation(String value) {
    if (value.isEmpty) {
      return 'Provide a valid name, please';
    } else {
      RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$').hasMatch(value)
          ? 'Arabic characters only'
          : null;
    }
    return null;
  }

  String? fieldsIsEmptyValidation(String value) {
    if (value.isEmpty) {
      return 'Provide this field, please';
    }
    return null;
  }

  int profileErrorValid = 0;

  // isProfileChanged(RxBool isProfileHasChanged) {
  //   if (profileFirstNameController.text !=
  //       homeController.currentDoctorFirstName) {
  //     isProfileHasChanged(false);
  //   }
  //   isProfileHasChanged(true);
  // }
  RxBool isUpdateLoading = false.obs;
  updateProfile() async {
    isUpdateLoading.value = true;
    await profileRepository.updateProfile(
      doctorID: homeController.currentDoctorId!,
      firstName: profileFirstNameController.text,
      lastName: profileLastNameController.text,
      email: profileEmailController.text,
      age: profileAgeController.text,
      specialty: profileSpecialtyController.text,
      workingPlace: profileWorkingPlaceController.text,
      phone: profilePhoneController.text,
      job: profileJobController.text,
      highestDegree: profileHighestDegreeController.text,
      isUpdateLoading: isUpdateLoading,
    );
    isUpdateLoading.value = false;
    update();
  }
}
