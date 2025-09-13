import 'dart:ui' as ui;
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
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.white,
          elevation: 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: AppColors.subBG,
            onTap: onTap,
            child: Container(
              width: 300.w,
              height: 130.h,
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
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.doctorInfoView,
                                arguments:
                                    AppRoutesArgs.doctorInfoViewRouteArgs(
                                  doctorId: doctorId,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  initialIndex: 0,
                                  isNavigateToTheButtonOfInformationTab: false,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          (currentDoctorModel.id.toString() ==
                                                      doctorId ||
                                                  homeDataModel.role ==
                                                      AppStrings.roleAdmin)
                                              ? patientName
                                              : isAllDataOpen
                                                  ? patientName
                                                  : convertTextToSymbols(
                                                      patientName),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.title,
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
                                        style: const TextStyle(
                                          color: AppColors.description,
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
                                          children: [
                                            Text(
                                              doctorName(
                                                firstName:
                                                    drFirstName.toString(),
                                                lastName: drLastName.toString(),
                                                role: isSyndicateCardRequired,
                                              ),
                                              style: const TextStyle(
                                                color: AppColors.description,
                                                fontSize: 13,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            isSyndicateCardRequired ==
                                                    'Verified'
                                                ? const VerificationIcon(
                                                    isPatientCard: true,
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                  drFirstName == ''
                                      ? const SizedBox.shrink()
                                      : const SizedBox(height: 4),
                                  Text(
                                    hospital,
                                    style: const TextStyle(
                                      color: AppColors.description,
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
                  const Divider(),
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
                                          title: context.tr(AppStrings.outcome),
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
                                          title: context.tr(AppStrings.outcome),
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
                                    title: context.tr(AppStrings.addComment),
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
            submitStatus ? AppIcons.isFinalSubmit : AppIcons.isFinalNotSubmit,
            color: submitStatus
                ? AppColors.primary.withOpacity(0.7)
                : Colors.amber,
          ),
        ),
      ],
    );
  }
}
