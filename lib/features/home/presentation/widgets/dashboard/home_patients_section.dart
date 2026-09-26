import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';

import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomePatientsSection extends StatefulWidget {
  final bool isDark;
  final List<PatientHomeDataModel> myPatients;
  final List<PatientHomeDataModel> allPatients;
  final int? myPatientsCount;
  final int? allPatientsCount;
  final VoidCallback? onSeeAll;
  final void Function(
    PatientHomeDataModel patient, {
    required bool isAllDataOpen,
  })? onPatientTap;
  final void Function(
    PatientHomeDataModel patient, {
    required bool isAllDataOpen,
  })? onOutcomeTap;
  final void Function(
    PatientHomeDataModel patient, {
    required bool isAllDataOpen,
  })? onAddCommentTap;

  const HomePatientsSection({
    super.key,
    required this.isDark,
    required this.myPatients,
    required this.allPatients,
    this.myPatientsCount,
    this.allPatientsCount,
    this.onSeeAll,
    this.onPatientTap,
    this.onOutcomeTap,
    this.onAddCommentTap,
  });

  @override
  State<HomePatientsSection> createState() => _HomePatientsSectionState();
}

class _HomePatientsSectionState extends State<HomePatientsSection> {
  bool _showMyPatients = true;

  bool get _canViewAllPatients =>
      PermissionHelper.canPermission(AppPermissions.viewAllPatients);

  @override
  Widget build(BuildContext context) {
    final showMyOnly = !_canViewAllPatients || _showMyPatients;
    final patients = showMyOnly ? widget.myPatients : widget.allPatients;
    final preview = patients.take(5).toList();
    final myCount = widget.myPatientsCount ?? widget.myPatients.length;
    final allCount = widget.allPatientsCount ?? widget.allPatients.length;
    final activeCount = showMyOnly ? myCount : allCount;
    // Create-first is never shown on Home. Skip the whole section when the
    // account has no patients yet (add via header + / Patients tab).
    final trulyNoPatients = activeCount <= 0 && patients.isEmpty;
    if (trulyNoPatients) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeader(
          title: context.tr(AppStrings.patients),
          isDark: widget.isDark,
          // Without "view all patients", show my-patients count next to the
          // title (same pattern as pending consultations) and hide the toggle.
          badgeCount: _canViewAllPatients ? null : myCount,
          actionLabel: context.tr(AppStrings.viewAll),
          onAction: widget.onSeeAll,
        ),
        if (_canViewAllPatients) ...[
          SizedBox(height: 12.h),
          HomePatientsToggle(
            isDark: widget.isDark,
            showMyPatients: showMyOnly,
            myPatientsCount: myCount,
            allPatientsCount: allCount,
            showAllPatientsTab: true,
            onChanged: (value) => setState(() => _showMyPatients = value),
          ),
        ],
        SizedBox(height: 12.h),
        if (preview.isNotEmpty)
          ...preview.map(
            (patient) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: HomePatientCard(
                isDark: widget.isDark,
                patient: patient,
                onTap: widget.onPatientTap == null
                    ? null
                    : () => widget.onPatientTap!(
                          patient,
                          isAllDataOpen: !showMyOnly,
                        ),
                onOutcomeTap: widget.onOutcomeTap == null
                    ? null
                    : () => widget.onOutcomeTap!(
                          patient,
                          isAllDataOpen: !showMyOnly,
                        ),
                onAddCommentTap: widget.onAddCommentTap == null
                    ? null
                    : () => widget.onAddCommentTap!(
                          patient,
                          isAllDataOpen: !showMyOnly,
                        ),
              ),
            ),
          )
        else
          _ViewPatientsCard(
            isDark: widget.isDark,
            count: activeCount,
            onViewAll: widget.onSeeAll,
          ),
      ],
    );
  }
}

class _ViewPatientsCard extends StatelessWidget {
  final bool isDark;
  final int count;
  final VoidCallback? onViewAll;

  const _ViewPatientsCard({
    required this.isDark,
    required this.count,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final title = HomeDashboardColors.title(isDark);
    final subtitle = HomeDashboardColors.subtitle(isDark);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onViewAll,
        borderRadius: BorderRadius.circular(18.r),
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: HomeDashboardColors.cardBg(isDark),
            border: Border.all(
              color: primary.withOpacity(isDark ? 0.28 : 0.14),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary.withOpacity(isDark ? 0.22 : 0.12),
                ),
                child: Icon(
                  Icons.groups_rounded,
                  size: 22.sp,
                  color: primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(AppStrings.viewAll),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: title,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      count > 0
                          ? '$count ${context.tr(AppStrings.patients).toLowerCase()}'
                          : context.tr(AppStrings.patients),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 22.sp,
                color: subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
