import 'package:egy_akin/features/notification/presentation/widgets/notification_tile.dart';

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

  const CheckNotificationType({
    super.key,
    required this.notificationModel,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.isDarkMode,
  });

  Color get _accent =>
      isDarkMode ? AppColors.darkPrimary : AppColors.primary;

  void _openDoctorInfo({
    required String doctorId,
    required int initialIndex,
    required bool isNavigateToTheButtonOfInformationTab,
  }) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorId,
        initialIndex: initialIndex,
        currentDoctorModel: currentDoctorModel,
        isSyndicateCardRequired: isSyndicateCardRequired,
        accountVerification: accountVerification,
        currentDoctorRole: currentDoctorRole,
        currentDoctorPoints: currentDoctorPoints,
        homeDataModel: homeDataModel,
        isNavigateToTheButtonOfInformationTab:
            isNavigateToTheButtonOfInformationTab,
      ),
    );
  }

  Widget _doctorAvatar({
    required String? imageUrl,
    required String? firstName,
  }) {
    return NotificationAvatar(
      imageUrl: imageUrl,
      initial: firstName,
      accent: _accent,
    );
  }

  Widget _tile({
    required VoidCallback? onTap,
    Widget? avatar,
    VoidCallback? onAvatarTap,
    IconData? fallbackIcon,
  }) {
    return NotificationTile(
      isDarkMode: isDarkMode,
      isRead: notificationModel.read ?? true,
      content: notificationModel.content ?? '',
      createdAt: notificationModel.createdAt?.toString(),
      avatar: avatar,
      onTap: onTap,
      onAvatarTap: onAvatarTap,
      fallbackIcon: fallbackIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (notificationModel.type) {
      case AppStrings.newPatient:
        final doctor = notificationModel.patient?.doctor;
        return _tile(
          avatar: _doctorAvatar(
            imageUrl: doctor?.image?.toString(),
            firstName: doctor?.firstName,
          ),
          onAvatarTap: doctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: doctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: false,
                  ),
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
        );

      case 'Consultation':
        final doctor = notificationModel.typeDoctor;
        return _tile(
          avatar: _doctorAvatar(
            imageUrl: doctor?.image?.toString(),
            firstName: doctor?.firstName,
          ),
          onAvatarTap: doctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: doctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: false,
                  ),
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
        );

      case 'Achievement':
        final doctor = notificationModel.typeDoctor;
        return _tile(
          fallbackIcon: Icons.emoji_events_rounded,
          avatar: _doctorAvatar(
            imageUrl: doctor?.image?.toString(),
            firstName: doctor?.firstName,
          ),
          onAvatarTap: doctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: doctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: false,
                  ),
          onTap: () {
            if (currentDoctorModel.id.toString() ==
                notificationModel.typeDoctor!.id.toString()) {
              showCustomBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => DoctorInfoViewCubit(
                      sl(),
                      sl(),
                      sl(),
                      sl(),
                      sl(),
                      sl(),
                    ),
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
              _openDoctorInfo(
                doctorId: notificationModel.typeDoctor!.id.toString(),
                initialIndex: 1,
                isNavigateToTheButtonOfInformationTab: false,
              );
            }
          },
        );

      case AppStrings.comment:
        final doctor = notificationModel.typeDoctor;
        return _tile(
          avatar: _doctorAvatar(
            imageUrl: doctor?.image?.toString(),
            firstName: notificationModel.patient?.doctor?.firstName ??
                doctor?.firstName,
          ),
          onAvatarTap: doctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: doctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: false,
                  ),
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
        );

      case AppStrings.outcome:
        return _tile(
          fallbackIcon: Icons.flag_rounded,
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
        );

      case 'Other':
        final typeDoctor = notificationModel.typeDoctor;
        final patientDoctor = notificationModel.patient?.doctor;
        final imageUrl =
            (typeDoctor?.image ?? patientDoctor?.image)?.toString();
        final firstName = typeDoctor?.firstName ?? patientDoctor?.firstName;
        return _tile(
          avatar: _doctorAvatar(
            imageUrl: imageUrl,
            firstName: firstName,
          ),
          onAvatarTap: typeDoctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: typeDoctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: false,
                  ),
          onTap: () {},
        );

      case 'Syndicate Card':
        final doctor = notificationModel.typeDoctor;
        return _tile(
          avatar: _doctorAvatar(
            imageUrl: doctor?.image?.toString(),
            firstName: doctor?.firstName,
          ),
          onAvatarTap: doctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: doctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: true,
                  ),
          onTap: () {
            _openDoctorInfo(
              doctorId: notificationModel.typeDoctor!.id.toString(),
              initialIndex: 0,
              isNavigateToTheButtonOfInformationTab: true,
            );
          },
        );

      case 'Post':
      case 'PostLike':
      case 'PostComment':
      case 'CommentLike':
        final doctor = notificationModel.typeDoctor;
        return _tile(
          avatar: _doctorAvatar(
            imageUrl: doctor?.image?.toString(),
            firstName: doctor?.firstName,
          ),
          onAvatarTap: doctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: doctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: true,
                  ),
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
        );

      case 'group_invitation':
      case 'group_invitation_accepted':
      case 'group_join_request':
        final doctor = notificationModel.typeDoctor;
        return _tile(
          fallbackIcon: Icons.groups_rounded,
          avatar: _doctorAvatar(
            imageUrl: doctor?.image?.toString(),
            firstName: doctor?.firstName,
          ),
          onAvatarTap: doctor?.id == null
              ? null
              : () => _openDoctorInfo(
                    doctorId: doctor!.id.toString(),
                    initialIndex: 0,
                    isNavigateToTheButtonOfInformationTab: true,
                  ),
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
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
