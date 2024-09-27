import 'dart:developer';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_question.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/file_list_when_submit.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/section_submit_button.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';

class BuildSectionDetailsIfFinalSubmitFalse extends StatefulWidget {
  final List<QuestionModel> questions;
  final String doctorId;
  final String patientId;
  final SectionModel sectionModel;
  final HomeModelResponse homeDataModel;
  final bool isAllDataOpen;
  final DoctorModel currentDoctorModel;
  final bool finalSubmitStatus;
  const BuildSectionDetailsIfFinalSubmitFalse(
      {super.key,
      required this.questions,
      required this.patientId,
      required this.doctorId,
      required this.sectionModel,
      required this.homeDataModel,
      required this.currentDoctorModel,
      required this.finalSubmitStatus,
      required this.isAllDataOpen});

  @override
  State<BuildSectionDetailsIfFinalSubmitFalse> createState() =>
      _BuildSectionDetailsIfFinalSubmitFalseState();
}

class _BuildSectionDetailsIfFinalSubmitFalseState
    extends State<BuildSectionDetailsIfFinalSubmitFalse> {
  @override
  Widget build(BuildContext context) {
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Form(
          key: cubit.sectionDetailsKeyForm,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.questions.length,
                  shrinkWrap: true,
                  controller: cubit.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var questionModel = widget.questions[index];

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
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
                              ),
                              BlocBuilder<PatientSectionDetailsCubit,
                                  PatientSectionDetailsState>(
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
                                      // question condition
                                      if (questionModel.type ==
                                          AppStrings.questionTypeFiles) {
                                        // if no answer ever
                                        if ((cubit.formData[questionModel.id
                                                        .toString()] ==
                                                    null ||
                                                cubit.formData[questionModel.id
                                                        .toString()] as List ==
                                                    []) &&
                                            (cubit.questionModelList[index]
                                                    .answer as List)
                                                .isEmpty) {
                                          return const SizedBox.shrink();
                                        }

                                        // there is data
                                        if ((cubit.formData.containsKey(
                                                    questionModel.id
                                                        .toString()) &&
                                                cubit.formData[questionModel.id
                                                        .toString()] !=
                                                    null &&
                                                cubit.formData[questionModel.id
                                                        .toString()] as List !=
                                                    []) ||
                                            (cubit.questionModelList[index]
                                                    .answer as List)
                                                .isNotEmpty) {
                                          return InkWell(
                                            onTap: () {
                                              cubit
                                                  .removeAllFilesInFilesQuestion(
                                                      patientId:
                                                          widget.patientId,
                                                      sectionId: widget
                                                          .sectionModel
                                                          .sectionId
                                                          .toString(),
                                                      questionId: questionModel
                                                          .id
                                                          .toString());
                                            },
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Remove all',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      // last case
                                      return const SizedBox.shrink();
                                    },
                                  );
                                },
                              ),
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
                              : questionModel.type ==
                                      AppStrings.questionTypeFiles
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Attention: Files will upload directly.\nTotals should be maximum 5MB.\nSingle file size maximum 2MB.',
                                            style: TextStyle(
                                              color: AppColors.description,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                          BuildQuestion(
                            index: index,
                            currentDoctorModel: widget.currentDoctorModel,
                            doctorId: widget.doctorId,
                            homeDataModel: widget.homeDataModel,
                            isAllDataOpen: widget.isAllDataOpen,
                            patientId: widget.patientId,
                            sectionModel: widget.sectionModel,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              widget.homeDataModel.role == AppStrings.roleAdmin
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
          currentDoctorRole: widget.homeDataModel.role.toString(),
          sectionModel: widget.sectionModel,
          patientId: widget.patientId,
          currentDoctorPoints:
              int.parse(widget.homeDataModel.scoreValue.toString()),
          finalSubmitStatus: widget.finalSubmitStatus,
          homeDataModel: widget.homeDataModel,
        ),
      ],
    );
  }

  // String stringDateTostring(String datevalue) {
  //   DateTime convertDate = DateTime.parse(datevalue);

  //   String stringdate =
  //       "${convertDate.day}/${convertDate.month}/${convertDate.year}";

  //   return stringdate;
  // }

  // showDate(String dateTime) async {
  //   DateTime dateTime0;
  //   if (dateTime.isNotEmpty) {
  //     dateTime0 = DateFormat('MM/dd/yyyy').parse(dateTime);
  //   } else {
  //     dateTime0 = DateTime.now();
  //   }
  //   return await showDatePicker(
  //     context: context,
  //     initialDate: dateTime0,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );
  // }
}
