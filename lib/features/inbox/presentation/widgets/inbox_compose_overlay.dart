import 'dart:ui';

import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

enum InboxComposeChoice { member, group }

class InboxComposeOverlay extends StatefulWidget {
  final Rect anchorRect;
  final VoidCallback onDismiss;
  final ValueChanged<InboxComposeChoice> onChoice;

  const InboxComposeOverlay({
    super.key,
    required this.anchorRect,
    required this.onDismiss,
    required this.onChoice,
  });

  @override
  State<InboxComposeOverlay> createState() => _InboxComposeOverlayState();
}

class _InboxComposeOverlayState extends State<InboxComposeOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _backdropFade;
  late final Animation<double> _panelScale;
  late final Animation<double> _panelFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _backdropFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.5, curve: Curves.easeOut),
    );
    _panelScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.08, 0.85, curve: Curves.easeOutBack),
    );
    _panelFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.08, 0.7, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    if (!_controller.isAnimating) {
      await _controller.reverse();
    }
    widget.onDismiss();
  }

  void _select(InboxComposeChoice choice) {
    widget.onChoice(choice);
    _dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final screen = MediaQuery.sizeOf(context);

        const panelMargin = 12.0;
        final maxPanelWidth = screen.width - panelMargin * 2;
        final top = widget.anchorRect.bottom + 8;
        final right = screen.width - widget.anchorRect.right;

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _dismiss,
                  behavior: HitTestBehavior.opaque,
                  child: FadeTransition(
                    opacity: _backdropFade,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: Colors.black.withOpacity(isDark ? 0.42 : 0.28),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: top,
                right: right,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxPanelWidth),
                  child: IntrinsicWidth(
                    child: FadeTransition(
                      opacity: _panelFade,
                      child: ScaleTransition(
                        alignment: Alignment.topRight,
                        scale: _panelScale,
                        child: _ComposePanel(
                          isDark: isDark,
                          primary: primary,
                          onMember: () => _select(InboxComposeChoice.member),
                          onGroup: () => _select(InboxComposeChoice.group),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ComposePanel extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final VoidCallback onMember;
  final VoidCallback onGroup;

  const _ComposePanel({
    required this.isDark,
    required this.primary,
    required this.onMember,
    required this.onGroup,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: HomeDashboardColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: HomeDashboardColors.border(isDark).withOpacity(0.65),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.35 : 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 4.h),
              child: Text(
                context.tr(AppStrings.newMessage),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
            _ComposeOptionTile(
              isDark: isDark,
              icon: Icons.person_outline_rounded,
              iconColor: primary,
              iconBg: primary.withOpacity(isDark ? 0.22 : 0.14),
              title: context.tr(AppStrings.startChatWithMember),
              subtitle: context.tr(AppStrings.startChatWithMemberSubtitle),
              onTap: onMember,
            ),
            Divider(
              height: 1,
              indent: 14.w,
              endIndent: 14.w,
              color: HomeDashboardColors.border(isDark).withOpacity(0.55),
            ),
            _ComposeOptionTile(
              isDark: isDark,
              icon: Icons.groups_rounded,
              iconColor: const Color(0xFF3B82F6),
              iconBg: const Color(0xFF3B82F6).withOpacity(isDark ? 0.22 : 0.14),
              title: context.tr(AppStrings.startGroupChat),
              subtitle: context.tr(AppStrings.startGroupChatSubtitle),
              onTap: onGroup,
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}

class _ComposeOptionTile extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ComposeOptionTile({
    required this.isDark,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
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
