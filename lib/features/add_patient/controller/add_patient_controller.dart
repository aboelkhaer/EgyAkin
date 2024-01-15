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

  submitBotton({
    required BuildContext context,
  }) {
    bool isValid = true;

    for (var question in questionModelList!) {
      if (question.mandatory == true) {
        if (question.type == 'multiple') {
          Map myMap = formData[question.id.toString()] ??= {
            "answers": [],
            "other_field": ''
          };

          // Check if "answers" key is either null or an empty list
          if (myMap.containsKey('answers')) {
            dynamic answersValue = myMap['answers'];

            if (answersValue == null ||
                (answersValue is List && answersValue.isEmpty)) {
              debugPrint('"answers" key is either null or an empty list.');

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
          }
        }
        if (question.answer == null || question.answer == '') {
          showCustomDialog(
            context: context,
            title: 'Required',
            description: 'This question is required \n{${question.question}}',
            coloredBottonText: 'Cancel',
            isNoColorShow: false,
            coloredBottonOnTap: () {
              Get.back();
            },
          );

          isValid = false;
          break;
        }

        if (question.question == 'Phone') {
          String phoneNumber = formData[question.id.toString()];

          if (phoneNumber.length != 11) {
            showCustomDialog(
              context: context,
              title: 'Required',
              description: 'Phone should have 11 digits',
              coloredBottonText: 'Cancel',
              isNoColorShow: false,
              coloredBottonOnTap: () {
                Get.back();
              },
            );
            isValid = false;
            break;
          }
          if (int.tryParse(phoneNumber) == null) {
            showCustomDialog(
              context: context,
              title: 'Required',
              description: 'Phone should have 11 digits',
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
      }
    }

    if (isValid) {
      addPatientForFirstTime();
    }
  }
}
