import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';
import 'invite_external_doctor_dialog.dart';

class SelectedDoctorsStrip extends StatelessWidget {
  final bool isDark;
  final List<DoctorModelInConsultationModelResponse> doctors;
  final List<PendingExternalInvite> emailInvites;
  final ScrollController? scrollController;
  final bool Function(DoctorModelInConsultationModelResponse doctor)
      canRemove;
  final void Function(DoctorModelInConsultationModelResponse doctor) onRemove;
  final void Function(DoctorModelInConsultationModelResponse doctor) onTap;
  final ValueChanged<String>? onRemoveEmail;

  const SelectedDoctorsStrip({
    super.key,
    required this.isDark,
    required this.doctors,
    required this.canRemove,
    required this.onRemove,
    required this.onTap,
    this.emailInvites = const [],
    this.onRemoveEmail,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final total = doctors.length + emailInvites.length;
    final isEmpty = total == 0;

    return AnimatedSize(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: isEmpty
          ? const SizedBox(width: double.infinity)
          : Column(
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: total,
                    separatorBuilder: (_, __) => SizedBox(width: 8.w),
                    itemBuilder: (context, index) {
                      if (index < doctors.length) {
                        final doctor = doctors[index];
                        return _AppearChip(
                          key: ValueKey('doctor_${doctor.id}'),
                          child: _DoctorChip(
                            isDark: isDark,
                            primary: primary,
                            doctor: doctor,
                            canRemove: canRemove(doctor),
                            onTap: () => onTap(doctor),
                            onRemove: () => onRemove(doctor),
                          ),
                        );
                      }

                      final invite = emailInvites[index - doctors.length];
                      return _AppearChip(
                        key: ValueKey('email_${invite.email.toLowerCase()}'),
                        child: _EmailChip(
                          isDark: isDark,
                          primary: primary,
                          email: invite.email,
                          onRemove: onRemoveEmail == null
                              ? null
                              : () => onRemoveEmail!(invite.email),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
    );
  }
}

class _AppearChip extends StatefulWidget {
  final Widget child;

  const _AppearChip({
    super.key,
    required this.child,
  });

  @override
  State<_AppearChip> createState() => _AppearChipState();
}

class _AppearChipState extends State<_AppearChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0.18, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}

class _DoctorChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final DoctorModelInConsultationModelResponse doctor;
  final bool canRemove;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _DoctorChip({
    required this.isDark,
    required this.primary,
    required this.doctor,
    required this.canRemove,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final name = capitalizeFirstText(doctor.firstName?.toString() ?? '');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Container(
          padding: EdgeInsets.fromLTRB(6.w, 4.h, canRemove ? 6.w : 12.w, 4.h),
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
              if (canRemove) ...[
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 22.r,
                    height: 22.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HomeDashboardColors.danger.withOpacity(0.12),
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
  }
}

class _EmailChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String email;
  final VoidCallback? onRemove;

  const _EmailChip({
    required this.isDark,
    required this.primary,
    required this.email,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(6.w, 4.h, onRemove != null ? 6.w : 12.w, 4.h),
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
          Container(
            width: 28.r,
            height: 28.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primary.withOpacity(isDark ? 0.28 : 0.16),
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              size: 14.sp,
              color: primary,
            ),
          ),
          SizedBox(width: 6.w),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 160.w),
            child: Text(
              email,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
          ),
          if (onRemove != null) ...[
            SizedBox(width: 4.w),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 22.r,
                height: 22.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HomeDashboardColors.danger.withOpacity(0.12),
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
