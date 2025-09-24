import 'package:egy_akin/features/notification/presentation/widgets/achievement_check.dart';
import 'package:egy_akin/features/notification/presentation/widgets/unread_red_circle.dart';

import '../../../../exports.dart';

class CheckNotificationType extends StatelessWidget {
  final NotificationsModel notificationModel;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final String isSyndicateCardRequired;
  final HomeModelResponse homeDataModel;
  final bool isDarkMode;

  const CheckNotificationType(
      {super.key,
      required this.notificationModel,
      required this.currentDoctorModel,
      required this.accountVerification,
      required this.isSyndicateCardRequired,
      required this.currentDoctorRole,
      required this.currentDoctorPoints,
      required this.homeDataModel,
      required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    switch (notificationModel.type) {
      case AppStrings.newPatient:
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.patientSections,
              arguments: AppRoutesArgs.patientSectionsRouteArguments(
                patientId: notificationModel.patient!.id.toString(),
                currentDoctorRole: currentDoctorRole,
                currentDoctorPoints: currentDoctorPoints,
                currentDoctorModel: currentDoctorModel,
                homeDataModel: homeDataModel,
                isAllDataOpen: false,
              ),
            );
            context.read<NotificationCubit>().getAllNotifications();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel
                                      .patient!.doctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: false,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.patient!.doctor!.image ==
                                      null
                                  ? Text(
                                      notificationModel
                                          .patient!.doctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .patient!.doctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'Consultation':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.consultation,
              arguments: AppRoutesArgs.consultationRouteArgs(
                homeDataModel: homeDataModel,
                currentDoctorModel: currentDoctorModel,
                initialTab: 1,
              ),
            );
            navigatorKey.currentState?.pushNamed(
              AppRoutes.consultationDetails,
              arguments: AppRoutesArgs.consultationDetailsRouteArgs(
                homeDataModel: homeDataModel,
                currentDoctorModel: currentDoctorModel,
                patientName: notificationModel.patient!.name.toString(),
                consultationId: notificationModel.typeId.toString(),
                isReceivedConsultation: true,
                isOpen: notificationModel.isOpen ?? false,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  initialIndex: 0,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: false,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'Achievement':
        return GestureDetector(
          onTap: () {
            if (currentDoctorModel.id.toString() ==
                notificationModel.typeDoctor!.id.toString()) {
              showCustomBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        DoctorInfoViewCubit(sl(), sl(), sl(), sl(), sl(), sl()),
                    child: AchievementsTab(
                      isProfileFeature: true,
                      currentDoctorId: currentDoctorModel.id.toString(),
                    ),
                  );
                },
              );
            }
            if (currentDoctorModel.id.toString() !=
                notificationModel.patient!.doctor!.id.toString()) {
              navigatorKey.currentState?.pushNamed(
                AppRoutes.doctorInfoView,
                arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                  doctorId: notificationModel.typeDoctor!.id.toString(),
                  currentDoctorModel: currentDoctorModel,
                  isSyndicateCardRequired: isSyndicateCardRequired,
                  accountVerification: accountVerification,
                  currentDoctorRole: currentDoctorRole,
                  currentDoctorPoints: currentDoctorPoints,
                  homeDataModel: homeDataModel,
                  initialIndex: 1,
                  isNavigateToTheButtonOfInformationTab: false,
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
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
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // AchievementCheck(
                                //   currentDoctorRole:
                                //       homeDataModel.role.toString(),
                                //   currentDoctorId:
                                //       currentDoctorModel.id.toString(),
                                //   notificationDoctorId: notificationModel
                                //       .typeDoctor!.id
                                //       .toString(),
                                //   notificationDoctorName: notificationModel
                                //       .typeDoctor!.firstName
                                //       .toString(),
                                // )
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );

      case AppStrings.comment:
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.comments,
              arguments: AppRoutesArgs.patientCommentsRouteArgs(
                patientId: notificationModel.patient!.id.toString(),
                currentDoctorModel: currentDoctorModel,
                verified: accountVerification,
                patientName: notificationModel.patient!.name.toString(),
                homeDataModel: homeDataModel,
                currentDoctorPoints: currentDoctorPoints,
                isSyndicateCardRequired: isSyndicateCardRequired,
                currentDoctorRole: currentDoctorRole,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: false,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .patient!.doctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case AppStrings.outcome:
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.outcome,
              arguments: AppRoutesArgs.outcomeRouteArgs(
                verified: accountVerification,
                outcomeStatus:
                    notificationModel.patient!.sections!.outcomeStatus!,
                patientName: notificationModel.patient!.name.toString(),
                patientId: notificationModel.patient!.id.toString(),
                doctorId: notificationModel.typeDoctor!.id.toString(),
                currentDoctorModel: currentDoctorModel,
                isSyndicateCardRequired: isSyndicateCardRequired,
                homeDataModel: homeDataModel,
                currentDoctorRole: currentDoctorRole,
                currentDoctorPoints: currentDoctorPoints,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: notificationModel.content,
                        style: TextStyle(
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : AppColors.title,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    TimeAgoService.instance.formatTimeAgoFromString(
                      notificationModel.createdAt.toString(),
                      context,
                    ),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 8.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'Other':
        return GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: false,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor != null
                                  ? notificationModel.typeDoctor!.image == null
                                      ? Text(
                                          notificationModel
                                              .typeDoctor!.firstName![0]
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        )
                                      : CustomCachedNetworkImage(
                                          imageUrl: notificationModel
                                              .typeDoctor!.image
                                              .toString(),
                                          height: 100.h,
                                          width: 100.w,
                                        )
                                  : notificationModel.patient!.doctor!.image ==
                                          null
                                      ? Text(
                                          notificationModel
                                              .patient!.doctor!.firstName![0]
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        )
                                      : CustomCachedNetworkImage(
                                          imageUrl: notificationModel
                                              .patient!.doctor!.image
                                              .toString(),
                                          height: 100.h,
                                          width: 100.w,
                                        ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'Syndicate Card':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.doctorInfoView,
              arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                doctorId: notificationModel.typeDoctor!.id.toString(),
                initialIndex: 0,
                currentDoctorModel: currentDoctorModel,
                isSyndicateCardRequired: isSyndicateCardRequired,
                accountVerification: accountVerification,
                currentDoctorRole: currentDoctorRole,
                currentDoctorPoints: currentDoctorPoints,
                homeDataModel: homeDataModel,
                isNavigateToTheButtonOfInformationTab: true,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'Post':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.showSingleFeed,
              arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                homeDataModel: homeDataModel,
                currentDoctorModel: currentDoctorModel,
                feed: const PostCommunityModel(),
                isComeFromNotification: true,
                feedId: notificationModel.typeId.toString(),
                showPostFrom: ShowPostFromEnum.notification.name,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'PostLike':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.showSingleFeed,
              arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                homeDataModel: homeDataModel,
                currentDoctorModel: currentDoctorModel,
                feed: const PostCommunityModel(),
                isComeFromNotification: true,
                feedId: notificationModel.typeId.toString(),
                showPostFrom: ShowPostFromEnum.notification.name,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'PostComment':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.showSingleFeed,
              arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                homeDataModel: homeDataModel,
                currentDoctorModel: currentDoctorModel,
                feed: const PostCommunityModel(),
                isComeFromNotification: true,
                feedId: notificationModel.typeId.toString(),
                showPostFrom: ShowPostFromEnum.notification.name,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'CommentLike':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.showSingleFeed,
              arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                homeDataModel: homeDataModel,
                currentDoctorModel: currentDoctorModel,
                feed: const PostCommunityModel(),
                isComeFromNotification: true,
                feedId: notificationModel.typeId.toString(),
                showPostFrom: ShowPostFromEnum.notification.name,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'group_invitation':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.groupDetailsInCommunity,
              arguments: AppRoutesArgs.groupDetailsInCommunityRouteArgs(
                currentDoctorModel: currentDoctorModel,
                homeDataModel: homeDataModel,
                groupId: notificationModel.typeId.toString(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'group_invitation_accepted':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.groupDetailsInCommunity,
              arguments: AppRoutesArgs.groupDetailsInCommunityRouteArgs(
                currentDoctorModel: currentDoctorModel,
                homeDataModel: homeDataModel,
                groupId: notificationModel.typeId.toString(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      case 'group_join_request':
        return GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.groupDetailsInCommunity,
              arguments: AppRoutesArgs.groupDetailsInCommunityRouteArgs(
                currentDoctorModel: currentDoctorModel,
                homeDataModel: homeDataModel,
                groupId: notificationModel.typeId.toString(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                                  doctorId: notificationModel.typeDoctor!.id
                                      .toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  isNavigateToTheButtonOfInformationTab: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: notificationModel.typeDoctor!.image == null
                                  ? Text(
                                      notificationModel
                                          .typeDoctor!.firstName![0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: notificationModel
                                          .typeDoctor!.image
                                          .toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: notificationModel.content,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : AppColors.title,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    notificationModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.grey.shade500,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UnreadRedCircle(isRead: notificationModel.read!),
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.darkBorder : Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );

      default:
        return Container();
    }
  }
}
