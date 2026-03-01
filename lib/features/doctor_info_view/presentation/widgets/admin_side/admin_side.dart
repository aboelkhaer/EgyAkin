import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/block_user_for_admin_side.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/verify_email_for_admin.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/verify_syndicate_card_for_admin.dart';
import '../../../../../app/services/theme_bloc.dart';

class AdminSide extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;

  const AdminSide(
      {super.key, required this.homeDataModel, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    DoctorInfoViewCubit cubit = DoctorInfoViewCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        // Check if user has viewYourPatients permission
        if (!PermissionHelper.canPermission(
            AppPermissions.viewAdminSideInProfiles)) {
          return const SizedBox.shrink();
        }

        return
            // homeDataModel.role == AppStrings.roleAdmin
            //     ?
            Stack(
          children: [
            AdminOnlyBadge(
              showBadge: true,
              style: BadgeStyle.premium,
              fontSize: 6.sp,
              badgePadding:
                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              showIcon: false,
              glowEffect: true,
              pulseAnimation: true,
              badgeText: 'A',
              top: 0,
              right: 105.w,
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 12.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${context.tr(AppStrings.age)}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : AppColors.title,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.age ?? context.tr(AppStrings.noData),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          '${context.tr(AppStrings.id)}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : AppColors.title,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.id.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          '${context.tr(AppStrings.joinUs)}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : AppColors.title,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          TimeAgoService.instance.formatTimeAgoFromString(
                              doctorInfo.data!.createdAt.toString(), context),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    VerifyEmailForAdmin(
                        homeDataModel: homeDataModel,
                        doctorInfo: doctorInfo,
                        isDarkMode: isDarkMode,
                        cubit: cubit),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          '${context.tr(AppStrings.registrationNumber)}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : AppColors.title,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.registrationNumber ??
                              context.tr(AppStrings.noData),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? AppColors.darkDescription
                                  : Colors.grey.shade600),
                        ),
                      ],
                    ),
                    VerifySyndicateCardForAdmin(
                        homeDataModel: homeDataModel,
                        doctorInfo: doctorInfo,
                        isDarkMode: isDarkMode,
                        cubit: cubit),
                    BlockUserForAdminSide(
                        homeDataModel: homeDataModel,
                        doctorInfo: doctorInfo,
                        isDarkMode: isDarkMode,
                        cubit: cubit),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: isDarkMode
                      ? AppColors.darkScaffoldBG
                      : Colors.grey.shade100,
                  child: Text(
                    context.tr(AppStrings.adminSide),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode ? AppColors.darkTitle : AppColors.title),
                  ),
                ),
              ),
            ),
          ],
        );
        // : const SizedBox.shrink();
      },
    );
  }
}
