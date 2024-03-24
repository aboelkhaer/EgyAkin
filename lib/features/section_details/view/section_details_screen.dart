import 'dart:developer';

import 'package:intl/intl.dart';

import '../../../exports.dart';

class SectionDetailsScreen extends StatefulWidget {
  const SectionDetailsScreen({super.key});

  @override
  State<SectionDetailsScreen> createState() => _SectionDetailsScreenState();
}

class _SectionDetailsScreenState extends State<SectionDetailsScreen> {
  String sectionId = Get.arguments[0].toString();
  String sectionName = Get.arguments[1];
  bool finalSubmit = Get.arguments[2];
  String patientId = Get.arguments[3].toString();
  String doctorId = Get.arguments[4].toString();
  final SectionDetailsController _controller =
      Get.put(SectionDetailsController());

  @override
  void initState() {
    _controller.getPatientSectionDetails(sectionId, patientId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              if (_controller.scrollController.hasClients) {
                _controller.scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text(
              sectionName,
            )),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: finalSubmit
          ? BuildSectionDetailsIfFinalSubmitTrue(controller: _controller)
          : doctorId.toString() !=
                  _controller.homeController.currentDoctorId.toString()
              ? BuildSectionDetailsIfFinalSubmitTrue(controller: _controller)
              : buildSectionForm(size: size),
    );
  }

