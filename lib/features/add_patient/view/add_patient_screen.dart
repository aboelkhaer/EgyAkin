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
        title: const Text('Add Patient'),
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
                            onPressed: () {
                              bool isValid = true;
                              if (_controller.addPatientKeyForm.currentState!
                                  .validate()) {
                                for (var question
                                    in _controller.questionModelList!) {
                                  if (question.type == 'multiple' &&
                                      question.answer.isEmpty) {
                                    // _controller.scrollController.jumpTo(
                                    //   _controller.scrollController.position
                                    //           .minScrollExtent +
                                    //       question.id! * 56,
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
                                    // _controller.scrollController.jumpTo(
                                    //   _controller.scrollController.position
                                    //           .minScrollExtent +
                                    //       question.id! * 56,
                                    // );
                                    customSnackBar(
                                        isError: true,
                                        title: 'Required',
                                        body:
                                            'This question is required \n{${question.question}}');

                                    isValid = false;
                                    break;
                                  }
                                }
                              } else {
                                isValid = false;
                                customSnackBar(
                                    isError: true,
                                    title: 'Required',
                                    body: 'Enter all required fields, please ');
                              }

                              if (isValid) {
                                setState(() {
                                  _controller.addPatientForFirstTime();
                                });
                              }
                            },
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
      case 'multiple':
        List<dynamic> answers = questionList[index].answer ??= [];

        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          onChanged: (val) {},
          validator: (val) {
            if (questionList[index].mandatory == true) {
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
                  _controller.formData[questionList[index].id.toString()] =
                      answers;
                  log('map ${_controller.formData}');
                  log('list answer ${questionList[index].answer}');
                });
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
}
