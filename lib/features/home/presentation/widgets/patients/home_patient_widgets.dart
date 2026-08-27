import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/home_dashboard_shared.dart';

class HomePatientsToggle extends StatelessWidget {
  final bool isDark;
  final bool showMyPatients;
  final int myPatientsCount;
  final int allPatientsCount;
  final ValueChanged<bool> onChanged;
  final bool showAllPatientsTab;

  const HomePatientsToggle({
    super.key,
    required this.isDark,
    required this.showMyPatients,
    required this.myPatientsCount,
    required this.allPatientsCount,
    required this.onChanged,
    this.showAllPatientsTab = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showAllPatientsTab) {
      return _MyPatientsOnlyHeader(
        isDark: isDark,
        count: myPatientsCount,
      );
    }

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: HomeDashboardColors.surfaceBg(isDark),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _PatientTabChip(
              label: context.tr(AppStrings.myPatients),
              count: myPatientsCount,
              isSelected: showMyPatients,
              isDark: isDark,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _PatientTabChip(
              label: context.tr(AppStrings.allPatients),
              count: allPatientsCount,
              isSelected: !showMyPatients,
              isDark: isDark,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyPatientsOnlyHeader extends StatelessWidget {
  final bool isDark;
  final int count;

  const _MyPatientsOnlyHeader({
    required this.isDark,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final titleColor = HomeDashboardColors.title(isDark);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: primary.withOpacity(isDark ? 0.14 : 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: primary.withOpacity(isDark ? 0.24 : 0.16),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: primary.withOpacity(isDark ? 0.22 : 0.14),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.people_alt_rounded,
              size: 16.sp,
              color: primary,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              context.tr(AppStrings.myPatients),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: primary.withOpacity(isDark ? 0.28 : 0.18),
              ),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientTabChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _PatientTabChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? primary : primary.withOpacity(0.15))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? (isDark ? Colors.white : primary)
                    : HomeDashboardColors.subtitle(isDark),
              ),
            ),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark
                        ? Colors.white.withOpacity(0.2)
                        : primary.withOpacity(0.2))
                    : HomeDashboardColors.border(isDark),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? (isDark ? Colors.white : primary)
                      : HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePatientCard extends StatelessWidget {
  final bool isDark;
  final PatientHomeDataModel patient;
  final VoidCallback? onTap;
  final VoidCallback? onOutcomeTap;
  final VoidCallback? onAddCommentTap;
  final VoidCallback? onDoctorTap;

  const HomePatientCard({
    super.key,
    required this.isDark,
    required this.patient,
    this.onTap,
    this.onOutcomeTap,
    this.onAddCommentTap,
    this.onDoctorTap,
  });

  Future<void> _openDoctorProfile(BuildContext context) async {
    if (onDoctorTap != null) {
      onDoctorTap!();
      return;
    }

    final doctorId = patient.doctor?.id?.toString();
    if (doctorId == null || doctorId.isEmpty) return;

    HomeCubit homeCubit;
    try {
      homeCubit = context.read<HomeCubit>();
    } catch (_) {
      homeCubit = sl<HomeCubit>();
    }

    final homeData = homeCubit.homeDataModel;
    final currentDoctor = homeCubit.currentDoctorModel;
    final isOwnProfile = currentDoctor.id.toString() == doctorId;

    final hasPermission = await PermissionHelper.hasPermission(
      AppPermissions.viewDoctorProfile,
    );

    if (!context.mounted) return;

    if (!hasPermission && !isOwnProfile) {
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description: context.tr(
          AppStrings.youDontHavePermissionToViewDoctorProfiles,
        ),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => navigatorKey.currentState?.pop(),
        isNoColorShow: false,
      );
      return;
    }

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorId,
        currentDoctorModel: currentDoctor,
        isSyndicateCardRequired: homeData.isSyndicateCardRequired ?? '',
        accountVerification: homeData.verified ?? false,
        currentDoctorRole: homeData.role.toString(),
        currentDoctorPoints: int.tryParse(homeData.scoreValue ?? '0') ?? 0,
        homeDataModel: homeData,
        initialIndex: 0,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final isDone = patient.sections?.submitStatus == true;
    final needsOutcome = patient.sections?.outcomeStatus == true;
    final accent = needsOutcome && !isDone
        ? HomeDashboardColors.danger
        : (isDone
            ? HomeDashboardColors.success
            : HomeDashboardColors.warning);
    final name = _patientName(patient);
    final doctorName = _doctorName(patient);
    final canOpenDoctor = doctorName.isNotEmpty &&
        (onDoctorTap != null ||
            (patient.doctor?.id?.toString().isNotEmpty ?? false));
    final hospital = patient.hospital?.trim() ?? '';
    final updatedRaw = (patient.updatedAt?.trim().isNotEmpty ?? false)
        ? patient.updatedAt
        : patient.sectionsLastUpdatedAt;
    final updatedLabel = (updatedRaw == null || updatedRaw.trim().isEmpty)
        ? ''
        : TimeAgoService.instance.formatTimeAgoFromString(
            updatedRaw,
            context,
          );

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: HomeDashboardDecor.card(isDark).copyWith(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 5.w,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(11.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeInitialsAvatar(
                              initials: _initialsFromName(name),
                              radius: 16,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: HomeDashboardColors.title(isDark),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    [
                                      if (patient.age != null)
                                        '${_formatCompactNum(patient.age!)}y',
                                      if (patient.id != null) '#${patient.id}',
                                      if (hospital.isNotEmpty) hospital,
                                    ].join(' · '),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color:
                                          HomeDashboardColors.subtitle(isDark),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: (isDone
                                        ? HomeDashboardColors.success
                                        : HomeDashboardColors.warning)
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isDone
                                        ? Icons.check_circle_rounded
                                        : Icons.schedule_rounded,
                                    size: 12.sp,
                                    color: isDone
                                        ? HomeDashboardColors.success
                                        : HomeDashboardColors.warning,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    isDone
                                        ? context.tr(AppStrings.done)
                                        : context.tr(AppStrings.pending),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDone
                                          ? HomeDashboardColors.success
                                          : HomeDashboardColors.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: HomeDashboardColors.surfaceBg(isDark),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: _PatientMetricsRow(
                              isDark: isDark,
                              egfr: patient.egfr ?? 0,
                              egfrPrevious: patient.egfrPrevious,
                              bmi: patient.bmi,
                            ),
                          ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: canOpenDoctor
                              ? () => _openDoctorProfile(context)
                              : null,
                          child: Row(
                            children: [
                              Icon(
                                Icons.medical_services_outlined,
                                size: 14.sp,
                                color: canOpenDoctor
                                    ? primary
                                    : HomeDashboardColors.subtitle(isDark),
                              ),
                              SizedBox(width: 4.w),
                              Flexible(
                                child: Text(
                                  doctorName.isEmpty ? '—' : doctorName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: canOpenDoctor
                                        ? primary
                                        : HomeDashboardColors.title(isDark),
                                  ),
                                ),
                              ),
                              if (patient.doctor?.isSyndicateCardRequired ==
                                  'Verified')
                                const VerificationIcon(
                                  duration: 0,
                                  isSmaller: true,
                                ),
                              if (updatedLabel.isNotEmpty)
                                Text(
                                  ' · $updatedLabel',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color:
                                        HomeDashboardColors.subtitle(isDark),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 34.h,
                                child: _OutcomeButton(
                                  isDark: isDark,
                                  isOutcomeCompleted:
                                      patient.sections?.outcomeStatus == true,
                                  isSectionsSubmitted: isDone,
                                  onPressed: onOutcomeTap ?? onTap,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: SizedBox(
                                height: 34.h,
                                child: ElevatedButton(
                                  onPressed: onAddCommentTap ?? onTap,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  child: Text(
                                    context.tr(AppStrings.addComment),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OutcomeButton extends StatelessWidget {
  final bool isDark;
  final bool isOutcomeCompleted;
  final bool isSectionsSubmitted;
  final VoidCallback? onPressed;

  const _OutcomeButton({
    required this.isDark,
    required this.isOutcomeCompleted,
    required this.isSectionsSubmitted,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final labelStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
    );

    // Completed outcome → outline. Incomplete → filled primary (disabled until
    // sections are submitted), matching the classic patient card.
    if (isOutcomeCompleted) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: HomeDashboardColors.title(isDark),
          side: BorderSide(color: HomeDashboardColors.border(isDark)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(context.tr(AppStrings.outcome), style: labelStyle),
      );
    }

    final enabled = isSectionsSubmitted;
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: primary.withOpacity(0.35),
        disabledForegroundColor: Colors.white.withOpacity(0.85),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(context.tr(AppStrings.outcome), style: labelStyle),
    );
  }
}

String _patientName(PatientHomeDataModel patient) {
  final name = patient.name?.trim();
  if (name != null && name.isNotEmpty) return name;
  return 'Patient #${patient.id ?? ''}';
}

String _formatCompactNum(num value) {
  if (value % 1 == 0) return value.toInt().toString();
  return value.toStringAsFixed(1);
}

class _PatientMetricsRow extends StatelessWidget {
  final bool isDark;
  final num egfr;
  final num? egfrPrevious;
  final num? bmi;

  const _PatientMetricsRow({
    required this.isDark,
    required this.egfr,
    required this.egfrPrevious,
    required this.bmi,
  });

  @override
  Widget build(BuildContext context) {
    final muted = HomeDashboardColors.subtitle(isDark);
    final previous = egfrPrevious ?? 0;
    final delta = egfr - previous;
    final egfrUp = delta > 0;
    final egfrFlat = delta == 0;
    final rowColor = egfrFlat
        ? HomeDashboardColors.title(isDark)
        : (egfrUp
            ? HomeDashboardColors.success
            : HomeDashboardColors.danger);
    final deltaLabel = _formatCompactNum(delta.abs());
    final bmiValue = bmi ?? 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BMI',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: muted,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _formatCompactNum(bmiValue),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: rowColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EGFR',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: muted,
                  ),
                ),
                SizedBox(height: 4.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: _formatCompactNum(egfr),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: rowColor,
                        ),
                      ),
                      TextSpan(
                        text: ' mL/min',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: muted,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!egfrFlat) ...[
                  Transform.flip(
                    flipY: !egfrUp,
                    child: SvgPicture.asset(
                      AppImages.arrowTrend,
                      width: 18.r,
                      height: 18.r,
                      colorFilter: ColorFilter.mode(
                        rowColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                ],
                Flexible(
                  child: Text(
                    deltaLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: rowColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _doctorName(PatientHomeDataModel patient) {
  final first = patient.doctor?.firstName?.trim() ?? '';
  final last = patient.doctor?.lastName?.trim() ?? '';
  return '$first $last'.trim();
}

String _initialsFromName(String name) {
  final parts =
      name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return 'P';
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return ('${parts.first[0]}${parts.last[0]}').toUpperCase();
}

class PatientsListEmptyState extends StatelessWidget {
  final bool isDark;
  final bool isFiltered;
  final String? title;
  final String? subtitle;
  final String? hint;

  const PatientsListEmptyState({
    super.key,
    required this.isDark,
    this.isFiltered = false,
    this.title,
    this.subtitle,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final border = isDark
        ? Colors.white.withOpacity(0.06)
        : const Color(0xFFE8E8EE);

    final resolvedTitle = title ??
        (isFiltered
            ? context.tr(AppStrings.noMatchingPatients)
            : context.tr(AppStrings.noPatientsYet));
    final resolvedSubtitle = subtitle ??
        (isFiltered
            ? context.tr(AppStrings.nothingMatchesCurrentFilters)
            : context.tr(AppStrings.patientsWillShowOnceAdded));
    final resolvedHint = hint ??
        (isFiltered
            ? context.tr(AppStrings.useFilterIconToChangeCriteria)
            : context.tr(AppStrings.pullDownToRefreshThisList));

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88.r,
              height: 88.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primary.withOpacity(isDark ? 0.28 : 0.16),
                    primary.withOpacity(isDark ? 0.1 : 0.05),
                  ],
                ),
                border: Border.all(color: primary.withOpacity(0.22)),
              ),
              child: Icon(
                isFiltered
                    ? Icons.filter_alt_off_rounded
                    : Icons.people_outline_rounded,
                size: 36.sp,
                color: primary,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              resolvedTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              resolvedSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
                height: 1.45,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFiltered
                        ? Icons.tune_rounded
                        : Icons.person_add_alt_1_rounded,
                    size: 14.sp,
                    color: primary,
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      resolvedHint,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
