import '../../../exports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  final NotificationController controller = Get.put(NotificationController());
  List<BaseNotificationModel>? notifications = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.updateNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.notification),
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
                      if (notifications![index].type == AppStrings.newPatient) {
                        Get.toNamed(AppRoutes.patientSections, arguments: [
                          // notifications![index].id,
                          notifications![index].basePatientModel!.id,
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
                      if (notifications![index].type == AppStrings.outcome) {
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
                      if (notifications![index].type == AppStrings.comment) {
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
                      // child:
                      //     checkNotificationType(notifications![index], index),
                      child: CheckNotificationType(
                          notificationModel: notifications![index]),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
