import '../../../exports.dart';

class CurrentPatientsScreen extends GetView<CurrentPatientsController> {
  const CurrentPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Your Patients',
          style: TextStyle(),
        ),
        // elevation: 0,
      ),
      body: Column(
        children: [
          GetBuilder<CurrentPatientsController>(
            init: CurrentPatientsController(),
            builder: (currentPatientsController) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                    right: 30,
                    bottom: 50,
                  ),
                  itemCount:
                      currentPatientsController.currentPatientsList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var patient =
                        currentPatientsController.currentPatientsList![index];
                    var drFirstName = currentPatientsController
                        .homeController.currentDoctorFirstName;
                    var drLastName = currentPatientsController
                        .homeController.currentDoctorLastName;
                    return VerticalPatientCard(
                      patientName: patient.name ?? '',
                      drFirstName: drFirstName ?? '',
                      updatedAt: patient.updatedAt ?? '',
                      drLastName: drLastName ?? '',
                      hospital: patient.hospital ?? '',
                      isOutcomeStatus: patient.sections!.outcomeStatus!,
                      submitStatus: patient.sections == null
                          ? false
                          : patient.sections!.submitStatus ?? false,
                      onOutcomeTap: () => Get.toNamed(
                        AppRoutes.outcome,
                        arguments: [
                          patient.sections!.outcomeStatus,
                          patient.id,
                          patient.name
                        ],
                      ),
                      onAddCommentTap: () {
                        Get.toNamed(
                          AppRoutes.comments,
                          arguments: [
                            patient.id,
                            patient.name,
                          ],
                        );
                      },
                      onTap: () {
                        Get.toNamed(AppRoutes.patientSections, arguments: [
                          patient.id,
                          patient.doctorModel!.id,
                          patient.name,
                          patient.sections!.submitStatus,
                        ]);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
