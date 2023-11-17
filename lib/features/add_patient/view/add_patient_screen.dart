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
            child: const Text('Add Patient')),
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
                            onPressed: () => _controller.submitBotton(),
                            title: 'Submit',
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
      case 'string':
        return BuildStringValueQuestions(
          questionList: questionList,
          index: index,
          textInputFormatter: questionList[index].question == 'Phone'
              ? [
                  LengthLimitingTextInputFormatter(11),
                ]
              : questionList[index].question == 'National ID'
                  ? [
                      LengthLimitingTextInputFormatter(14),
                    ]
                  : [],
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
            // if (questionList[index].mandatory == true &&
            //     (val == null || val.isEmpty)) {
            //   return 'This field is required';
            // }

            return null;
          },
        );
      case 'select':
        dynamic selectedValue;
        return BuildSelectValueQuestion(
          questionList: questionList,
          index: index,
          selected: questionList[index].answer ?? selectedValue,
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (val == null || val == '')) {
              return 'This field is required';
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
      // case 'multiple':
      //   List<dynamic> answers = [];

      //   return BuildMultipleValueQuestion(
      //     index: index,
      //     questionList: questionList,
      //     initialValue: '',
      //     onChanged: (val) {
      //       setState(() {});
      //       _controller.formData[questionList[index].id.toString()] = {
      //         "other_field": val
      //       };
      //     },
      //     validator: (val) {
      //       if (questionList[index].mandatory == true) {
      //         if (val == null || val.isEmpty) {
      //           return 'This field is required';
      //         }
      //       }
      //       return null;
      //     },
      //     listContainOther: answers,
      //     children: questionList[index].values!.map((value) {
      //       return ChoiceChip(
      //         label: Text(
      //           value.toString(),
      //           style: const TextStyle(
      //               color: Colors.white, fontWeight: FontWeight.bold),
      //         ),
      //         backgroundColor: Colors.grey.shade400,
      //         selected: answers.contains(value),
      //         selectedColor: AppColors.primary.withOpacity(0.7),
      //         onSelected: (selected) {
      //           setState(() {
      //             if (selected) {
      //               answers.add(value);
      //             } else {
      //               answers.remove(value);
      //             }
      //             _controller.formData[questionList[index].id.toString()] = {
      //               "answer": [answers]
      //             };
      //             // _controller.formData[questionList[index].id.toString()] ={"answer":};
      //             log('map ${_controller.formData}');
      //             log('list answer $answers');
      //           });
      //         },
      //       );
      //     }).toList(),
      //   );
      case 'multiple':
        Map<String, dynamic> answerMap =
            questionList[index].answer ??= {"answers": [], "other_field": ''};
        List<dynamic> answers = questionList[index].answer['answers'] ??= [];

        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          initialValue: answerMap['other_field'] ?? '',
          onChanged: (val) {
            setState(() {
              // _controller.otherValue[questionList[index].id.toString()] = val;
              answerMap['other_field'] = val;
              _controller.formData[questionList[index].id.toString()] = {
                "answers": answers,
                "other_field": answers.contains('Others') ? val : '',
              };
            });

            log('map ${_controller.formData}');
          },
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (answers.contains('Others') || answers.contains('others'))) {
              if (val == null || val.isEmpty) {
                return 'This field is required';
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
                  "answers": answers,
                  "other_field": answers.contains('Others')
                      ? answerMap['other_field']
                      : '',
                };

                log('map ${_controller.formData}');
                // log('list answer ${questionList[index].answer}');
              },
            );
          }).toList(),
        );
      case 'date':
        String? questionAnswer = questionList[index].answer;

        return SizedBox(
          width: size.width * 0.4,
          child: CustomElevatedButton(
            size: size,
            onPressed: () async {
              // final selectedDate = await showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime(2000),
              //   lastDate: DateTime(2100),
              // );
              // if (selectedDate != null) {
              //   setState(() {
              //     questionAnswer = selectedDate.toString();
              //     formDataMap[questionList[index].id.toString()] = selectedDate;
              //     log(formDataMap.toString());
              //   });
              // }
            },
            title: questionAnswer == null
                ? 'Add date'
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
      // Perform some asynchronous operation for each item

      if (questionModel.type == 'multiple' && questionModel.mandatory == true) {
        log('multiple    mendatory    moatz123');
        // _controller.scrollController.jumpTo(
        //   _controller.scrollController.position
        //           .minScrollExtent +
        //       question.id! * 56,
        // );

        if (questionModel.answer == [] ||
            questionModel.answer['other_field'] == null ||
            questionModel.answer['other_field'] == '') {
          customSnackBar(
              isError: true,
              title: 'Required',
              body:
                  'Enter all required fields, please \n{${questionModel.question}}');

          isValid = false;
          return;
        }
      }
      if (questionModel.mandatory == true &&
          (questionModel.answer == null || questionModel.answer == '')) {
        // _controller.scrollController.jumpTo(
        //   _controller.scrollController.position
        //           .minScrollExtent +
        //       question.id! * 56,
        // );
        customSnackBar(
            isError: true,
            title: 'Required',
            body: 'This question is required \n{${questionModel.question}}');

        isValid = false;
        return;
      }
    });
  }

  // Future<void> validateForm({
  //   required List<BaseQuestionModel> questionList,
  //   required bool isValid,
  // }) async {
  //   for (var questionModel in questionList) {
  //     // if (questionModel.mandatory == true &&
  //     //         (questionModel.answer == null ||
  //     //             questionModel.answer.toString().isEmpty) ||
  //     //     (questionModel.type == 'multiple' &&
  //     //         questionModel.mandatory == true)) {
  //     //   customSnackBar(
  //     //       isError: true,
  //     //       title: 'Required',
  //     //       body:
  //     //           'Enter all required fields, please \n{${questionModel.question}}');
  //     // }
  //     if (questionModel.mandatory == true && questionModel.answer == null ||
  //         questionModel.answer.toString().isEmpty) {
  //       customSnackBar(
  //           isError: true,
  //           title: 'Required',
  //           body:
  //               'Enter all required fields, please \n{${questionModel.question}}');
  //       return;
  //     } else if (questionModel.mandatory == true &&
  //         questionModel.type == 'multiple') {
  //       // log(_controller.formData[questionModel.id.toString()]['answers']
  //       //     .toString());
  //       log('map ${_controller.formData}');

  //       // for (var item in _controller.formData.entries) {
  //       //   if (item.key == questionModel.id.toString()) {
  //       //     List<dynamic>? targetList = _controller.formData[questionModel.id];
  //       //     String targetString = _controller.formData[questionModel.id];
  //       //     log(targetList.toString());
  //       //   }
  //       // }
  //       if (_controller.formData.containsKey(questionModel.id.toString()) &&
  //           _controller.formData[questionModel.id.toString()]['answer']
  //               is List) {
  //         if (_controller.formData[questionModel.id.toString()]['answer'] ==
  //             []) {
  //           log('yes');
  //         }
  //       }
  //     }
  //     // You can add additional validation rules here based on your requirements
  //   }
  // }
}
