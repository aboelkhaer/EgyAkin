import '../../../exports.dart';

class AddPatientController extends GetxController {
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  AddPatientRepository addPatientRepository = Get.find<AddPatientRepository>();
  GlobalKey<FormState> addPatientKeyForm = GlobalKey<FormState>();
  HomeController homeController = Get.find<HomeController>();
  ScrollController scrollController = ScrollController();
  Map otherValue = {};

  List<BaseQuestionModel>? questionModelList = [];
  Map<String, dynamic> formData = {};
  Map<String, bool> formValidate = {};

  RxBool isAddPatientLoading = false.obs;

  getPatientSectionDetails(String sectionId) async {
    isAddPatientLoading(true);
    List<BaseQuestionModel>? containList =
        await addPatientRepository.getPatientSectionDetails(
      sectionId: sectionId,
      isAddPatientLoading: isAddPatientLoading,
    );

    questionModelList = containList;

    isAddPatientLoading(false);
    update();
  }

  RxBool isAddPatientForFirstTimeLoading = false.obs;
  addPatientForFirstTime() async {
    isAddPatientForFirstTimeLoading(true);

    await addPatientRepository.addPatientForFirstTime(
      isAddPatientForFirstTimeLoading: isAddPatientForFirstTimeLoading,
      doctorId: homeController.currentDoctorId.toString(),
      map: formData,
    );

    isAddPatientForFirstTimeLoading(false);
    update();
  }
}
