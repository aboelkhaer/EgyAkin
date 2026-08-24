import 'package:intl/intl.dart';

import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeWeekSummarySection extends StatelessWidget {
  final bool isDark;
  final WeekRecapModel summary;

  const HomeWeekSummarySection({
    super.key,
    required this.isDark,
    required this.summary,
  });

  String _rangeLabel(BuildContext context) {
    final from = _tryParse(summary.from);
    final to = _tryParse(summary.to);
    if (from == null || to == null) {
      return context.tr(AppStrings.thisWeek);
    }

    final sameMonth = from.year == to.year && from.month == to.month;
    if (sameMonth) {
      return '${DateFormat('MMM d').format(from)}–${DateFormat('d').format(to)}';
    }
    if (from.year == to.year) {
      return '${DateFormat('MMM d').format(from)}–${DateFormat('MMM d').format(to)}';
    }
    return '${DateFormat('MMM d, y').format(from)}–${DateFormat('MMM d, y').format(to)}';
  }

  DateTime? _tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    return DateTime.tryParse(raw)?.toLocal();
  }

  @override
  Widget build(BuildContext context) {
    final outcomes = summary.outcomesSubmitted ?? 0;
    final newPatients = summary.patientsAdded ?? 0;
    final points = summary.pointsEarned ?? 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: HomeDashboardDecor.card(
        isDark,
        color: HomeDashboardColors.primary(isDark)
            .withOpacity(isDark ? 0.12 : 0.06),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.show_chart_rounded,
                size: 14.sp,
                color: HomeDashboardColors.primary(isDark),
              ),
              SizedBox(width: 6.w),
              Text(
                context.tr(AppStrings.thisWeek),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: HomeDashboardColors.title(isDark),
                ),
              ),
              const Spacer(),
              Text(
                _rangeLabel(context),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _WeekMetric(
                    isDark: isDark,
                    icon: Icons.check_circle_rounded,
                    iconColor: HomeDashboardColors.success,
                    value: '$outcomes',
                    label: context.tr(AppStrings.outcomes),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: HomeDashboardColors.border(isDark),
                ),
                Expanded(
                  child: _WeekMetric(
                    isDark: isDark,
                    icon: Icons.person_add_alt_1_rounded,
                    iconColor: HomeDashboardColors.primary(isDark),
                    value: '+$newPatients',
                    label: context.tr(AppStrings.newPatients),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: HomeDashboardColors.border(isDark),
                ),
                Expanded(
                  child: _WeekMetric(
                    isDark: isDark,
                    icon: Icons.emoji_events_rounded,
                    iconColor: HomeDashboardColors.warning,
                    value: '+$points',
                    label: context.tr(AppStrings.points),
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

class _WeekMetric extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _WeekMetric({
    required this.isDark,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14.sp, color: iconColor),
            SizedBox(width: 4.w),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                height: 1.1,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.sp,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
      ],
    );
  }
}
