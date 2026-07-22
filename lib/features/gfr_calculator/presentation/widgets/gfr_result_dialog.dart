import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/utils/gfr_equation_formulas.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_calculator_theme.dart';

/// CKD GFR category (KDIGO) for display only.
String gfrCkdStageLabel(double egfr) {
  if (egfr >= 90) return 'G1';
  if (egfr >= 60) return 'G2';
  if (egfr >= 45) return 'G3a';
  if (egfr >= 30) return 'G3b';
  if (egfr >= 15) return 'G4';
  return 'G5';
}

Color gfrCkdStageColor(double egfr) {
  if (egfr >= 60) return Colors.green.shade600;
  if (egfr >= 30) return Colors.orange.shade700;
  return Colors.red.shade600;
}

Future<void> showGfrResultDialog({
  required BuildContext context,
  required String equationLabel,
  double? singleEgfr,
  List<NkfEgfrResultLine>? nkfResults,
}) {
  assert(singleEgfr != null || (nkfResults != null && nkfResults.isNotEmpty));

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final theme = GfrCalculatorTheme(
            themeState is ThemeLoaded && themeState.isDarkMode,
          );

          return Dialog(
            backgroundColor: theme.cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
              side: BorderSide(color: theme.border),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.analytics_outlined,
                          color: AppColors.primary,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          context.tr(AppStrings.gfrResult),
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                            color: theme.title,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        icon: Icon(
                          Icons.close,
                          size: 20.sp,
                          color: theme.subtitle,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  if (singleEgfr != null)
                    _SingleEgfrResultBody(
                      egfr: singleEgfr,
                      equationLabel: equationLabel,
                      theme: theme,
                    )
                  else if (nkfResults != null)
                    _NkfEgfrResultsBody(
                      results: nkfResults,
                      theme: theme,
                    ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      title: context.tr(AppStrings.ok),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class _SingleEgfrResultBody extends StatelessWidget {
  final double egfr;
  final String equationLabel;
  final GfrCalculatorTheme theme;

  const _SingleEgfrResultBody({
    required this.egfr,
    required this.equationLabel,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final stage = gfrCkdStageLabel(egfr);
    final stageColor = gfrCkdStageColor(egfr);
    final unit = context.tr(AppStrings.egfrUnitIndexed);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: theme.surfaceBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Text(
                context.tr(AppStrings.estimatedGfr),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: theme.subtitle,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                egfr.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: theme.subtitle,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: stageColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: stageColor.withOpacity(0.4)),
                ),
                child: Text(
                  'CKD $stage',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: stageColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          equationLabel,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            color: theme.subtitle,
          ),
        ),
      ],
    );
  }
}

class _NkfEgfrResultsBody extends StatelessWidget {
  final List<NkfEgfrResultLine> results;
  final GfrCalculatorTheme theme;

  const _NkfEgfrResultsBody({
    required this.results,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final unit = context.tr(AppStrings.egfrUnitIndexed);

    return Column(
      children: [
        for (var i = 0; i < results.length; i++) ...[
          if (i > 0) SizedBox(height: 10.h),
          _NkfResultRow(
            label: context.tr(results[i].labelKey),
            egfr: results[i].egfr,
            unit: unit,
            theme: theme,
          ),
        ],
      ],
    );
  }
}

class _NkfResultRow extends StatelessWidget {
  final String label;
  final double egfr;
  final String unit;
  final GfrCalculatorTheme theme;

  const _NkfResultRow({
    required this.label,
    required this.egfr,
    required this.unit,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final stage = gfrCkdStageLabel(egfr);
    final stageColor = gfrCkdStageColor(egfr);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: theme.surfaceBg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: theme.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                height: 1.3,
                color: theme.title,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                egfr.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 9.sp,
                  color: theme.subtitle,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'CKD $stage',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: stageColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
