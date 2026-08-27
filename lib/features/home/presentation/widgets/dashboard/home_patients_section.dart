import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';

import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomePatientsSection extends StatefulWidget {
  final bool isDark;
  final List<PatientHomeDataModel> myPatients;
  final List<PatientHomeDataModel> allPatients;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeader(
          title: context.tr(AppStrings.patients),
          isDark: widget.isDark,
          actionLabel: context.tr(AppStrings.seeAllLower),
          onAction: widget.onSeeAll,
        ),
        SizedBox(height: 12.h),
        HomePatientsToggle(
          isDark: widget.isDark,
          showMyPatients: showMyOnly,
          myPatientsCount: widget.myPatients.length,
          allPatientsCount: widget.allPatients.length,
          showAllPatientsTab: _canViewAllPatients,
          onChanged: _canViewAllPatients
              ? (value) => setState(() => _showMyPatients = value)
              : (_) {},
        ),
        SizedBox(height: 12.h),
        if (preview.isEmpty)
          Container(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            alignment: Alignment.center,
            child: Text(
              context.tr(AppStrings.noPatientsYet),
              style: TextStyle(
                fontSize: 12.sp,
                color: HomeDashboardColors.subtitle(widget.isDark),
              ),
            ),
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
