import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class GroupsListCard extends StatelessWidget {
  final GroupModel group;
  final bool isDark;
  final Color primary;
  final Color accent;
  final VoidCallback onTap;
  final Widget? trailing;

  const GroupsListCard({
    super.key,
    required this.group,
    required this.isDark,
    required this.primary,
    required this.accent,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final muted = HomeDashboardColors.subtitle(isDark);
    final imageUrl = group.groupImage;
    final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;
    final private = group.privacy == GroupStatus.private.name;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Ink(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 10.w, 12.h),
          decoration: HomeDashboardDecor.card(isDark),
          child: Row(
            children: [
              Container(
                width: 46.r,
                height: 46.r,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: hasImage
                    ? CustomCachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 46.r,
                        height: 46.r,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.groups_rounded,
                        size: 20.sp,
                        color: accent,
                      ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          private
                              ? Icons.lock_rounded
                              : Icons.people_alt_outlined,
                          size: 11.sp,
                          color: muted,
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            '${group.memberCount ?? 0} members',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w500,
                              color: muted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: 8.w),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class GroupsJoinChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  const GroupsJoinChip({
    super.key,
    required this.isDark,
    required this.primary,
    required this.label,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(20.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: enabled
                ? primary
                : (isDark
                    ? Colors.white.withOpacity(0.08)
                    : const Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                enabled
                    ? Icons.person_add_alt_1_rounded
                    : Icons.check_rounded,
                size: 12.sp,
                color: enabled
                    ? Colors.white
                    : HomeDashboardColors.subtitle(isDark),
              ),
              SizedBox(width: 3.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: enabled
                      ? Colors.white
                      : HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupsListLoading extends StatelessWidget {
  final bool isDark;
  final int count;

  const GroupsListLoading({
    super.key,
    required this.isDark,
    this.count = 6,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      itemCount: count,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Container(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 10.w, 12.h),
            decoration: HomeDashboardDecor.card(isDark),
            child: Row(
              children: [
                Container(
                  width: 46.r,
                  height: 46.r,
                  decoration: BoxDecoration(
                    color: bone,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 88.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
