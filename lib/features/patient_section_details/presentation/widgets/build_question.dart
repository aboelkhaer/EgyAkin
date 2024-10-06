import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
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
      case AppStrings.questionTypeSelect:
        var questionAnswer = cubit.questionModelList[widget.index].answer;
        dynamic selectedValue;
        return BuildSelectValueQuestion(
          questionList: cubit.questionModelList,
          index: widget.index,
          selected: initialValueInSelectQuestion(
              questionAnswer: questionAnswer, selectedValue: selectedValue),
          validator: (val) {
            if (cubit.questionModelList[widget.index].mandatory == true &&
                (cubit.questionModelList[widget.index].answer == null ||
                    cubit.questionModelList[widget.index].answer ==
                        AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }

            return null;
          },
          onChanged: (val) {
            selectedValue = val;
            if (questionAnswer != val) {
              // questionAnswer = val;
              cubit.updateQuestionAnswer(
                  cubit.questionModelList[widget.index].id.toString(), val);

              cubit.formData[
                  cubit.questionModelList[widget.index].id.toString()] = val;
            } else {
              // questionAnswer = null;
              cubit.updateQuestionAnswer(
                  cubit.questionModelList[widget.index].id.toString(), null);
              cubit.formData
                  .remove(cubit.questionModelList[widget.index].id.toString());
            }

            setState(() {});
          },
        );
      case AppStrings.questionTypeMultiple:
        var questionAnswer = cubit.questionModelList[widget.index].answer;
        Map<String, dynamic> answerMap = questionAnswer ??= {
          AppStrings.answers: [],
          AppStrings.otherField: AppStrings.empty
        };
        List<dynamic> answers = cubit
            .questionModelList[widget.index].answer[AppStrings.answers] ??= [];

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
          children: cubit.questionModelList[widget.index].values!.map((value) {
            return Tooltip(
              message: value.toString(),
              child: Theme(
                data: ThemeData(
                  chipTheme: ChipThemeData(
                    selectedColor: AppColors.primary.withOpacity(0.7),
                    checkmarkColor: Colors.white, // Change the checkmark color
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
      case AppStrings.questionTypeDate:
        var questionAnswer = cubit.questionModelList[widget.index].answer;
        questionAnswer ??= DateTime.now().toString();
        // questionAnswer == null|| questionAnswer ==''? DateTime.now().toString(): questions[index].answer;

        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 4,
          child: CalendarDatePicker(
            initialDate: questionAnswer == null || questionAnswer == ""
                ? DateTime.now()
                : DateTime.parse(questionAnswer),
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
        );

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
                  loaded: (questions,
                      isSubmitLoading,
                      isSubmitted,
                      message,
                      snackbarErrorCounter,
                      isChooseFilesLoading,
                      isChooseFilesLoaded,
                      uploadFilesProgress) {
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
                  loaded: (questions,
                      isSubmitLoading,
                      isSubmitted,
                      message,
                      snackbarErrorCounter,
                      isChooseFilesLoading,
                      isChooseFilesLoaded,
                      uploadFilesProgress) {
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
                  loaded: (questions,
                      isSubmitLoading,
                      isSubmitted,
                      message,
                      snackbarErrorCounter,
                      isChooseFilesLoading,
                      isChooseFilesLoaded,
                      uploadFilesProgress) {
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
}
