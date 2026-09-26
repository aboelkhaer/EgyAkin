import 'package:egy_akin/exports.dart';

/// Delete confirmation for chat multi-select.
///
/// [deleteForMeOnly] — true when deleting others' messages (hide for me).
/// false when deleting own messages (delete for everyone / WhatsApp placeholder).
Future<bool> showChatDeleteMessagesSheet({
  required BuildContext context,
  required int count,
  bool deleteForMeOnly = false,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.55),
    builder: (ctx) => _ChatDeleteMessagesSheet(
      count: count,
      deleteForMeOnly: deleteForMeOnly,
    ),
  );
  return result == true;
}

class _ChatDeleteMessagesSheet extends StatelessWidget {
  final int count;
  final bool deleteForMeOnly;

  const _ChatDeleteMessagesSheet({
    required this.count,
    required this.deleteForMeOnly,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
        final titleColor = isDark ? AppColors.darkTitle : AppColors.title;
        final subColor =
            isDark ? AppColors.darkDescription : AppColors.description;
        final border = isDark
            ? Colors.white.withOpacity(0.06)
            : Colors.black.withOpacity(0.06);
        const danger = Color(0xFFE5484D);
        final bottom = MediaQuery.viewPaddingOf(context).bottom;

        final title = count == 1
            ? context.tr(AppStrings.deleteMessageQuestion)
            : context
                .tr(AppStrings.deleteMessagesQuestion)
                .replaceAll('{count}', '$count');

        final subtitle = deleteForMeOnly
            ? (count == 1
                ? context.tr(AppStrings.deleteMessageForMeOnly)
                : context.tr(AppStrings.deleteMessagesForMeOnly))
            : (count == 1
                ? context.tr(AppStrings.deleteMessageForEveryone)
                : context.tr(AppStrings.deleteMessagesForEveryone));

        return Padding(
          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 12.h + bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 18.h),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(color: border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.4 : 0.14),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 36.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.18)
                            : Colors.black.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: danger.withOpacity(isDark ? 0.18 : 0.1),
                      ),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: danger,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: subColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 42.h,
                      child: Material(
                        color: danger,
                        borderRadius: BorderRadius.circular(12.r),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          borderRadius: BorderRadius.circular(12.r),
                          child: Center(
                            child: Text(
                              context.tr(AppStrings.delete),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(false),
                          borderRadius: BorderRadius.circular(12.r),
                          child: Center(
                            child: Text(
                              context.tr(AppStrings.cancel),
                              style: TextStyle(
                                color: titleColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
