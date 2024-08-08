import '../../../../exports.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Container(
          height: 90,
          color: Colors.grey.shade100,
          child: Row(
            children: [
              finalSubmit &&
                      currentDoctorRole != 'Admin' &&
                      currentDoctorPoints < 200
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
                          isDisable: currentDoctorRole == 'Admin'
                              ? false
                              : doctorId == currentDoctorId
                                  ? false
                                  : true,
                        ),
                      ),
                    ),
              finalSubmit &&
                      currentDoctorRole != 'Admin' &&
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
                          title: 'Request report',
                          // isDisable: doctorId == currentDoctorId ? false : true,
                        )
                      : CustomElevatedButton(
                          onPressed: () {
                            cubit.finalSubmit(patientId, context);
                          },
                          title: AppStrings.finalSubmit,
                          isDisable: currentDoctorRole == 'Admin'
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
  }
}
