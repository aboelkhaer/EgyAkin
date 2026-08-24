import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../../exports.dart';

class AdminActionCard extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color accent;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? footer;

  const AdminActionCard({
    super.key,
    required this.isDark,
    required this.icon,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 8.w, 12.h),
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: accent.withOpacity(isDark ? 0.22 : 0.12),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(icon, size: 18.sp, color: accent),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.replaceAll(':', ''),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeColor: HomeDashboardColors.primary(isDark),
              ),
            ],
          ),
          if (footer != null) ...[
            SizedBox(height: 10.h),
            footer!,
          ],
        ],
      ),
    );
  }
}
