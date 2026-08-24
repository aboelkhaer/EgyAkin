import '../../../../exports.dart';

class AchievementCheck extends StatelessWidget {
  final String currentDoctorRole;
  final String currentDoctorId;
  final String notificationDoctorId;
  final String notificationDoctorName;
  const AchievementCheck(
      {super.key,
      required this.currentDoctorRole,
      required this.currentDoctorId,
      required this.notificationDoctorId,
      required this.notificationDoctorName});

  @override
  Widget build(BuildContext context) {
    if ((currentDoctorRole == AppStrings.roleAdmin &&
            (currentDoctorId == notificationDoctorId)) ||
        currentDoctorId == notificationDoctorId) {
      return Flexible(
        child: RichText(
          text: TextSpan(
            text: context.tr(AppStrings.congratulations),
            style: TextStyle(color: AppColors.title, fontSize: 12.sp),
            children: <TextSpan>[
              TextSpan(
                text:
                    '🎉 ${context.tr(AppStrings.youHaveEarnedNewAchievement)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              // const TextSpan(text: 'for his patient'),
              // const TextSpan(
              //     text: ' : ',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold)),
              TextSpan(
                  text: context.tr(AppStrings.keepUpTheGreatWork),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      );
    }
    if ((currentDoctorRole == AppStrings.roleAdmin &&
            (currentDoctorId != notificationDoctorId)) ||
        currentDoctorId != notificationDoctorId) {
      return Flexible(
        child: RichText(
          text: TextSpan(
            text: 'Dr.$notificationDoctorName',
            style: TextStyle(color: AppColors.title, fontSize: 12.sp),
            children: <TextSpan>[
              TextSpan(
                text:
                    ' ${context.tr(AppStrings.hasEarnedNewAchievement)} 🎉',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              // const TextSpan(text: 'for his patient'),
              // const TextSpan(
              //     text: ' : ',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold)),
              // TextSpan(
              //     text:
              //         '${notificationModel.patient!.name}',
              //     style: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //     )),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
