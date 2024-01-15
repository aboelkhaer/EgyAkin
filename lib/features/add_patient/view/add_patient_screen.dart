import 'dart:developer';
import 'package:intl/intl.dart';
import '../../../exports.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  @override
  void initState() {
    _controller.getPatientSectionDetails('1');

    super.initState();
  }

  final AddPatientController _controller = Get.put(AddPatientController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              if (_controller.scrollController.hasClients) {
                _controller.scrollController.animateTo(
                  0, // Scroll position to jump to (top of the list)
                  duration:
                      const Duration(milliseconds: 500), // Animation duration
                  curve: Curves.easeInOut, // Animation curve
                );
              }
            },
            child: const Text(AppStrings.addPatient)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Stack(
        children: [
          Form(
            key: _controller.addPatientKeyForm,
            child: Obx(
              () => _controller.isAddPatientLoading.value ||
                      _controller.isAddPatientForFirstTimeLoading.value
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
                                                AppStrings.asteriskMark,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
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
                        Container(
                          height: 90,
                        ),
                      ],
                    ),
            ),
          ),
          Positioned(
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
                () => _controller.isAddPatientLoading.value ||
                        _controller.isAddPatientForFirstTimeLoading.value
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomElevatedButton(
                            size: size,
                            onPressed: () =>
                                _controller.submitBotton(context: context),
                            title: AppStrings.submit,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionWidget(
      List<BaseQuestionModel> questionList, int index, Size size) {
    Map<String, dynamic> formDataMap = _controller.formData;

    switch (questionList[index].type) {
      case AppStrings.string:
        return BuildStringValueQuestions(
          questionList: questionList,
          initialValue: formDataMap[questionList[index].id.toString()] ??
              AppStrings.empty,
          index: index,
          textInputFormatter:
              questionList[index].question == AppStrings.phone ||
                      questionList[index].question == AppStrings.mobile
                  ? [
                      LengthLimitingTextInputFormatter(11),
                    ]
                  : questionList[index].question == AppStrings.nationalID
                      ? [
                          LengthLimitingTextInputFormatter(14),
                        ]
                      : [
                          LengthLimitingTextInputFormatter(200),
                        ],
          onChanged: (val) {
            if (questionList[index].answer != val) {
              questionList[index].answer = val;
              formDataMap[questionList[index].id.toString()] = val;
            } else {
              questionList[index].answer = null;
              formDataMap.remove(questionList[index].id.toString());
            }
          },
          validator: (val) {
            return null;
          },
        );
      case AppStrings.selectType:
        dynamic selectedValue;
        return BuildSelectValueQuestion(
          questionList: questionList,
          index: index,
          selected: questionList[index].answer ?? selectedValue,
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (val == null || val == AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }

            return null;
          },
          onChanged: (val) {
            selectedValue = val;
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

      case AppStrings.multipleType:
        Map<String, dynamic> answerMap = questionList[index].answer ??= {
          AppStrings.answers: [],
          AppStrings.otherField: AppStrings.empty
        };
        List<dynamic> answers =
            questionList[index].answer[AppStrings.answers] ??= [];

        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          initialValue: answerMap[AppStrings.otherField] ?? AppStrings.empty,
          onChanged: (val) {
            setState(() {
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
            if (questionList[index].mandatory == true &&
                (answers.contains(AppStrings.others) ||
                    answers.contains(AppStrings.others))) {
              if (val == null || val.isEmpty) {
                return AppStrings.thisFieldIsRequired;
              }
            }
            return null;
          },
          listContainOther: answers,
          children: questionList[index].values!.map((value) {
            return ChoiceChip(
              label: Text(
                value.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
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
                });
                _controller.formData[questionList[index].id.toString()] = {
                  AppStrings.answers: answers,
                  AppStrings.otherField: answers.contains(AppStrings.others)
                      ? answerMap[AppStrings.otherField]
                      : AppStrings.empty,
                };

                // log('map ${_controller.formData}');
              },
            );
          }).toList(),
        );
      case AppStrings.date:
        String? questionAnswer = questionList[index].answer;

        return SizedBox(
          width: size.width * 0.4,
          child: CustomElevatedButton(
            size: size,
            onPressed: () async {},
            title: questionAnswer == null
                ? AppStrings.addDate
                : stringDateTostring(questionAnswer),
            hasIcon: true,
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

  Future processItems({
    required List<BaseQuestionModel> questionList,
    required bool isValid,
  }) async {
    Future.forEach(questionList, (BaseQuestionModel questionModel) async {
      if (questionModel.type == AppStrings.multipleType &&
          questionModel.mandatory == true) {
        if (questionModel.answer == [] ||
            questionModel.answer[AppStrings.otherField] == null ||
            questionModel.answer[AppStrings.otherField] == AppStrings.empty) {
          customSnackBar(
              isError: true,
              title: AppStrings.required,
              body:
                  '${AppStrings.enterAllRequiredFieldsPlease} \n{${questionModel.question}}');

          isValid = false;
          return;
        }
      }
      if (questionModel.mandatory == true &&
          (questionModel.answer == null ||
              questionModel.answer == AppStrings.empty)) {
        customSnackBar(
            isError: true,
            title: AppStrings.required,
            body:
                '${AppStrings.thisQuestionIsRequired} \n{${questionModel.question}}');

        isValid = false;
        return;
      }
    });
  }
}
