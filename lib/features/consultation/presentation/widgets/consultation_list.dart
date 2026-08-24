import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class ConsultationList extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool isReceivedConsultation;
  final bool isDarkMode;
  final List<GetCurrentDoctorConsultationModelResponse> consultations;

  const ConsultationList({
    super.key,
    required this.consultations,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.isReceivedConsultation,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDarkMode);
    final titleColor = HomeDashboardColors.title(isDarkMode);
    final muted = HomeDashboardColors.subtitle(isDarkMode);

    if (consultations.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 80.h),
          Center(
            child: Column(
              children: [
                Icon(
                  isReceivedConsultation
                      ? Icons.inbox_outlined
                      : Icons.outbox_outlined,
                  size: 36.sp,
                  color: muted,
                ),
                SizedBox(height: 10.h),
                Text(
                  context.tr(AppStrings.noConsultationsYet),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isReceivedConsultation
                      ? context.tr(
                          AppStrings.receivedConsultationsWillAppearHere,
                        )
                      : context.tr(
                          AppStrings.sentConsultationsWillAppearHere,
                        ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: consultations.length,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 50.h),
      itemBuilder: (context, index) {
        final consult = consultations[index];
        final isOpen = consult.isOpen ?? false;
        final isMine =
            currentDoctorModel.id.toString() == consult.doctorId.toString();

        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Material(
            color: HomeDashboardColors.cardBg(isDarkMode),
            borderRadius: BorderRadius.circular(16.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () {
                navigatorKey.currentState?.pushNamed(
                  AppRoutes.consultationDetails,
                  arguments: AppRoutesArgs.consultationDetailsRouteArgs(
                    homeDataModel: homeDataModel,
                    currentDoctorModel: currentDoctorModel,
                    patientName: consult.patientName.toString(),
                    consultationId: consult.id.toString(),
                    isReceivedConsultation: isReceivedConsultation,
                    isOpen: isOpen,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: HomeDashboardColors.border(isDarkMode),
                  ),
                  boxShadow: isDarkMode
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.doctorInfoView,
                              arguments:
                                  AppRoutesArgs.doctorInfoViewRouteArgs(
                                initialIndex: 0,
                                doctorId: consult.doctorId.toString(),
                                currentDoctorModel: currentDoctorModel,
                                isSyndicateCardRequired: homeDataModel
                                    .isSyndicateCardRequired
                                    .toString(),
                                accountVerification: homeDataModel.verified!,
                                currentDoctorRole: homeDataModel.role!,
                                currentDoctorPoints: int.parse(
                                  homeDataModel.scoreValue.toString(),
                                ),
                                homeDataModel: homeDataModel,
                                isNavigateToTheButtonOfInformationTab: false,
                              ),
                            );
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary.withOpacity(0.15),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CustomCachedNetworkImage(
                              imageUrl: consult.image.toString(),
                              height: 40.w,
                              width: 40.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      doctorName(
                                        firstName: consult.doctorFirstName,
                                        lastName: consult.doctorLastName,
                                        role:
                                            consult.isSyndicateCard.toString(),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isMine
                                            ? const Color(0xFF22C55E)
                                            : titleColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                  if (consult.isSyndicateCard ==
                                      'Verified') ...[
                                    SizedBox(width: 4.w),
                                    const VerificationIcon(duration: 300),
                                  ],
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${consult.consultMessage}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.5.sp,
                                  height: 1.35,
                                  color: muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _StatusBadge(
                          isDark: isDarkMode,
                          isOpen: isOpen,
                          openLabel: context.tr(AppStrings.opened),
                          closedLabel: context.tr(AppStrings.closed),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? HomeDashboardColors.surfaceBg(isDarkMode)
                            : primary.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 14.sp,
                            color: primary,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              '${context.tr(AppStrings.thePatient)}: ${consult.patientName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 12.sp,
                          color: muted,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          TimeAgoService.instance.formatTimeAgoFromString(
                            consult.createdAt.toString(),
                            context,
                          ),
                          style: TextStyle(
                            color: muted,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 18.sp,
                          color: muted,
                          textDirection: Directionality.of(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isDark;
  final bool isOpen;
  final String openLabel;
  final String closedLabel;

  const _StatusBadge({
    required this.isDark,
    required this.isOpen,
    required this.openLabel,
    required this.closedLabel,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        isOpen ? const Color(0xFF22C55E) : const Color(0xFFEF4444);

    return Tooltip(
      message: isOpen ? openLabel : closedLabel,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.18 : 0.12),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isOpen ? Icons.lock_open_rounded : Icons.lock_rounded,
              size: 12.sp,
              color: color,
            ),
            SizedBox(width: 4.w),
            Text(
              isOpen ? openLabel : closedLabel,
              style: TextStyle(
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
