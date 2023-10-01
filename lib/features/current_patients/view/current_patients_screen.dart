import 'package:timeago/timeago.dart' as timeago;

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
                    right: 20,
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
                    return Stack(
                      children: [
                        Card(
                          color: Colors.white, // Backgrond color
                          elevation: 0.8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: AppColors.subBG, // Splash color
                            onTap: () {},
                            child: Container(
                              width: size.width * 0.85,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.subBG,
                                        radius: 20,
                                        child: Text(
                                          patient.name == null
                                              ? ''
                                              : patient.name![0],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        patient.name == null
                                                            ? ''
                                                            : patient.name!,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              AppColors.title,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        patient.createdAt ==
                                                                null
                                                            ? ''
                                                            : timeago
                                                                .format(DateTime
                                                                    .parse(patient
                                                                        .createdAt!))
                                                                .toString(),
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .description,
                                                          fontSize: 10,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Dr.${drFirstName!.capitalizeFirst} ${drLastName!.capitalizeFirst}',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.description,
                                                      fontSize: 13,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    patient.hospital == null
                                                        ? ''
                                                        : patient.hospital!,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.description,
                                                      fontSize: 13,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Icon(
                            Icons.language_rounded,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                        ),
                      ],
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
