import '../../../../exports.dart';

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
      return Positioned(
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
                    ) {
                      if (message.isNotEmpty) {
                        customSnackBar(context: context, message: message);
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
                        title: AppStrings.submit,
                        isDisable: (doctorId.toString() ==
                                        currentDoctorModel.id.toString() ||
                                    currentDoctorRole ==
                                        AppStrings.roleAdmin) &&
                                cubit.formData.isNotEmpty
                            ? false
                            : true,
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
                          title: AppStrings.submit,
                          isDisable: (doctorId.toString() ==
                                          currentDoctorModel.id.toString() ||
                                      currentDoctorRole ==
                                          AppStrings.roleAdmin) &&
                                  cubit.formData.isNotEmpty
                              ? false
                              : true,
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
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
