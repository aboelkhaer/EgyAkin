import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

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
              color:
                  isDarkMode ? AppColors.darkScaffoldBG : Colors.grey.shade100,
              child: Row(
                children: [
                  finalSubmit &&
                          currentDoctorRole != AppStrings.roleAdmin &&
                          currentDoctorPoints < 200
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: SizedBox(
                            height: 50,
                            child: CustomElevatedButton(
                              onPressed: () {
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
                              },
                              title: context.tr(AppStrings.delete),
                              isDelete: true,
                              isDisable:
                                  currentDoctorRole == AppStrings.roleAdmin
                                      ? false
                                      : doctorId == currentDoctorId
                                          ? false
                                          : true,
                            ),
                          ),
                        ),
                  finalSubmit &&
                          currentDoctorRole != AppStrings.roleAdmin &&
                          currentDoctorPoints < 200
                      ? const SizedBox.shrink()
                      : const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: finalSubmit
                          ? CustomElevatedButton(
                              onPressed: () {
                                cubit.downloadPatientReport(patientId);
                              },
                              title: context.tr(AppStrings.requestReport),

                              // isDisable: doctorId == currentDoctorId ? false : true,
                            )
                          : CustomElevatedButton(
                              onPressed: () {
                                cubit.finalSubmit(patientId, context);
                              },
                              title: context.tr(AppStrings.finalSubmit),
                              isDisable:
                                  currentDoctorRole == AppStrings.roleAdmin
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
