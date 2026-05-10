import 'dart:developer';
import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/app/shared/functions/is_date.dart';
import 'package:egy_akin/app/shared/functions/select_question_has_displayable_answer.dart';
import 'package:egy_akin/features/outcome/presentation/widgets/submit_button.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';

import '../../../../exports.dart';

class IfOutcomeNotSubmitted extends StatefulWidget {
  const IfOutcomeNotSubmitted({
    super.key,
    required this.cubit,
    required this.outcomeStatus,
    required this.accountVerification,
    required this.patientId,
    required this.isSyndicateCardRequired,
    required this.currentDoctorModel,
    required this.doctorId,
    required this.homeDataModel,
  });

  final OutcomeCubit cubit;
  final bool outcomeStatus;
  final String patientId;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final DoctorModel currentDoctorModel;
  final String doctorId;
  final HomeModelResponse homeDataModel;

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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
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
                        loaded: (
                          response,
                          isSubmitedOutcome,
                          message,
                          _,
                          isSubmitedOutcomeLoading,
                          submitterModel,
                        ) {
                          if (isSubmitedOutcome) {
                            navigatorKey.currentState?.pushReplacementNamed(
                                AppRoutes.home,
                                arguments: 0);
                          }
                          if (message.isNotEmpty) {
                            if (isSubmitedOutcome) {
                              customSnackBar(
                                  context: context, message: message);
                            } else {
                              showHintDialog(
                                context: context,
                                message: message,
                                dialogType: DialogType.error,
                              );
                            }
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
                        loaded: (
                          response,
                          isSubmitedOutcome,
                          message,
                          _,
                          isSubmitedOutcomeLoading,
                          submitterModel,
                        ) {
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
                                                    if (question.mandatory!)
                                                      const TextSpan(
                                                        text: AppStrings
                                                            .asteriskMark,
                                                        style: TextStyle(
                                                          color: Colors.red,
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
                                          cubit.questionModelList,
                                          index,
                                          size,
                                          cubit,
                                        ),
                                        // BuildQuestion(index: index, currentDoctorModel:widget.currentDoctorModel, doctorId: doctorId, homeDataModel: widget.homeDataModel, isAllDataOpen: isAllDataOpen, patientId: widget.patientId, sectionModel: widget.sectionModel)
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
                  Container(
                    height: 90,
                    color: isDarkMode ? AppColors.darkScaffoldBG : null,
                  ),
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
                  color: isDarkMode ? AppColors.darkCardBG : null,
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
                      loaded: (
                        response,
                        isSubmitedOutcome,
                        message,
                        _,
                        isSubmitedOutcomeLoading,
                        submitterModel,
                      ) {},
                      error: (message) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                        });
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded: (
                        response,
                        isSubmitedOutcome,
                        message,
                        snackbarErrorCounter,
                        isSubmitedOutcomeLoading,
                        submitterModel,
                      ) {
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
                          return SubmitButtonForOutcome(
                            cubit: cubit,
                            patientId: widget.patientId,
                            accountVerification: widget.accountVerification,
                            isSyndicateCardRequired:
                                widget.isSyndicateCardRequired,
                            currentDoctorModel: widget.currentDoctorModel,
                          );
                        }
                      },
                      orElse: () {
                        return SubmitButtonForOutcome(
                          cubit: cubit,
                          patientId: widget.patientId,
                          accountVerification: widget.accountVerification,
                          isSyndicateCardRequired:
                              widget.isSyndicateCardRequired,
                          currentDoctorModel: widget.currentDoctorModel,
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
      },
    );
  }

  void _updateDoubleValue({
    required OutcomeCubit cubit,
    required int index,
    required String whole,
    required String decimal,
  }) {
    final wholeNum = whole.isEmpty ? 0 : int.parse(whole);
    final decimalNum = decimal.padRight(2, '0');
    final doubleValue = wholeNum + (int.parse(decimalNum) / 100);

    cubit.updateQuestionAnswer(
      cubit.questionModelList[index].id.toString(),
      doubleValue,
    );

    cubit.formData[cubit.questionModelList[index].id.toString()] = doubleValue;
  }

