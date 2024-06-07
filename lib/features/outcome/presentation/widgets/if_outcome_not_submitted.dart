import 'dart:developer';

import 'package:egy_akin/features/outcome/presentation/widgets/submit_button.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';

class IfOutcomeNotSubmitted extends StatefulWidget {
  const IfOutcomeNotSubmitted({
    super.key,
    required this.cubit,
    required this.outcomeStatus,
    required this.accountVerification,
    required this.patientId,
  });

  final OutcomeCubit cubit;
  final bool outcomeStatus;
  final String patientId;
  final bool accountVerification;

  @override
  State<IfOutcomeNotSubmitted> createState() => _IfOutcomeNotSubmittedState();
}

class _IfOutcomeNotSubmittedState extends State<IfOutcomeNotSubmitted> {
  Map<String, dynamic> answerMap = {};
  @override
  void initState() {
    answerMap = {
      AppStrings.answers: [],
      AppStrings.otherField: AppStrings.empty,
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OutcomeCubit cubit = OutcomeCubit.get(context);
    return Stack(
      children: [
        Form(
          key: cubit.outcomeFormKey,
          child: Column(
            children: [
              BlocConsumer<OutcomeCubit, OutcomeState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (response, isSubmitedOutcome, message, _,
                        isSubmitedOutcomeLoading) {
                      if (isSubmitedOutcome) {
                        navigatorKey.currentState?.pushReplacementNamed(
                            AppRoutes.home,
                            arguments: 0);
                      }
                      if (message.isNotEmpty) {
                        customSnackBar(context: context, message: message);
                      }
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Expanded(
                        child: SingleChildScrollView(
                          child: ShimmerLoadingPatientsCards(
                            ishorizontal: false,
                          ),
                        ),
                      );
                    },
                    loaded: (response, isSubmitedOutcome, message, _,
                        isSubmitedOutcomeLoading) {
                      List<QuestionModel> questions = response;
                      if (isSubmitedOutcomeLoading) {
                        return const Expanded(
                          child: SingleChildScrollView(
                            child: ShimmerLoadingPatientsCards(
                              ishorizontal: false,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: questions.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var question = questions[index];

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
                                      cubit.questionModelList,
                                      index,
                                      size,
                                      cubit,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              Container(height: 90),
            ],
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
            child: BlocConsumer<OutcomeCubit, OutcomeState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (response, isSubmitedOutcome, message, _,
                      isSubmitedOutcomeLoading) {
                    // if (isAddedPatientSuccessfully) {
                    //   navigatorKey.currentState
                    //       ?.pushNamed(AppRoutes.home, arguments: 0);
                    //   navigatorKey.currentState
                    //       ?.pushNamed(
                    //         AppRoutes.patientSections,
                    //         arguments:
                    //             AppRoutesArgs.patientSectionsRouteArguments(
                    //           patientId: patientId.toString(),
                    //           currentDoctorModel: widget.currentDoctorModel,
                    //         ),
                    //       )
                    //       .then(
                    //           (value) => context.read<HomeCubit>().getHome());
                    // }
                  },
                  error: (message) {
                    showCustomDialog(
                      context: context,
                      title: 'Attention!',
                      description: message,
                      coloredButtonText: 'Cancel',
                      isNoColorShow: false,
                      coloredButtonOnTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (response, isSubmitedOutcome, message,
                      snackbarErrorCounter, isSubmitedOutcomeLoading) {
                    if (isSubmitedOutcomeLoading) {
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator()),
                        ],
                      );
                    } else {
                      return SubmitBottonForOutcome(
                        cubit: cubit,
                        patientId: widget.patientId,
                      );
                    }
                  },
                  orElse: () {
                    return SubmitBottonForOutcome(
                      cubit: cubit,
                      patientId: widget.patientId,
                    );
                  },
                  loading: () => const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator()),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildQuestionWidget(List<QuestionModel> questionList, int index,
      Size size, OutcomeCubit cubit) {
    switch (questionList[index].type) {
      case AppStrings.string:
        var questionAnswer = questionList[index].answer;
        questionAnswer ??= '';
        return BuildStringValueQuestions(
          questionList: questionList,
          initialValue: questionList[index].answer ?? AppStrings.empty,
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
            if (questionAnswer != val) {
              // questionAnswer = val;
              cubit.updateQuestionAnswer(
                  questionList[index].id.toString(), val);
              cubit.formData[questionList[index].id.toString()] = val;
            } else {
              // questionAnswer = null;
              cubit.formData[questionList[index].id.toString()] = null;
              cubit.formData.remove(questionList[index].id.toString());
            }
            log(questionAnswer.toString());
          },
          validator: (val) {
            return null;
          },
        );
      case AppStrings.selectType:
        var questionAnswer = questionList[index].answer;
        dynamic selectedValue;
        return BuildSelectValueQuestion(
          questionList: questionList,
          index: index,
          selected: questionAnswer ?? selectedValue,
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (val == null || val == AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }

            return null;
          },
          onChanged: (val) {
            selectedValue = val;
            if (questionAnswer != val) {
              questionAnswer = val;
              cubit.updateQuestionAnswer(
                  questionList[index].id.toString(), val);

              cubit.formData[questionList[index].id.toString()] = val;
            } else {
              cubit.updateQuestionAnswer(
                  questionList[index].id.toString(), val);
              cubit.formData.remove(questionList[index].id.toString());
            }

            log(cubit.formData.toString());

            setState(() {});
          },
        );

      case AppStrings.multipleType:
        // Map<String, dynamic> answerMap = {
        //   AppStrings.answers: [],
        //   AppStrings.otherField: AppStrings.empty
        // };
        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          initialValue: answerMap[AppStrings.otherField] ?? AppStrings.empty,
          onChanged: (val) {
            setState(() {
              answerMap[AppStrings.otherField] = val;
            });
            cubit.formData[questionList[index].id.toString()] = {
              AppStrings.answers: answerMap[AppStrings.answers],
              AppStrings.otherField: answerMap[AppStrings.otherField],
            };
            log('map ${cubit.formData}');
          },
          validator: (val) {
            if (questionList[index].mandatory == true &&
                ((answerMap[AppStrings.answers] as List<dynamic>)
                        .contains(AppStrings.others) ||
                    (answerMap[AppStrings.answers] as List<dynamic>)
                        .contains(AppStrings.others))) {
              if (val == null || val.isEmpty) {
                return AppStrings.thisFieldIsRequired;
              }
            }
            return null;
          },
          listContainOther: (answerMap[AppStrings.answers] as List<dynamic>),
          children: questionList[index].values!.map((value) {
            return ChoiceChip(
              label: Text(
                value.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.grey.shade400,
              selected: (answerMap[AppStrings.answers] as List<dynamic>)
                  .contains(value),
              selectedColor: AppColors.primary.withOpacity(0.7),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    (answerMap[AppStrings.answers] as List).add(value);
                  } else {
                    (answerMap[AppStrings.answers] as List).remove(value);
                  }
                });
                cubit.formData[questionList[index].id.toString()] = {
                  AppStrings.answers: (answerMap[AppStrings.answers] as List),
                  AppStrings.otherField: answerMap[AppStrings.otherField],
                };
                log('map ${cubit.formData}');
              },
            );
          }).toList(),
        );
      case AppStrings.date:
        String? questionAnswer = questionList[index].answer;

        return SizedBox(
          width: size.width * 0.4,
          child: CustomElevatedButton(
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
    required List<QuestionModel> questionList,
    required bool isValid,
  }) async {
    Future.forEach(questionList, (QuestionModel questionModel) async {
      if (questionModel.type == AppStrings.multipleType &&
          questionModel.mandatory == true) {
        if (questionModel.answer == [] ||
            questionModel.answer[AppStrings.otherField] == null ||
            questionModel.answer[AppStrings.otherField] == AppStrings.empty) {
          customSnackBar(
              message:
                  '${AppStrings.enterAllRequiredFieldsPlease} \n{${questionModel.question}}',
              context: context);

          isValid = false;
          return;
        }
      }
      if (questionModel.mandatory == true &&
          (questionModel.answer == null ||
              questionModel.answer == AppStrings.empty)) {
        customSnackBar(
            message:
                '${AppStrings.enterAllRequiredFieldsPlease} \n{${questionModel.question}}',
            context: context);

        isValid = false;
        return;
      }
    });
  }
}
