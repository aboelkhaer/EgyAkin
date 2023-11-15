import 'package:timeago/timeago.dart' as timeago;

import '../../exports.dart';

class VerticalPatientCard extends StatelessWidget {
  final String patientName;
  final String drFirstName;
  final String drLastName;
  final VoidCallback onTap;
  final String updatedAt;
  final String hospital;
  final VoidCallback onOutcomeTap;
  final VoidCallback onAddCommentTap;
  final bool isOutcomeStatus;
  final bool submitStatus;
  const VerticalPatientCard(
      {super.key,
      required this.patientName,
      required this.drFirstName,
      required this.drLastName,
      required this.onAddCommentTap,
      required this.isOutcomeStatus,
      required this.hospital,
      required this.onOutcomeTap,
      required this.submitStatus,
      required this.updatedAt,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            child: Container(
              width: size.width * 0.90,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                                      Flexible(
                                        child: Text(
                                          patientName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.title,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        timeago
                                            .format(DateTime.parse(updatedAt))
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
                                  drFirstName == ''
                                      ? const SizedBox.shrink()
                                      : const SizedBox(height: 4),
                                  drFirstName == ''
                                      ? const SizedBox.shrink()
                                      : Text(
                                          'Dr.${drFirstName.capitalizeFirst} ${drLastName.capitalizeFirst}',
                                          style: const TextStyle(
                                            color: AppColors.description,
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  drFirstName == ''
                                      ? const SizedBox.shrink()
                                      : const SizedBox(height: 4),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
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
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        child: const Text('Outcome'),
                                      )
                                    : CustomElevatedButton(
                                        size: size,
                                        onPressed: onOutcomeTap,
                                        title: 'Outcome',
                                        isDisable: !submitStatus,
                                        // isDisable:
                                        //     isOutcomeStatus && !submitStatus ? false : true,
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
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Icon(
            submitStatus ? AppIcons.isFinalSubmit : AppIcons.isFinalNotSubmit,
            color: submitStatus
                ? AppColors.primary.withOpacity(0.7)
                : Colors.amber,
          ),
        ),
      ],
    );
  }
}
