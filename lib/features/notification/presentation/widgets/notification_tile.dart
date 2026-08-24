import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class NotificationTile extends StatelessWidget {
  final bool isDarkMode;
  final bool isRead;
  final String content;
  final String? createdAt;
  final Widget? avatar;
  final VoidCallback? onTap;
  final VoidCallback? onAvatarTap;
  final IconData? fallbackIcon;

  const NotificationTile({
    super.key,
    required this.isDarkMode,
    required this.isRead,
    required this.content,
    required this.createdAt,
    this.avatar,
    this.onTap,
    this.onAvatarTap,
    this.fallbackIcon,
  });

  Color get _accent => HomeDashboardColors.primary(isDarkMode);

  Color get _sheet => HomeDashboardColors.cardBg(isDarkMode);

  Color get _ink => HomeDashboardColors.title(isDarkMode);

  Color get _muted => HomeDashboardColors.subtitle(isDarkMode);

  @override
  Widget build(BuildContext context) {
    final timeLabel = createdAt == null
        ? ''
        : TimeAgoService.instance.formatTimeAgoFromString(
            createdAt.toString(),
            context,
          );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDarkMode).withOpacity(0.75),
            ),
            gradient: isRead
                ? null
                : LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      _accent.withOpacity(isDarkMode ? 0.22 : 0.12),
                      _sheet,
                    ],
                    stops: const [0.0, 0.18],
                  ),
            color: isRead ? _sheet : null,
            boxShadow: isDarkMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 3.5.w,
                    color: isRead ? Colors.transparent : _accent,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 12.h, 10.w, 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: onAvatarTap,
                            child: Container(
                              width: 42.w,
                              height: 42.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _accent.withOpacity(0.16),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: avatar ??
                                    ColoredBox(
                                      color: _accent.withOpacity(0.14),
                                      child: Icon(
                                        fallbackIcon ??
                                            Icons.notifications_rounded,
                                        size: 18.sp,
                                        color: _accent,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  content,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: isRead
                                        ? FontWeight.w500
                                        : FontWeight.w600,
                                    height: 1.4,
                                    letterSpacing: -0.1,
                                    color: _ink,
                                  ),
                                ),
                                if (timeLabel.isNotEmpty) ...[
                                  SizedBox(height: 6.h),
                                  Text(
                                    timeLabel,
                                    style: TextStyle(
                                      fontSize: 10.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: _muted,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Column(
                              children: [
                                if (!isRead)
                                  Container(
                                    width: 8.r,
                                    height: 8.r,
                                    decoration: BoxDecoration(
                                      color: _accent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: _accent.withOpacity(0.45),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  SizedBox(height: 8.r),
                                SizedBox(height: 14.h),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 18.sp,
                                  color: _muted.withOpacity(0.65),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initial;
  final Color accent;

  const NotificationAvatar({
    super.key,
    required this.imageUrl,
    required this.initial,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CustomCachedNetworkImage(
        imageUrl: imageUrl!,
        height: 42.w,
        width: 42.w,
      );
    }

    final letter = (initial == null || initial!.isEmpty)
        ? '@'
        : initial![0].toUpperCase();

    return ColoredBox(
      color: accent.withOpacity(0.16),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14.sp,
            color: accent,
          ),
        ),
      ),
    );
  }
}
