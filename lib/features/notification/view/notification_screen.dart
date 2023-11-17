import 'package:timeago/timeago.dart' as timeago;

import '../../../app/app_models/notification/base_notification_model.dart';
import '../../../exports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void dispose() {
    // controller.updateNotifications();
    super.dispose();
  }

  final NotificationController controller = Get.put(NotificationController());
  List<BaseNotificationModel>? notifications = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.updateNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: notifications!.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (notifications![index].type == 'New Patient') {
                        Get.toNamed(AppRoutes.patientSections, arguments: [
                          notifications![index].id,
                          notifications![index]
                              .basePatientModel!
                              .doctorModel!
                              .id,
                          notifications![index].basePatientModel!.name,
                          notifications![index]
                              .basePatientModel!
                              .sections!
                              .submitStatus,
                        ]);
                      }
                      if (notifications![index].type == 'Outcome') {
                        Get.toNamed(
                          AppRoutes.outcome,
                          arguments: [
                            notifications![index]
                                .basePatientModel!
                                .sections!
                                .outcomeStatus,
                            notifications![index].basePatientModel!.id,
                            notifications![index].basePatientModel!.name,
                          ],
                        );
                      }
                      if (notifications![index].type == 'Comment') {
                        Get.toNamed(
                          AppRoutes.comments,
                          arguments: [
                            notifications![index].basePatientModel!.id,
                            notifications![index].basePatientModel!.name,
                          ],
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: notifications![index].read!
                            ? Colors.white
                            : Colors.grey.shade300,
                      ),
                      child:
                          checkNotificationType(notifications![index], index),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget checkNotificationType(BaseNotificationModel notificationModel, index) {
    switch (notificationModel.type) {
      case 'New Patient':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text:
                    'Dr. ${notifications![index].basePatientModel!.doctorModel!.firstName!.capitalizeFirst} ${notifications![index].basePatientModel!.doctorModel!.lastName!.capitalizeFirst}',
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
                      text:
                          '${notifications![index].basePatientModel!.hospital}'),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              timeago
                  .format(DateTime.parse(
                      notifications![index].createdAt.toString()))
                  .toString(),
              style: const TextStyle(
                color: AppColors.title,
                fontSize: 10,
              ),
            ),
          ],
        );
      case 'Comment':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: 'On the linked patient, someone has made a ',
                style: TextStyle(color: AppColors.title),
                children: <TextSpan>[
                  TextSpan(
                    text: 'comment.',
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
                  .format(DateTime.parse(
                      notifications![index].createdAt.toString()))
                  .toString(),
              style: const TextStyle(
                color: AppColors.title,
                fontSize: 10,
              ),
            ),
          ],
        );
      case 'Outcome':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: 'On the linked patient, someone has made an ',
                style: TextStyle(color: AppColors.title),
                children: <TextSpan>[
                  TextSpan(
                    text: 'outcome.',
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
                  .format(DateTime.parse(
                      notifications![index].createdAt.toString()))
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
