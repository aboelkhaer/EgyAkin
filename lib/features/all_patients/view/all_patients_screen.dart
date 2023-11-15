import '../../../exports.dart';

class AllPatientsScreen extends GetView<AllPatientsController> {
  const AllPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: GestureDetector(
          onTap: () {
            if (controller.scrollController.hasClients) {
              controller.scrollController.animateTo(
                0, // Scroll position to jump to (top of the list)
                duration:
                    const Duration(milliseconds: 500), // Animation duration
                curve: Curves.easeInOut, // Animation curve
              );
            }
          },
          child: const Text(
            'All Patients',
            style: TextStyle(),
          ),
        ),
        // elevation: 0,
      ),
      body: Column(
        children: [
          GetBuilder<AllPatientsController>(
            init: AllPatientsController(),
            builder: (allPatientsController) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: allPatientsController.scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 20,
                    right: size.width * 0.09,
                    bottom: 50,
                  ),
                  itemCount: allPatientsController.allPatientsList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var patient = allPatientsController.allPatientsList![index];

                    return VerticalPatientCard(
                      patientName: patient.name ?? '',
                      drFirstName: patient.doctorModel!.firstName ?? '',
                      drLastName: patient.doctorModel!.lastName ?? '',
                      updatedAt: patient.updatedAt ?? '',
                      hospital: patient.hospital ?? '',
                      submitStatus: patient.sections == null
                          ? false
                          : patient.sections!.submitStatus ?? false,
                      isOutcomeStatus: patient.sections!.outcomeStatus!,
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
