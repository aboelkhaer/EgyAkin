import '../../../../exports.dart';

class FooterBottons extends StatelessWidget {
  final String doctorId;
  final String currentDoctorId;
  final String patientName;
  final String patientId;
  final PatientSectionsCubit cubit;
  const FooterBottons({
    super.key,
    required this.doctorId,
    required this.currentDoctorId,
    required this.patientName,
    required this.cubit,
    required this.patientId,
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
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: CustomElevatedButton(
                    onPressed: () {
                      showCustomDialog(
                          context: context,
                          title: 'Attention !!',
                          description:
                              'Are you sure you want to delete\n$patientName?',
                          coloredBottonText: 'Cancel',
                          noColoredBottonText: 'Delete',
                          coloredBottonOnTap: () => Navigator.of(context).pop(),
                          noColoredBottonOnTap: () {
                            // _controller.deletePatient(patientId.toString());
                            // WidgetsBinding.instance
                            //     .addPostFrameCallback((_) => setState(() {
                            //           Get.find<HomeController>().homeInit();
                            //         }));
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: CustomElevatedButton(
                    onPressed: () {
                      // _controller.finalSubmit(
                      //     patientId.toString(), context);
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
