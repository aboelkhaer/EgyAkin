import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_question.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/section_submit_button.dart';

import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

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

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

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
                      controller: cubit.patientSectionDetailsScrollController,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${index + 1} - ${questionModel.question!} ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: isDarkMode
                                                        ? AppColors.darkTitle
                                                        : Colors.black,
                                                  ),
                                                ),
                                                if (questionModel.mandatory! ||
                                                    questionModel.question ==
                                                        AppStrings.nationalID)
                                                  const TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
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
                                          // question condition
                                          if (questionModel.type ==
                                              AppStrings.questionTypeFiles) {
                                            // if no answer ever
                                            if ((cubit.formData[questionModel.id
                                                            .toString()] ==
                                                        null ||
                                                    cubit.formData[questionModel
                                                                .id
                                                                .toString()]
                                                            as List ==
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
                                                    cubit.formData[questionModel
                                                            .id
                                                            .toString()] !=
                                                        null &&
                                                    cubit.formData[questionModel
                                                                .id
                                                                .toString()]
                                                            as List !=
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
                                                          questionId:
                                                              questionModel.id
                                                                  .toString());
                                                },
                                                highlightColor:
                                                    Colors.transparent,
                                                splashColor: Colors.transparent,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    'Remove all',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                              questionModel.type ==
                                      AppStrings.questionTypeMultiple
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                context.tr(AppStrings
                                                    .attentionFilesWillUploadDirectlyTotalsShouldBeMaximum5MB),
                                                style: const TextStyle(
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
                  widget.sectionModel.sectionId.toString() == '9'
                      ? const SizedBox.shrink()
                      : PermissionHelper.canPermission(AppPermissions
                              .viewSubmitButtonForAdminInPatientSectionDetails)
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
      },
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
