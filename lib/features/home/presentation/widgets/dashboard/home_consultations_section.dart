import '../../../../../exports.dart';
import '../../../data/models/home_dashboard_fake_data.dart';
import 'home_dashboard_shared.dart';

class HomeConsultationsSection extends StatelessWidget {
  final bool isDark;
  final List<HomeConsultationFake> consultations;

  const HomeConsultationsSection({
    super.key,
    required this.isDark,
    required this.consultations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeader(
          title: context.tr(AppStrings.pendingConsultations),
          isDark: isDark,
          badgeCount: consultations.length,
          actionLabel: context.tr(AppStrings.openChat),
          onAction: () {},
        ),
        SizedBox(height: 10.h),
        ...consultations.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _ConsultationCard(isDark: isDark, item: item),
          ),
        ),
      ],
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  final bool isDark;
  final HomeConsultationFake item;

  const _ConsultationCard({
    required this.isDark,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return Container(
      padding: EdgeInsets.all(11.w),
      decoration: HomeDashboardDecor.card(isDark),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeInitialsAvatar(
            initials: item.doctorInitials,
            radius: 18,
            showOnlineDot: item.isOnline,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.doctorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: HomeDashboardColors.title(isDark),
                        ),
                      ),
                    ),
                    Text(
                      item.timeLabel,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  '${item.specialty} · ${item.location}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
              ],
            ),
          ),
          if (item.unreadCount > 0) ...[
            SizedBox(width: 6.w),
            Container(
              width: 18.r,
              height: 18.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${item.unreadCount}',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
