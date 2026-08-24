import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/admin_action_card.dart';

import '../../../../../exports.dart';

class BlockUserForAdminSide extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;
  final bool isDarkMode;
  final DoctorInfoViewCubit cubit;

  const BlockUserForAdminSide({
    super.key,
    required this.homeDataModel,
    required this.doctorInfo,
    required this.isDarkMode,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final blocked = doctorInfo.data!.blocked.toString() == 'true';

    return PermissionGuard(
      permission: AppPermissions.blockUser,
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: AdminActionCard(
          isDark: isDarkMode,
          icon: Icons.block_rounded,
          accent: const Color(0xFFEF4444),
          title: context.tr(AppStrings.blocked),
          subtitle: blocked
              ? context.tr(AppStrings.yes)
              : context.tr(AppStrings.no),
          value: cubit.doctorBlocked,
          onChanged: (_) {
            cubit.changeBlockUserStatus(doctorInfo.data!.id.toString());
          },
        ),
      ),
    );
  }
}
