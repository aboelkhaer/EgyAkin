import 'package:egy_akin/app/services/deep_link_handler.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../exports.dart';

/// Professional share sheet for community posts.
Future<void> showSharePostSheet({
  required BuildContext context,
  required PostCommunityModel feed,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (ctx) => _SharePostSheet(feed: feed),
  );
}

class _SharePostSheet extends StatefulWidget {
  final PostCommunityModel feed;

  const _SharePostSheet({required this.feed});

  @override
  State<_SharePostSheet> createState() => _SharePostSheetState();
}

class _SharePostSheetState extends State<_SharePostSheet> {
  bool _sharing = false;
  bool _copied = false;
  bool _showCopiedToast = false;
  final GlobalKey _shareOriginKey = GlobalKey();
  Timer? _copiedTimer;

  @override
  void dispose() {
    _copiedTimer?.cancel();
    super.dispose();
  }

  String get _deepLink =>
      DeepLinkHandler().generatePostDeepLink(widget.feed.id.toString());

  String get _authorName {
    final d = widget.feed.doctor;
    if (d == null) return 'EgyAkin';
    return doctorName(
      firstName: d.firstName,
      lastName: d.lastName,
      role: d.isSyndicateCardRequired?.toString() ?? '',
    );
  }

  String get _previewText {
    final pollQ = widget.feed.poll?.question?.trim();
    if (pollQ != null && pollQ.isNotEmpty) return pollQ;
    final content = (widget.feed.content ?? '').trim();
    if (content.isNotEmpty) return content;
    if (widget.feed.mediaPath?.isNotEmpty == true) {
      return context.tr(AppStrings.photo);
    }
    return context.tr(AppStrings.checkOutThisPostOnEgyAkin);
  }

  String? get _thumbUrl {
    final paths = widget.feed.mediaPath;
    if (paths == null || paths.isEmpty) return null;
    final first = paths.first.trim();
    return first.isEmpty ? null : first;
  }

  /// Short caption + **one** post URL.
  /// Chat apps (WhatsApp, iMessage, …) build the rich card from the page’s
  /// Open Graph tags — long multi-link text blocks suppress that preview.
  String _shareBody() {
    final snippet = _previewText;
    final clipped = snippet.length > 120
        ? '${snippet.substring(0, 117).trimRight()}…'
        : snippet;

    return '$clipped\n— $_authorName\n\n$_deepLink';
  }

