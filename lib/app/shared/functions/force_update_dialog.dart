import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../exports.dart';

const String kAndroidPlayStoreUrl =
    'https://play.google.com/store/apps/details?id=com.incode.EgyAkin';
const String kIosAppStoreUrl = 'https://apps.apple.com/app/id6738606085';

Future<void> showForceUpdateDialog({
  required BuildContext context,
  required bool isAndroid,
  String? storeUrl,
  String? currentVersion,
  String? latestVersion,
  Future<void> Function()? onAndroidInAppUpdate,
}) {
  final themeState = context.read<ThemeBloc>().state;
  final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
  final resolvedStoreUrl = storeUrl?.trim().isNotEmpty == true
      ? storeUrl!
      : (isAndroid ? kAndroidPlayStoreUrl : kIosAppStoreUrl);

  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: context.tr(AppStrings.updateRequired),
    barrierColor: Colors.black.withOpacity(0.62),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) {
      return PopScope(
        canPop: false,
        child: _ForceUpdateDialog(
          isDark: isDark,
          isAndroid: isAndroid,
          storeUrl: resolvedStoreUrl,
          currentVersion: currentVersion?.trim() ?? '',
          latestVersion: latestVersion?.trim() ?? '',
          onAndroidInAppUpdate: onAndroidInAppUpdate,
        ),
      );
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
          child: child,
        ),
      );
    },
  );
}

class _ForceUpdateDialog extends StatefulWidget {
  final bool isDark;
  final bool isAndroid;
  final String storeUrl;
  final String currentVersion;
  final String latestVersion;
  final Future<void> Function()? onAndroidInAppUpdate;

  const _ForceUpdateDialog({
    required this.isDark,
    required this.isAndroid,
    required this.storeUrl,
    required this.currentVersion,
    required this.latestVersion,
    this.onAndroidInAppUpdate,
  });

  @override
  State<_ForceUpdateDialog> createState() => _ForceUpdateDialogState();
}

class _ForceUpdateDialogState extends State<_ForceUpdateDialog> {
  bool _openingStore = false;

  Future<void> _openStore() async {
    if (_openingStore) return;
    setState(() => _openingStore = true);

    try {
      if (widget.isAndroid && widget.onAndroidInAppUpdate != null) {
        try {
          await widget.onAndroidInAppUpdate!();
          return;
        } catch (e) {
          debugPrint('Immediate in-app update failed, opening Play Store: $e');
        }
      }

      await launchURL(
        url: widget.storeUrl,
        externalBrowserOnly: true,
        onError: (error) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr(AppStrings.couldNotLaunchAppStore)),
            ),
          );
        },
      );
    } finally {
      if (mounted) setState(() => _openingStore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final primary = HomeDashboardColors.primary(isDark);

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400.w),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: HomeDashboardColors.cardBg(isDark),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: HomeDashboardColors.border(isDark).withOpacity(0.75),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.45 : 0.16),
                      blurRadius: 28,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: BoxDecoration(
                          color: primary.withOpacity(isDark ? 0.22 : 0.12),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Icon(
                          Icons.system_update_alt_rounded,
                          color: primary,
                          size: 30.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        context.tr(AppStrings.updateRequired),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: HomeDashboardColors.title(isDark),
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        context.tr(
                          AppStrings.aNewVersionIsAvailablePleaseUpdate,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                          color: HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                      if (widget.currentVersion.isNotEmpty) ...[
                        SizedBox(height: 14.h),
                        _VersionRow(
                          isDark: isDark,
                          primary: primary,
                          currentVersion: widget.currentVersion,
                          latestVersion: widget.latestVersion,
                        ),
                      ],
                      SizedBox(height: 10.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: HomeDashboardColors.surfaceBg(isDark),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: HomeDashboardColors.border(isDark)
                                .withOpacity(0.8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              size: 16.sp,
                              color: primary,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                context.tr(
                                  AppStrings.forceUpdateMustUpdateToContinue,
                                ),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  height: 1.35,
                                  fontWeight: FontWeight.w600,
                                  color: HomeDashboardColors.subtitle(isDark),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: _openingStore ? null : _openStore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                primary.withOpacity(0.55),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          child: _openingStore
                              ? SizedBox(
                                  width: 20.sp,
                                  height: 20.sp,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      widget.isAndroid
                                          ? Icons.shop_rounded
                                          : Icons.apple,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      context.tr(AppStrings.updateNow),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800,
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
        ),
      ),
    );
  }
}

class _VersionRow extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String currentVersion;
  final String latestVersion;

  const _VersionRow({
    required this.isDark,
    required this.primary,
    required this.currentVersion,
    required this.latestVersion,
  });

  @override
  Widget build(BuildContext context) {
    final storeValue =
        latestVersion.isNotEmpty ? 'v$latestVersion' : '—';

    return Row(
      children: [
        Expanded(
          child: _VersionChip(
            isDark: isDark,
            label: context.tr(AppStrings.currentVersionLabel),
            value: currentVersion.isNotEmpty ? 'v$currentVersion' : '—',
            accent: HomeDashboardColors.subtitle(isDark),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Icon(
            Icons.arrow_forward_rounded,
            size: 16.sp,
            color: primary,
          ),
        ),
        Expanded(
          child: _VersionChip(
            isDark: isDark,
            label: context.tr(AppStrings.storeVersionLabel),
            value: storeValue,
            accent: primary,
            emphasized: latestVersion.isNotEmpty,
          ),
        ),
      ],
    );
  }
}

class _VersionChip extends StatelessWidget {
  final bool isDark;
  final String label;
  final String value;
  final Color accent;
  final bool emphasized;

  const _VersionChip({
    required this.isDark,
    required this.label,
    required this.value,
    required this.accent,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: emphasized
            ? accent.withOpacity(isDark ? 0.18 : 0.10)
            : HomeDashboardColors.surfaceBg(isDark),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: emphasized
              ? accent.withOpacity(0.35)
              : HomeDashboardColors.border(isDark).withOpacity(0.8),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: emphasized ? accent : HomeDashboardColors.title(isDark),
            ),
          ),
        ],
      ),
    );
  }
}
