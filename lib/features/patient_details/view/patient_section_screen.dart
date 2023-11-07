import 'dart:developer';

import '../../../exports.dart';

class PatienSectionScreen extends StatefulWidget {
  const PatienSectionScreen({super.key});

  @override
  State<PatienSectionScreen> createState() => _PatienSectionScreenState();
}

class _PatienSectionScreenState extends State<PatienSectionScreen> {
  final PatientSectionController _controller =
      Get.put(PatientSectionController());
  int patientId = Get.arguments[0];
  int doctorId = Get.arguments[1];
  String patientName = Get.arguments[2];
  bool submitStatus = Get.arguments[3];

  @override
  void initState() {
    _controller.getPatientSections(patientId.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          Get.find<HomeController>().homeInit();
        }));
    log('moatz111');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          patientName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => _controller.isPatientSectionLoading.value
            ? const ShimmerLoadingPatientsCards(ishorizontal: false)
            : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 30, right: 30),
                      child: ListView.builder(
                        itemCount: _controller.sectionModelList!.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 20),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var section = _controller.sectionModelList![index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SectionCard(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.sectionDetails,
                                  arguments: [
                                    section.sectionId,
                                    section.sectionName,
                                    submitStatus,
                                    patientId,
                                    doctorId,
                                  ],
                                );
                              },
                              updatedAt: section.updatedAt!,
                              isSubmitStatus: section.sectionStatus!,
                              index: index,
                              sectionName: section.sectionName!,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  submitStatus ||
                          doctorId != _controller.homeController.currentDoctorId
                      ? const SizedBox.shrink()
                      : Center(
                          child: SizedBox(
                            height: 90,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 5),
                                      child: CustomElevatedButton(
                                        size: size,
                                        onPressed: () {
                                          showCustomDialog(
                                              context: context,
                                              title: 'Attention !!',
                                              description:
                                                  'Are you sure you want to delete\n$patientName,?',
                                              coloredBottonText: 'Cancel',
                                              noColoredBottonText: 'Delete',
                                              coloredBottonOnTap: () =>
                                                  Get.back(),
                                              noColoredBottonOnTap: () {
                                                _controller.deletePatient(
                                                    patientId.toString());
                                              });
                                        },
                                        title: 'Delete',
                                        isDelete: true,
                                        isDisable: doctorId ==
                                                _controller.homeController
                                                    .currentDoctorId
                                            ? false
                                            : true,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                        left: submitStatus ? 10 : 5,
                                      ),
                                      child: CustomElevatedButton(
                                        size: size,
                                        onPressed: () {
                                          _controller.finalSubmit(
                                              patientId.toString(), context);
                                        },
                                        title: 'Final Submit',
                                        isDisable: doctorId ==
                                                _controller.homeController
                                                    .currentDoctorId
                                            ? false
                                            : true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
