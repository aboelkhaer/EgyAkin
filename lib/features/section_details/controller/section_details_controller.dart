import 'dart:developer';

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

  updateSectionDetails(String sectionId, String patientId) async {
    isSectionDetailsUpdateLoading(true);
    await sectionDetailsRepository.updateSectionDetails(
      sectionId: sectionId,
      patientId: patientId,
      isSectionDetailsUpdateLoading: isSectionDetailsUpdateLoading,
      map: formData,
    );
    formData = {};
    isSectionDetailsUpdateLoading(false);

    update();
  }

  submitBotton(
      {required String sectionId,
      required String patientId,
      required BuildContext context}) {
    bool isValid = true;

    for (var question in questionModelList!) {
      if (question.mandatory == true) {
        if (question.type == 'multiple') {
          Map myMap = question.answer;
          log(myMap.toString());

          // Check if "answers" key is either null or an empty list
          if (myMap.containsKey('answers')) {
            dynamic answersValue = myMap['answers'];

            if (answersValue == null ||
                (answersValue is List && answersValue.isEmpty)) {
              debugPrint('"answers" key is either null or an empty list.');
              // customSnackBar(
              //   isError: true,
              //   title: 'Required',
              //   body:
              //       'You must select at least one choice. \n{${question.question}}',
              // );
              showCustomDialog(
                context: context,
                title: 'Required',
                description:
                    'You must select at least one choice. \n{${question.question}}',
                coloredBottonText: 'Cancel',
                isNoColorShow: false,
                coloredBottonOnTap: () {
                  Get.back();
                },
              );

              isValid = false;
              break;
            } else {
              debugPrint(
                  '"answers" key is present and has a non-empty list value: $answersValue');
            }
          } else {
            debugPrint('"answers" key is not present in the map.');
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: 'Something went wrong.',
            );

            isValid = false;
            break;
          }

          if ((myMap['other_field'] == null ||
                  myMap['other_field'].toString().isEmpty) &&
              (myMap['answers'] as List).contains('Others')) {
            // customSnackBar(
            //   isError: true,
            //   title: 'Required',
            //   body: 'You must add "Others" field in \n{${question.question}}',
            // );
            showCustomDialog(
              context: context,
              title: 'Required',
              description:
                  'You must add "Others" field in \n{${question.question}}',
              coloredBottonText: 'Cancel',
              isNoColorShow: false,
              coloredBottonOnTap: () {
                Get.back();
              },
            );

            isValid = false;
            break;
          }
        }
        if (question.question == 'National ID') {
          if (formData.containsKey(question.id.toString())) {
            String nationalID = formData[question.id.toString()];
            if (nationalID.length != 14) {
              // customSnackBar(
              //   isError: true,
              //   title: 'Required',
              //   body: 'National ID should have 14 digits',
              // );
              showCustomDialog(
                context: context,
                title: 'Required',
                description: 'National ID should have 14 digits',
                coloredBottonText: 'Cancel',
                isNoColorShow: false,
                coloredBottonOnTap: () {
                  Get.back();
                },
              );
              isValid = false;
              break;
            }
            if (int.tryParse(nationalID) == null) {
              showCustomDialog(
                context: context,
                title: AppStrings.required,
                description: AppStrings.nationalIDShouldHave14Digits,
                coloredBottonText: AppStrings.cancel,
                isNoColorShow: false,
                coloredBottonOnTap: () {
                  Get.back();
                },
              );
              isValid = false;
              break;
            }
          }
        }

        if (question.answer == null || question.answer == AppStrings.empty) {
          showCustomDialog(
            context: context,
            title: AppStrings.required,
            description:
                '${AppStrings.youMustSelectAtLeastOneChoice} \n{${question.question}}',
            coloredBottonText: AppStrings.cancel,
            isNoColorShow: false,
            coloredBottonOnTap: () {
              Get.back();
            },
          );

          isValid = false;
          break;
        }
      }
    }

    if (isValid) {
      updateSectionDetails(
        sectionId,
        patientId,
      );
    }
  }
}
