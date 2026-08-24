import 'package:egy_akin/app/shared/widgets/professional_submit_button.dart';

import '../../../../exports.dart';
import '../../../../app/shared/functions/permissions_helper.dart';

class SectionSubmitButton extends StatelessWidget {
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  final String patientId;
  final bool finalSubmitStatus;
  final int currentDoctorPoints;
  final SectionModel sectionModel;
  final HomeModelResponse homeDataModel;
  final bool isAllDataOpen;

  /// When false, validation/error dialogs are handled by the parent (scroll-to-field).
  final bool handleErrorDialogs;

  const SectionSubmitButton({
    super.key,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.currentDoctorRole,
    required this.sectionModel,
    required this.patientId,
    required this.finalSubmitStatus,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    this.isAllDataOpen = false,
    this.handleErrorDialogs = true,
  });

  void _submit(BuildContext context) {
    PatientSectionDetailsCubit.get(context).updatePatientSectionDetails(
      sectionModel.sectionId.toString(),
      patientId.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditingLocked =
        finalSubmitStatus && sectionModel.alwaysOpen != true;
    final canShowSubmit = PermissionHelper.canPermission(
          AppPermissions.viewSubmitButtonForAdminInPatientSectionDetails,
        ) ||
        !isEditingLocked;

    if (!canShowSubmit || sectionModel.sectionId.toString() == '9') {
      return const SizedBox.shrink();
    }

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return BlocConsumer<PatientSectionDetailsCubit,
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
                if (handleErrorDialogs && message.isNotEmpty) {
                  showHintDialog(
                    context: context,
                    message: message,
                    dialogType: DialogType.error,
                  );
                }
                if (isSubmitted) {
                  navigatorKey.currentState?.pushReplacementNamed(
                    AppRoutes.home,
                    arguments: 0,
                  );
                  navigatorKey.currentState?.pushNamed(
                    AppRoutes.patientSections,
                    arguments: AppRoutesArgs.patientSectionsRouteArguments(
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
            final isLoading = state.maybeWhen(
              orElse: () => false,
              loading: () => true,
              loaded: (
                _,
                isSubmitLoading,
                __,
                ___,
                ____,
                _____,
                ______,
                _______,
                ________,
                _________,
                __________,
                ___________,
                ____________,
                _____________,
                ______________,
              ) =>
                  isSubmitLoading,
              medicationSectionLoaded: (
                _,
                __,
                ___,
                ____,
                isSubmitLoading,
                _____,
                ______,
                _______,
                ________,
                _________,
              ) =>
                  isSubmitLoading,
            );

            return ProfessionalSubmitBar(
              isDark: isDark,
              isLoading: isLoading,
              onPressed: () => _submit(context),
              label: context.tr(AppStrings.submit),
              subtitle: context.tr(AppStrings.saveSectionAnswers),
            );
          },
        );
      },
    );
  }
}
