import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeStatsSection extends StatelessWidget {
  final bool isDark;
  final int myPatientsCount;
  final int myPatientsDelta;
  final int allPatientsCount;
  final int allPatientsDelta;
  final int score;
  final int scoreDelta;

  const HomeStatsSection({
    super.key,
    required this.isDark,
    required this.myPatientsCount,
    required this.myPatientsDelta,
    required this.allPatientsCount,
    required this.allPatientsDelta,
    required this.score,
    required this.scoreDelta,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            isDark: isDark,
            icon: Icons.groups_rounded,
            iconColor: HomeDashboardColors.primary(isDark),
            tint: HomeDashboardColors.primary(isDark),
            value: '$myPatientsCount',
            delta: '+$myPatientsDelta',
            label: context.tr(AppStrings.myPatients),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _StatCard(
            isDark: isDark,
            icon: Icons.apartment_rounded,
            iconColor: HomeDashboardColors.info,
            tint: HomeDashboardColors.info,
            value: '$allPatientsCount',
            delta: '+$allPatientsDelta',
            label: context.tr(AppStrings.allPatients),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _StatCard(
            isDark: isDark,
            icon: Icons.workspace_premium_rounded,
            iconColor: HomeDashboardColors.score,
            tint: HomeDashboardColors.score,
            value: '$score',
            delta: '↑$scoreDelta',
            label: context.tr(AppStrings.score),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color iconColor;
  final Color tint;
  final String value;
  final String delta;
  final String label;

  const _StatCard({
    required this.isDark,
    required this.icon,
    required this.iconColor,
    required this.tint,
    required this.value,
    required this.delta,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 10.h),
      decoration: HomeDashboardDecor.card(
        isDark,
        color: tint.withOpacity(isDark ? 0.14 : 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26.r,
            height: 26.r,
            decoration: BoxDecoration(
              color: tint.withOpacity(isDark ? 0.25 : 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 14.sp, color: iconColor),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              height: 1.1,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: HomeDashboardColors.success.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              delta,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w700,
                color: HomeDashboardColors.success,
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.sp,
              color: HomeDashboardColors.subtitle(isDark),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
