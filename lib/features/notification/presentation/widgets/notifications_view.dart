import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/notification/presentation/widgets/check_notification_type.dart';

class NotificationsView extends StatelessWidget {
  final List<NotificationsModel> notificationsModel;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;
  final bool isDarkMode;
  final bool animateItems;

  const NotificationsView({
    super.key,
    required this.notificationsModel,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.isDarkMode,
    this.animateItems = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: notificationsModel.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final tile = CheckNotificationType(
          notificationModel: notificationsModel[index],
          currentDoctorModel: currentDoctorModel,
          accountVerification: accountVerification,
          currentDoctorRole: currentDoctorRole,
          currentDoctorPoints: currentDoctorPoints,
          isSyndicateCardRequired: isSyndicateCardRequired,
          homeDataModel: homeDataModel,
          isDarkMode: isDarkMode,
        );

        if (!animateItems) return tile;

        final delayIndex = index > 10 ? 10 : index;
        return FadeInUp(
          from: 14,
          duration: const Duration(milliseconds: 420),
          delay: Duration(milliseconds: 35 * delayIndex),
          child: tile,
        );
      },
    );
  }
}
