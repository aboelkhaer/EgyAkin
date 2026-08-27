import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

/// Reads data.pending_consultations straight from the homeNew payload —
/// that list is already scoped server-side to this doctor's unanswered
/// consultations on open threads (consultation_doctors.status = 'not
/// replied' AND is_open = true), so no separate request and no client-side
/// re-filtering is needed here.
class HomeConsultationsSection extends StatelessWidget {
  static const int _maxVisible = 3;

  final bool isDark;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const HomeConsultationsSection({
    super.key,
    required this.isDark,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  void _openConsultationList() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.consultation,
      arguments: AppRoutesArgs.consultationRouteArgs(
        homeDataModel: homeDataModel,
        currentDoctorModel: currentDoctorModel,
        initialTab: 1, // Received
      ),
    );
  }

  void _openConsultationDetails(
    GetCurrentDoctorConsultationModelResponse consult,
  ) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.consultationDetails,
      arguments: AppRoutesArgs.consultationDetailsRouteArgs(
        homeDataModel: homeDataModel,
        currentDoctorModel: currentDoctorModel,
        patientName: consult.patientName?.toString() ?? '',
        consultationId: consult.id?.toString() ?? '',
        isReceivedConsultation: true,
        isOpen: consult.isOpen ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending = homeDataModel.data?.pendingConsultations ??
        const <GetCurrentDoctorConsultationModelResponse>[];
    final pendingCount = int.tryParse(
          homeDataModel.pendingConsultationCount ?? '',
        ) ??
        pending.length;

    if (pending.isEmpty && pendingCount <= 0) {
      return const SizedBox.shrink();
    }

    final visible = pending.take(_maxVisible).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        HomeSectionHeader(
          title: context.tr(AppStrings.pendingConsultations),
          isDark: isDark,
          badgeCount: pendingCount,
          actionLabel: context.tr(AppStrings.viewAll),
          onAction: _openConsultationList,
        ),
        SizedBox(height: 10.h),
        ...visible.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _ConsultationCard(
              isDark: isDark,
              item: item,
              onTap: () => _openConsultationDetails(item),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  final bool isDark;
  final GetCurrentDoctorConsultationModelResponse item;
  final VoidCallback onTap;

  const _ConsultationCard({
    required this.isDark,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final name = doctorName(
      firstName: item.doctorFirstName,
      lastName: item.doctorLastName,
      role: item.isSyndicateCard?.toString() ?? '',
    );
    final workplace = (item.workingplace ?? '').trim();
    final message = (item.consultMessage ?? '').trim();
    final patient = (item.patientName ?? '').trim();
    final imageUrl = (item.image ?? '').trim();
    final timeLabel = TimeAgoService.instance.formatTimeAgoFromString(
      item.createdAt?.toString() ?? '',
      context,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.all(11.w),
          decoration: HomeDashboardDecor.card(isDark),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary.withOpacity(0.15),
                ),
                clipBehavior: Clip.antiAlias,
                child: imageUrl.isNotEmpty
                    ? CustomCachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 36.r,
                        width: 36.r,
                      )
                    : Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 18.sp,
                          color: primary,
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
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: HomeDashboardColors.title(isDark),
                            ),
                          ),
                        ),
                        Text(
                          timeLabel,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: HomeDashboardColors.subtitle(isDark),
                          ),
                        ),
                      ],
                    ),
                    if (workplace.isNotEmpty) ...[
                      SizedBox(height: 3.h),
                      Text(
                        workplace,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                    ],
                    if (message.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ],
                    if (patient.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        '${context.tr(AppStrings.thePatient)}: $patient',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.chevron_right_rounded,
                size: 18.sp,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
