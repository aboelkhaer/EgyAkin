import '../../../exports.dart';

class SectionDetailsController extends GetxController {
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  SectionDetailsRepository sectionDetailsRepository =
      Get.find<SectionDetailsRepository>();
  GlobalKey<FormState> sectionDetailsKeyForm = GlobalKey<FormState>();
  HomeController homeController = Get.find<HomeController>();
  final ScrollController scrollController = ScrollController();

  List<BaseQuestionModel>? questionModelList = [];
  Map<String, dynamic> formData = {};

  RxBool isSectionDetailsLoading = false.obs;
  RxBool isSubmit = false.obs;

  getPatientSectionDetails(String sectionId, String patientId) async {
    isSectionDetailsLoading(true);
    List<BaseQuestionModel>? containList =
        await sectionDetailsRepository.getPatientSectionDetails(
            sectionId: sectionId,
            patientId: patientId,
            isSectionDetailsLoading: isSectionDetailsLoading);

    questionModelList = containList;

    isSectionDetailsLoading(false);
    update();
  }

  RxBool isSectionDetailsUpdateLoading = false.obs;

  updateSectionDetails(String sectionId, String patientId, context) async {
    isSectionDetailsUpdateLoading(true);
    await sectionDetailsRepository.updateSectionDetails(
        sectionId: sectionId,
        patientId: patientId,
        isSectionDetailsUpdateLoading: isSectionDetailsUpdateLoading,
        map: formData,
        context: context);
    formData = {};
    isSectionDetailsUpdateLoading(false);

    update();
  }
}
