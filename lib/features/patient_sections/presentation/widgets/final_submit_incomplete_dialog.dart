import 'dart:ui';

import '../../../../exports.dart';

Future<void> showFinalSubmitIncompleteDialog({
  required BuildContext context,
  required List<String> incompleteSections,
  required VoidCallback onSubmitAnyway,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: context.tr(AppStrings.sectionsIncompleteBarrier),
    barrierColor: Colors.black.withOpacity(0.55),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Center(
              child: _FinalSubmitIncompleteDialog(
                incompleteSections: incompleteSections,
                onSubmitAnyway: onSubmitAnyway,
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _FinalSubmitIncompleteDialog extends StatelessWidget {
  final List<String> incompleteSections;
  final VoidCallback onSubmitAnyway;

  const _FinalSubmitIncompleteDialog({
    required this.incompleteSections,
    required this.onSubmitAnyway,
  });

  IconData _iconForSection(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('report') || lower.contains('lab')) {
      return Icons.description_outlined;
    }
    if (lower.contains('outcome') || lower.contains('heart')) {
      return Icons.favorite_border_rounded;
    }
    if (lower.contains('follow') ||
        lower.contains('referral') ||
        lower.contains('patient') ||
        lower.contains('cts')) {
      return Icons.groups_outlined;
    }
    return Icons.article_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        const warning = Color(0xFFF59E0B);
        final dialogBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;
        final titleColor = isDark ? Colors.white : const Color(0xFF111827);
        final subtitleColor =
            isDark ? const Color(0xFFA0A0A0) : const Color(0xFF6B7280);
        final iconCircleBg =
            isDark ? const Color(0xFF3A2A14) : const Color(0xFFFFF1E0);
        final itemBg =
            isDark ? const Color(0xFF242424) : const Color(0xFFF5F5F7);
        final itemBorder =
            isDark ? const Color(0xFF333333) : const Color(0xFFE8E4F5);
        final itemIconBg =
            isDark ? const Color(0xFF3A2A14) : const Color(0xFFFFF1E0);
        final keepBg =
            isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6);
        final keepBorder =
            isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE5E7EB);
        final keepText =
            isDark ? const Color(0xFFE5E5E5) : const Color(0xFF374151);
        final count = incompleteSections.length;

        return Material(
          color: Colors.transparent,
          child: Container(
            width: 310.w,
            margin: EdgeInsets.symmetric(horizontal: 28.w),
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 18.h),
            decoration: BoxDecoration(
              color: dialogBg,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.45 : 0.12),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: iconCircleBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: warning,
                    size: 28.sp,
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  context
                      .tr(AppStrings.sectionsIncompleteCount)
                      .replaceAll('{count}', '$count'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  context.tr(AppStrings.completeTheseBeforeFinalSubmission),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: subtitleColor,
                  ),
                ),
                SizedBox(height: 16.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 180.h),
                  child: Stack(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 12.h),
                        itemCount: incompleteSections.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8.h),
                        itemBuilder: (context, index) {
                          final name = incompleteSections[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 11.h,
                            ),
                            decoration: BoxDecoration(
                              color: itemBg,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(color: itemBorder),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: BoxDecoration(
                                    color: itemIconBg,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(
                                    _iconForSection(name),
                                    size: 16.sp,
                                    color: warning,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w700,
                                      color: titleColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (incompleteSections.length > 3)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 28.h,
                          child: IgnorePointer(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    dialogBg.withOpacity(0),
                                    dialogBg,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44.h,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: keepBg,
                            foregroundColor: keepText,
                            side: BorderSide(color: keepBorder),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            context.tr(AppStrings.keepEditing),
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                              color: keepText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6B47E6), Color(0xFF7C5CFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B47E6)
                                  .withOpacity(isDark ? 0.45 : 0.35),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              onSubmitAnyway();
                            },
                            borderRadius: BorderRadius.circular(14.r),
                            child: Center(
                              child: Text(
                                context.tr(AppStrings.submitAnyway),
                                style: TextStyle(
                                  fontSize: 12.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
