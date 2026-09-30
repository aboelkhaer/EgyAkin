import 'dart:ui';

import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

/// Polished confirm dialog for blocking a chat peer in a 1:1 conversation.
Future<bool> showBlockUserDialog({
  required BuildContext context,
  required String displayName,
}) async {
  final themeState = context.read<ThemeBloc>().state;
  final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

  final result = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: context.tr(AppStrings.dismiss),
    barrierColor: Colors.black.withOpacity(0.55),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1).animate(curved),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Center(
              child: _BlockUserDialog(
                isDark: isDark,
                displayName: displayName,
              ),
            ),
          ),
        ),
      );
    },
  );
  return result == true;
}

class _BlockUserDialog extends StatelessWidget {
  final bool isDark;
  final String displayName;

  const _BlockUserDialog({
    required this.isDark,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    const danger = HomeDashboardColors.danger;
    final name = displayName.trim().isEmpty
        ? context.tr(AppStrings.block).toLowerCase()
        : displayName.trim();

    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.sizeOf(context).width - 48.w,
        constraints: BoxConstraints(maxWidth: 340.w),
        decoration: BoxDecoration(
          color: HomeDashboardColors.cardBg(isDark),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: HomeDashboardColors.border(isDark).withOpacity(0.75),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.45 : 0.14),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: danger.withOpacity(isDark ? 0.12 : 0.08),
              blurRadius: 30,
              spreadRadius: -4,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Stack(
            children: [
              Positioned(
                top: -36,
                right: -28,
                child: IgnorePointer(
                  child: Container(
                    width: 120.r,
                    height: 120.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          danger.withOpacity(isDark ? 0.22 : 0.12),
                          danger.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 72.r,
                          height: 72.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: danger.withOpacity(isDark ? 0.1 : 0.06),
                          ),
                        ),
                        Container(
                          width: 54.r,
                          height: 54.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                danger.withOpacity(isDark ? 0.32 : 0.18),
                                danger.withOpacity(isDark ? 0.16 : 0.08),
                              ],
                            ),
                            border: Border.all(
                              color: danger.withOpacity(0.28),
                              width: 1.2,
                            ),
                          ),
                          child: Icon(
                            Icons.block_rounded,
                            color: danger,
                            size: 26.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      '${context.tr(AppStrings.block)} $name?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.tr(AppStrings.blockUserDescription),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.45,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: danger.withOpacity(isDark ? 0.14 : 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: danger.withOpacity(0.22),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 16.sp,
                            color: danger,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              context.tr(AppStrings.blockUserHint),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: danger,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44.h,
                            child: OutlinedButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    HomeDashboardColors.surfaceBg(isDark),
                                foregroundColor:
                                    HomeDashboardColors.title(isDark),
                                side: BorderSide(
                                  color: HomeDashboardColors.border(isDark),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                context.tr(AppStrings.cancel),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: SizedBox(
                            height: 44.h,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFEF4444),
                                    Color(0xFFDC2626),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: danger.withOpacity(0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                ),
                                child: Text(
                                  context.tr(AppStrings.block),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w800,
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
            ],
          ),
        ),
      ),
    );
  }
}
