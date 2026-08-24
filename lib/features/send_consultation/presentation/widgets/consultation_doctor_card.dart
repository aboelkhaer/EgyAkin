import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class ConsultationDoctorCard extends StatelessWidget {
  final bool isDark;
  final DoctorModelInConsultationModelResponse doctor;
  final bool isSelected;
  final bool isExistingMember;
  final bool selectionEnabled;
  final bool isCurrentUser;
  final VoidCallback onOpenProfile;
  final ValueChanged<bool>? onSelectionChanged;

  const ConsultationDoctorCard({
    super.key,
    required this.isDark,
    required this.doctor,
    required this.isSelected,
    required this.isExistingMember,
    required this.selectionEnabled,
    required this.onOpenProfile,
    this.isCurrentUser = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final checked = isSelected || isExistingMember;
    final name = doctorName(
      firstName: doctor.firstName,
      lastName: doctor.lastName,
      role: doctor.isSyndicateCardRequired.toString(),
    );
    final email = doctor.email?.toString() ?? '';
    final specialty = doctor.specialty?.toString().trim() ?? '';
    final initial = (doctor.firstName?.isNotEmpty == true)
        ? doctor.firstName![0].toUpperCase()
        : 'D';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onOpenProfile,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          decoration: HomeDashboardDecor.card(isDark).copyWith(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: checked && !isCurrentUser
                  ? primary.withOpacity(isDark ? 0.55 : 0.4)
                  : HomeDashboardColors.border(isDark).withOpacity(0.7),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                if (doctor.image == null || doctor.image.toString().isEmpty)
                  HomeInitialsAvatar(initials: initial, radius: 20)
                else
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: primary.withOpacity(0.15),
                    child: ClipOval(
                      child: CustomCachedNetworkImage(
                        imageUrl: doctor.image.toString(),
                        height: 40.r,
                        width: 40.r,
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
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                          ),
                          if (doctor.isSyndicateCardRequired.toString() ==
                              'Verified')
                            const VerificationIcon(
                              duration: 0,
                              isSmaller: true,
                            ),
                        ],
                      ),
                      if (email.isNotEmpty) ...[
                        SizedBox(height: 3.h),
                        Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: HomeDashboardColors.subtitle(isDark),
                          ),
                        ),
                      ],
                      if (specialty.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          specialty,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                      ],
                      if (isExistingMember && !isCurrentUser) ...[
                        SizedBox(height: 4.h),
                        Text(
                          context.tr(AppStrings.alreadyInConsultation),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: HomeDashboardColors.success,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                if (isCurrentUser)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: HomeDashboardColors.surfaceBg(isDark),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: HomeDashboardColors.border(isDark),
                      ),
                    ),
                    child: Text(
                      context.tr(AppStrings.you),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  )
                else
                  _SelectionControl(
                    isDark: isDark,
                    checked: checked,
                    enabled: selectionEnabled && onSelectionChanged != null,
                    onChanged: onSelectionChanged,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionControl extends StatelessWidget {
  final bool isDark;
  final bool checked;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  const _SelectionControl({
    required this.isDark,
    required this.checked,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return GestureDetector(
      onTap: !enabled ? null : () => onChanged?.call(!checked),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 26.r,
        height: 26.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: checked ? primary : Colors.transparent,
          border: Border.all(
            color: checked ? primary : HomeDashboardColors.border(isDark),
            width: 1.6,
          ),
        ),
        child: checked
            ? Icon(Icons.check_rounded, size: 16.sp, color: Colors.white)
            : null,
      ),
    );
  }
}
