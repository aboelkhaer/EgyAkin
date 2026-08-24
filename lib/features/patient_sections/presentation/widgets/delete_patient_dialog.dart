import 'dart:ui';

import '../../../../exports.dart';

Future<void> showDeletePatientDialog({
  required BuildContext context,
  required VoidCallback onConfirmDelete,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: context.tr(AppStrings.deletePatientBarrier),
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
              child: _DeletePatientDialog(onConfirmDelete: onConfirmDelete),
            ),
          ),
        ),
      );
    },
  );
}

class _DeletePatientDialog extends StatelessWidget {
  final VoidCallback onConfirmDelete;

  const _DeletePatientDialog({required this.onConfirmDelete});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        const danger = Color(0xFFEF4444);
        final dialogBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;
        final titleColor = isDark ? Colors.white : const Color(0xFF111827);
        final descriptionColor =
            isDark ? const Color(0xFFA0A0A0) : const Color(0xFF666666);
        final iconBg =
            isDark ? const Color(0xFF3A1C1C) : const Color(0xFFFFE8E8);
        final cancelBg =
            isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6);
        final cancelBorder =
            isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE5E7EB);
        final cancelText =
            isDark ? const Color(0xFFE5E5E5) : const Color(0xFF374151);

        return Material(
          color: Colors.transparent,
          child: Container(
            width: 268.w,
            margin: EdgeInsets.symmetric(horizontal: 36.w),
            padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 16.h),
            decoration: BoxDecoration(
              color: dialogBg,
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.45 : 0.12),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: danger,
                    size: 22.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  context.tr(AppStrings.deletePatientQuestion),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  context.tr(AppStrings.deletePatientDescription),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                    color: descriptionColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 38.h,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: cancelBg,
                            foregroundColor: cancelText,
                            side: BorderSide(color: cancelBorder),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            context.tr(AppStrings.cancel),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: cancelText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: SizedBox(
                        height: 38.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onConfirmDelete();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: danger,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            context.tr(AppStrings.delete),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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
