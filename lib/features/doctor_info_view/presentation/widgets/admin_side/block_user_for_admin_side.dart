import '../../../../../exports.dart';

class BlockUserForAdminSide extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;
  final bool isDarkMode;
  final DoctorInfoViewCubit cubit;
  const BlockUserForAdminSide(
      {super.key,
      required this.homeDataModel,
      required this.doctorInfo,
      required this.isDarkMode,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return PermissionGuard(
        permission: AppPermissions.blockUser,
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Row(
              children: [
                Text(
                  '${context.tr(AppStrings.blocked)}:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: isDarkMode ? AppColors.darkTitle : AppColors.title,
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: cubit.doctorBlocked,
                    onChanged: (value) {
                      cubit.changeBlockUserStatus(
                          doctorInfo.data!.id.toString());
                    },
                    activeColor:
                        isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 60.w),
                SelectableText(
                  doctorInfo.data!.blocked.toString() == 'false'
                      ? context.tr(AppStrings.no)
                      : context.tr(AppStrings.yes),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
