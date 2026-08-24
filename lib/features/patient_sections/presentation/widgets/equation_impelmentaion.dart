import '../../../../exports.dart';

class EquationImplementation extends StatelessWidget {
  final String equationName;
  final String? currentCreatinineValue;
  final String? basalCreatinineValue;
  final String? creatinineOnDischargeValue;
  final String? currentCreatinineLocalization;
  final String? basalCreatinineLocalization;
  final String? creatinineOnDischargeLocalization;

  const EquationImplementation({
    super.key,
    required this.equationName,
    this.currentCreatinineValue,
    this.basalCreatinineValue,
    this.creatinineOnDischargeValue,
    this.currentCreatinineLocalization,
    this.basalCreatinineLocalization,
    this.creatinineOnDischargeLocalization,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final cardBg = isDark ? AppColors.darkCardBG : Colors.white;
        final titleColor = isDark ? AppColors.darkTitle : const Color(0xFF111827);
        final labelColor =
            isDark ? AppColors.darkDescription : const Color(0xFF6B7280);
        final headerBg = isDark
            ? AppColors.darkPrimary.withOpacity(0.18)
            : const Color(0xFFEDE7FF);
        final border = isDark ? AppColors.darkBorder : const Color(0xFFE8E4F5);

        return Container(
          width: 190.w,
          margin: EdgeInsets.only(right: 10.w),
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                color: headerBg,
                child: Text(
                  equationName.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    color: isDark ? AppColors.darkPrimary : AppColors.primary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _EqRow(
                      label: currentCreatinineLocalization ??
                          context.tr(AppStrings.currentGfr),
                      value: currentCreatinineValue ?? '—',
                      labelColor: labelColor,
                      valueColor: titleColor,
                    ),
                    SizedBox(height: 5.h),
                    _EqRow(
                      label: basalCreatinineLocalization ??
                          context.tr(AppStrings.basalCrGfr),
                      value: basalCreatinineValue ?? '—',
                      labelColor: labelColor,
                      valueColor: titleColor,
                    ),
                    SizedBox(height: 5.h),
                    _EqRow(
                      label: creatinineOnDischargeLocalization ??
                          context.tr(AppStrings.dischargeGfr),
                      value: creatinineOnDischargeValue ?? '—',
                      labelColor: labelColor,
                      valueColor: titleColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EqRow extends StatelessWidget {
  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;

  const _EqRow({
    required this.label,
    required this.value,
    required this.labelColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: labelColor,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 10.5.sp,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
