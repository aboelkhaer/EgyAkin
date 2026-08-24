import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeNetworkInsightsSection extends StatelessWidget {
  final bool isDark;
  final ResearchInsightsModel insights;

  const HomeNetworkInsightsSection({
    super.key,
    required this.isDark,
    required this.insights,
  });

  static String _formatNum(num value) {
    if (value % 1 == 0) return value.toInt().toString();
    return value.toStringAsFixed(1);
  }

  static String? _signedDeltaDetail(num? delta, {String suffix = ''}) {
    if (delta == null) return null;
    final sign = delta > 0 ? '▲ +' : (delta < 0 ? '▼ ' : '');
    return '$sign${_formatNum(delta)}$suffix';
  }

  static Color _akiDeltaColor(num? delta, bool isDark) {
    if (delta == null || delta == 0) {
      return HomeDashboardColors.subtitle(isDark);
    }
    // Higher AKI incidence is worse.
    return delta > 0
        ? HomeDashboardColors.danger
        : HomeDashboardColors.success;
  }

  static Color _egfrDeltaColor(num? delta, bool isDark) {
    if (delta == null || delta == 0) {
      return HomeDashboardColors.subtitle(isDark);
    }
    // Higher eGFR is better.
    return delta > 0
        ? HomeDashboardColors.success
        : HomeDashboardColors.danger;
  }

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final patients = insights.population?.patientCount ?? 0;
    final hospitals = insights.population?.hospitalCount ?? 0;
    final aki = insights.akiIncidencePct;
    final akiDelta = insights.akiIncidenceDeltaPct;
    final cause = insights.mostCommonCause?.trim();
    final causePct = insights.mostCommonCausePct;
    final avgEgfr = insights.avgEgfrAtAdmission;
    final avgEgfrDelta = insights.avgEgfrAtAdmissionDelta;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: HomeDashboardDecor.card(
        isDark,
        color: HomeDashboardColors.primary(isDark)
            .withOpacity(isDark ? 0.12 : 0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.science_outlined, size: 15.sp, color: primary),
              SizedBox(width: 6.w),
              Text(
                context.tr(AppStrings.networkInsights),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: HomeDashboardColors.title(isDark),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.25 : 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  context.tr(AppStrings.researchUpper),
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '${_formatNum(patients)} ${context.tr(AppStrings.patients)} · ${_formatNum(hospitals)} ${context.tr(AppStrings.hospitals)} · ${context.tr(AppStrings.deIdentified)}',
            style: TextStyle(
              fontSize: 10.sp,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
          SizedBox(height: 10.h),
          _InsightRow(
            isDark: isDark,
            label: context.tr(AppStrings.akiIncidence),
            value: aki == null ? '—' : '${_formatNum(aki)}%',
            detail: _signedDeltaDetail(
              akiDelta,
              suffix: context.tr(AppStrings.thisQuarter),
            ),
            detailColor: _akiDeltaColor(akiDelta, isDark),
          ),
          Divider(color: HomeDashboardColors.border(isDark), height: 20.h),
          _InsightRow(
            isDark: isDark,
            label: context.tr(AppStrings.mostCommonCause),
            value: (cause == null || cause.isEmpty) ? '—' : cause,
            detail: causePct == null
                ? null
                : '${_formatNum(causePct)}${context.tr(AppStrings.percentOfCases)}',
            detailColor: HomeDashboardColors.warning,
            valueColor: HomeDashboardColors.warning,
          ),
          Divider(color: HomeDashboardColors.border(isDark), height: 20.h),
          _InsightRow(
            isDark: isDark,
            label: context.tr(AppStrings.avgEgfrAtAdmission),
            value: avgEgfr == null ? '—' : _formatNum(avgEgfr),
            detail: _signedDeltaDetail(avgEgfrDelta) ??
                (avgEgfrDelta == null
                    ? context.tr(AppStrings.vsPriorPeriod)
                    : null),
            detailColor: avgEgfrDelta == null
                ? HomeDashboardColors.info
                : _egfrDeltaColor(avgEgfrDelta, isDark),
          ),
        ],
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  final bool isDark;
  final String label;
  final String value;
  final String? detail;
  final Color detailColor;
  final Color? valueColor;

  const _InsightRow({
    required this.isDark,
    required this.label,
    required this.value,
    required this.detail,
    required this.detailColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: valueColor ?? HomeDashboardColors.title(isDark),
              ),
            ),
            if (detail != null && detail!.isNotEmpty) ...[
              SizedBox(height: 2.h),
              Text(
                detail!,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: detailColor,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
