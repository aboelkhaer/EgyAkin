import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class SelectedDoctorsStrip extends StatelessWidget {
  final bool isDark;
  final List<DoctorModelInConsultationModelResponse> doctors;
  final ScrollController? scrollController;
  final bool Function(DoctorModelInConsultationModelResponse doctor)
      canRemove;
  final void Function(DoctorModelInConsultationModelResponse doctor) onRemove;
  final void Function(DoctorModelInConsultationModelResponse doctor) onTap;

  const SelectedDoctorsStrip({
    super.key,
    required this.isDark,
    required this.doctors,
    required this.canRemove,
    required this.onRemove,
    required this.onTap,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) return const SizedBox.shrink();

    final primary = HomeDashboardColors.primary(isDark);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(AppStrings.selected),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 44.h,
          child: ListView.separated(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: doctors.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              final name =
                  capitalizeFirstText(doctor.firstName?.toString() ?? '');
              final removable = canRemove(doctor);

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTap(doctor),
                  borderRadius: BorderRadius.circular(22.r),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        6.w, 4.h, removable ? 6.w : 12.w, 4.h),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(isDark ? 0.18 : 0.1),
                      borderRadius: BorderRadius.circular(22.r),
                      border: Border.all(
                        color: primary.withOpacity(isDark ? 0.35 : 0.22),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _DoctorAvatar(
                          doctor: doctor,
                          radius: 14,
                          isDark: isDark,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '${context.tr(AppStrings.doctorPrefix)} $name',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: HomeDashboardColors.title(isDark),
                          ),
                        ),
                        if (removable) ...[
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () => onRemove(doctor),
                            child: Container(
                              width: 22.r,
                              height: 22.r,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HomeDashboardColors.danger
                                    .withOpacity(0.12),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                size: 14.sp,
                                color: HomeDashboardColors.danger,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  final DoctorModelInConsultationModelResponse doctor;
  final double radius;
  final bool isDark;

  const _DoctorAvatar({
    required this.doctor,
    required this.radius,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final initial = (doctor.firstName?.isNotEmpty == true)
        ? doctor.firstName![0].toUpperCase()
        : 'D';
    final primary = HomeDashboardColors.primary(isDark);

    if (doctor.image == null || doctor.image.toString().isEmpty) {
      return HomeInitialsAvatar(initials: initial, radius: radius);
    }

    return CircleAvatar(
      radius: radius.r,
      backgroundColor: primary.withOpacity(0.15),
      child: ClipOval(
        child: CustomCachedNetworkImage(
          imageUrl: doctor.image.toString(),
          height: radius.r * 2,
          width: radius.r * 2,
        ),
      ),
    );
  }
}
