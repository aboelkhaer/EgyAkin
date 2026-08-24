import '../../../../exports.dart';
import '../../../../app/shared/functions/permissions_helper.dart';
import 'delete_patient_dialog.dart';

class FooterButtons extends StatelessWidget {
  final String doctorId;
  final String currentDoctorId;
  final String patientName;
  final String patientId;
  final bool finalSubmit;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final PatientSectionsCubit cubit;

  const FooterButtons({
    super.key,
    required this.doctorId,
    required this.currentDoctorId,
    required this.patientName,
    required this.cubit,
    required this.patientId,
    required this.finalSubmit,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
  });

  bool get _hideDelete =>
      finalSubmit &&
      !PermissionHelper.canPermission(
        AppPermissions.viewPatientsFinalSubmitAndDeleteContainerForAdmin,
      ) &&
      currentDoctorPoints < 200;

  bool get _deleteDisabled => PermissionHelper.canPermission(
        AppPermissions.deletePatientForAdmin,
      )
          ? false
          : doctorId != currentDoctorId;

  bool get _submitDisabled => PermissionHelper.canPermission(
            AppPermissions.finalSubmitPatientForAdmin,
          ) &&
          PermissionHelper.canPermission(AppPermissions.finalSubmitPatient)
      ? false
      : doctorId != currentDoctorId;

  bool get _reportDisabled =>
      !PermissionHelper.canPermission(AppPermissions.generatePatientPdf);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final barBg = isDark ? Colors.black : Colors.white;
        final topBorder =
            isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8E4F5);

        return Container(
          decoration: BoxDecoration(
            color: barBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
            border: Border(top: BorderSide(color: topBorder, width: 0.8)),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
          ),
          child: SafeArea(
            top: false,
            minimum: EdgeInsets.only(bottom: 8.h),
            child: Padding(
              padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 2.h),
              child: Row(
                children: [
                  if (!_hideDelete) ...[
                    Expanded(
                      flex: 34,
                      child: _DeleteButton(
                        isDark: isDark,
                        isDisabled: _deleteDisabled,
                        onPressed: () async {
                          final hasPermission =
                              await PermissionHelper.hasPermission(
                            AppPermissions.deletePatient,
                          );

                          if (!context.mounted) return;

                          if (hasPermission) {
                            showDeletePatientDialog(
                              context: context,
                              onConfirmDelete: () {
                                cubit.deletePatient(patientId);
                              },
                            );
                          } else {
                            showCustomDialog(
                              context: context,
                              title: context.tr(AppStrings.attention),
                              description: context.tr(
                                AppStrings
                                    .youDontHavePermissionToDeletePatients,
                              ),
                              coloredButtonText: context.tr(AppStrings.ok),
                              coloredButtonOnTap: () =>
                                  Navigator.of(context).pop(),
                              isNoColorShow: false,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                  Expanded(
                    flex: 66,
                    child: finalSubmit
                        ? _PrimaryActionButton(
                            isDark: isDark,
                            title: context.tr(AppStrings.requestReport),
                            subtitle: context.tr(
                              AppStrings.generatePatientPdfReport,
                            ),
                            isDisabled: _reportDisabled,
                            onPressed: () {
                              cubit.downloadPatientReport(patientId);
                            },
                          )
                        : _PrimaryActionButton(
                            isDark: isDark,
                            title: context.tr(AppStrings.finalSubmit),
                            subtitle: context.tr(
                              AppStrings.submitCompletedRecord,
                            ),
                            isDisabled: _submitDisabled,
                            onPressed: () async {
                              final hasPermission =
                                  await PermissionHelper.hasPermission(
                                AppPermissions.finalSubmitPatient,
                              );

                              if (!context.mounted) return;

                              if (hasPermission) {
                                cubit.finalSubmit(patientId, context);
                              } else {
                                showCustomDialog(
                                  context: context,
                                  title: context.tr(AppStrings.attention),
                                  description: context.tr(
                                    AppStrings
                                        .youDontHavePermissionToFinalSubmitPatients,
                                  ),
                                  coloredButtonText: context.tr(AppStrings.ok),
                                  coloredButtonOnTap: () =>
                                      Navigator.of(context).pop(),
                                  isNoColorShow: false,
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final bool isDark;
  final bool isDisabled;
  final VoidCallback onPressed;

  const _DeleteButton({
    required this.isDark,
    required this.isDisabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const danger = Color(0xFFEF4444);
    final bg = isDark ? const Color(0xFF2A1515) : const Color(0xFFFFE8E8);
    final border = isDark ? const Color(0xFF7F2D2D) : const Color(0xFFF5A0A0);

    return Opacity(
      opacity: isDisabled ? 0.45 : 1,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: border, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete_outline_rounded, size: 16.sp, color: danger),
                SizedBox(width: 5.w),
                Text(
                  context.tr(AppStrings.delete),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: danger,
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

class _PrimaryActionButton extends StatelessWidget {
  final bool isDark;
  final String title;
  final String subtitle;
  final bool isDisabled;
  final VoidCallback onPressed;

  const _PrimaryActionButton({
    required this.isDark,
    required this.title,
    required this.subtitle,
    required this.isDisabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            colors: [Color(0xFF6B47E6), Color(0xFF5B6CFF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6B47E6).withOpacity(isDark ? 0.45 : 0.32),
              blurRadius: isDark ? 18 : 14,
              spreadRadius: isDark ? 0.5 : 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isDisabled ? null : onPressed,
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 6.h, 7.w, 6.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
