import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

Future<void> showDeleteCommentDialog({
  required BuildContext context,
  required bool isDark,
  required VoidCallback onConfirm,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: context.tr(AppStrings.dismiss),
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _DeleteCommentDialog(
        isDark: isDark,
        onConfirm: onConfirm,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _DeleteCommentDialog extends StatelessWidget {
  final bool isDark;
  final VoidCallback onConfirm;

  const _DeleteCommentDialog({
    required this.isDark,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    const danger = HomeDashboardColors.danger;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 40.w,
          constraints: BoxConstraints(maxWidth: 420.w),
          padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 16.h),
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.8),
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: danger.withOpacity(isDark ? 0.22 : 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: danger,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr(AppStrings.delete),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: HomeDashboardColors.title(isDark),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          context.tr(AppStrings.thisCannotBeUndone),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: danger,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20.sp,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Text(
                context.tr(AppStrings.areYouSureToDeleteComment),
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.4,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: HomeDashboardColors.title(isDark),
                          side: BorderSide(
                            color: HomeDashboardColors.border(isDark),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          context.tr(AppStrings.cancel),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: danger,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          context.tr(AppStrings.delete),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
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
      ),
    );
  }
}
