import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeConsultationsSection extends StatefulWidget {
  final bool isDark;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  /// Bumps on home reload so this section refetches.
  final int reloadToken;

  const HomeConsultationsSection({
    super.key,
    required this.isDark,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.reloadToken,
  });

  @override
  State<HomeConsultationsSection> createState() =>
      _HomeConsultationsSectionState();
}

class _HomeConsultationsSectionState extends State<HomeConsultationsSection> {
  static const int _maxVisible = 3;

  bool _loading = true;
  List<GetCurrentDoctorConsultationModelResponse> _pending = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant HomeConsultationsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reloadToken != widget.reloadToken) {
      _load();
    }
  }

  Future<void> _load() async {
    if (mounted) {
      setState(() => _loading = true);
    }

    final result =
        await sl<GetReceivedConsultationUsecase>().execute(NoParams());
    if (!mounted) return;

    result.fold(
      (_) {
        setState(() {
          _loading = false;
          _pending = const [];
        });
      },
      (consultations) {
        final pending = consultations
            .where((c) => c.isOpen == true)
            .toList(growable: false);
        setState(() {
          _loading = false;
          _pending = pending;
        });
      },
    );
  }

  void _openConsultationList() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.consultation,
      arguments: AppRoutesArgs.consultationRouteArgs(
        homeDataModel: widget.homeDataModel,
        currentDoctorModel: widget.currentDoctorModel,
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
        homeDataModel: widget.homeDataModel,
        currentDoctorModel: widget.currentDoctorModel,
        patientName: consult.patientName?.toString() ?? '',
        consultationId: consult.id?.toString() ?? '',
        isReceivedConsultation: true,
        isOpen: consult.isOpen ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading && _pending.isEmpty) {
      return const SizedBox.shrink();
    }
    if (_pending.isEmpty) {
      return const SizedBox.shrink();
    }

    final visible = _pending.take(_maxVisible).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        HomeSectionHeader(
          title: context.tr(AppStrings.pendingConsultations),
          isDark: widget.isDark,
          badgeCount: _pending.length,
          actionLabel: context.tr(AppStrings.viewAll),
          onAction: _openConsultationList,
        ),
        SizedBox(height: 10.h),
        ...visible.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _ConsultationCard(
              isDark: widget.isDark,
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
