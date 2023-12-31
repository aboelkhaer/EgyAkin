import '../../../exports.dart';

class CurrentPatientsScreen extends GetView<CurrentPatientsController> {
  const CurrentPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            if (controller.currentPatientsScrollController.hasClients) {
              controller.currentPatientsScrollController.animateTo(
                0, // Scroll position to jump to (top of the list)
                duration:
                    const Duration(milliseconds: 500), // Animation duration
                curve: Curves.easeInOut, // Animation curve
              );
            }
          },
          child: const Text(
            'Your Patients',
            style: TextStyle(),
          ),
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
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller:
                      currentPatientsController.currentPatientsScrollController,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 20,
                    right: size.width * 0.09,
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
