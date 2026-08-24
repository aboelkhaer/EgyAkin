import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class ConsultationLockWidget extends StatefulWidget {
  final bool isLocked;
  final VoidCallback? onToggle;
  final bool isLoading;

  const ConsultationLockWidget({
    super.key,
    required this.isLocked,
    this.onToggle,
    this.isLoading = false,
  });

  @override
  State<ConsultationLockWidget> createState() => _ConsultationLockWidgetState();
}

class _ConsultationLockWidgetState extends State<ConsultationLockWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 220),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = HomeDashboardColors.primary(isDark);
    final accent =
        widget.isLocked ? HomeDashboardColors.danger : primary;
    final bg = widget.isLocked
        ? (isDark ? const Color(0xFF2A1515) : const Color(0xFFFFF1F1))
        : (isDark
            ? primary.withOpacity(0.14)
            : primary.withOpacity(0.08));
    final border = widget.isLocked
        ? (isDark ? const Color(0xFF7F2D2D) : const Color(0xFFFECACA))
        : (isDark
            ? primary.withOpacity(0.35)
            : primary.withOpacity(0.22));

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: widget.isLoading ? null : _handleTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: border),
            ),
            child: Row(
              children: [
                Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(isDark ? 0.25 : 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: widget.isLoading
                      ? Center(
                          child: SizedBox(
                            width: 14.w,
                            height: 14.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.8,
                              color: accent,
                            ),
                          ),
                        )
                      : Icon(
                          widget.isLocked
                              ? Icons.lock_rounded
                              : Icons.lock_open_rounded,
                          color: accent,
                          size: 16.sp,
                        ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isLocked
                            ? context.tr(AppStrings.consultationLocked)
                            : context.tr(AppStrings.consultationUnlocked),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        widget.isLocked
                            ? context.tr(AppStrings.unlockConsultation)
                            : context.tr(AppStrings.lockConsultation),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: accent.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!widget.isLoading)
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18.sp,
                    color: accent.withOpacity(0.8),
                    textDirection: Directionality.of(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    _animationController.forward().then((_) => _animationController.reverse());
    HapticFeedback.lightImpact();
    Future.delayed(const Duration(milliseconds: 120), () {
      widget.onToggle?.call();
    });
  }
}
