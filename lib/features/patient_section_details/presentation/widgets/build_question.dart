import 'dart:developer';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/select_question_has_displayable_answer.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/app/shared/functions/is_date.dart';
import 'package:egy_akin/features/patient_section_details/presentation/utils/patient_section_file_utils.dart';
import 'package:egy_akin/features/patient_section_details/presentation/utils/patient_section_multiple_answer_utils.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/file_list_when_submit.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/repeatable_question_widget.dart';

import '../../../../exports.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';

class BuildQuestion extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final String doctorId;
  final int index;
  final HomeModelResponse homeDataModel;
  final bool isAllDataOpen;
  final String patientId;
  final SectionModel sectionModel;
  const BuildQuestion(
      {super.key,
      required this.index,
      required this.currentDoctorModel,
      required this.doctorId,
      required this.homeDataModel,
      required this.isAllDataOpen,
      required this.patientId,
      required this.sectionModel});

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        PatientSectionDetailsCubit cubit =
            PatientSectionDetailsCubit.get(context);

        switch (cubit.questionModelList[widget.index].type) {
          //! double
          case AppStrings.questionTypeDouble:
            // Get current value (null if no answer exists)
            final currentAnswer = cubit.questionModelList[widget.index].answer;
            final qidDouble =
                cubit.questionModelList[widget.index].id.toString();

            // Split into whole and decimal parts only if value exists
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cubit.aiFilledQuestionIds.contains(qidDouble))
                  const AiFilledFieldBanner(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Whole number part
                    SizedBox(
                      width: 50,
                      child: CustomTextFormField(
                        title: '00',
                        textInputType: TextInputType.number,
                        contentPadding: EdgeInsets.zero,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        initialValue: initialWhole, // null will show title '00'
                        onChanged: (wholeValue) {
                          final decimalValue =
                              cubit.getCurrentDecimalValue(widget.index);
                          _updateDoubleValue(
                            cubit: cubit,
                            index: widget.index,
                            whole: wholeValue,
                            decimal: decimalValue,
                          );
                        },
                        validator: (val) {
                          if (cubit.questionModelList[widget.index].mandatory ==
                                  true &&
                              (val == null || val.isEmpty)) {
                            return AppStrings.thisFieldIsRequired;
                          }
                          return null;
                        },
                      ),
                    ),

                    //! Decimal point
                    Container(
                      width: 4,
                      height: 4,
                      margin:
                          const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        shape: BoxShape.circle,
                      ),
                    ),

                    //! Decimal part
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
                        initialValue:
                            initialDecimal, // null will show title '00'
                        onChanged: (decimalValue) {
                          final wholeValue =
                              cubit.getCurrentWholeValue(widget.index);
                          _updateDoubleValue(
                            cubit: cubit,
                            index: widget.index,
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
            var questionAnswer = cubit.questionModelList[widget.index].answer;
            final qidStr = cubit.questionModelList[widget.index].id.toString();
            return BuildStringValueQuestions(
              questionList: cubit.questionModelList,
              index: widget.index,
              showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidStr),
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidStr),
              initialValue: initialValueInQuestions(
                answer: questionAnswer,
                currentDoctorId: widget.currentDoctorModel.id.toString(),
                doctorId: widget.doctorId.toString(),
                question:
                    cubit.questionModelList[widget.index].question.toString(),
                questionAnswerInForm: cubit.formData[
                    cubit.questionModelList[widget.index].id.toString()],
                currentDoctorRole: widget.homeDataModel.role.toString(),
                isAllDataOpen: widget.isAllDataOpen,
              ),
              textInputFormatter:
                  cubit.questionModelList[widget.index].question ==
                          AppStrings.phone
                      ? [
                          LengthLimitingTextInputFormatter(11),
                        ]
                      : cubit.questionModelList[widget.index].question ==
                              AppStrings.nationalID
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
                        cubit.questionModelList[widget.index].id.toString(),
                        val);
                    cubit.formData[cubit.questionModelList[widget.index].id
                        .toString()] = val;
                  } else {
                    cubit.updateQuestionAnswer(
                        cubit.questionModelList[widget.index].id.toString(),
                        null);
                    cubit.formData.remove(
                        cubit.questionModelList[widget.index].id.toString());
                  }
                });
              },
              validator: (val) {
                if (cubit.questionModelList[widget.index].mandatory == true &&
                    (val == null || val.isEmpty)) {
                  return AppStrings.thisFieldIsRequired;
                }

                return null;
              },
            );

          //! Select
          case AppStrings.questionTypeSelect:
            var questionAnswer = cubit.questionModelList[widget.index].answer;
            Map<String, dynamic> answerMap = questionAnswer ??= {
              AppStrings.answers: '',
              AppStrings.otherField: AppStrings.empty
            };
            dynamic selectedValue;
            final qidSel = cubit.questionModelList[widget.index].id.toString();
            return BuildSelectValueQuestion(
              questionList: cubit.questionModelList,
              index: widget.index,
              showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidSel) &&
                  selectQuestionHasDisplayableAnswer(
                    optionValues: cubit.questionModelList[widget.index].values,
                    storedAnswer: answerMap,
                  ),
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidSel),
              selected: initialValueInSelectQuestion(
                  questionAnswer: questionAnswer is Map
                      ? questionAnswer[AppStrings.answers]
                      : questionAnswer,
                  selectedValue: selectedValue,
                  values: cubit.questionModelList[widget.index].values!),
              validator: (val) {
                if (cubit.questionModelList[widget.index].mandatory == true &&
                    (cubit.questionModelList[widget.index].answer['answers'] ==
                            null ||
                        cubit.questionModelList[widget.index]
                                .answer['answers'] ==
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
                      cubit.questionModelList[widget.index].id.toString(),
                      answerMap);

                  cubit.formData[cubit.questionModelList[widget.index].id
                      .toString()] = answerMap;
                } else {
                  // questionAnswer['answers'] = '';

                  cubit.updateQuestionAnswer(
                      cubit.questionModelList[widget.index].id.toString(),
                      {'answers': null, 'otherField': null});
                  cubit.formData.remove(
                      cubit.questionModelList[widget.index].id.toString());
                }
                // make log for the map
                log(cubit.formData.toString());

                setState(() {});
              },
              onChangedForOtherField: (value) {
                setState(() {
                  answerMap[AppStrings.otherField] = value;
                  cubit.formData[cubit.questionModelList[widget.index].id
                      .toString()] = answerMap;
                });
                log(cubit.formData.toString());
              },
            );

          //! Multiple
          case AppStrings.questionTypeMultiple:
            final questionAnswer = cubit.questionModelList[widget.index].answer;
            final qidMulti =
                cubit.questionModelList[widget.index].id.toString();

            final answerMap = resolveMultipleAnswerMap(
              questionAnswer: questionAnswer,
              formEntry: cubit.formData[qidMulti],
            );
            final hasLegacyStringAnswer =
                answerMap[AppStrings.answers] is String;
            final String oldAnswer = hasLegacyStringAnswer
                ? (answerMap[AppStrings.answers] as String? ?? AppStrings.empty)
                : AppStrings.empty;
            final List<dynamic> answers = hasLegacyStringAnswer
                ? cubit.questionModelList[widget.index].values!
                    .where((value) => oldAnswer.contains(value.toString()))
                    .toList()
                : List<dynamic>.from(
                    answerMap[AppStrings.answers] as List<dynamic>? ??
                        <dynamic>[],
                  );

            void syncMultipleAnswer() {
              final payload = multipleAnswerPayload(
                answers: answers,
                otherText: answerMap[AppStrings.otherField],
              );
              answerMap[AppStrings.answers] = payload[AppStrings.answers];
              answerMap[AppStrings.otherField] = payload[AppStrings.otherField];
              cubit.updateQuestionAnswer(qidMulti, payload);
              cubit.formData[qidMulti] = payload;
            }

            return BuildMultipleValueQuestion(
              index: widget.index,
              questionList: cubit.questionModelList,
              initialValue: answerMap[AppStrings.otherField]?.toString() ?? '',
              listContainOther: answers,
              oldAnswer: null,
              isOldAnswer: false,
              showAiFilledBanner: cubit.aiFilledQuestionIds.contains(qidMulti),
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidMulti),
              onChanged: (val) {
                setState(() {
                  answerMap[AppStrings.otherField] = val;
                  syncMultipleAnswer();
                });

                log('map ${cubit.formData}');
              },
              validator: (val) {
                if (cubit.questionModelList[widget.index].mandatory == true) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.chooseAtLeastOnOption;
                  }
                }
                return null;
              },
              children:
                  cubit.questionModelList[widget.index].values!.map((value) {
                return Tooltip(
                  message: value.toString(),
                  child: Theme(
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
                        maxLines: 2,
                      ),
                      backgroundColor: isDarkMode
                          ? Colors.grey.shade700
                          : Colors.grey.shade400,
                      selected: answers.contains(value),
                      selectedColor: AppColors.primary.withOpacity(0.7),
                      onSelected: (selected) {
                        cubit.clearAiFilledMark(qidMulti);
                        setState(() {
                          if (selected) {
                            if (!answers.contains(value)) {
                              answers.add(value);
                            }
                          } else {
                            answers.remove(value);
                            if (value == AppStrings.others) {
                              answerMap[AppStrings.otherField] =
                                  AppStrings.empty;
                            }
                          }

                          syncMultipleAnswer();
                          log('map ${cubit.formData}');
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            );

          //! Repeatable (e.g. creatinine readings)
          case AppStrings.questionTypeRepeatable:
            final qidRepeatable =
                cubit.questionModelList[widget.index].id.toString();
            return RepeatableQuestionWidget(
              questionIndex: widget.index,
              keyboardType: cubit.questionModelList[widget.index].keyboardType,
              mandatory:
                  cubit.questionModelList[widget.index].mandatory == true,
              showAiFilledBanner:
                  cubit.aiFilledQuestionIds.contains(qidRepeatable),
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidRepeatable),
            );

          //! Date

          case AppStrings.questionTypeDate:
            var questionAnswer = cubit.questionModelList[widget.index].answer;
            questionAnswer ??= DateTime.now().toString();
            final qidDate = cubit.questionModelList[widget.index].id.toString();
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
                      cubit.formData[cubit.questionModelList[widget.index].id
                          .toString()] = questionAnswer;
                      log(cubit.formData[
                          cubit.questionModelList[widget.index].id.toString()]);
                      setState(() {});
                    },
                  ),
                ),
                isValidDate(
                        cubit.questionModelList[widget.index].answer.toString())
                    ? const SizedBox.shrink()
                    : cubit.questionModelList[widget.index].answer == null
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              const Text('Old Answer:'),
                              const SizedBox(width: 5),
                              Text(
                                cubit.questionModelList[widget.index].answer
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
              ],
            );

          //! File
          case AppStrings.questionTypeFiles:
            // List<String> filesList =
            //     List.from(cubit.questionModelList[widget.index].answer);
            return PermissionGuard(
              permission: AppPermissions.uploadPatientFiles,
              fallback: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context
                      .tr(AppStrings.youDontHavePermissionToUploadPatientFiles),
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            cubit.questionIndexWhichDoctorClicked =
                                widget.index.toString();
                            cubit.pickFilesForQuestions(
                                widget.index,
                                widget.patientId,
                                widget.sectionModel.sectionId.toString(),
                                context);
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: BlocBuilder<PatientSectionDetailsCubit,
                              PatientSectionDetailsState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return const SizedBox(
                                    height: 50,
                                    child: Icon(
                                      Icons.cloud_upload_outlined,
                                      color: AppColors.primary,
                                    ),
                                  );
                                },
                                loaded: (
                                  questions,
                                  isSubmitLoading,
                                  isSubmitted,
                                  message,
                                  snackbarErrorCounter,
                                  isChooseFilesLoading,
                                  isChooseFilesLoaded,
                                  uploadFilesProgress,
                                  isGetMedicationsLoading,
                                  isGetMedicationsLoaded,
                                  isSearchMedicationLoading,
                                  counterChanges,
                                  isCreateMedicationLoading,
                                  isCreateMedicationLoaded,
                                  dialogMessage,
                                ) {
                                  if (cubit.questionIndexWhichDoctorClicked ==
                                      widget.index.toString()) {
                                    if (isChooseFilesLoading) {
                                      return const SizedBox(
                                        height: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }

                                  return const SizedBox(
                                    height: 50,
                                    child: Icon(
                                      Icons.cloud_upload_outlined,
                                      color: AppColors.primary,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Display the picked files
                  BlocConsumer<PatientSectionDetailsCubit,
                      PatientSectionDetailsState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        error: (message) {
                          customSnackBar(context: context, message: message);
                        },
                        loaded: (
                          questions,
                          isSubmitLoading,
                          isSubmitted,
                          message,
                          snackbarErrorCounter,
                          isChooseFilesLoading,
                          isChooseFilesLoaded,
                          uploadFilesProgress,
                          isGetMedicationsLoading,
                          isGetMedicationsLoaded,
                          isSearchMedicationLoading,
                          counterChanges,
                          isCreateMedicationLoading,
                          isCreateMedicationLoaded,
                          dialogMessage,
                        ) {
                          if (message != '') {
                            customSnackBar(context: context, message: message);
                          }
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox.shrink();
                        },
                        loaded: (
                          questions,
                          isSubmitLoading,
                          isSubmitted,
                          message,
                          snackbarErrorCounter,
                          isChooseFilesLoading,
                          isChooseFilesLoaded,
                          uploadFilesProgress,
                          isGetMedicationsLoading,
                          isGetMedicationsLoaded,
                          isSearchMedicationLoading,
                          counterChanges,
                          isCreateMedicationLoading,
                          isCreateMedicationLoaded,
                          dialogMessage,
                        ) {
                          if (cubit.formData.containsKey(cubit
                                  .questionModelList[widget.index].id
                                  .toString()) &&
                              cubit.formData[cubit
                                      .questionModelList[widget.index].id
                                      .toString()] !=
                                  []) {
                            final rawFiles = cubit.formData[cubit
                                .questionModelList[widget.index].id
                                .toString()] as List;
                            final remoteUrls = fileUrlsFromQuestionAnswer(
                              rawFiles,
                            );

                            if (remoteUrls.isNotEmpty &&
                                remoteUrls.length == rawFiles.length &&
                                rawFiles.every(
                                  (item) =>
                                      item is String ||
                                      (item is Map &&
                                          remoteFileUrlFromEntry(
                                                Map<String, dynamic>.from(
                                                  item.map(
                                                    (k, v) => MapEntry(
                                                      k.toString(),
                                                      v,
                                                    ),
                                                  ),
                                                ),
                                              ) !=
                                              null),
                                )) {
                              return FileListWhenSubmit(files: remoteUrls);
                            }

                            return Column(
                              children: rawFiles.map((file) {
                                if (file is String && isRemoteFileUrl(file)) {
                                  final fileName = Uri.tryParse(file)
                                          ?.pathSegments
                                          .lastOrNull ??
                                      file.split('/').last;
                                  return ListTile(
                                    title: Text(fileName),
                                    onTap: () => launchURL(
                                      url: file,
                                      onError: (error) =>
                                          showErrorDialog(context, error),
                                    ),
                                  );
                                }

                                final fileMap = Map<String, dynamic>.from(
                                  (file as Map).map(
                                    (k, v) => MapEntry(k.toString(), v),
                                  ),
                                );

                                return ListTile(
                                  title: Text(fileDisplayName(fileMap)),
                                  onTap: () => openPatientSectionFile(
                                    context,
                                    fileMap,
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  ),

                  BlocBuilder<PatientSectionDetailsCubit,
                      PatientSectionDetailsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox.shrink();
                        },
                        loaded: (
                          questions,
                          isSubmitLoading,
                          isSubmitted,
                          message,
                          snackbarErrorCounter,
                          isChooseFilesLoading,
                          isChooseFilesLoaded,
                          uploadFilesProgress,
                          isGetMedicationsLoading,
                          isGetMedicationsLoaded,
                          isSearchMedicationLoading,
                          counterChanges,
                          isCreateMedicationLoading,
                          isCreateMedicationLoaded,
                          dialogMessage,
                        ) {
                          if (cubit.formData[cubit
                                      .questionModelList[widget.index].id
                                      .toString()] ==
                                  null ||
                              (cubit.formData[cubit
                                      .questionModelList[widget.index].id
                                      .toString()]) as List ==
                                  [] ||
                              cubit.formData[cubit
                                      .questionModelList[widget.index].id
                                      .toString()] ==
                                  {}) {
                            final savedUrls = fileUrlsFromQuestionAnswer(
                              cubit.questionModelList[widget.index].answer,
                            );
                            if (savedUrls.isNotEmpty) {
                              return FileListWhenSubmit(files: savedUrls);
                            }
                            return FileListWhenSubmit(
                              files: cubit
                                  .questionModelList[widget.index].answer
                                  .cast<String>(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

  void _updateDoubleValue({
    required PatientSectionDetailsCubit cubit,
    required int index,
    required String whole,
    required String decimal,
  }) {
    cubit.clearAiFilledMark(cubit.questionModelList[index].id.toString());
    final wholeNum = whole.isEmpty ? 0 : int.parse(whole);
    final decimalNum = decimal.padRight(2, '0');
    final doubleValue = wholeNum + (int.parse(decimalNum) / 100);

    cubit.updateQuestionAnswer(
      cubit.questionModelList[index].id.toString(),
      doubleValue,
    );

    // Also update formData to prevent the "You should update and data to submit" dialog
    cubit.formData[cubit.questionModelList[index].id.toString()] = doubleValue;
  }
}
