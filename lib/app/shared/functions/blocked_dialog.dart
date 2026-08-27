import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../exports.dart';

bool _isDialogOpen = false;

void showBlockedDialog({
  required BuildContext context,
  required VoidCallback onDismissed,
}) {
  if (_isDialogOpen) return;
  _isDialogOpen = true;

  final themeState = context.read<ThemeBloc>().state;
  final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

  showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: LocalizationService.instance.translate(AppStrings.close),
    barrierColor: Colors.black.withOpacity(0.55),
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _BlockedAccountDialog(isDark: isDark);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.88, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  ).then((_) {
    _isDialogOpen = false;
    onDismissed();
  });
}

class _BlockedAccountDialog extends StatelessWidget {
  final bool isDark;

  const _BlockedAccountDialog({required this.isDark});

  Future<void> _openSupportEmail(BuildContext context) async {
    const email = AppStrings.contactUsSupportEmail;
    final uri = Uri(
      scheme: 'mailto',
      path: email,
    );

    var opened = false;
    try {
      if (await canLaunchUrl(uri)) {
        opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      opened = false;
    }

    if (opened) return;
    if (!context.mounted) return;

    // iOS Simulator / devices without a mail app: copy email instead.
    await Clipboard.setData(ClipboardData(text: email));
    if (!context.mounted) return;

    _showThemedSnackBar(
      context,
      LocalizationService.instance.translate(AppStrings.supportEmailCopied),
    );
  }

  void _showThemedSnackBar(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.maybeOf(context) ??
        (navigatorKey.currentContext != null
            ? ScaffoldMessenger.maybeOf(navigatorKey.currentContext!)
            : null);
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        backgroundColor:
            isDark ? AppColors.darkCardBG : const Color(0xFF1F2937),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: isDark
                ? AppColors.darkBorder
                : Colors.white.withOpacity(0.08),
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: isDark ? AppColors.darkTitle : Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        action: SnackBarAction(
          label: LocalizationService.instance.translate(AppStrings.ok),
          textColor: isDark ? AppColors.darkPrimary : Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFE11D48);
    const accentDeep = Color(0xFF9F1239);
    final cardBg = HomeDashboardColors.cardBg(isDark);
    final title = HomeDashboardColors.title(isDark);
    final subtitle = HomeDashboardColors.subtitle(isDark);
    final border = HomeDashboardColors.border(isDark);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 40.w,
          constraints: BoxConstraints(maxWidth: 420.w),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: border.withOpacity(0.75)),
            boxShadow: [
              BoxShadow(
                color: accent.withOpacity(isDark ? 0.28 : 0.18),
                blurRadius: 32,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dramatic header band
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 28.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? const [
                            Color(0xFF4C0519),
                            Color(0xFF881337),
                            Color(0xFF9F1239),
                          ]
                        : const [
                            Color(0xFFFFE4E6),
                            Color(0xFFFFE2E8),
                            Color(0xFFFFCADA),
                          ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72.r,
                      height: 72.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [accent, accentDeep],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accent.withOpacity(0.45),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.35),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.gpp_bad_rounded,
                        color: Colors.white,
                        size: 34.sp,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      LocalizationService.instance
                          .translate(AppStrings.youAreBlocked),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: isDark ? Colors.white : accentDeep,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.black : Colors.white)
                            .withOpacity(isDark ? 0.28 : 0.55),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        LocalizationService.instance
                            .translate(AppStrings.blocked),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: isDark ? Colors.white70 : accentDeep,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocalizationService.instance.translate(
                        AppStrings.pleaseContactSupportIfYouThinkThisIsAMistake,
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                        color: subtitle,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    // Email chip
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _openSupportEmail(context),
                        borderRadius: BorderRadius.circular(14.r),
                        child: Ink(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: HomeDashboardColors.surfaceBg(isDark),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: border.withOpacity(0.8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36.r,
                                height: 36.r,
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(isDark ? 0.2 : 0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(
                                  Icons.mail_outline_rounded,
                                  color: accent,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocalizationService.instance.translate(
                                        AppStrings.contactUsEmailSupport,
                                      ),
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: subtitle,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      AppStrings.contactUsSupportEmail,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: title,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.open_in_new_rounded,
                                size: 16.sp,
                                color: subtitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () => _openSupportEmail(context),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          LocalizationService.instance
                              .translate(AppStrings.contactUsEmailSupport),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 42.h,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: subtitle,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          LocalizationService.instance
                              .translate(AppStrings.close),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: title,
                          ),
                        ),
                      ),
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
