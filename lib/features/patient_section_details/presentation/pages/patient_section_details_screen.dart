import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_true.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/file_list_when_submit.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/section_submit_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';

class PatientSectionDetailsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final SectionModel sectionModel;
  final bool finalSubmitStatus;
  final String patientId;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final String doctorId;
  final HomeModelResponse homeDataModel;
  const PatientSectionDetailsScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.sectionModel,
      required this.finalSubmitStatus,
      required this.patientId,
      required this.doctorId,
      required this.currentDoctorRole,
      required this.currentDoctorPoints,
      required this.homeDataModel});

  @override
  State<PatientSectionDetailsScreen> createState() =>
      _PatientSectionDetailsScreenState();
}

class _PatientSectionDetailsScreenState
    extends State<PatientSectionDetailsScreen> {
  @override
  void initState() {
    context.read<PatientSectionDetailsCubit>().getPatientSectionDetails(
        widget.sectionModel.sectionId.toString(), widget.patientId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              animateToTopOfScreen(cubit.scrollController);
            },
            child: Text(
              widget.sectionModel.sectionName.toString(),
            )),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body:
          BlocConsumer<PatientSectionDetailsCubit, PatientSectionDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              customSnackBar(context: context, message: message);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (questions, isSubmitLoading, isSubmitted, message,
                snackbarErrorCounter) {
              if (widget.currentDoctorRole == 'Admin') {
                return buildSectionForm(
                    size: size,
                    cubit: cubit,
                    questions: cubit.questionModelList);
              }
              if (widget.finalSubmitStatus) {
                return BuildSectionDetailsIfFinalSubmitTrue(
                  questionList: cubit.questionModelList,
                  doctorId: widget.doctorId,
                  currentDoctorId: widget.currentDoctorModel.id.toString(),
                );
              }
              if (widget.doctorId.toString() !=
                  widget.currentDoctorModel.id.toString()) {
                BuildSectionDetailsIfFinalSubmitTrue(
                  questionList: cubit.questionModelList,
                  doctorId: widget.doctorId,
                  currentDoctorId: widget.currentDoctorModel.id.toString(),
                );
              }
              return buildSectionForm(
                  size: size, cubit: cubit, questions: cubit.questionModelList);
              // return widget.finalSubmitStatus
              //     ? BuildSectionDetailsIfFinalSubmitTrue(
              //         questionList: cubit.questionModelList,
              //         doctorId: widget.doctorId,
              //         currentDoctorId: widget.currentDoctorModel.id.toString(),
              //       )
              //     : widget.doctorId.toString() !=
              //             widget.currentDoctorModel.id.toString()
              //         ? BuildSectionDetailsIfFinalSubmitTrue(
              //             questionList: cubit.questionModelList,
              //             doctorId: widget.doctorId,
              //             currentDoctorId:
              //                 widget.currentDoctorModel.id.toString(),
              //           )
              //         : buildSectionForm(
              //             size: size,
              //             cubit: cubit,
              //             questions: cubit.questionModelList);
            },
          );
        },
      ),
    );
  }

  Widget buildSectionForm({
    required Size size,
    required PatientSectionDetailsCubit cubit,
    required List<QuestionModel> questions,
  }) {
    return Stack(
      children: [
        Form(
          key: cubit.sectionDetailsKeyForm,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  shrinkWrap: true,
                  controller: cubit.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var questionModel = questions[index];

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
                                  '${index + 1} - ${questionModel.question!}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              questionModel.mandatory! ||
                                      questionModel.question ==
                                          AppStrings.nationalID
                                  ? const Text(
                                      '*',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          questionModel.type == AppStrings.questionTypeMultiple
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.pressAndHoldToViewAllText,
                                      style: TextStyle(
                                        color: AppColors.description,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          buildQuestionWidget(
                            index,
                            size,
                            cubit,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              widget.currentDoctorRole == 'Admin'
                  ? Container(height: 90)
                  : widget.doctorId.toString() !=
                          widget.currentDoctorModel.id.toString()
                      ? const SizedBox.shrink()
                      : widget.finalSubmitStatus
                          ? const SizedBox.shrink()
                          : Container(
                              height: 90,
                            ),
            ],
          ),
        ),
        SectionSubmitButton(
          doctorId: widget.doctorId,
          currentDoctorModel: widget.currentDoctorModel,
          currentDoctorRole: widget.currentDoctorRole,
          sectionModel: widget.sectionModel,
          patientId: widget.patientId,
          currentDoctorPoints: widget.currentDoctorPoints,
          finalSubmitStatus: widget.finalSubmitStatus,
          homeDataModel: widget.homeDataModel,
        ),
        // widget.doctorId.toString() != widget.currentDoctorModel.id.toString()
        //     ? const SizedBox.shrink()
        //     : widget.finalSubmitStatus
        //         ? const SizedBox.shrink()
        //         : Positioned(
        //             left: 0,
        //             right: 0,
        //             bottom: 0,
        //             child: Container(
        //               height: 90,
        //               alignment: Alignment.center,
        //               decoration: BoxDecoration(
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.grey.shade100,
        //                     spreadRadius: 1,
        //                     blurRadius: 7,
        //                     offset: const Offset(3, 4),
        //                   ),
        //                 ],
        //               ),
        //               child: SizedBox(
        //                 width: double.infinity,
        //                 height: 50,
        //                 child: Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 20),
        //                   child: BlocConsumer<PatientSectionDetailsCubit,
        //                       PatientSectionDetailsState>(
        //                     listener: (context, state) {
        //                       state.maybeWhen(
        //                         orElse: () {},
        //                         loaded: (questions,
        //                             isSubmitLoading,
        //                             isSubmitted,
        //                             message,
        //                             snackbarErrorCounter) {
        //                           if (message.isNotEmpty) {
        //                             customSnackBar(
        //                                 context: context, message: message);
        //                           }
        //                           if (isSubmitted) {
        //                             // context
        //                             //     .read<PatientSectionsCubit>()
        //                             //     .getPatientSections(widget.patientId);
        //                             navigatorKey.currentState
        //                                 ?.pushReplacementNamed(AppRoutes.home,
        //                                     arguments: 0);
        //                             navigatorKey.currentState?.pushNamed(
        //                               AppRoutes.patientSections,
        //                               arguments: AppRoutesArgs
        //                                   .patientSectionsRouteArguments(
        //                                 patientId: widget.patientId,
        //                                 currentDoctorModel:
        //                                     widget.currentDoctorModel,
        //                                 currentDoctorRole:
        //                                     widget.currentDoctorRole,
        //                               ),
        //                             );
        //                           }
        //                         },
        //                       );
        //                     },
        //                     builder: (context, state) {
        //                       return state.maybeWhen(
        //                         orElse: () {
        //                           return CustomElevatedButton(
        //                             onPressed: () {
        //                               cubit.updatePatientSectionDetails(
        //                                 widget.sectionModel.sectionId
        //                                     .toString(),
        //                                 widget.patientId.toString(),
        //                               );
        //                             },
        //                             title: AppStrings.submit,
        //                             isDisable: widget.doctorId.toString() ==
        //                                         widget.currentDoctorModel.id
        //                                             .toString() &&
        //                                     cubit.formData.isNotEmpty
        //                                 ? false
        //                                 : true,
        //                           );
        //                         },
        //                         loaded: (questions,
        //                             isSubmitLoading,
        //                             isSubmitted,
        //                             message,
        //                             snackbarErrorCounter) {
        //                           if (isSubmitLoading) {
        //                             return const Column(
        //                               children: [
        //                                 SizedBox(
        //                                   height: 25,
        //                                   width: 25,
        //                                   child: CircularProgressIndicator(),
        //                                 ),
        //                               ],
        //                             );
        //                           } else {
        //                             return CustomElevatedButton(
        //                               onPressed: () {
        //                                 cubit.updatePatientSectionDetails(
        //                                   widget.sectionModel.sectionId
        //                                       .toString(),
        //                                   widget.patientId.toString(),
        //                                 );
        //                               },
        //                               title: AppStrings.submit,
        //                               isDisable: widget.doctorId.toString() ==
        //                                           widget.currentDoctorModel.id
        //                                               .toString() &&
        //                                       cubit.formData.isNotEmpty
        //                                   ? false
        //                                   : true,
        //                             );
        //                           }
        //                         },
        //                         loading: () {
        //                           return const SizedBox(
        //                             height: 25,
        //                             width: 25,
        //                             child: CircularProgressIndicator(),
        //                           );
        //                         },
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
      ],
    );
  }

  Widget buildQuestionWidget(
      int index, Size size, PatientSectionDetailsCubit cubit) {
    // Map<String, dynamic> formDataMap = cubit.formData;

    switch (cubit.questionModelList[index].type) {
      case AppStrings.questionTypeString:
        var questionAnswer = cubit.questionModelList[index].answer;
        return BuildStringValueQuestions(
          questionList: cubit.questionModelList,
          index: index,
          initialValue: initialValueInQuestions(
            answer: questionAnswer,
            currentDoctorId: widget.currentDoctorModel.id.toString(),
            doctorId: widget.doctorId.toString(),
            question: cubit.questionModelList[index].question.toString(),
            questionAnswerInForm:
                cubit.formData[cubit.questionModelList[index].id.toString()],
            currentDoctorRole: widget.currentDoctorRole,
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
      case AppStrings.questionTypeSelect:
        var questionAnswer = cubit.questionModelList[index].answer;
        dynamic selectedValue;
        return BuildSelectValueQuestion(
          questionList: cubit.questionModelList,
          index: index,
          selected: initialValueInSelectQuestion(
              questionAnswer: questionAnswer, selectedValue: selectedValue),
          validator: (val) {
            if (cubit.questionModelList[index].mandatory == true &&
                (cubit.questionModelList[index].answer == null ||
                    cubit.questionModelList[index].answer ==
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
                  cubit.questionModelList[index].id.toString(), val);

              cubit.formData[cubit.questionModelList[index].id.toString()] =
                  val;
            } else {
              // questionAnswer = null;
              cubit.updateQuestionAnswer(
                  cubit.questionModelList[index].id.toString(), null);
              cubit.formData
                  .remove(cubit.questionModelList[index].id.toString());
            }

            setState(() {});
          },
        );
      case AppStrings.questionTypeMultiple:
        var questionAnswer = cubit.questionModelList[index].answer;
        Map<String, dynamic> answerMap = questionAnswer ??= {
          AppStrings.answers: [],
          AppStrings.otherField: AppStrings.empty
        };
        List<dynamic> answers =
            cubit.questionModelList[index].answer[AppStrings.answers] ??= [];

        return BuildMultipleValueQuestion(
          index: index,
          questionList: cubit.questionModelList,
          initialValue: answerMap[AppStrings.otherField] ?? '',
          listContainOther: answers,
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
                      } else {
                        answers.remove(value);
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
                      // log('list answer ${questionList[index].answer}');
                    });
                  },
                ),
              ),
            );
          }).toList(),
        );
      case AppStrings.questionTypeDate:
        var questionAnswer = cubit.questionModelList[index].answer;
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
              cubit.formData[cubit.questionModelList[index].id.toString()] =
                  questionAnswer;
              log(cubit.formData[cubit.questionModelList[index].id.toString()]);
              setState(() {});
            },
          ),
        );

      case AppStrings.questionTypeFiles:
        List<String> filesList =
            List.from(cubit.questionModelList[index].answer);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      // Pick multiple files
                      FilePickerResult? result;
                      result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);
                      if (result != null && result.files.isNotEmpty) {
                        List<Map<String, String>> filesList = [];

                        for (var pickedFile in result.files) {
                          File file = File(pickedFile.path!);
                          String fileName = pickedFile.name;
                          String fileData =
                              base64Encode(await file.readAsBytes());

                          filesList.add(
                              {"file_name": fileName, "file_data": fileData});
                        }

                        setState(() {
                          cubit.formData[cubit.questionModelList[index].id
                              .toString()] = filesList;
                        });

                        log(cubit.formData[
                                cubit.questionModelList[index].id.toString()]
                            .toString());
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const SizedBox(
                      height: 50,
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Display the picked files
            if (cubit.formData
                .containsKey(cubit.questionModelList[index].id.toString()))
              Column(
                children: (cubit.formData[cubit.questionModelList[index].id
                        .toString()] as List<Map<String, String>>)
                    .map(
                      (file) => ListTile(
                        title: Text(file['file_name']!),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(
                              () {
                                (cubit.formData[cubit
                                            .questionModelList[index].id
                                            .toString()]
                                        as List<Map<String, String>>)
                                    .remove(file);
                              },
                            );
                            log(cubit.formData.toString());
                            // cubit.updateScreen();
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            BlocBuilder<PatientSectionDetailsCubit, PatientSectionDetailsState>(
              builder: (context, state) {
                //  cubit.formData[cubit.questionModelList[index].id.toString()] ==
                //             null ||
                //         cubit.formData[
                //                 cubit.questionModelList[index].id.toString()] ==
                //             []
                //     ? FileListWhenSubmit(files: filesList)
                //     : const SizedBox.shrink(),
                if (cubit.formData[
                            cubit.questionModelList[index].id.toString()] ==
                        null ||
                    (cubit.formData[cubit.questionModelList[index].id
                            .toString()]) as List ==
                        [] ||
                    cubit.formData[
                            cubit.questionModelList[index].id.toString()] ==
                        {}) {
                  return FileListWhenSubmit(files: filesList);
                }
                return const SizedBox.shrink();
              },
            )
          ],
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
