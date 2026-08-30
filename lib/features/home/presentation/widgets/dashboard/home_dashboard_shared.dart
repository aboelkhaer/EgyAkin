import 'package:egy_akin/app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDashboardColors {
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  static const Color score = Color(0xFF10B981);
  static const Color online = Color(0xFF22C55E);
  static const Color headerLight = Color(0xFFEDE7FF);
  static const Color headerDark = Color(0xFF1A1428);

  static Color cardBg(bool isDark) =>
      isDark ? AppColors.darkCardBG : Colors.white;

  static Color surfaceBg(bool isDark) =>
      isDark ? AppColors.darkSurface : const Color(0xFFF3F4F6);

  static Color border(bool isDark) =>
      isDark ? AppColors.darkBorder : const Color(0xFFE5E7EB);

  static Color title(bool isDark) =>
      isDark ? AppColors.darkTitle : const Color(0xFF111827);

  static Color subtitle(bool isDark) =>
      isDark ? AppColors.darkDescription : const Color(0xFF6B7280);

  static Color primary(bool isDark) =>
      isDark ? AppColors.darkPrimary : AppColors.primary;

  static Color scaffold(bool isDark) =>
      isDark ? AppColors.darkScaffoldBG : const Color(0xFFF5F5F7);

  static Color header(bool isDark) => isDark ? headerDark : headerLight;
}

class HomeDashboardDecor {
  static BoxDecoration card(bool isDark, {Color? color}) {
    return BoxDecoration(
      color: color ?? HomeDashboardColors.cardBg(isDark),
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(
        color: HomeDashboardColors.border(isDark).withOpacity(0.7),
      ),
      boxShadow: isDark
          ? null
          : [
              BoxShadow(
                color: Colors.black.withOpacity(0.035),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
    );
  }
}

class HomeInitialsAvatar extends StatelessWidget {
  final String initials;
  final double radius;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showOnlineDot;

  const HomeInitialsAvatar({
    super.key,
    required this.initials,
    this.radius = 18,
    this.backgroundColor,
    this.textColor,
    this.showOnlineDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary.withOpacity(0.15);
    final fg = textColor ?? AppColors.primary;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius.r,
          backgroundColor: bg,
          child: Text(
            initials.toUpperCase(),
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: (radius * 0.65).sp,
            ),
          ),
        ),
        if (showOnlineDot)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 8.r,
              height: 8.r,
              decoration: BoxDecoration(
                color: HomeDashboardColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.2),
              ),
            ),
          ),
      ],
    );
  }
}

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? badgeText;
  final int? badgeCount;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData? leadingIcon;
  final bool isDark;

  /// When true (and [onAction] is set), shows only a chevron — no label.
  final bool actionIconOnly;

  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.isDark,
    this.badgeText,
    this.badgeCount,
    this.actionLabel,
    this.onAction,
    this.leadingIcon,
    this.actionIconOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final showAction = onAction != null &&
        (actionIconOnly || (actionLabel != null && actionLabel!.isNotEmpty));

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 15.sp, color: primary),
          SizedBox(width: 6.w),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        if (badgeCount != null || badgeText != null) ...[
          SizedBox(width: 6.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: badgeText != null ? 8.w : 6.w,
              vertical: 2.h,
            ),
            decoration: BoxDecoration(
              color: primary.withOpacity(isDark ? 0.25 : 0.12),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              badgeText ?? '$badgeCount',
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
                color: primary,
              ),
            ),
          ),
        ],
        const Spacer(),
        if (showAction)
          actionIconOnly
              ? SizedBox(
                  width: 28.w,
                  height: 28.w,
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 22.sp,
                    color: primary,
                  ),
                )
              : GestureDetector(
                  onTap: onAction,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        actionLabel!,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: primary,
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 15.sp, color: primary),
                    ],
                  ),
                ),
      ],
    );

    // Icon-only headers (e.g. Resume drafts): tap anywhere on the row.
    if (showAction && actionIconOnly) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onAction,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: row,
          ),
        ),
      );
    }

    return row;
  }
}

class HomeUpdatedLabel extends StatelessWidget {
  final bool isDark;
  final String label;

  const HomeUpdatedLabel({
    super.key,
    required this.isDark,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.sync_rounded,
          size: 12.sp,
          color: HomeDashboardColors.subtitle(isDark),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
      ],
    );
  }
}

class DashboardEmptyState extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final IconData hintIcon;
  final String title;
  final String subtitle;
  final String? hint;
  final bool compact;

  const DashboardEmptyState({
    super.key,
    required this.isDark,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hint,
    this.hintIcon = Icons.info_outline_rounded,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final border = isDark
        ? Colors.white.withOpacity(0.06)
        : const Color(0xFFE8E8EE);
    final iconSize = compact ? 56.r : 88.r;
    final iconGlyph = compact ? 24.sp : 36.sp;

    final iconBadge = Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withOpacity(isDark ? 0.28 : 0.16),
            primary.withOpacity(isDark ? 0.1 : 0.05),
          ],
        ),
        border: Border.all(color: primary.withOpacity(0.22)),
      ),
      child: Icon(icon, size: iconGlyph, color: primary),
    );

    if (compact) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconBadge,
              SizedBox(width: 12.w),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            iconBadge,
            SizedBox(height: 18.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
                height: 1.45,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
            if (hint != null && hint!.isNotEmpty) ...[
              SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(hintIcon, size: 14.sp, color: primary),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        hint!,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
