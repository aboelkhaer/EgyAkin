import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeStatsSection extends StatelessWidget {
  final bool isDark;
  final int myPatientsCount;
  final int allPatientsCount;
  final int score;
  final int myPatientsDelta;
  final int allPatientsDelta;
  final int scoreDelta;

  const HomeStatsSection({
    super.key,
    required this.isDark,
    required this.myPatientsCount,
    required this.allPatientsCount,
    required this.score,
    this.myPatientsDelta = 0,
    this.allPatientsDelta = 0,
    this.scoreDelta = 0,
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
            delta: myPatientsDelta != 0 ? '+$myPatientsDelta' : null,
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
            delta: allPatientsDelta != 0 ? '+$allPatientsDelta' : null,
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
            delta: scoreDelta != 0 ? '↑$scoreDelta' : null,
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
  final String? delta;
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
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      decoration: HomeDashboardDecor.card(isDark),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: HomeDashboardColors.title(isDark),
                    ),
                  ),
                ),
              ),
              if (delta != null && delta!.isNotEmpty) ...[
                SizedBox(width: 4.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: HomeDashboardColors.success.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    delta!,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700,
                      color: HomeDashboardColors.success,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ],
      ),
    );
  }
}
