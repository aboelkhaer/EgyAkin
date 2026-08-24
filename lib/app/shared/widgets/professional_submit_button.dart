import 'package:egy_akin/exports.dart';

/// Sticky submit bar matching the add-patient footer pattern.
class ProfessionalSubmitBar extends StatelessWidget {
  final bool isDark;
  final bool isLoading;
  final VoidCallback? onPressed;
  final String? label;
  final String? subtitle;

  const ProfessionalSubmitBar({
    super.key,
    required this.isDark,
    required this.isLoading,
    required this.onPressed,
    this.label,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          border: Border(
            top: BorderSide(
              width: 1,
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : const Color(0xFFE8E8EE),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.06),
              blurRadius: 14,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          minimum: EdgeInsets.only(bottom: 4.h),
          child: ProfessionalSubmitButton(
            isDark: isDark,
            isLoading: isLoading,
            onPressed: onPressed,
            label: label,
            subtitle: subtitle,
          ),
        ),
      ),
    );
  }
}

class ProfessionalSubmitButton extends StatelessWidget {
  final bool isDark;
  final bool isLoading;
  final VoidCallback? onPressed;
  final String? label;
  final String? subtitle;

  const ProfessionalSubmitButton({
    super.key,
    required this.isDark,
    required this.isLoading,
    required this.onPressed,
    this.label,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final primary = isDark ? const Color(0xFF6D4CDB) : AppColors.primary;
    final title = label ?? context.tr(AppStrings.submit);
    final hint = subtitle ?? 'Save your answers and continue';
    final enabled = !isLoading && onPressed != null;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 8.h),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: primary.withOpacity(isDark ? 0.22 : 0.12),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: primary.withOpacity(0.28)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 16.r,
                height: 16.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Submitting…',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 2.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onPressed!();
                }
              : null,
          borderRadius: BorderRadius.circular(18.r),
          child: Ink(
            height: 44.h,
            decoration: BoxDecoration(
              color: enabled ? primary : primary.withOpacity(0.45),
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: enabled
                  ? [
                      BoxShadow(
                        color: primary.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(14.w, 0, 8.w, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.05,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          hint,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.88),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 15.sp,
                      color: Colors.white,
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