  Widget buildQuestionWidget(List<QuestionModel> questionList, int index,
      Size size, OutcomeCubit cubit) {
    switch (cubit.questionModelList[index].type) {
      //! double
      case AppStrings.questionTypeDouble:
        final currentAnswer = cubit.questionModelList[index].answer;
        final qidDouble = cubit.questionModelList[index].id.toString();

        String? initialWhole;
        String? initialDecimal;

        if (currentAnswer != null) {
          final currentValue = currentAnswer is String
              ? double.tryParse(currentAnswer) ?? 0.0
              : currentAnswer as double;
          final parts = currentValue.toString().split('.');
          initialWhole = parts[0];
          initialDecimal = parts.length > 1
              ? parts[1].padRight(2, '0').substring(0, 2)
              : '00';
        }

        return Column(
          children: [
            if (cubit.aiFilledQuestionIds.contains(qidDouble))
              const AiFilledFieldBanner(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            SizedBox(
              width: 50,
              child: CustomTextFormField(
                title: '00',
                textInputType: TextInputType.number,
                contentPadding: EdgeInsets.zero,
                maxLength: 2,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                initialValue: initialWhole,
                onChanged: (wholeValue) {
                  cubit.clearAiFilledMark(qidDouble);
                  final decimalValue = cubit.getCurrentDecimalValue(index);
                  _updateDoubleValue(
                    cubit: cubit,
                    index: index,
                    whole: wholeValue,
                    decimal: decimalValue,
                  );
                },
                validator: (val) {
                  if (cubit.questionModelList[index].mandatory == true &&
                      (val == null || val.isEmpty)) {
                    return AppStrings.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 50,
              child: CustomTextFormField(
                title: '00',
                textInputType: TextInputType.number,
                contentPadding: EdgeInsets.zero,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                maxLength: 2,
                textAlign: TextAlign.center,
                initialValue: initialDecimal,
                onChanged: (decimalValue) {
                  cubit.clearAiFilledMark(qidDouble);
                  final wholeValue = cubit.getCurrentWholeValue(index);
                  _updateDoubleValue(
                    cubit: cubit,
                    index: index,
                    whole: wholeValue,
                    decimal: decimalValue,
                  );
                },
                validator: (value) => null,
              ),
            ),
              ],
            ),
          ],
        );

      //! String
      case AppStrings.questionTypeString:
        var questionAnswer = cubit.questionModelList[index].answer;
        final qid = cubit.questionModelList[index].id.toString();
        return BuildStringValueQuestions(
          questionList: cubit.questionModelList,
          index: index,
          showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qid),
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qid),
          initialValue: initialValueInQuestions(
            answer: questionAnswer,
            currentDoctorId: widget.currentDoctorModel.id.toString(),
            doctorId: widget.doctorId.toString(),
            question: cubit.questionModelList[index].question.toString(),
            questionAnswerInForm:
                cubit.formData[cubit.questionModelList[index].id.toString()],
            currentDoctorRole: widget.homeDataModel.role.toString(),
            isAllDataOpen: false,
          ),
          textInputFormatter: cubit.questionModelList[index].question ==
                  AppStrings.phone
              ? [
                  LengthLimitingTextInputFormatter(11),
                ]
              : cubit.questionModelList[index].question == AppStrings.nationalID
                  ? [
                      LengthLimitingTextInputFormatter(14),
                    ]
                  : [
                      LengthLimitingTextInputFormatter(255),
                    ],
          onChanged: (val) {
            setState(() {
              if (questionAnswer != val) {
                cubit.updateQuestionAnswer(
                    cubit.questionModelList[index].id.toString(), val);
                cubit.formData[cubit.questionModelList[index].id.toString()] =
                    val;
              } else {
                cubit.updateQuestionAnswer(
                    cubit.questionModelList[index].id.toString(), null);
                cubit.formData
                    .remove(cubit.questionModelList[index].id.toString());
              }
            });
          },
          validator: (val) {
            if (cubit.questionModelList[index].mandatory == true &&
                (val == null || val.isEmpty)) {
              return AppStrings.thisFieldIsRequired;
            }

            return null;
          },
        );

      //! Select
      case AppStrings.questionTypeSelect:
        var questionAnswer = cubit.questionModelList[index].answer;
        Map<String, dynamic> answerMap = questionAnswer ??= {
          AppStrings.answers: '',
          AppStrings.otherField: AppStrings.empty
        };
        dynamic selectedValue;
        final qidSelect = cubit.questionModelList[index].id.toString();
        return BuildSelectValueQuestion(
          questionList: cubit.questionModelList,
          index: index,
          isAddPatient: true,
          formData: cubit.formData,
          showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidSelect) &&
              selectQuestionHasDisplayableAnswer(
                optionValues: cubit.questionModelList[index].values,
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
              values: cubit.questionModelList[index].values!),
          validator: (val) {
            if (cubit.questionModelList[index].mandatory == true &&
                (cubit.questionModelList[index].answer['answers'] == null ||
                    cubit.questionModelList[index].answer['answers'] ==
                        AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }

            return null;
          },
          onChanged: (val) {
            selectedValue = val;
            if (questionAnswer != val) {
              // questionAnswer['answers'] = val;
              answerMap[AppStrings.answers] = val;
              if (answerMap[AppStrings.otherField] != 'Others') {
                answerMap[AppStrings.otherField] = null;
              }
              cubit.updateQuestionAnswer(
                  cubit.questionModelList[index].id.toString(), answerMap);

              cubit.formData[cubit.questionModelList[index].id.toString()] =
                  answerMap;
            } else {
              // questionAnswer['answers'] = '';

              cubit.updateQuestionAnswer(
                  cubit.questionModelList[index].id.toString(),
                  {'answers': null, 'otherField': null});
              cubit.formData
                  .remove(cubit.questionModelList[index].id.toString());
            }
            // make log for the map
            log(cubit.formData.toString());

            setState(() {});
          },
          onChangedForOtherField: (value) {
            setState(() {
              answerMap[AppStrings.otherField] = value;
              cubit.formData[cubit.questionModelList[index].id.toString()] =
                  answerMap;
            });
            log(cubit.formData.toString());
          },
        );

      //! Multiple
      case AppStrings.questionTypeMultiple:
        var questionAnswer = cubit.questionModelList[index].answer;
        Map<String, dynamic> answerMap = questionAnswer ??= {
          AppStrings.answers: [],
          AppStrings.otherField: AppStrings.empty
        };
        final qidMulti = cubit.questionModelList[index].id.toString();
        if (cubit.questionModelList[index].answer[AppStrings.answers]
            is String) {
          String answers =
              cubit.questionModelList[index].answer[AppStrings.answers] ??= '';
          return BuildMultipleValueQuestion(
            index: index,
            questionList: cubit.questionModelList,
            initialValue: answerMap[AppStrings.otherField] ?? '',
            listContainOther: const [],
            oldAnswer:
                cubit.questionModelList[index].answer[AppStrings.answers],
            isOldAnswer: true,
            showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidMulti),
            onClearAiFilledMark: () => cubit.clearAiFilledMark(qidMulti),
            onChanged: (val) {
              setState(() {
                answerMap[AppStrings.otherField] = val;
                cubit.formData[cubit.questionModelList[index].id.toString()] = {
                  AppStrings.answers: answers,
                  AppStrings.otherField: answers.contains(AppStrings.others)
                      ? val
                      : AppStrings.empty,
                };
              });

              log('map ${cubit.formData}');
            },
            validator: (val) {
              if (cubit.questionModelList[index].mandatory == true) {
                if (val == null || val.isEmpty) {
                  return AppStrings.chooseAtLeastOnOption;
                }
              }
              return null;
            },
            children: cubit.questionModelList[index].values!.map((value) {
              final currentTheme = BlocProvider.of<ThemeBloc>(context).state;
              final isDarkModeLocal =
                  currentTheme is ThemeLoaded && currentTheme.isDarkMode;
              final isSelected = answers.contains(value);

              return Tooltip(
                message: value.toString(),
                child: Theme(
                  data: ThemeData(
                    chipTheme: ChipThemeData(
                      selectedColor: AppColors.primary.withOpacity(0.7),
                      checkmarkColor:
                          Colors.white, // Change the checkmark color
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
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isDarkModeLocal
                                ? AppColors.title
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    backgroundColor: isDarkModeLocal
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                    selected: isSelected,
                    selectedColor: AppColors.primary.withOpacity(0.7),
                    onSelected: (selected) {
                      setState(() {
                        // Check if `answers` is a String, and if so, replace it with an empty List<dynamic>
                        if (answerMap[AppStrings.answers] is String) {
                          answerMap[AppStrings.answers] = <dynamic>[];
                        }

                        // Now safely retrieve `answers` as a List<dynamic>
                        List<dynamic> answers =
                            answerMap[AppStrings.answers] as List<dynamic>;

                        if (selected) {
                          answers.add(value);
                          // Show other field if "Other" is selected
                          if (value == AppStrings.others) {
                            answerMap[AppStrings.otherField] =
                                ''; // Reset other field if selected
                          }
                        } else {
                          answers.remove(value);
                          // Clear other field if "Other" is deselected
                          if (value == AppStrings.others) {
                            answerMap[AppStrings.otherField] = AppStrings.empty;
                          }
                        }

                        // Update the answerMap with the modified `answers` list
                        answerMap[AppStrings.answers] = answers;

                        // Update cubit.formData with the answers list and other field
                        cubit.formData[
                            cubit.questionModelList[index].id.toString()] = {
                          AppStrings.answers: answers,
                          AppStrings.otherField:
                              answers.contains(AppStrings.others)
                                  ? answerMap[AppStrings.otherField]
                                  : AppStrings.empty,
                        };
                        log('map ${cubit.formData}');
                      });
                    },
                  ),
                ),
              );
            }).toList(),
          );
        } else if (cubit.questionModelList[index].answer is Map) {
          List<dynamic> answers =
              cubit.questionModelList[index].answer[AppStrings.answers] ??= [];
          return BuildMultipleValueQuestion(
            index: index,
            questionList: cubit.questionModelList,
            initialValue: answerMap[AppStrings.otherField] ?? '',
            listContainOther: answers,
            showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidMulti),
            onClearAiFilledMark: () => cubit.clearAiFilledMark(qidMulti),
            onChanged: (val) {
              setState(() {
                answerMap[AppStrings.otherField] = val;
                cubit.formData[cubit.questionModelList[index].id.toString()] = {
                  AppStrings.answers: answers,
                  AppStrings.otherField: answers.contains(AppStrings.others)
                      ? val
                      : AppStrings.empty,
                };
              });

              log('map ${cubit.formData}');
            },
            validator: (val) {
              if (cubit.questionModelList[index].mandatory == true) {
                if (val == null || val.isEmpty) {
                  return AppStrings.chooseAtLeastOnOption;
                }
              }
              return null;
            },
            children: cubit.questionModelList[index].values!.map((value) {
              final currentTheme = BlocProvider.of<ThemeBloc>(context).state;
              final isDarkModeLocal =
                  currentTheme is ThemeLoaded && currentTheme.isDarkMode;
              final isSelected = answers.contains(value);

              return Tooltip(
                message: value.toString(),
                child: Theme(
                  data: ThemeData(
                    chipTheme: ChipThemeData(
                      selectedColor: AppColors.primary.withOpacity(0.7),
                      checkmarkColor:
                          Colors.white, // Change the checkmark color
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
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isDarkModeLocal
                                ? AppColors.darkTitle
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    backgroundColor: isDarkModeLocal
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                    selected: isSelected,
                    selectedColor: AppColors.primary.withOpacity(0.7),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          answers.add(value);
                          // Show other field if "Other" is selected
                          if (value == AppStrings.others) {
                            answerMap[AppStrings.otherField] =
                                ''; // Reset other field if selected
                          }
                        } else {
                          answers.remove(value);
                          // Clear other field if "Other" is deselected
                          if (value == AppStrings.others) {
                            answerMap[AppStrings.otherField] = AppStrings.empty;
                          }
                        }

                        cubit.formData[
                            cubit.questionModelList[index].id.toString()] = {
                          AppStrings.answers: answers,
                          AppStrings.otherField:
                              answers.contains(AppStrings.others)
                                  ? answerMap[AppStrings.otherField]
                                  : AppStrings.empty,
                        };
                        log('map ${cubit.formData}');
                      });
                    },
                  ),
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();

      //! Date
      case AppStrings.questionTypeDate:
        var questionAnswer = cubit.questionModelList[index].answer;
        questionAnswer ??= DateTime.now().toString();
        final qidDate = cubit.questionModelList[index].id.toString();
        // questionAnswer == null|| questionAnswer ==''? DateTime.now().toString(): questions[index].answer;
        return Column(
          children: [
            if (cubit.aiFilledQuestionIds.contains(qidDate))
              const AiFilledFieldBanner(),
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.height / 4,
              child: CalendarDatePicker(
                initialDate: () {
                  if (questionAnswer == null || questionAnswer == '') {
                    return DateTime.now();
                  }
                  try {
                    return DateTime.parse(questionAnswer);
                  } catch (e) {
                    // Log the error or handle it as needed
                    return DateTime
                        .now(); // Default to the current date if parsing fails
                  }
                }(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                onDateChanged: (val) {
                  cubit.clearAiFilledMark(qidDate);
                  questionAnswer = val.toString();
                  cubit.formData[cubit.questionModelList[index].id.toString()] =
                      questionAnswer;
                  log(cubit
                      .formData[cubit.questionModelList[index].id.toString()]);
                  setState(() {});
                },
              ),
            ),
            isValidDate(cubit.questionModelList[index].answer.toString())
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      const Text('Old Answer:'),
                      const SizedBox(width: 5),
                      Text(
                        cubit.questionModelList[index].answer.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ],
        );

      default:
        return Container();
    }
  }
}