  Widget buildSectionForm({
    required Size size,
  }) {
    return Stack(
      children: [
        Form(
          key: _controller.sectionDetailsKeyForm,
          child: Obx(
            () => _controller.isSectionDetailsLoading.value
                ? const SingleChildScrollView(
                    child: ShimmerLoadingPatientsCards(ishorizontal: false))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _controller.questionModelList!.length,
                          shrinkWrap: true,
                          controller: _controller.scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var question =
                                _controller.questionModelList![index];

                            return Container(
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primary,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${index + 1} - ${question.question!}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      question.mandatory! ||
                                              question.question ==
                                                  AppStrings.nationalID
                                          ? const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  question.type ==
                                          AppStrings.questionTypeMultiple
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppStrings
                                                  .pressAndHoldToViewAllText,
                                              style: TextStyle(
                                                color: AppColors.description,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  buildQuestionWidget(
                                      _controller.questionModelList!,
                                      index,
                                      size),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      doctorId.toString() !=
                              _controller.homeController.currentDoctorId
                                  .toString()
                          ? const SizedBox.shrink()
                          : finalSubmit
                              ? const SizedBox.shrink()
                              : Container(
                                  height: 90,
                                ),
                    ],
                  ),
          ),
        ),
        doctorId.toString() !=
                _controller.homeController.currentDoctorId.toString()
            ? const SizedBox.shrink()
            : finalSubmit
                ? const SizedBox.shrink()
                : Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(3, 4),
                          ),
                        ],
                      ),
                      child: Obx(
                        () => _controller.isSectionDetailsUpdateLoading.value
                            ? const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: CustomElevatedButton(
                                    size: size,
                                    onPressed: () => _controller.submitBotton(
                                      sectionId: sectionId,
                                      patientId: patientId,
                                      context: context,
                                    ),
                                    title: AppStrings.submit,
                                    isDisable: doctorId.toString() ==
                                                _controller.homeController
                                                    .currentDoctorId
                                                    .toString() &&
                                            _controller.formData.isNotEmpty
                                        ? false
                                        : true,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
      ],
    );
  }

  Widget buildQuestionWidget(
      List<BaseQuestionModel> questionList, int index, Size size) {
    Map<String, dynamic> formDataMap = _controller.formData;

    switch (questionList[index].type) {
      case AppStrings.questionTypeString:
        return BuildStringValueQuestions(
          questionList: questionList,
          index: index,
          initialValue: questionList[index].question == AppStrings.nationalID
              ? doctorId.toString() ==
                      _controller.homeController.currentDoctorId.toString()
                  ? questionList[index].answer ?? AppStrings.empty
                  : hideNationalId(questionList[index].answer)
              : questionList[index].answer ?? AppStrings.empty,
          textInputFormatter: questionList[index].question == AppStrings.phone
              ? [
                  LengthLimitingTextInputFormatter(11),
                ]
              : questionList[index].question == AppStrings.nationalID
                  ? [
                      LengthLimitingTextInputFormatter(14),
                    ]
                  : [],
          onChanged: (val) {
            setState(() {
              if (questionList[index].answer != val) {
                questionList[index].answer = val;
                formDataMap[questionList[index].id.toString()] = val;
              } else {
                questionList[index].answer = null;
                formDataMap.remove(questionList[index].id.toString());
              }
            });
          },
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (val == null || val.isEmpty)) {
              return AppStrings.thisFieldIsRequired;
            }

            return null;
          },
        );
      case AppStrings.questionTypeSelect:
        dynamic selectedValue;
        return BuildSelectValueQuestion(
          questionList: questionList,
          index: index,
          selected: questionList[index].answer ??= selectedValue,
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (questionList[index].answer == null ||
                    questionList[index].answer == AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }

            return null;
          },
          onChanged: (val) {
            selectedValue = val;
            log(selectedValue);
            if (questionList[index].answer != val) {
              questionList[index].answer = val;
              formDataMap[questionList[index].id.toString()] = val;
            } else {
              questionList[index].answer = null;
              formDataMap.remove(questionList[index].id.toString());
            }
            setState(() {});
          },
        );
      case AppStrings.questionTypeMultiple:
        // List<dynamic> answers = questionList[index].answer['answers'] ??= [];
        // String otherValue = '';
        Map<String, dynamic> answerMap = questionList[index].answer ??= {
          AppStrings.answers: [],
          AppStrings.otherField: AppStrings.empty
        };
        List<dynamic> answers =
            questionList[index].answer[AppStrings.answers] ??= [];

        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          initialValue: answerMap[AppStrings.otherField] ?? '',
          listContainOther: answers,
          onChanged: (val) {
            setState(() {
              // _controller.formData[questionList[index].id.toString()] = {
              //   "answer": {
              //     "answer": answers,
              //     "other_field": val,
              //   },
              // };
              answerMap[AppStrings.otherField] = val;
              _controller.formData[questionList[index].id.toString()] = {
                AppStrings.answers: answers,
                AppStrings.otherField: answers.contains(AppStrings.others)
                    ? val
                    : AppStrings.empty,
              };
            });

            log('map ${_controller.formData}');
          },
          validator: (val) {
            if (questionList[index].mandatory == true) {
              if (val == null || val.isEmpty) {
                return AppStrings.chooseAtLeastOnOption;
              }
            }
            return null;
          },
          children: questionList[index].values!.map((value) {
            return Tooltip(
              message: value.toString(),
              child: ChoiceChip(
                label: Text(
                  value.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                backgroundColor: Colors.grey.shade400,
                selected: answers.contains(value),
                selectedColor: AppColors.primary.withOpacity(0.7),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      answers.add(value);
                    } else {
                      answers.remove(value);
                    }

                    _controller.formData[questionList[index].id.toString()] = {
                      AppStrings.answers: answers,
                      AppStrings.otherField: answers.contains(AppStrings.others)
                          ? answerMap[AppStrings.otherField]
                          : AppStrings.empty,
                    };
                    log('map ${_controller.formData}');
                    // log('list answer ${questionList[index].answer}');
                  });
                },
              ),
            );
          }).toList(),
        );
      case AppStrings.questionTypeDate:
        questionList[index].answer ??= DateTime.now().toString();

        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 4,
          child: CalendarDatePicker(
            initialDate: DateTime.parse(questionList[index].answer),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            onDateChanged: (val) {
              questionList[index].answer = val.toString();
              formDataMap[questionList[index].id.toString()] =
                  questionList[index].answer;
              setState(() {});
            },
          ),
        );

      default:
        return Container();
    }
  }

  String stringDateTostring(String datevalue) {
    DateTime convertDate = DateTime.parse(datevalue);

    String stringdate =
        "${convertDate.day}/${convertDate.month}/${convertDate.year}";

    return stringdate;
  }

  showDate(String dateTime) async {
    DateTime dateTime0;
    if (dateTime.isNotEmpty) {
      dateTime0 = DateFormat('MM/dd/yyyy').parse(dateTime);
    } else {
      dateTime0 = DateTime.now();
    }
    return await showDatePicker(
      context: context,
      initialDate: dateTime0,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }
}
