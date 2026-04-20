import 'dart:developer';
import 'package:egy_akin/app/shared/functions/hint_dialog.dart';
import 'package:egy_akin/app/shared/functions/select_question_has_displayable_answer.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:intl/intl.dart';
import 'package:egy_akin/features/record/presentation/cubit/record_cubit.dart';
import 'package:egy_akin/features/record/presentation/pages/record_screen.dart';

import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class AddPatientScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  const AddPatientScreen({
    super.key,
    required this.currentDoctorModel,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  // Map<String, dynamic> answerMap = {};
  // Map<String, dynamic> answerMapForSelect = {};
  @override
  void initState() {
    // answerMap = {
    //   AppStrings.answers: [],
    //   AppStrings.otherField: AppStrings.empty,
    // };
    // answerMapForSelect = {
    //   AppStrings.answers: '',
    //   AppStrings.otherField: AppStrings.empty
    // };

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddPatientCubit cubit = AddPatientCubit.get(context);

    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: AppBar(
            title: Text(
              context.tr(AppStrings.addPatient),
              style: TextStyle(
                color: isDarkMode ? AppColors.darkTitle : Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor:
                isDarkMode ? AppColors.darkCardBG : AppColors.primary,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.mic,
                  color: isDarkMode ? AppColors.darkTitle : Colors.white,
                ),
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => sl<RecordCubit>(),
                        child: RecordScreen(
                          questions: cubit.questionModelList ?? [],
                          source: 'add_patient',
                          sectionId: '1',
                        ),
                      ),
                    ),
                  );

                  if (result is Map<String, dynamic>) {
                    cubit.applyVoiceAnswers(result);
                    if (mounted) setState(() {});
                  }
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              Form(
                key: cubit.addPatientKeyForm,
                child: Column(
                  children: [
                    BlocBuilder<AddPatientCubit, AddPatientState>(
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
                          loaded: (questions, isAddedPatientSuccessfully,
                              patientId, isAddPatientLoading, message, _) {
                            if (isAddPatientLoading) {
                              return const Expanded(
                                child: SingleChildScrollView(
                                  child: ShimmerLoadingPatientsCards(
                                    ishorizontal: false,
                                  ),
                                ),
                              );
                            }
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
                                      color: isDarkMode
                                          ? AppColors.darkCardBG
                                          : Colors.white,
                                      border: Border.all(
                                        color: isDarkMode
                                            ? AppColors.darkPrimary
                                            : AppColors.primary,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${index + 1} - ${question.question!} ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: isDarkMode
                                                            ? AppColors
                                                                .darkTitle
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    if (question.mandatory! ||
                                                        question.question ==
                                                            AppStrings
                                                                .nationalID)
                                                      TextSpan(
                                                        text: AppStrings
                                                            .asteriskMark,
                                                        style: TextStyle(
                                                          color: isDarkMode
                                                              ? Colors
                                                                  .red.shade300
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        buildQuestionWidget(
                                          questions,
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
                    color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                    border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color:
                            isDarkMode ? AppColors.darkBorder : Colors.black12,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? Colors.black.withOpacity(0.3)
                            : Colors.grey.shade100,
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(3, 4),
                      ),
                    ],
                  ),
                  child: BlocConsumer<AddPatientCubit, AddPatientState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (questions, isAddedPatientSuccessfully,
                            patientId, isAddPatientLoading, message, _) {
                          if (isAddedPatientSuccessfully) {
                            navigatorKey.currentState
                                ?.pushNamed(AppRoutes.home, arguments: 0);
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.patientSections,
                              arguments:
                                  AppRoutesArgs.patientSectionsRouteArguments(
                                patientId: patientId.toString(),
                                currentDoctorModel: widget.currentDoctorModel,
                                currentDoctorPoints: widget.currentDoctorPoints,
                                currentDoctorRole: widget.currentDoctorRole,
                                homeDataModel: widget.homeDataModel,
                                isAllDataOpen: false,
                              ),
                            );
                          }
                          if (message.isNotEmpty) {
                            // customSnackBar(context: context, message: message);
                            showHintDialog(
                              context: context,
                              message: message,
                              dialogType: DialogType.error,
                            );
                          }
                        },
                        error: (message) {
                          showCustomDialog(
                            context: context,
                            title: context.tr(AppStrings.attention),
                            description: message,
                            coloredButtonText: context.tr(AppStrings.cancel),
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
                        loaded: (questions, isAddedPatientSuccessfully,
                            patientId, isAddPatientLoading, message, _) {
                          if (isAddPatientLoading) {
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
                            return SubmitButton(
                              cubit: cubit,
                            );
                          }
                        },
                        orElse: () {
                          return SubmitButton(
                            cubit: cubit,
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
          ),
        );
      },
    );
  }

  Widget buildQuestionWidget(List<QuestionModel> questionList, int index,
      Size size, AddPatientCubit cubit) {
    switch (questionList[index].type) {
      case AppStrings.string:
        var questionAnswer = questionList[index].answer;
        questionAnswer ??= '';
        final qid = questionList[index].id.toString();
        return BuildStringValueQuestions(
          questionList: questionList,
          initialValue: cubit.formData[qid] ?? AppStrings.empty,
          index: index,
          showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qid),
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qid),
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
                      : questionList[index].question == 'Age'
                          ? [
                              LengthLimitingTextInputFormatter(3),
                            ]
                          : [
                              LengthLimitingTextInputFormatter(200),
                            ],
          onChanged: (val) {
            if (questionAnswer != val) {
              questionAnswer = val;
              cubit.formData[questionList[index].id.toString()] = val;
            } else {
              questionAnswer = null;
              cubit.formData.remove(questionList[index].id.toString());
            }
            log(questionAnswer.toString());
          },
          validator: (val) {
            return null;
          },
        );

      //! Select
      case AppStrings.questionTypeSelect:
        var questionAnswer = questionList[index].answer;

        // Initialize answerMapForSelect from the existing value or default structure
        Map<dynamic, dynamic> answerMapForSelect =
            cubit.formData[questionList[index].id.toString()] ??
                {
                  AppStrings.answers: '',
                  AppStrings.otherField: AppStrings.empty,
                };

        dynamic selectedValue;

        final qidSelect = questionList[index].id.toString();
        return BuildSelectValueQuestion(
          questionList: questionList,
          index: index,
          formData: cubit.formData,
          isAddPatient: true,
          showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidSelect) &&
              selectQuestionHasDisplayableAnswer(
                optionValues: questionList[index].values,
                storedAnswer: cubit.formData[qidSelect] ??
                    {
                      AppStrings.answers: '',
                      AppStrings.otherField: AppStrings.empty,
                    },
              ),
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qidSelect),
          selected: initialValueInSelectQuestion(
              questionAnswer: questionAnswer is Map
                  ? questionAnswer[AppStrings.answers]
                  : questionAnswer,
              selectedValue: selectedValue,
              values: questionList[index].values!),
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (answerMapForSelect[AppStrings.answers] == null ||
                    answerMapForSelect[AppStrings.answers] ==
                        AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }
            return null;
          },
          onChanged: (val) {
            setState(() {
              // Update the "answers" field
              answerMapForSelect[AppStrings.answers] = val;

              // If the answer is not "Others", reset the "other_field" to null
              if (val != AppStrings.others) {
                answerMapForSelect[AppStrings.otherField] = null;
              }

              // Update the cubit with the modified map
              cubit.formData[questionList[index].id.toString()] =
                  Map.from(answerMapForSelect);
            });

            debugPrint('onChanged: ${cubit.formData}');
          },
          onChangedForOtherField: (value) {
            setState(() {
              // Copy the existing map and update only the "other_field"
              answerMapForSelect[AppStrings.otherField] = value;

              // Update the cubit with the modified map
              cubit.formData[questionList[index].id.toString()] =
                  Map.from(answerMapForSelect);
            });

            debugPrint('onChangedForOtherField: ${cubit.formData}');
          },
        );

      //! Multiple
      case AppStrings.multipleType:
        // Retrieve or initialize the answer map from cubit.formData
        Map<String, dynamic> answerMap =
            cubit.formData[questionList[index].id.toString()] ??
                {
                  AppStrings.answers: [],
                  AppStrings.otherField: AppStrings.empty,
                };

        final qidMulti = questionList[index].id.toString();
        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          initialValue: answerMap[AppStrings.otherField] ?? AppStrings.empty,
          showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidMulti),
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qidMulti),
          onChanged: (val) {
            setState(() {
              answerMap[AppStrings.otherField] = val;
            });
            cubit.formData[questionList[index].id.toString()] = {
              AppStrings.answers: List.from(answerMap[AppStrings.answers]),
              AppStrings.otherField: answerMap[AppStrings.otherField],
            };
            debugPrint('map ${cubit.formData}');
          },
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (answerMap[AppStrings.answers] as List<dynamic>)
                    .contains(AppStrings.others)) {
              if (val == null || val.isEmpty) {
                return AppStrings.thisFieldIsRequired;
              }
            }
            return null;
          },
          listContainOther: List.from(answerMap[AppStrings.answers]),
          children: questionList[index].values!.map((value) {
            final isSelected = (answerMap[AppStrings.answers] as List<dynamic>)
                .contains(value);
            final currentTheme = BlocProvider.of<ThemeBloc>(context).state;
            final isDarkModeLocal =
                currentTheme is ThemeLoaded && currentTheme.isDarkMode;

            return Theme(
              data: ThemeData(
                chipTheme: ChipThemeData(
                  selectedColor: AppColors.primary.withOpacity(0.7),
                  checkmarkColor: Colors.white,
                  showCheckmark: true,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              child: ChoiceChip(
                label: Text(
                  value.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: isDarkModeLocal
                    ? Colors.grey.shade700
                    : Colors.grey.shade400,
                selected: isSelected,
                selectedColor: AppColors.primary.withOpacity(0.7),
                onSelected: (selected) {
                  cubit.clearAiFilledMark(qidMulti);
                  setState(() {
                    if (selected) {
                      (answerMap[AppStrings.answers] as List).add(value);
                    } else {
                      (answerMap[AppStrings.answers] as List).remove(value);
                    }
                  });
                  cubit.formData[questionList[index].id.toString()] = {
                    AppStrings.answers:
                        List.from(answerMap[AppStrings.answers]),
                    AppStrings.otherField: answerMap[AppStrings.otherField],
                  };
                  debugPrint('map ${cubit.formData}');
                },
              ),
            );
          }).toList(),
        );

      //! Date
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
        '${convertDate.day}/${convertDate.month}/${convertDate.year}';

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
