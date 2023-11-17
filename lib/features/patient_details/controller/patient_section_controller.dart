import 'dart:developer';

import '../../../exports.dart';

class PatientSectionController extends GetxController {
  PatientSectionRepository patientSectionRepository =
      Get.find<PatientSectionRepository>();
  HomeController homeController = Get.find<HomeController>();

  RxList<BaseSectionModel>? sectionModelList = RxList();
  //  RxList<VocabularyModel> vocabs = RxList();
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  RxBool isPatientSectionLoading = false.obs;

  getPatientSections(String patientId) async {
    isPatientSectionLoading(true);
    List<BaseSectionModel>? containList =
        await patientSectionRepository.getPatientSection(
            patientId: patientId,
            isPatientSectionLoading: isPatientSectionLoading);
    sectionModelList!.value = containList!;
    isPatientSectionLoading(false);
    update();
  }

  deletePatient(String patientId) async {
    Get.back();
    isPatientSectionLoading(true);
    await patientSectionRepository.deletePatient(
        patientId: patientId, isPatientSectionLoading: isPatientSectionLoading);
    isPatientSectionLoading(false);
    update();
  }

  finalSubmit(String patientId, context) async {
    bool allSectionsSubmitted = true;
    List<String> sectionsNotCompleted = [];

    await Future.forEach(sectionModelList!, (element) async {
      if (element.sectionStatus! == false) {
        sectionsNotCompleted.add(element.sectionName!);
      }
    });

    if (sectionsNotCompleted.isEmpty) {
      isPatientSectionLoading(true);
      await patientSectionRepository.finalSubmit(
          patientId: patientId,
          isPatientSectionLoading: isPatientSectionLoading);
      homeController.homeInit();
      isPatientSectionLoading(false);
      log('all completed');
    } else {
      showCustomDialog(
          context: context,
          title: 'You left some sections in binding, continue?',
          // description:
          //     'You left sections not completed, you sure want to continue?',
          description: sectionsNotCompleted,
          noColoredBottonOnTap: () => Get.back(),
          coloredBottonText: 'Submit',
          noColoredBottonText: 'Cancel',
          coloredBottonOnTap: () async {
            Get.back();
            isPatientSectionLoading(true);
            await patientSectionRepository.finalSubmit(
                patientId: patientId,
                isPatientSectionLoading: isPatientSectionLoading);
            homeController.homeInit();
            isPatientSectionLoading(false);
          });
    }
    sectionsNotCompleted = [];
    update();
  }
}
