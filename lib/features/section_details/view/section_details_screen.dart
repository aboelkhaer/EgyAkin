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
                  0, // Scroll position to jump to (top of the list)
                  duration:
                      const Duration(milliseconds: 500), // Animation duration
                  curve: Curves.easeInOut, // Animation curve
                );
              }
            },
            child: Text(sectionName)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Stack(
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
                                        question.mandatory!
                                            ? const Text(
                                                '*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        // TextButton(
                                        //   onPressed: () {
                                        //     showCustomDialog(
                                        //       context: context,
                                        //       title:
                                        //           question.question.toString(),
                                        //       description: _checkAnswerType(
                                        //         type: question.type!,
                                        //         answer: question.answer,
                                        //       ),
                                        //       coloredBottonOnTap: () {
                                        //         Clipboard.setData(ClipboardData(
                                        //             text: question.answer));
                                        //       },
                                        //       isColoredBottonDisable:
                                        //           question.type == 'string'
                                        //               ? false
                                        //               : true,
                                        //       noColoredBottonOnTap: () {
                                        //         Get.back();
                                        //       },
                                        //       coloredBottonText: 'Copy',
                                        //       noColoredBottonText: 'Cancel',
                                        //     );
                                        //   },
                                        //   style: ButtonStyle(
                                        //     overlayColor:
                                        //         MaterialStateColor.resolveWith(
                                        //       (states) => Colors.transparent,
                                        //     ),
                                        //   ),
                                        //   child: const Text(
                                        //     'Show answer',
                                        //     style: TextStyle(
                                        //         color: Colors.blue,
                                        //         fontSize: 12),
                                        //   ),
                                        // ),
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
                                      // onPressed: () {
                                      //   bool isValid = true;
                                      //   if (_controller
                                      //       .sectionDetailsKeyForm.currentState!
                                      //       .validate()) {
                                      //     for (var question in _controller
                                      //         .questionModelList!) {
                                      //       if (question.mandatory == true) {
                                      //         if (question.answer == null ||
                                      //             question.answer == '') {
                                      //           customSnackBar(
                                      //               isError: true,
                                      //               title: 'Error',
                                      //               body:
                                      //                   'Enter all required fields, please');
                                      //           isValid = false;
                                      //           break;
                                      //         }
                                      //       }
                                      //     }
                                      //   } else {
                                      //     isValid = false;
                                      //     customSnackBar(
                                      //         isError: true,
                                      //         title: 'Error',
                                      //         body:
                                      //             'Enter all required fields, please');
                                      //   }

                                      //   log(isValid.toString());

                                      //   if (isValid) {
                                      //     setState(() {
                                      //       _controller.updateSectionDetails(
                                      //           sectionId, patientId, context);
                                      //     });
                                      //   }
                                      // },
                                      onPressed: () {
                                        bool isValid = true;
                                        if (_controller
                                            .sectionDetailsKeyForm.currentState!
                                            .validate()) {
                                          int index = 0;
                                          for (var question in _controller
                                              .questionModelList!) {
                                            if (question.type == 'multiple' &&
                                                question.answer == null &&
                                                question.mandatory == true) {
                                              // _controller.scrollController
                                              //     .jumpTo(
                                              //   _controller
                                              //           .scrollController
                                              //           .position
                                              //           .minScrollExtent +
                                              //       index * 56,
                                              // );
                                              customSnackBar(
                                                  isError: true,
                                                  title: 'Required',
                                                  body:
                                                      'Enter all required fields, please \n{${question.question}}');

                                              isValid = false;
                                              break;
                                            }
                                            if (question.mandatory == true &&
                                                (question.answer == null ||
                                                    question.answer == '')) {
                                              // _controller.scrollController
                                              //     .jumpTo(
                                              //   _controller
                                              //           .scrollController
                                              //           .position
                                              //           .minScrollExtent +
                                              //       index * 56,
                                              // );
                                              customSnackBar(
                                                  isError: true,
                                                  title: 'Required',
                                                  body:
                                                      'This question is required \n{${question.question}}');

                                              isValid = false;
                                              break;
                                            }
                                            index = index + 1;
                                          }
                                        } else {
                                          isValid = false;
                                          customSnackBar(
                                              isError: true,
                                              title: 'Required',
                                              body:
                                                  'Enter all required fields, please');
                                        }

                                        if (isValid) {
                                          setState(() {
                                            _controller.updateSectionDetails(
                                                sectionId, patientId, context);
                                          });
                                        }
                                      },
                                      title: 'Submit',
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
      ),
    );
  }

  // checkSubmit() {
  //   if (doctorId.toString() ==
  //           _controller.homeController.currentDoctorId.toString() &&
  //       _controller.formData.isNotEmpty) {
  //     _controller.isSubmit(true);
  //   } else {
  //     _controller.isSubmit(false);
  //   }
  // }

  // _checkAnswerType({required String type, var answer}) {
  //   if (answer != null) {
  //     if (type == 'string' || type == 'select') {
  //       return answer as String;
  //     }
  //     if (type == 'multiple') {
  //       return answer as List<dynamic>;
  //     }
  //     return answer as String;
  //   }
  // }

  Widget buildQuestionWidget(
      List<BaseQuestionModel> questionList, int index, Size size) {
    Map<String, dynamic> formDataMap = _controller.formData;

    switch (questionList[index].type) {
      case 'string':
        return BuildStringValueQuestions(
          questionList: questionList,
          index: index,
          onChanged: (val) {
            // _controller.formData[questionList[index].id.toString()] = val;
            if (questionList[index].answer != val) {
              questionList[index].answer = val;
              formDataMap[questionList[index].id.toString()] = val;
            } else {
              questionList[index].answer = null;
              formDataMap.remove(questionList[index].id.toString());
            }
          },
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (val == null || val.isEmpty)) {
              return 'This field is required';
            }

            return null;
          },
        );
      case 'select':
        dynamic selectedValue;
        return BuildSelectValueQuestion(
          questionList: questionList,
          index: index,
          selected: questionList[index].answer ??= selectedValue,
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (questionList[index].answer == null ||
                    questionList[index].answer == '')) {
              return 'This question is required';
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
      case 'multiple':
        List<dynamic> answers = questionList[index].answer['answers'] ??= [];
        String otherValue = '';

        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          initialValue: questionList[index].answer['other_field'] ?? '',
          listContainOther: answers,
          onChanged: (val) {
            setState(() {
              // _controller.formData[questionList[index].id.toString()] = {
              //   "answer": {
              //     "answer": answers,
              //     "other_field": val,
              //   },
              // };
              otherValue = val;
              questionList[index].answer['other_field'] = val;
              _controller.formData[questionList[index].id.toString()] = {
                "answers": answers,
                "other_field": val,
              };
            });

            log('map ${_controller.formData}');
          },
          validator: (val) {
            if (questionList[index].mandatory == true) {
              if (val == null || val.isEmpty) {
                return 'Choose at least one option';
              }
            }
            return null;
          },
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
                  // _controller.formData[questionList[index].id.toString()] =
                  //     answers;
                  _controller.formData[questionList[index].id.toString()] = {
                    "answers": answers,
                    "other_field": otherValue,
                  };
                  log('map ${_controller.formData}');
                  // log('list answer ${questionList[index].answer}');
                });
              },
            );
          }).toList(),
        );
      case 'date':
        // String? questionAnswer = questionList[index].answer;
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
      // return SizedBox(
      //   height: MediaQuery.of(context).copyWith().size.height / 5,
      //   child: CupertinoDatePicker(
      //     initialDateTime: DateTime.parse(questionList[index].answer),
      //     onDateTimeChanged: (DateTime newdate) {
      //       if (questionList[index].answer == newdate.toString()) {
      //         formDataMap.remove(questionList[index].id.toString());
      //       } else {
      //         formDataMap[questionList[index].id.toString()] =
      //             newdate.toString();
      //       }

      //       setState(() {});
      //       log(formDataMap.toString());
      //     },
      //     use24hFormat: true,
      //     // maximumDate: DateTime(2024, 12, 30),
      //     minimumYear: 1900,
      //     maximumYear: 2100,
      //     minuteInterval: 1,
      //     mode: CupertinoDatePickerMode.date,
      //   ),
      // );

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
