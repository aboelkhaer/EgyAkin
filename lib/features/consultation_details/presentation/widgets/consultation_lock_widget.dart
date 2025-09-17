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
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _updateColorAnimation();
  }

  void _updateColorAnimation() {
    _colorAnimation = ColorTween(
      begin: widget.isLocked
          ? Colors.red.withOpacity(0.8)
          : AppColors.primary.withOpacity(0.8),
      end: widget.isLocked ? Colors.red : AppColors.primary,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(ConsultationLockWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLocked != widget.isLocked) {
      _updateColorAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.isLocked
              ? [
                  Colors.red.withOpacity(0.1),
                  Colors.red.withOpacity(0.05),
                ]
              : [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: widget.isLocked
                ? Colors.red.withOpacity(0.15)
                : AppColors.primary.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isLoading ? null : _handleTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Lock Icon with Animation
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: _colorAnimation.value,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _colorAnimation.value!.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: widget.isLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              )
                            : Icon(
                                widget.isLocked ? Icons.lock : Icons.lock_open,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                      ),

                      SizedBox(width: 12.w),

                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isLocked
                                  ? context.tr(AppStrings.consultationLocked)
                                  : context.tr(AppStrings.consultationUnlocked),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: widget.isLocked
                                    ? Colors.red
                                    : AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              widget.isLocked
                                  ? context.tr(AppStrings.unlockConsultation)
                                  : context.tr(AppStrings.lockConsultation),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: widget.isLocked
                                    ? Colors.red.withOpacity(0.7)
                                    : AppColors.primary.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Arrow Icon
                      if (!widget.isLoading)
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            color: _colorAnimation.value,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Add haptic feedback
    HapticFeedback.lightImpact();

    // Call the callback after a short delay
    Future.delayed(const Duration(milliseconds: 150), () {
      widget.onToggle?.call();
    });
  }
}
