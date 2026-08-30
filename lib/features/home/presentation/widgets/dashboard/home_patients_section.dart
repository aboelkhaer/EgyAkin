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
  final VoidCallback? onAddPatient;
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
    this.onAddPatient,
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
        if (preview.isEmpty)
          _EmptyPatientsCard(
            isDark: widget.isDark,
            onAddPatient: widget.onAddPatient,
          )
        else
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
          ),
      ],
    );
  }
}

class _EmptyPatientsCard extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onAddPatient;

  const _EmptyPatientsCard({
    required this.isDark,
    this.onAddPatient,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final title = HomeDashboardColors.title(isDark);
    final subtitle = HomeDashboardColors.subtitle(isDark);
    final canAdd = onAddPatient != null;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  primary.withOpacity(0.18),
                  HomeDashboardColors.cardBg(isDark),
                  primary.withOpacity(0.08),
                ]
              : [
                  primary.withOpacity(0.1),
                  Colors.white,
                  primary.withOpacity(0.04),
                ],
        ),
        border: Border.all(
          color: primary.withOpacity(isDark ? 0.32 : 0.18),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: primary.withOpacity(0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        children: [
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary.withOpacity(isDark ? 0.42 : 0.28),
                  primary.withOpacity(isDark ? 0.16 : 0.1),
                ],
              ),
              border: Border.all(
                color: primary.withOpacity(isDark ? 0.45 : 0.22),
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(isDark ? 0.28 : 0.16),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              Icons.person_add_alt_1_rounded,
              size: 28.sp,
              color: primary,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            context.tr(AppStrings.noPatientsYet),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: title,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            context.tr(AppStrings.addFirstPatientSubtitle),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: subtitle,
            ),
          ),
          if (canAdd) ...[
            SizedBox(height: 16.h),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAddPatient,
                borderRadius: BorderRadius.circular(14.r),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primary,
                        Color.lerp(
                              primary,
                              isDark
                                  ? const Color(0xFF1F2937)
                                  : const Color(0xFF4C1D95),
                              0.22,
                            ) ??
                            primary,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(isDark ? 0.35 : 0.28),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 28.r,
                          height: 28.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            size: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Flexible(
                          child: Text(
                            context.tr(AppStrings.addYourFirstPatient),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
