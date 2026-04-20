import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';
import '../../../../app/shared/functions/permissions_helper.dart';
import '../../../../app/shared/permissions/app_permissions.dart';

class FooterButtons extends StatelessWidget {
  final String doctorId;
  final String currentDoctorId;
  final String patientName;
  final String patientId;
  final bool finalSubmit;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final PatientSectionsCubit cubit;
  const FooterButtons({
    super.key,
    required this.doctorId,
    required this.currentDoctorId,
    required this.patientName,
    required this.cubit,
    required this.patientId,
    required this.finalSubmit,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Container(
              height: 90,
              padding: const EdgeInsets.only(bottom: 20),
              color:
                  isDarkMode ? AppColors.darkScaffoldBG : Colors.grey.shade100,
              child: Row(
                children: [
                  finalSubmit &&
                          !PermissionHelper.canPermission(AppPermissions
                              .viewPatientsFinalSubmitAndDeleteContainerForAdmin) &&
                          currentDoctorPoints < 200
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: SizedBox(
                            height: 50,
                            child: CustomElevatedButton(
                              onPressed: () async {
                                // Check permission before showing delete dialog
                                final hasPermission =
                                    await PermissionHelper.hasPermission(
                                  AppPermissions.deletePatient,
                                );

                                if (hasPermission) {
                                  // User has permission - show delete confirmation dialog
                                  showCustomDialog(
                                      context: context,
                                      title: context.tr(AppStrings.attention),
                                      description:
                                          '${context.tr(AppStrings.areYouSureYouWantToDelete)}\n$patientName?',
                                      coloredButtonText:
                                          context.tr(AppStrings.cancel),
                                      noColoredButtonText:
                                          context.tr(AppStrings.delete),
                                      coloredButtonOnTap: () =>
                                          Navigator.of(context).pop(),
                                      noColoredButtonOnTap: () {
                                        Navigator.of(context).pop();
                                        cubit.deletePatient(patientId);
                                      });
                                } else {
                                  // User doesn't have permission - show permission denied dialog
                                  showCustomDialog(
                                      context: context,
                                      title: context.tr(AppStrings.attention),
                                      description: context.tr(AppStrings
                                          .youDontHavePermissionToDeletePatients),
                                      coloredButtonText:
                                          context.tr(AppStrings.ok),
                                      coloredButtonOnTap: () =>
                                          Navigator.of(context).pop(),
                                      isNoColorShow: false);
                                }
                              },
                              title: context.tr(AppStrings.delete),
                              isDelete: true,
                              isDisable: PermissionHelper.canPermission(
                                      AppPermissions.deletePatientForAdmin)
                                  ? false
                                  : doctorId == currentDoctorId
                                      ? false
                                      : true,
                            ),
                          ),
                        ),
                  finalSubmit &&
                          !PermissionHelper.canPermission(AppPermissions
                              .viewPatientsFinalSubmitAndDeleteContainerForAdmin) &&
                          currentDoctorPoints < 200
                      ? const SizedBox.shrink()
                      : const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: finalSubmit
                          ? CustomElevatedButton(
                              isDisable: !PermissionHelper.canPermission(
                                  AppPermissions.generatePatientPdf),
                              onPressed: () {
                                cubit.downloadPatientReport(patientId);
                              },
                              title: context.tr(AppStrings.requestReport),

                              // isDisable: doctorId == currentDoctorId ? false : true,
                            )
                          : CustomElevatedButton(
                              onPressed: () async {
                                // Check permission before final submit
                                final hasPermission =
                                    await PermissionHelper.hasPermission(
                                  AppPermissions.finalSubmitPatient,
                                );

                                if (hasPermission) {
                                  // User has permission - proceed with final submit
                                  cubit.finalSubmit(patientId, context);
                                } else {
                                  // User doesn't have permission - show permission denied dialog
                                  showCustomDialog(
                                    context: context,
                                    title: context.tr(AppStrings.attention),
                                    description: context.tr(AppStrings
                                        .youDontHavePermissionToFinalSubmitPatients),
                                    coloredButtonText:
                                        context.tr(AppStrings.ok),
                                    coloredButtonOnTap: () =>
                                        Navigator.of(context).pop(),
                                    isNoColorShow: false,
                                  );
                                }
                              },
                              title: context.tr(AppStrings.finalSubmit),
                              isDisable: (PermissionHelper.canPermission(
                                          AppPermissions
                                              .finalSubmitPatientForAdmin) &&
                                      PermissionHelper.canPermission(
                                          AppPermissions.finalSubmitPatient))
                                  ? false
                                  : doctorId == currentDoctorId
                                      ? false
                                      : true,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