  Future<void> _copyLink() async {
    await Clipboard.setData(ClipboardData(text: _deepLink));
    HapticFeedback.selectionClick();
    if (!mounted) return;
    _copiedTimer?.cancel();
    setState(() {
      _copied = true;
      _showCopiedToast = true;
    });
    _copiedTimer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      setState(() {
        _copied = false;
        _showCopiedToast = false;
      });
    });
  }

  Future<void> _shareViaSystem() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      final box =
          _shareOriginKey.currentContext?.findRenderObject() as RenderBox?;
      final origin = box != null
          ? Rect.fromLTWH(
              box.localToGlobal(Offset.zero).dx,
              box.localToGlobal(Offset.zero).dy,
              box.size.width,
              box.size.height,
            )
          : null;

      final uri = Uri.tryParse(_deepLink);
      // Prefer URI share so iOS/Android can surface a link preview card.
      if (uri != null) {
        try {
          await Share.shareUri(uri, sharePositionOrigin: origin);
        } catch (_) {
          await Share.share(
            _shareBody(),
            subject: '$_authorName · EgyAkin',
            sharePositionOrigin: origin,
          );
        }
      } else {
        await Share.share(
          _shareBody(),
          subject: '$_authorName · EgyAkin',
          sharePositionOrigin: origin,
        );
      }
      if (mounted) Navigator.of(context).maybePop();
    } catch (e) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: '${context.tr(AppStrings.failedToShare)}: $e',
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
    final primary = HomeDashboardColors.primary(isDark);
    final title = HomeDashboardColors.title(isDark);
    final subtitle = HomeDashboardColors.subtitle(isDark);
    final sheetBg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7);
    final cardBg = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final thumb = _thumbUrl;
    final doctorImage = widget.feed.doctor?.image?.toString() ?? '';

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h + bottom * 0.25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.22)
                    : Colors.black.withOpacity(0.12),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: sheetBg,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 12.w, 8.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr(AppStrings.sharePost),
                            style: TextStyle(
                              color: title,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Material(
                          color: isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.05),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => Navigator.of(context).maybePop(),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Icon(
                                Icons.close_rounded,
                                size: 18.sp,
                                color: subtitle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 14.h),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: primary.withOpacity(isDark ? 0.22 : 0.12),
                        ),
                        boxShadow: isDark
                            ? null
                            : [
                                BoxShadow(
                                  color: primary.withOpacity(0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AuthorAvatar(
                            imageUrl: doctorImage,
                            primary: primary,
                            name: _authorName,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _authorName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: title,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  _previewText,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: subtitle,
                                    fontSize: 12.sp,
                                    height: 1.35,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (widget.feed.group?.name != null) ...[
                                  SizedBox(height: 8.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(
                                        isDark ? 0.18 : 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      widget.feed.group!.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (thumb != null) ...[
                            SizedBox(width: 10.w),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CustomCachedNetworkImage(
                                imageUrl: thumb,
                                width: 64.r,
                                height: 64.r,
                                fit: BoxFit.cover,
                                showLoaderPlaceholder: false,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: _showCopiedToast
                        ? Padding(
                            padding:
                                EdgeInsets.fromLTRB(14.w, 0, 14.w, 12.h),
                            child: _CopiedToast(
                              isDark: isDark,
                              primary: primary,
                              message:
                                  context.tr(AppStrings.reportLinkCopied),
                            ),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 16.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: _ShareActionTile(
                            key: _shareOriginKey,
                            isDark: isDark,
                            primary: primary,
                            icon: Icons.ios_share_rounded,
                            label: context.tr(AppStrings.shareVia),
                            loading: _sharing,
                            onTap: _shareViaSystem,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _ShareActionTile(
                            isDark: isDark,
                            primary: primary,
                            icon: _copied
                                ? Icons.check_rounded
                                : Icons.link_rounded,
                            label: _copied
                                ? context.tr(AppStrings.copied)
                                : context.tr(AppStrings.copyLink),
                            accentFilled: _copied,
                            onTap: _copyLink,
                          ),
                        ),
                      ],
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
}

class _CopiedToast extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String message;

  const _CopiedToast({
    required this.isDark,
    required this.primary,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 8),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: primary.withOpacity(isDark ? 0.22 : 0.1),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: primary.withOpacity(isDark ? 0.35 : 0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 28.r,
              height: 28.r,
              decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: HomeDashboardColors.title(isDark),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthorAvatar extends StatelessWidget {
  final String imageUrl;
  final String name;
  final Color primary;

  const _AuthorAvatar({
    required this.imageUrl,
    required this.name,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : 'E';
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primary.withOpacity(0.35), width: 1.4),
      ),
      child: ClipOval(
        child: imageUrl.isEmpty
            ? ColoredBox(
                color: primary.withOpacity(0.14),
                child: Center(
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              )
            : CustomCachedNetworkImage(
                imageUrl: imageUrl,
                width: 40.r,
                height: 40.r,
                fit: BoxFit.cover,
                showLoaderPlaceholder: false,
              ),
      ),
    );
  }
}

class _ShareActionTile extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool loading;
  final bool accentFilled;

  const _ShareActionTile({
    super.key,
    required this.isDark,
    required this.primary,
    required this.icon,
    required this.label,
    required this.onTap,
    this.loading = false,
    this.accentFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = accentFilled
        ? primary
        : (isDark ? const Color(0xFF2C2C2E) : Colors.white);
    final fg = accentFilled
        ? Colors.white
        : HomeDashboardColors.title(isDark);
    final sub = accentFilled
        ? Colors.white.withOpacity(0.9)
        : HomeDashboardColors.subtitle(isDark);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: accentFilled
                ? null
                : Border.all(
                    color: primary.withOpacity(isDark ? 0.2 : 0.12),
                  ),
          ),
          child: Column(
            children: [
              Container(
                width: 42.r,
                height: 42.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentFilled
                      ? Colors.white.withOpacity(0.18)
                      : primary.withOpacity(isDark ? 0.2 : 0.1),
                ),
                child: Center(
                  child: loading
                      ? SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: primary,
                          ),
                        )
                      : Icon(icon, color: accentFilled ? Colors.white : primary, size: 20.sp),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: fg,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                accentFilled
                    ? context.tr(AppStrings.linkReady)
                    : context.tr(AppStrings.tapToContinue),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: sub,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
