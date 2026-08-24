import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/admin_action_card.dart';

import '../../../../../exports.dart';

class VerifyEmailForAdmin extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;
  final bool isDarkMode;
  final DoctorInfoViewCubit cubit;

  const VerifyEmailForAdmin({
    super.key,
    required this.homeDataModel,
    required this.doctorInfo,
    required this.isDarkMode,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return PermissionGuard(
      permission: AppPermissions.verifyUserEmail,
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: AdminActionCard(
          isDark: isDarkMode,
          icon: Icons.mark_email_read_outlined,
          accent: const Color(0xFF3B82F6),
          title: context.tr(AppStrings.emailVerification),
          subtitle: doctorInfo.data!.emailVerifiedAt == null
              ? context.tr(AppStrings.noData)
              : TimeAgoService.instance.formatTimeAgoFromString(
                  doctorInfo.data!.emailVerifiedAt.toString(),
                  context,
                ),
          value: cubit.doctorVerifiedEmail,
          onChanged: (_) {
            cubit.verifyDoctorEmail(doctorInfo.data!.id.toString());
          },
        ),
      ),
    );
  }
}
