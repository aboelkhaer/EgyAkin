import '../../../../exports.dart';

class SectionCard extends StatelessWidget {
  final VoidCallback onTap;
  final String? updatedAt;
  final bool isSubmitStatus;
  final int index;
  final String sectionName;

  const SectionCard({
    super.key,
    required this.onTap,
    required this.updatedAt,
    required this.isSubmitStatus,
    required this.index,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final cardBg = isDark ? AppColors.darkCardBG : Colors.white;
        final border = isDark ? AppColors.darkBorder : const Color(0xFFE8E4F5);
        final titleColor =
            isDark ? AppColors.darkTitle : const Color(0xFF111827);
        final muted =
            isDark ? AppColors.darkDescription : const Color(0xFF9CA3AF);
        const pending = Color(0xFFF59E0B);
        const completed = Color(0xFF22C55E);
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;

        final timeAgo = (updatedAt == null || updatedAt!.toString().isEmpty)
            ? ''
            : TimeAgoService.instance
                .formatTimeAgoFromString(updatedAt!.toString(), context);

        return Material(
          color: cardBg,
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: border),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Row(
                children: [
                  _LeadingBadge(
                    isCompleted: isSubmitStatus,
                    number: index + 1,
                    primary: primary,
                    completed: completed,
                    isDark: isDark,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sectionName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: titleColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Container(
                              width: 5.w,
                              height: 5.w,
                              decoration: BoxDecoration(
                                color: isSubmitStatus ? completed : pending,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Flexible(
                              child: isSubmitStatus
                                  ? Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: context.tr(
                                              AppStrings.completed,
                                            ),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: completed,
                                            ),
                                          ),
                                          if (timeAgo.isNotEmpty)
                                            TextSpan(
                                              text: ' · $timeAgo',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                                color: muted,
                                              ),
                                            ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      context.tr(AppStrings.pending),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: pending,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18.sp,
                    color: muted,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LeadingBadge extends StatelessWidget {
  final bool isCompleted;
  final int number;
  final Color primary;
  final Color completed;
  final bool isDark;

  const _LeadingBadge({
    required this.isCompleted,
    required this.number,
    required this.primary,
    required this.completed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: completed.withOpacity(isDark ? 0.16 : 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          size: 16.sp,
          color: completed,
        ),
      );
    }

    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: primary.withOpacity(isDark ? 0.16 : 0.1),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$number',
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: primary,
        ),
      ),
    );
  }
}
