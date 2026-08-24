import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeOutcomesSection extends StatelessWidget {
  final bool isDark;
  final List<PatientHomeDataModel> outcomes;
  final int badgeCount;
  final VoidCallback? onViewAll;
  final ValueChanged<PatientHomeDataModel>? onAddOutcome;

  const HomeOutcomesSection({
    super.key,
    required this.isDark,
    required this.outcomes,
    this.badgeCount = 0,
    this.onViewAll,
    this.onAddOutcome,
  });

  @override
  Widget build(BuildContext context) {
    if (outcomes.isEmpty && badgeCount <= 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeader(
          title: context.tr(AppStrings.addOutcomes),
          isDark: isDark,
          badgeCount: badgeCount > 0 ? badgeCount : outcomes.length,
          actionLabel: context.tr(AppStrings.viewAll),
          onAction: onViewAll,
        ),
        if (outcomes.isNotEmpty) ...[
          SizedBox(height: 10.h),
          ...outcomes.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _OutcomeCard(
                isDark: isDark,
                item: item,
                onAddOutcome: onAddOutcome,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _OutcomeCard extends StatelessWidget {
  final bool isDark;
  final PatientHomeDataModel item;
  final ValueChanged<PatientHomeDataModel>? onAddOutcome;

  const _OutcomeCard({
    required this.isDark,
    required this.item,
    this.onAddOutcome,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final name = item.name?.trim().isNotEmpty == true
        ? item.name!.trim()
        : 'Patient #${item.id ?? ''}';
    final contextLabel = [
      if (item.hospital?.trim().isNotEmpty == true) item.hospital!.trim(),
      if (item.doctor != null)
        [
          item.doctor!.firstName,
          item.doctor!.lastName,
        ].where((e) => e != null && e.trim().isNotEmpty).join(' '),
    ].where((e) => e.isNotEmpty).join(' · ');

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: HomeDashboardDecor.card(isDark),
      child: Row(
        children: [
          HomeInitialsAvatar(
            initials: _initialsFromName(name),
            radius: 16,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: HomeDashboardColors.title(isDark),
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 11.sp,
                      color: HomeDashboardColors.warning,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      context.tr(AppStrings.pendingUpper),
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w800,
                        color: HomeDashboardColors.warning,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (contextLabel.isNotEmpty) ...[
                      SizedBox(width: 6.w),
                      Flexible(
                        child: Text(
                          contextLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: HomeDashboardColors.subtitle(isDark),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          SizedBox(
            height: 30.h,
            child: ElevatedButton(
              onPressed: onAddOutcome == null ? null : () => onAddOutcome!(item),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                context.tr(AppStrings.plusOutcome),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _initialsFromName(String name) {
  final parts =
      name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return 'P';
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return ('${parts.first[0]}${parts.last[0]}').toUpperCase();
}
