import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/app/shared/functions/is_date.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/file_list_when_submit.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../exports.dart';

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
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);

    switch (cubit.questionModelList[widget.index].type) {
      //! double
      case AppStrings.questionTypeDouble:
        // Get current value (null if no answer exists)
        final currentAnswer = cubit.questionModelList[widget.index].answer;

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

        return Row(
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  if (cubit.questionModelList[widget.index].mandatory == true &&
                      (val == null || val.isEmpty)) {
                    return AppStrings.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
            ),

            // Decimal point
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                shape: BoxShape.circle,
              ),
            ),

            // Decimal part
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
                initialValue: initialDecimal, // null will show title '00'
                onChanged: (decimalValue) {
                  final wholeValue = cubit.getCurrentWholeValue(widget.index);
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
        );

      //! String
      case AppStrings.questionTypeString:
        var questionAnswer = cubit.questionModelList[widget.index].answer;
        return BuildStringValueQuestions(
          questionList: cubit.questionModelList,
          index: widget.index,
          initialValue: initialValueInQuestions(
            answer: questionAnswer,
            currentDoctorId: widget.currentDoctorModel.id.toString(),
            doctorId: widget.doctorId.toString(),
            question: cubit.questionModelList[widget.index].question.toString(),
            questionAnswerInForm: cubit
                .formData[cubit.questionModelList[widget.index].id.toString()],
            currentDoctorRole: widget.homeDataModel.role.toString(),
            isAllDataOpen: widget.isAllDataOpen,
          ),
          textInputFormatter:
              cubit.questionModelList[widget.index].question == AppStrings.phone
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
                    cubit.questionModelList[widget.index].id.toString(), val);
                cubit.formData[
                    cubit.questionModelList[widget.index].id.toString()] = val;
              } else {
                cubit.updateQuestionAnswer(
                    cubit.questionModelList[widget.index].id.toString(), null);
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
        return BuildSelectValueQuestion(
          questionList: cubit.questionModelList,
          index: widget.index,
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
                    cubit.questionModelList[widget.index].answer['answers'] ==
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
              cubit.formData
                  .remove(cubit.questionModelList[widget.index].id.toString());
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
        var questionAnswer = cubit.questionModelList[widget.index].answer;
        Map<String, dynamic> answerMap = questionAnswer ??= {
          AppStrings.answers: [],
          AppStrings.otherField: AppStrings.empty
        };
        if (cubit.questionModelList[widget.index].answer[AppStrings.answers]
            is String) {
          String answers = cubit.questionModelList[widget.index]
              .answer[AppStrings.answers] ??= '';
          return BuildMultipleValueQuestion(
            index: widget.index,
            questionList: cubit.questionModelList,
            initialValue: answerMap[AppStrings.otherField] ?? '',
            listContainOther: const [],
            oldAnswer: cubit
                .questionModelList[widget.index].answer[AppStrings.answers],
            isOldAnswer: true,
            onChanged: (val) {
              setState(() {
                answerMap[AppStrings.otherField] = val;
                cubit.formData[
                    cubit.questionModelList[widget.index].id.toString()] = {
                  AppStrings.answers: answers,
                  AppStrings.otherField: answers.contains(AppStrings.others)
                      ? val
                      : AppStrings.empty,
                };
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
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    backgroundColor: Colors.grey.shade400,
                    selected: answers.contains(value),
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
                        cubit.formData[cubit.questionModelList[widget.index].id
                            .toString()] = {
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
        } else if (cubit.questionModelList[widget.index].answer is Map) {
          List<dynamic> answers = cubit.questionModelList[widget.index]
              .answer[AppStrings.answers] ??= [];
          return BuildMultipleValueQuestion(
            index: widget.index,
            questionList: cubit.questionModelList,
            initialValue: answerMap[AppStrings.otherField] ?? '',
            listContainOther: answers,
            onChanged: (val) {
              setState(() {
                answerMap[AppStrings.otherField] = val;
                cubit.formData[
                    cubit.questionModelList[widget.index].id.toString()] = {
                  AppStrings.answers: answers,
                  AppStrings.otherField: answers.contains(AppStrings.others)
                      ? val
                      : AppStrings.empty,
                };
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

                        cubit.formData[cubit.questionModelList[widget.index].id
                            .toString()] = {
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
        var questionAnswer = cubit.questionModelList[widget.index].answer;
        questionAnswer ??= DateTime.now().toString();
        // questionAnswer == null|| questionAnswer ==''? DateTime.now().toString(): questions[index].answer;

        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.height / 4,
              child: CalendarDatePicker(
                initialDate: () {
                  if (questionAnswer == null || questionAnswer == "") {
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
                  questionAnswer = val.toString();
                  cubit.formData[cubit.questionModelList[widget.index].id
                      .toString()] = questionAnswer;
                  log(cubit.formData[
                      cubit.questionModelList[widget.index].id.toString()]);
                  setState(() {});
                },
              ),
            ),
            isValidDate(cubit.questionModelList[widget.index].answer.toString())
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
        return Column(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        cubit.formData[cubit.questionModelList[widget.index].id
                                .toString()] !=
                            []) {
                      return Column(
                        children: (cubit.formData[cubit
                                .questionModelList[widget.index].id
                                .toString()] as List<Map<String, String>>)
                            .map(
                          (file) {
                            String fileName = file['file_name']!;
                            String filePath = file[
                                'file_data']!; // Assuming this holds the file path or base64 data

                            return ListTile(
                              title: Text(fileName),
                              onTap: () async {
                                String fileName = file['file_name']!;
                                String filePath = file[
                                    'file_data']!; // Assuming this is the base64 string

                                print('Tapped on file: $fileName');

                                if (fileName.endsWith('.jpg') ||
                                    fileName.endsWith('.png') ||
                                    fileName.endsWith('.jpeg')) {
                                  // Handle image file
                                  print('Opening image file.');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          width: double.maxFinite,
                                          height: 300,
                                          child: Image.memory(
                                            base64Decode(filePath),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (fileName.endsWith('.pdf') ||
                                    fileName.endsWith('.doc') ||
                                    fileName.endsWith('.docx')) {
                                  print('Opening document file: $fileName');

                                  // Check if it's base64 PDF
                                  if (filePath.startsWith(
                                      'data:application/pdf;base64,')) {
                                    print('Detected base64 PDF.');

                                    // Extract the base64 data
                                    final base64Data = filePath.split(',').last;
                                    final bytes = base64Decode(
                                        base64Data); // Decode the base64 string

                                    // Get the temporary directory
                                    final dir = await getTemporaryDirectory();
                                    final tempFile =
                                        File('${dir.path}/$fileName');

                                    print(
                                        'Writing to temporary file: ${tempFile.path}');

                                    // Write bytes to the temp file
                                    await tempFile.writeAsBytes(bytes);

                                    // Check if the file was written successfully
                                    if (await tempFile.exists()) {
                                      print(
                                          'Temporary PDF file exists. Attempting to open.');
                                      final result =
                                          await OpenFile.open(tempFile.path);
                                      print(
                                          'OpenFile result: ${result.message}');
                                    } else {
                                      print(
                                          'Error: Temporary PDF file does not exist after writing.');
                                    }
                                  } else {
                                    // Regular file path handling
                                    print('Opening regular file: $filePath');
                                    final result =
                                        await OpenFile.open(filePath);
                                    print('OpenFile result: ${result.message}');
                                  }
                                } else {
                                  print('Unsupported file type: $fileName');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Unsupported file type')),
                                  );
                                }
                              },
                            );
                          },
                        ).toList(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),

            BlocBuilder<PatientSectionDetailsCubit, PatientSectionDetailsState>(
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
                    if (cubit.formData[cubit.questionModelList[widget.index].id
                                .toString()] ==
                            null ||
                        (cubit.formData[cubit.questionModelList[widget.index].id
                                .toString()]) as List ==
                            [] ||
                        cubit.formData[cubit.questionModelList[widget.index].id
                                .toString()] ==
                            {}) {
                      return FileListWhenSubmit(
                          files: cubit.questionModelList[widget.index].answer
                              .cast<String>());
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ],
        );

      default:
        return Container();
    }
  }

  void _updateDoubleValue({
    required PatientSectionDetailsCubit cubit,
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
  }
}
