import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/notification/presentation/widgets/check_notification_type.dart';

class NotificationsView extends StatelessWidget {
  final List<NotificationsModel> notificationsModel;
  const NotificationsView({super.key, required this.notificationsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: notificationsModel.length,
        itemBuilder: (context, index) {
          return CheckNotificationType(
            notificationModel: notificationsModel[index],
          );
        },
      ),
    );
  }
}
