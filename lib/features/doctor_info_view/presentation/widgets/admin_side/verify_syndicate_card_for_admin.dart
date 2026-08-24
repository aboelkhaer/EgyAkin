import 'package:egy_akin/features/doctor_info_view/presentation/widgets/admin_side/admin_action_card.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../../exports.dart';

class VerifySyndicateCardForAdmin extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;
  final bool isDarkMode;
  final DoctorInfoViewCubit cubit;

  const VerifySyndicateCardForAdmin({
    super.key,
    required this.homeDataModel,
    required this.doctorInfo,
    required this.isDarkMode,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final status = doctorInfo.data!.isSyndicateCardRequired?.toString() ??
        context.tr(AppStrings.noData);
    final hasCard = doctorInfo.data!.syndicateCard != null;
    final isPending = doctorInfo.data!.isSyndicateCardRequired == 'Pending';
    final primary = HomeDashboardColors.primary(isDarkMode);

    return PermissionGuard(
      permission: AppPermissions.verifySyndicateCard,
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: AdminActionCard(
          isDark: isDarkMode,
          icon: Icons.verified_user_outlined,
          accent: const Color(0xFF14B8A6),
          title: context.tr(AppStrings.syndicateCardStatus),
          subtitle: status,
          value: cubit.isSyndicateCardVerified,
          onChanged: (_) {
            cubit.changeSyndicateCardStatus(doctorInfo.data!.id.toString());
          },
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    context.tr(AppStrings.syndicateCard).replaceAll(':', ''),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: HomeDashboardColors.title(isDarkMode),
                    ),
                  ),
                  const Spacer(),
                  if (isPending)
                    TextButton(
                      onPressed: () {
                        cubit.rejectSyndicateCard(
                          doctorInfo.data!.id.toString(),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: HomeDashboardColors.danger,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        context.tr(AppStrings.reject),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              if (!hasCard)
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: HomeDashboardColors.surfaceBg(isDarkMode),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: HomeDashboardColors.border(isDarkMode)
                          .withOpacity(0.8),
                    ),
                  ),
                  child: Text(
                    context.tr(AppStrings.noSyndicateCard),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: HomeDashboardColors.subtitle(isDarkMode),
                    ),
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      FullScreenImage.route(
                        imageUrl: doctorInfo.data!.syndicateCard.toString(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Stack(
                      children: [
                        CustomCachedNetworkImage(
                          imageUrl: doctorInfo.data!.syndicateCard.toString(),
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 8.w,
                          bottom: 8.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.55),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.zoom_in_rounded,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  context.tr(AppStrings.view),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 3.h,
                            color: primary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
