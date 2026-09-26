import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity_labels.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_background.dart';

import 'package:egy_akin/exports.dart';

class ChatRoomHeader extends StatelessWidget {
  final String displayName;
  final String? imageUrl;
  final String initials;
  final bool isVerified;
  final bool isOnline;
  final bool isGroup;
  /// Idle group subtitle — member names or "N Members".
  final String? membersSubtitle;
  final ChatComposerActivity peerActivity;
  final String? typingName;
  final VoidCallback? onCall;
  final VoidCallback? onInfo;

  const ChatRoomHeader({
    super.key,
    required this.displayName,
    required this.initials,
    this.imageUrl,
    this.isVerified = false,
    this.isOnline = false,
    this.isGroup = false,
    this.membersSubtitle,
    this.peerActivity = ChatComposerActivity.none,
    this.typingName,
    this.onCall,
    this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final borderColor =
            (isDarkMode ? AppColors.darkBorder : Colors.grey.shade300)
                .withOpacity(0.55);
        // High-contrast on frosted glass (AppColors.title/description wash out).
        final titleColor =
            isDarkMode ? Colors.white : const Color(0xFF0B141A);
        final isBusy = peerActivity.isActive;
        final idleSubtitleColor = isDarkMode
            ? const Color(0xFFAEBAC1)
            : const Color(0xFF54656F);
        final subtitleColor = isBusy
            ? AppColors.primary
            : isGroup
                ? idleSubtitleColor
                : isOnline
                    ? const Color(0xFF1FA855)
                    : idleSubtitleColor;

        final String rawStatusText;
        if (isBusy) {
          // Groups: "Mai is typing…"; 1:1: "is typing…"
          rawStatusText = isGroup
              ? ChatComposerActivityLabels.namedLine(
                  context,
                  fullName: typingName,
                  activity: peerActivity,
                )
              : ChatComposerActivityLabels.withIs(context, peerActivity);
        } else if (isGroup) {
          final members = membersSubtitle?.trim();
          rawStatusText = (members != null && members.isNotEmpty)
              ? members
              : context.tr(AppStrings.members);
        } else if (isOnline) {
          rawStatusText = context.tr(AppStrings.onlineNow);
        } else {
          rawStatusText = context.tr(AppStrings.offline);
        }
        // Typing uses animated dots instead of a static ellipsis.
        final statusText = peerActivity == ChatComposerActivity.typing
            ? rawStatusText.replaceAll(RegExp(r'(\.\.\.|…)\s*$'), '').trim()
            : rawStatusText;

        final statusKey = isBusy
            ? 'activity_${peerActivity.name}_${typingName ?? ''}'
            : isGroup
                ? 'members_${membersSubtitle ?? ''}'
                : isOnline
                    ? 'online'
                    : 'offline';

        return ChatRoomGlassSurface(
          isDark: isDarkMode,
          border: Border(
            bottom: BorderSide(color: borderColor, width: 1),
          ),
          // Blur extends under the status bar; content stays below the notch.
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.primary,
                      size: 18.sp,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onInfo,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 2.h,
                        ),
                        child: Row(
                          children: [
                            _ChatAvatar(
                              imageUrl: imageUrl,
                              initials: initials,
                              // Groups: no online/offline presence indicator.
                              showPresence: !isGroup,
                              isOnline: isOnline || isBusy,
                              isBusy: isBusy,
                              isDark: isDarkMode,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          displayName,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                            color: titleColor,
                                            height: 1.2,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (isVerified) ...[
                                        SizedBox(width: 3.w),
                                        Image.asset(
                                          AppImages.verified,
                                          height: 14.h,
                                          width: 14.w,
                                          color: Colors.green.shade600,
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  _AnimatedStatusLine(
                                    statusKey: statusKey,
                                    text: statusText,
                                    color: subtitleColor,
                                    activity: peerActivity,
                                  ),
                                ],
                              ),
                            ),
                            if (onCall != null)
                              IconButton(
                                onPressed: onCall,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 32.w,
                                  minHeight: 32.h,
                                ),
                                visualDensity: VisualDensity.compact,
                                icon: Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.primary,
                                  size: 18.sp,
                                ),
                              ),
                            if (onInfo != null)
                              Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  color: AppColors.primary,
                                  size: 18.sp,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
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

class _AnimatedStatusLine extends StatelessWidget {
  final String statusKey;
  final String text;
  final Color color;
  final ChatComposerActivity activity;

  const _AnimatedStatusLine({
    required this.statusKey,
    required this.text,
    required this.color,
    required this.activity,
  });

  IconData? get _leadingIcon {
    return switch (activity) {
      ChatComposerActivity.typing => null,
      ChatComposerActivity.recording => Icons.mic_rounded,
      ChatComposerActivity.sendingImage ||
      ChatComposerActivity.sendingImages =>
        Icons.image_outlined,
      ChatComposerActivity.sendingFile ||
      ChatComposerActivity.sendingFiles =>
        Icons.attach_file_rounded,
      ChatComposerActivity.none => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      alignment: Alignment.centerLeft,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 320),
        reverseDuration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.none,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (child, animation) {
          final fade = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );
          final slide = Tween<Offset>(
            begin: const Offset(0, 0.45),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ));
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(
              position: slide,
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(statusKey),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_leadingIcon != null) ...[
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: Icon(
                    _leadingIcon,
                    key: ValueKey(_leadingIcon),
                    size: 11.sp,
                    color: color,
                  ),
                ),
                SizedBox(width: 3.w),
              ],
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                    height: 1.15,
                  ),
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (activity == ChatComposerActivity.typing) ...[
                SizedBox(width: 2.w),
                _TypingDots(color: color),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TypingDots extends StatefulWidget {
  final Color color;

  const _TypingDots({required this.color});

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final t = (_controller.value + index * 0.18) % 1.0;
            final bounce = Curves.easeInOut.transform(
              t < 0.5 ? t * 2 : (1 - t) * 2,
            );
            return Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : 2.w),
              child: Opacity(
                opacity: 0.35 + (0.65 * bounce),
                child: Transform.translate(
                  offset: Offset(0, -2.5 * bounce),
                  child: Container(
                    width: 3.2.r,
                    height: 3.2.r,
                    decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final bool showPresence;
  final bool isOnline;
  final bool isBusy;
  final bool isDark;

  const _ChatAvatar({
    required this.initials,
    required this.isOnline,
    required this.isBusy,
    required this.isDark,
    this.showPresence = true,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final dotColor = isBusy
        ? AppColors.primary
        : isOnline
            ? const Color(0xFF22C55E)
            : (isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF));

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? ClipOval(
                  child: ChatAuthCachedImage(
                    imageUrl: imageUrl!,
                    width: 36.r,
                    height: 36.r,
                    fit: BoxFit.cover,
                  ),
                )
              : Text(
                  initials,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                  ),
                ),
        ),
        if (showPresence)
          Positioned(
            right: 0,
            bottom: 0,
            child: _PresenceDot(
              color: dotColor,
              isActive: isOnline || isBusy,
              borderColor: isDark ? const Color(0xFF1C1826) : Colors.white,
            ),
          ),
      ],
    );
  }
}

class _PresenceDot extends StatefulWidget {
  final Color color;
  final bool isActive;
  final Color borderColor;

  const _PresenceDot({
    required this.color,
    required this.isActive,
    required this.borderColor,
  });

  @override
  State<_PresenceDot> createState() => _PresenceDotState();
}

class _PresenceDotState extends State<_PresenceDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    if (widget.isActive) {
      _pulse.forward(from: 0);
    }
  }

  @override
  void didUpdateWidget(covariant _PresenceDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _pulse.forward(from: 0);
    }
    if (widget.color != oldWidget.color && widget.isActive) {
      _pulse.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final t = Curves.easeOut.transform(_pulse.value.clamp(0.0, 1.0));
        final scale = 1.0 + (0.35 * (1 - t));
        return Transform.scale(
          scale: widget.isActive ? scale : 1,
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        width: 10.r,
        height: 10.r,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.borderColor,
            width: 1.5,
          ),
          boxShadow: widget.isActive
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.45),
                    blurRadius: 6,
                    spreadRadius: 0.5,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
