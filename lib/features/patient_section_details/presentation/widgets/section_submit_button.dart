import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class SectionSubmitButton extends StatelessWidget {
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  final String patientId;
  final bool finalSubmitStatus;
  final int currentDoctorPoints;
  final SectionModel sectionModel;
  final HomeModelResponse homeDataModel;
  const SectionSubmitButton(
      {super.key,
      required this.doctorId,
      required this.currentDoctorModel,
      required this.currentDoctorRole,
      required this.sectionModel,
      required this.patientId,
      required this.finalSubmitStatus,
      required this.currentDoctorPoints,
      required this.homeDataModel});

  @override
  Widget build(BuildContext context) {
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);
    if (currentDoctorRole == AppStrings.roleAdmin ||
        (doctorId.toString() == currentDoctorModel.id.toString() &&
            !finalSubmitStatus)) {
      if (sectionModel.sectionId.toString() == '9') {
        return const SizedBox.shrink();
      }
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

          return Positioned(
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
                    color: isDarkMode ? AppColors.darkBorder : Colors.black12,
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
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocConsumer<PatientSectionDetailsCubit,
                      PatientSectionDetailsState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
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
                          if (message.isNotEmpty) {
                            // customSnackBar(context: context, message: message);
                            showHintDialog(
                              context: context,
                              message: message,
                              dialogType: DialogType.error,
                            );
                          }
                          if (isSubmitted) {
                            // context
                            //     .read<PatientSectionsCubit>()
                            //     .getPatientSections(widget.patientId);
                            navigatorKey.currentState?.pushReplacementNamed(
                                AppRoutes.home,
                                arguments: 0);
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.patientSections,
                              arguments:
                                  AppRoutesArgs.patientSectionsRouteArguments(
                                patientId: patientId,
                                currentDoctorModel: currentDoctorModel,
                                currentDoctorRole: currentDoctorRole,
                                currentDoctorPoints: currentDoctorPoints,
                                homeDataModel: homeDataModel,
                                isAllDataOpen: false,
                              ),
                            );
                          }
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return CustomElevatedButton(
                            onPressed: () {
                              cubit.updatePatientSectionDetails(
                                sectionModel.sectionId.toString(),
                                patientId.toString(),
                              );
                            },
                            title: context.tr(AppStrings.submit),

                            // isDisable: (doctorId.toString() ==
                            //                 currentDoctorModel.id.toString() ||
                            //             currentDoctorRole ==
                            //                 AppStrings.roleAdmin) &&
                            //         cubit.formData.isNotEmpty
                            //     ? false
                            //     : true,
                            isDisable: false,
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
                          if (isSubmitLoading) {
                            return const Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          } else {
                            return CustomElevatedButton(
                              onPressed: () {
                                cubit.updatePatientSectionDetails(
                                  sectionModel.sectionId.toString(),
                                  patientId.toString(),
                                );
                              },
                              title: context.tr(AppStrings.submit),
                              isDisable: false,
                            );
                          }
                        },
                        loading: () {
                          return const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          );
                        },
                        medicationSectionLoaded: (
                          response,
                          changesCounter,
                          snackBarMessage,
                          dialogMessage,
                          isSubmitLoading,
                          isSubmitLoaded,
                          isSearchMedicationLoading,
                          searchForDoseInMedicationSectionResponse,
                          isDeletePatientRecommendationLoading,
                          isSeeMore,
                        ) {
                          if (isSubmitLoading) {
                            return const Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          } else {
                            return CustomElevatedButton(
                              onPressed: () {
                                cubit.updatePatientSectionDetails(
                                  sectionModel.sectionId.toString(),
                                  patientId.toString(),
                                );
                              },
                              title: context.tr(AppStrings.submit),
                              isDisable: false,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
