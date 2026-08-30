import '../../../../exports.dart';

class PatientBmiCard extends StatelessWidget {
  final num? bmi;
  final String? bmiCategory;

  const PatientBmiCard({
    super.key,
    required this.bmi,
    required this.bmiCategory,
  });

  static bool hasData({num? bmi, String? bmiCategory}) {
    if (bmi != null) return true;
    final category = bmiCategory?.trim() ?? '';
    return category.isNotEmpty;
  }

  Color _accentFor(String category, bool isDark) {
    final key = category.toLowerCase().trim();
    if (key.contains('under')) {
      return const Color(0xFF0EA5E9);
    }
    if (key.contains('over') || key.contains('preobese')) {
      return const Color(0xFFF59E0B);
    }
    if (key.contains('obes') || key.contains('severe')) {
      return const Color(0xFFEF4444);
    }
    if (key.contains('normal') || key.contains('healthy')) {
      return const Color(0xFF22C55E);
    }
    return isDark ? AppColors.darkPrimary : AppColors.primary;
  }

  String _prettyCategory(String? raw) {
    final value = raw?.trim() ?? '';
    if (value.isEmpty) return '—';
    return value
        .split(RegExp(r'[_\s]+'))
        .where((part) => part.isNotEmpty)
        .map((part) =>
            '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}')
        .join(' ');
  }

  String _bmiLabel(num? value) {
    if (value == null) return '—';
    final asDouble = value.toDouble();
    if (asDouble == asDouble.roundToDouble()) {
      return asDouble.toStringAsFixed(0);
    }
    return asDouble.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final category = bmiCategory?.trim() ?? '';
        final accent = _accentFor(category, isDark);
        final cardBg = isDark ? AppColors.darkCardBG : Colors.white;
        final titleColor =
            isDark ? AppColors.darkTitle : const Color(0xFF111827);
        final labelColor =
            isDark ? AppColors.darkDescription : const Color(0xFF6B7280);
        final border = isDark ? AppColors.darkBorder : const Color(0xFFE8E4F5);

        return Container(
          width: 168.w,
          margin: EdgeInsetsDirectional.only(end: 10.w),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: border),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                color: accent.withOpacity(isDark ? 0.2 : 0.12),
                child: Row(
                  children: [
                    Icon(
                      Icons.monitor_weight_outlined,
                      size: 12.sp,
                      color: accent,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      context.tr(AppStrings.bmiUpper),
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _bmiLabel(bmi),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 22.sp,
                          height: 1,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.6,
                          color: titleColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        context.tr(AppStrings.bodyMassIndex),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 9.5.sp,
                          height: 1.1,
                          fontWeight: FontWeight.w500,
                          color: labelColor,
                        ),
                      ),
                      const Spacer(flex: 1),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(isDark ? 0.18 : 0.1),
                          borderRadius: BorderRadius.circular(7.r),
                          border: Border.all(
                            color: accent.withOpacity(0.28),
                          ),
                        ),
                        child: Text(
                          _prettyCategory(category),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            color: accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
