import 'dart:developer';

import 'package:egy_akin/features/notification/presentation/widgets/achievement_check.dart';

import '../../../../exports.dart';
import 'package:timeago/timeago.dart' as timeago;

class CheckNotificationType extends StatelessWidget {
  final NotificationsModel notificationModel;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final String isSyndicateCardRequired;
  final HomeModelResponse homeDataModel;

  const CheckNotificationType(
      {super.key,
      required this.notificationModel,
      required this.currentDoctorModel,
      required this.accountVerification,
      required this.isSyndicateCardRequired,
      required this.currentDoctorRole,
      required this.currentDoctorPoints,
      required this.homeDataModel});

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
                                      text:
                                          'Dr. ${capitalizeFirstText(notificationModel.patient!.doctor!.firstName!)}',
                                      style: TextStyle(
                                          color: AppColors.title,
                                          fontSize: 12.sp),
                                      children: <TextSpan>[
                                        const TextSpan(
                                          text: ' creates ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const TextSpan(text: 'a new patient '),
                                        const TextSpan(
                                            text: ' at ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                '${notificationModel.patient!.hospital}'),
                                      ],
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
                                  timeago
                                      .format(DateTime.parse(notificationModel
                                          .createdAt
                                          .toString()))
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
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
                  notificationModel.read!
                      ? const SizedBox.shrink()
                      : Positioned(
                          left: 0,
                          // right: 0.w,
                          // top: 2.h,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5.r,
                          ),
                        ),
                ],
              ),
              const Divider(
                color: Colors.grey,
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
              ),
            );
            // navigatorKey.currentState?.pushNamed(
            //   AppRoutes.patientSections,
            //   arguments: AppRoutesArgs.patientSectionsRouteArguments(
            //     patientId: notificationModel.patient!.id.toString(),
            //     currentDoctorRole: currentDoctorRole,
            //     currentDoctorPoints: currentDoctorPoints,
            //     currentDoctorModel: currentDoctorModel,
            //     homeDataModel: homeDataModel,
            //   ),
            // );
            // context.read<NotificationCubit>().getAllNotifications();
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
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  initialIndex: 0,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
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
                                      text:
                                          'Dr. ${capitalizeFirstText(notificationModel.patient!.doctor!.firstName!)}',
                                      style: TextStyle(
                                          color: AppColors.title,
                                          fontSize: 12.sp),
                                      children: <TextSpan>[
                                        const TextSpan(
                                          text: ' is seeking your advice ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const TextSpan(text: 'for his patient'),
                                        const TextSpan(
                                            text: ' : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                '${notificationModel.patient!.name}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
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
                                  timeago
                                      .format(DateTime.parse(notificationModel
                                          .createdAt
                                          .toString()))
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
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
                  notificationModel.read!
                      ? const SizedBox.shrink()
                      : Positioned(
                          left: 0,
                          // right: 0.w,
                          // top: 2.h,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5.r,
                          ),
                        ),
                ],
              ),
              const Divider(
                color: Colors.grey,
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
                notificationModel.patient!.doctor!.id.toString()) {
              showCustomBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => DoctorInfoViewCubit(sl(), sl()),
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
                  doctorId: notificationModel.patient!.doctor!.id.toString(),
                  currentDoctorModel: currentDoctorModel,
                  isSyndicateCardRequired: isSyndicateCardRequired,
                  accountVerification: accountVerification,
                  currentDoctorRole: currentDoctorRole,
                  currentDoctorPoints: currentDoctorPoints,
                  homeDataModel: homeDataModel,
                  initialIndex: 1,
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
                                  doctorId: notificationModel
                                      .patient!.doctor!.id
                                      .toString(),
                                  currentDoctorModel: currentDoctorModel,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  accountVerification: accountVerification,
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorPoints: currentDoctorPoints,
                                  homeDataModel: homeDataModel,
                                  initialIndex: 0,
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
                                AchievementCheck(
                                  currentDoctorRole: currentDoctorRole,
                                  currentDoctorId:
                                      currentDoctorModel.id.toString(),
                                  notificationDoctorId: notificationModel
                                      .patient!.doctor!.id
                                      .toString(),
                                  notificationDoctorName: notificationModel
                                      .patient!.doctor!.firstName
                                      .toString(),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  timeago
                                      .format(DateTime.parse(notificationModel
                                          .createdAt
                                          .toString()))
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
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
                  notificationModel.read!
                      ? const SizedBox.shrink()
                      : Positioned(
                          left: 0,
                          // right: 0.w,
                          // top: 2.h,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5.r,
                          ),
                        ),
                ],
              ),
              const Divider(
                color: Colors.grey,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: 'On the linked patient, someone has made a ',
                        style:
                            TextStyle(color: AppColors.title, fontSize: 12.sp),
                        children: const <TextSpan>[
                          TextSpan(
                            text: '${AppStrings.comment}.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
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
                    timeago
                        .format(DateTime.parse(
                            notificationModel.createdAt.toString()))
                        .toString(),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 8.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
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
                doctorId: notificationModel.patient!.doctor!.id.toString(),
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
                        text: 'On the linked patient, someone has made an ',
                        style:
                            TextStyle(color: AppColors.title, fontSize: 12.sp),
                        children: const <TextSpan>[
                          TextSpan(
                            text: '${AppStrings.outcome}.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
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
                    timeago
                        .format(DateTime.parse(
                            notificationModel.createdAt.toString()))
                        .toString(),
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

      default:
        return Container();
    }
  }
}
