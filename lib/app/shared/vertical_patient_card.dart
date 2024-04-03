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
              width: 325.w,
              height: 135.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

              // padding: const EdgeInsets.all(16),

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
                            SizedBox(width: 12.w),
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
                                          'Dr.${capitalizeFirstText(drFirstName.toString())} ${capitalizeFirstText(drLastName.toString())}',
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
                  SizedBox(height: 8.h),
                  const Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 28.h,
                                child: isOutcomeStatus
                                    ? TextButton(
                                        onPressed: onOutcomeTap,
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        child: const Text(AppStrings.outcome),
                                      )
                                    : CustomElevatedButton(
                                        onPressed: onOutcomeTap,
                                        title: AppStrings.outcome,
                                        isDisable: !submitStatus,
                                        // isDisable:
                                        //     isOutcomeStatus && !submitStatus ? false : true,
                                      ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: SizedBox(
                                // height: 40,
                                height: 28.h,
                                child: CustomElevatedButton(
                                  onPressed: onAddCommentTap,
                                  title: AppStrings.addComment,
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
          right: 2.w,
          top: 2.h,
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
