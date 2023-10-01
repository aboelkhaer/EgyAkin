import 'package:timeago/timeago.dart' as timeago;

import '../../../../exports.dart';

class PatientCard extends GetView<HomeController> {
  final String? patientName;
  final String? createdAt;
  final String? drName;
  final String? hospital;
  final Size size;

  final bool isCurrentDoctorPatients;
  const PatientCard({
    super.key,
    required this.size,
    this.patientName,
    this.createdAt,
    this.drName,
    this.hospital,
    required this.isCurrentDoctorPatients,
  });

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.subBG,
                        radius: 20,
                        child: Text(
                          patientName == null ? '' : patientName![0],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        patientName == null ? '' : patientName!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.title,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        createdAt == null
                                            ? ''
                                            : timeago
                                                .format(
                                                    DateTime.parse(createdAt!))
                                                .toString(),
                                        style: const TextStyle(
                                          color: AppColors.description,
                                          fontSize: 10,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    drName == null ? '' : drName!,
                                    style: const TextStyle(
                                      color: AppColors.description,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    hospital == null ? '' : hospital!,
                                    style: const TextStyle(
                                      color: AppColors.description,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: CustomElevatedButton(
                              size: size,
                              onPressed: () {},
                              title: 'Outcome',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: CustomElevatedButton(
                              size: size,
                              onPressed: () {
                                // controller.getAllPatients();
                              },
                              title: 'Add Note',
                            ),
                          ),
                        ),
                      ],
                    ),
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
  }
}
