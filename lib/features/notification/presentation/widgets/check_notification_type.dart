import '../../../../exports.dart';
import 'package:timeago/timeago.dart' as timeago;

class CheckNotificationType extends StatelessWidget {
  final NotificationsModel notificationModel;

  const CheckNotificationType({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    switch (notificationModel.type) {
      case AppStrings.newPatient:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 15.r,
                      backgroundColor: AppColors.primary.withOpacity(0.7),
                      child: Text(
                        notificationModel.patient!.doctor!.firstName![0]
                            .toUpperCase()
                            .toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  'Dr. ${capitalizeFirstText(notificationModel.patient!.doctor!.firstName!)}',
                              style: const TextStyle(color: AppColors.title),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: ' creates ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const TextSpan(text: 'a new patient '),
                                const TextSpan(
                                    text: ' at ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        '${notificationModel.patient!.hospital}'),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                timeago
                                    .format(DateTime.parse(
                                        notificationModel.createdAt.toString()))
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                notificationModel.read!
                    ? const SizedBox.shrink()
                    : Positioned(
                        left: 0,
                        // right: 0.w,
                        // top: 2.h,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 5.r,
                        ),
                      ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
            SizedBox(height: 10.h),
          ],
        );
      case AppStrings.comment:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: 'On the linked patient, someone has made a ',
                style: TextStyle(color: AppColors.title),
                children: <TextSpan>[
                  TextSpan(
                    text: '${AppStrings.comment}.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              timeago
                  .format(
                      DateTime.parse(notificationModel.createdAt.toString()))
                  .toString(),
              style: const TextStyle(
                color: AppColors.title,
                fontSize: 10,
              ),
            ),
          ],
        );
      case AppStrings.outcome:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: 'On the linked patient, someone has made an ',
                style: TextStyle(color: AppColors.title),
                children: <TextSpan>[
                  TextSpan(
                    text: '${AppStrings.outcome}.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              timeago
                  .format(
                      DateTime.parse(notificationModel.createdAt.toString()))
                  .toString(),
              style: const TextStyle(
                color: AppColors.title,
                fontSize: 10,
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }
}
