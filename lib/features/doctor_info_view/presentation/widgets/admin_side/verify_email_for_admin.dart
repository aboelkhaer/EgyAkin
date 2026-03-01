import '../../../../../exports.dart';

class VerifyEmailForAdmin extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;
  final bool isDarkMode;
  final DoctorInfoViewCubit cubit;
  const VerifyEmailForAdmin(
      {super.key,
      required this.homeDataModel,
      required this.doctorInfo,
      required this.isDarkMode,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return  PermissionGuard(
                      permission: AppPermissions.verifyUserEmail,
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Text(
                                '${context.tr(AppStrings.emailVerification)}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: isDarkMode
                                      ? AppColors.darkTitle
                                      : AppColors.title,
                                ),
                              ),
                              const Spacer(),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                  value: cubit.doctorVerifiedEmail,
                                  onChanged: (value) {
                                    cubit.verifyDoctorEmail(
                                        doctorInfo.data!.id.toString());
                                  },
                                  activeColor: isDarkMode
                                      ? AppColors.darkPrimary
                                      : AppColors.primary,
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
                                doctorInfo.data!.emailVerifiedAt == null
                                    ? context.tr(AppStrings.noData)
                                    : TimeAgoService.instance
                                        .formatTimeAgoFromString(
                                            doctorInfo.data!.emailVerifiedAt
                                                .toString(),
                                            context),
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
                      ),
                    );
  }
}
