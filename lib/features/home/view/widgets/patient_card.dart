import 'package:timeago/timeago.dart' as timeago;

import '../../../../exports.dart';

class PatientCard extends GetView<HomeController> {
  final String patientName;
  final String createdAt;
  final String drName;
  final String updatedAt;
  final String hospital;
  final bool submitStatus;
  final Size size;
  final bool isOutcomeStatus;
  final VoidCallback onTap;
  final VoidCallback onOutcomeTap;
  final VoidCallback onAddCommentTap;
  final VoidCallback onLongPress;

  final bool isCurrentDoctorPatients;
  const PatientCard({
    super.key,
    required this.size,
    required this.updatedAt,
    required this.patientName,
    required this.createdAt,
    required this.onOutcomeTap,
    required this.isOutcomeStatus,
    required this.onAddCommentTap,
    required this.onLongPress,
    required this.drName,
    required this.submitStatus,
    required this.onTap,
    required this.hospital,
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
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.only(
                  top: 20, left: 20, bottom: 10, right: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.subBG,
                        radius: 20,
                        child: Text(
                          patientName[0],
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
                                        patientName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.title,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        timeago
                                            .format(DateTime.parse(
                                                createdAt == updatedAt
                                                    ? createdAt
                                                    : updatedAt))
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
                                    drName,
                                    style: const TextStyle(
                                      color: AppColors.description,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    hospital,
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
                            child: isOutcomeStatus
                                ? TextButton(
                                    onPressed: onOutcomeTap,
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child: const Text('Outcome'),
                                  )
                                : CustomElevatedButton(
                                    size: size,
                                    onPressed: onOutcomeTap,
                                    title: 'Outcome',
                                    isDisable: !submitStatus,
                                    // isDisable: isOutcomeStatus && !submitStatus
                                    //     ? false
                                    //     : true,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: CustomElevatedButton(
                              size: size,
                              onPressed: onAddCommentTap,
                              title: 'Add Comment',
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
          child: SectionStatusIcon(submitStatus: submitStatus),
        ),
      ],
    );
  }
}
