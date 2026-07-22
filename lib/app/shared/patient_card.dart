import 'dart:ui' as ui;
import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import '../../exports.dart';

class PatientCard extends StatelessWidget {
  final String patientName;
  final String drFirstName;
  final String drLastName;
  final bool isAllDataOpen;
  final VoidCallback onTap;
  final String updatedAt;
  final String hospital;
  final VoidCallback onOutcomeTap;
  final VoidCallback onAddCommentTap;
  final String isSyndicateCardRequired;
  final String? doctorImage;
  final bool isOutcomeStatus;
  final String doctorId;
  final bool submitStatus;
  final double width;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;
  const PatientCard({
    super.key,
    required this.patientName,
    required this.drFirstName,
    required this.drLastName,
    required this.isAllDataOpen,
    required this.onAddCommentTap,
    required this.isOutcomeStatus,
    required this.hospital,
    required this.onOutcomeTap,
    required this.submitStatus,
    required this.updatedAt,
    required this.onTap,
    required this.doctorImage,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Stack(
          children: [
            Card(
              color: isDarkMode ? AppColors.darkCardBG : Colors.white,
              elevation: 0.8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: isDarkMode ? AppColors.darkSubBG : AppColors.subBG,
                onTap: onTap,
                child: Container(
                  width: width,
                  height: 130.h,
                  color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                  padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ) +
                      EdgeInsets.only(top: 10.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 9,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: GestureDetector(
                                onTap: () async {
                                  // Check permission before navigating to doctor info view
                                  final hasPermission =
                                      await PermissionHelper.hasPermission(
                                    AppPermissions.viewDoctorProfile,
                                  );

                                  if (!hasPermission &&
                                      currentDoctorModel.id.toString() !=
                                          doctorId) {
                                    // User doesn't have permission - show permission denied dialog
                                    showCustomDialog(
                                      context: context,
                                      title: context.tr(AppStrings.attention),
                                      description: context.tr(AppStrings
                                          .youDontHavePermissionToViewDoctorProfiles),
                                      coloredButtonText:
                                          context.tr(AppStrings.ok),
                                      coloredButtonOnTap: () =>
                                          navigatorKey.currentState?.pop(),
                                      isNoColorShow: false,
                                    );
                                  } else {
                                    // User has permission - navigate to doctor info view
                                    navigatorKey.currentState?.pushNamed(
                                      AppRoutes.doctorInfoView,
                                      arguments:
                                          AppRoutesArgs.doctorInfoViewRouteArgs(
                                        doctorId: doctorId,
                                        currentDoctorModel: currentDoctorModel,
                                        isSyndicateCardRequired:
                                            isSyndicateCardRequired,
                                        accountVerification:
                                            accountVerification,
                                        currentDoctorRole: currentDoctorRole,
                                        currentDoctorPoints:
                                            currentDoctorPoints,
                                        homeDataModel: homeDataModel,
                                        initialIndex: 0,
                                        isNavigateToTheButtonOfInformationTab:
                                            false,
                                      ),
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: isDarkMode
                                      ? AppColors.darkPrimary.withOpacity(0.8)
                                      : AppColors.primary.withOpacity(0.8),
                                  child: doctorImage == null
                                      ? Text(
                                          drFirstName[0].toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        )
                                      : CustomCachedNetworkImage(
                                          imageUrl: doctorImage.toString(),
                                          height: 100.h,
                                          width: 100.w,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              (currentDoctorModel.id
                                                              .toString() ==
                                                          doctorId ||
                                                      PermissionHelper
                                                          .canPermission(
                                                              AppPermissions
                                                                  .viewPatientsName))
                                                  ? patientName
                                                  : isAllDataOpen
                                                      ? patientName
                                                      : convertTextToSymbols(
                                                          patientName),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? AppColors.darkTitle
                                                    : AppColors.title,
                                              ),
                                              textDirection:
                                                  RegExp(r'[\u0600-\u06FF]')
                                                          .hasMatch(patientName)
                                                      ? ui.TextDirection.rtl
                                                      : ui.TextDirection.ltr,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            TimeAgoService.instance
                                                .formatTimeAgoFromString(
                                              updatedAt,
                                              context,
                                            ),
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? AppColors.darkDescription
                                                  : AppColors.description,
                                              fontSize: 10,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      drFirstName == ''
                                          ? const SizedBox.shrink()
                                          : const SizedBox(height: 4),
                                      drFirstName == ''
                                          ? const SizedBox.shrink()
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 0),
                                                    child: Text(
                                                      doctorName(
                                                        firstName: drFirstName
                                                            .toString(),
                                                        lastName: drLastName
                                                            .toString(),
                                                        role:
                                                            isSyndicateCardRequired,
                                                      ),
                                                      style: TextStyle(
                                                        color: isDarkMode
                                                            ? AppColors
                                                                .darkDescription
                                                            : AppColors
                                                                .description,
                                                        fontSize: 13,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                if (isSyndicateCardRequired ==
                                                    'Verified')
                                                  const SizedBox(width: 4),
                                                if (isSyndicateCardRequired ==
                                                    'Verified')
                                                  const VerificationIcon(
                                                    isPatientCard: true,
                                                  ),
                                              ],
                                            ),
                                      drFirstName == ''
                                          ? const SizedBox.shrink()
                                          : const SizedBox(height: 4),
                                      Text(
                                        hospital,
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkDescription
                                              : AppColors.description,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 8.h),
                      Divider(
                        color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 8.h),
                              margin: EdgeInsets.only(top: 0.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30.h,
                                      child: isOutcomeStatus
                                          ? CustomOutlineBotton(
                                              onPressed: onOutcomeTap,
                                              title: context
                                                  .tr(AppStrings.outcome),
                                            )
                                          // TextButton(
                                          //     onPressed: onOutcomeTap,
                                          //     style: ButtonStyle(
                                          //       overlayColor:
                                          //           MaterialStateProperty.all(
                                          //               Colors.transparent),
                                          //     ),
                                          //     child: const Text(AppStrings.outcome),
                                          //   )
                                          : CustomElevatedButton(
                                              onPressed: onOutcomeTap,
                                              title: context
                                                  .tr(AppStrings.outcome),
                                              isDisable: !submitStatus,
                                              // isDisable:
                                              //     isOutcomeStatus && !submitStatus ? false : true,
                                            ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: SizedBox(
                                      // height: 40,
                                      height: 30.h,
                                      child: CustomElevatedButton(
                                        onPressed: onAddCommentTap,
                                        title:
                                            context.tr(AppStrings.addComment),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: context.currentLocale?.languageCode != 'ar' ? 4.w : null,
              left: context.currentLocale?.languageCode != 'ar' ? null : 4.w,
              top: 2.h,
              child: Icon(
                submitStatus
                    ? AppIcons.isFinalSubmit
                    : AppIcons.isFinalNotSubmit,
                color: submitStatus
                    ? (isDarkMode
                        ? AppColors.darkPrimary.withOpacity(0.7)
                        : AppColors.primary.withOpacity(0.7))
                    : Colors.amber,
              ),
            ),
          ],
        );
      },
    );
  }
}
