import '../../../../exports.dart';

class FooterButtons extends StatelessWidget {
  final String doctorId;
  final String currentDoctorId;
  final String patientName;
  final String patientId;
  final bool finalSubmit;
  final PatientSectionsCubit cubit;
  const FooterButtons({
    super.key,
    required this.doctorId,
    required this.currentDoctorId,
    required this.patientName,
    required this.cubit,
    required this.patientId,
    required this.finalSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: SizedBox(
          height: 90,
          child: Row(
            children: [
              finalSubmit
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomElevatedButton(
                          onPressed: () {
                            showCustomDialog(
                                context: context,
                                title: 'Attention !!',
                                description:
                                    'Are you sure you want to delete\n$patientName?',
                                coloredButtonText: 'Cancel',
                                noColoredButtonText: 'Delete',
                                coloredButtonOnTap: () =>
                                    Navigator.of(context).pop(),
                                noColoredButtonOnTap: () {
                                  Navigator.of(context).pop();
                                  cubit.deletePatient(patientId);
                                });
                          },
                          title: 'Delete',
                          isDelete: true,
                          isDisable: doctorId == currentDoctorId ? false : true,
                        ),
                      ),
                    ),
              finalSubmit
                  ? const SizedBox.shrink()
                  : const SizedBox(
                      width: 10,
                    ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: finalSubmit
                      ? CustomElevatedButton(
                          onPressed: () {
                            cubit.downloadPatientReport(patientId);
                          },
                          title: 'Request report',
                          // isDisable: doctorId == currentDoctorId ? false : true,
                        )
                      : CustomElevatedButton(
                          onPressed: () {
                            cubit.finalSubmit(patientId, context);
                          },
                          title: AppStrings.finalSubmit,
                          isDisable: doctorId == currentDoctorId ? false : true,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
