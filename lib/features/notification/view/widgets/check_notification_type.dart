import '../../../../exports.dart';
import 'package:timeago/timeago.dart' as timeago;

class CheckNotificationType extends StatelessWidget {
  final BaseNotificationModel notificationModel;

  const CheckNotificationType({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    switch (notificationModel.type) {
      case AppStrings.newPatient:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text:
                    'Dr. ${notificationModel.basePatientModel!.doctorModel!.firstName!.capitalizeFirst} ${notificationModel.basePatientModel!.doctorModel!.lastName!.capitalizeFirst}',
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
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '${notificationModel.basePatientModel!.hospital}'),
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
