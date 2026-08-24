import '../../../exports.dart';

/// Label shown when a field value was applied from voice/AI analysis.
///
/// Use [compact] inline next to a field title (add-patient cards).
/// Default style sits above the control on other forms.
class AiFilledFieldBanner extends StatelessWidget {
  final bool compact;

  const AiFilledFieldBanner({
    super.key,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;

        final chip = Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 7.w : 8,
            vertical: compact ? 3.h : 4,
          ),
          decoration: BoxDecoration(
            color: primary.withOpacity(isDark ? 0.22 : 0.12),
            borderRadius: BorderRadius.circular(compact ? 20.r : 6),
            border: Border.all(
              color: primary.withOpacity(isDark ? 0.45 : 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: compact ? 11.sp : 14,
                color: primary,
              ),
              SizedBox(width: compact ? 4.w : 6),
              Text(
                context.tr(AppStrings.filledByAi),
                style: TextStyle(
                  fontSize: compact ? 9.5.sp : 11,
                  fontWeight: FontWeight.w600,
                  color: primary,
                  height: 1.1,
                ),
              ),
            ],
          ),
        );

        if (compact) return chip;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: chip,
          ),
        );
      },
    );
  }
}
