import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_calculator_theme.dart';
import 'package:egy_akin/exports.dart';

/// Card shell for GFR calculator sections.
class GfrSectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GfrSectionCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GfrCalculatorTheme.of(context);

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.border),
        boxShadow: theme.cardShadow,
      ),
      child: child,
    );
  }
}

class GfrSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const GfrSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GfrCalculatorTheme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(theme.isDarkMode ? 0.2 : 0.12),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: theme.title,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.35,
                    color: theme.subtitle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Selectable option row (equation, gender, etc.).
class GfrSelectOption extends StatelessWidget {
  final String label;
  final String? subtitle;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const GfrSelectOption({
    super.key,
    required this.label,
    this.subtitle,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GfrCalculatorTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: selected ? theme.selectedFill : theme.surfaceBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? AppColors.primary : theme.borderStrong,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18.sp,
                  color: selected ? AppColors.primary : theme.subtitle,
                ),
                SizedBox(width: 10.w),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w600,
                        color: selected ? AppColors.primary : theme.title,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: theme.subtitle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: selected ? AppColors.primary : theme.borderStrong,
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact chip for biomarker / yes-no style choices.
class GfrChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const GfrChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GfrCalculatorTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : theme.cardBg,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: selected ? AppColors.primary : theme.borderStrong,
            ),
            boxShadow: !selected && !theme.isDarkMode
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : theme.title,
            ),
          ),
        ),
      ),
    );
  }
}

class GfrCalculatorHeroBanner extends StatelessWidget {
  const GfrCalculatorHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = GfrCalculatorTheme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.heroGradient,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.isDarkMode
              ? AppColors.primary.withOpacity(0.25)
              : theme.border,
        ),
        boxShadow: theme.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: theme.isDarkMode
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.white,
              shape: BoxShape.circle,
              border: theme.isDarkMode
                  ? null
                  : Border.all(color: theme.border),
              boxShadow: theme.isDarkMode
                  ? null
                  : [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Icon(
              Icons.water_drop_outlined,
              color: AppColors.primary,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(AppStrings.gfrCalculator),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: theme.title,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  context.tr(AppStrings.gfrCalculationDesc),
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.35,
                    color: theme.subtitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
