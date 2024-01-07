import '../../../exports.dart';

class DoctroProfileController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  ProfileRepository profileRepository = Get.find<ProfileRepository>();
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  List<String> highestDegreeList =
      Get.find<RegisterController>().highestDegreeList;
  Rx<String?> highestDegree = ''.obs;

  late TextEditingController profileFirstNameController;
  late TextEditingController profileLastNameController;
  late TextEditingController profileEmailController;
  late TextEditingController profilePhoneController;
  late TextEditingController profileAgeController;
  late TextEditingController profileJobController;
  late TextEditingController profileRegistrationNumberController;
  late TextEditingController profileWorkingPlaceController;
  late TextEditingController profileSpecialtyController;

  RxBool isProfileHasChanged = false.obs;
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode registrationNumberFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode jobFocusNode = FocusNode();
  FocusNode workPlaceFocusNode = FocusNode();
  FocusNode specialtyFocusNode = FocusNode();

  // TODO zawed el registration number

  doctorProfileDispose() {
    profileFirstNameController.dispose();
    profileLastNameController.dispose();
    profileEmailController.dispose();
    profilePhoneController.dispose();
    profileRegistrationNumberController.dispose();
    profileAgeController.dispose();
    profileJobController.dispose();
    profileWorkingPlaceController.dispose();
    profileSpecialtyController.dispose();
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
      highestDegree: highestDegree.value!,
      isUpdateLoading: isUpdateLoading,
    );

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   homeController.homeInit();
    // });
    isUpdateLoading.value = false;
    update();
  }
}
