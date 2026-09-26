import 'dart:ui';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_bubble.dart';

enum ChatMessageAction { reply, forward, copy, edit, info, delete }

class ChatMessageOverlay extends StatefulWidget {
  final ChatMessageItem message;
  final Rect anchorRect;
  final bool lockMessagePosition;
  final bool anchorMenuFromBottom;
  final double keyboardInsetAtOpen;
  final double bottomReservedHeight;
  final String peerInitials;
  final String? peerImageUrl;
  final bool isGroup;
  final VoidCallback onDismiss;
  final ValueChanged<String> onEmojiSelected;
  final String? selectedEmoji;
  final ValueChanged<ChatMessageAction> onAction;

  const ChatMessageOverlay({
    super.key,
    required this.message,
    required this.anchorRect,
    this.lockMessagePosition = true,
    this.anchorMenuFromBottom = false,
    this.keyboardInsetAtOpen = 0,
    this.bottomReservedHeight = 52,
    required this.peerInitials,
    this.peerImageUrl,
    this.isGroup = false,
    required this.onDismiss,
    required this.onEmojiSelected,
    this.selectedEmoji,
    required this.onAction,
  });

  @override
  State<ChatMessageOverlay> createState() => _ChatMessageOverlayState();
}

class _ChatMessageOverlayState extends State<ChatMessageOverlay>
    with SingleTickerProviderStateMixin {
  static const _quickEmojis = [
    '👍',
    '❤️',
    '😂',
    '😮',
    '😢',
    '🙏',
    '🔥',
    '👏',
  ];

  static const double kEmojiGap = 8;
  static const double kMenuGap = 8;

  /// ~7 menu rows + divider + padding buffer (scaled in layout).
  static const int _menuRowCount = 7;

  late final AnimationController _controller;
  late final Animation<double> _blurFade;
  late final Animation<double> _contentScale;
  late final Animation<double> _contentFade;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    _blurFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.5, curve: Curves.easeOut),
    );

    _contentScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.05, 0.8, curve: Curves.easeOutCubic),
    );

    _contentFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.05, 0.75, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animateOut(VoidCallback action) async {
    if (_isClosing) return;
    _isClosing = true;
    if (_controller.status != AnimationStatus.dismissed) {
      await _controller.reverse();
    }
    if (mounted) action();
  }

  /// Uses the long-press rect for size and horizontal alignment only.
  Rect _effectiveAnchor(BuildContext context) => widget.anchorRect;

  double _emojiBarHeight() => 44.h;

  /// One menu row: vertical padding + icon/text line.
  double _menuRowHeight() => (9.h * 2) + 20.sp;

  double _menuHeightEstimate() => (_menuRowCount * _menuRowHeight()) + 1.h;

  double _bottomLimit(Size size, EdgeInsets padding) {
    return size.height -
        padding.bottom -
        widget.bottomReservedHeight.h -
        8.h;
  }

  double _columnTop(
    Size size,
    EdgeInsets padding,
    Rect anchor, {
    required bool anchorFromBottom,
  }) {
    final emojiH = _emojiBarHeight();
    final gap = kEmojiGap.h;
    final menuGap = kMenuGap.h;
    final menuH = _menuHeightEstimate() + 6.h;
    final messageH = anchor.height;
    final naturalTop = anchor.top - emojiH - gap;
    final bottomLimit = _bottomLimit(size, padding);
    // Keep the reaction bar fully below the status bar / notch.
    final minTop = padding.top + 8.h;

    // True last message: pin the action menu just above the input bar.
    if (anchorFromBottom) {
      final menuTop = bottomLimit - menuH;
      final messageTop = menuTop - menuGap - messageH;
      final emojiTop = messageTop - gap - emojiH;
      return emojiTop < minTop ? minTop : emojiTop;
    }

    // Lift the column whenever the menu would clip — even if position is locked
    // — so the user can scroll the remaining items.
    final menuBottom = anchor.bottom + menuGap + menuH;
    final overflow = menuBottom - bottomLimit;
    final top = overflow > 0 ? naturalTop - overflow : naturalTop;

    // Top-of-list messages: naturalTop is above the safe area, which would
    // hide the emoji row under the notch. Always push the column down.
    return top < minTop ? minTop : top;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final size = MediaQuery.sizeOf(context);
        final padding = MediaQuery.paddingOf(context);
        final isOutgoing = widget.message.isOutgoing;
        final anchor = _effectiveAnchor(context);
        final columnTop = _columnTop(
          size,
          padding,
          anchor,
          anchorFromBottom: widget.anchorMenuFromBottom,
        );

        final horizontalInset = isOutgoing
            ? (size.width - anchor.right).clamp(12.0, size.width - 12)
            : anchor.left.clamp(12.0, size.width - 12);
        final bottomLimit = _bottomLimit(size, padding);

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final maxColumnHeight =
                (bottomLimit - columnTop).clamp(0.0, size.height);
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => _animateOut(widget.onDismiss),
                    behavior: HitTestBehavior.opaque,
                    child: Opacity(
                      opacity: _blurFade.value,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10 * _blurFade.value + 2,
                          sigmaY: 10 * _blurFade.value + 2,
                        ),
                        child: ColoredBox(
                          color: Colors.black.withOpacity(
                            (isDarkMode ? 0.45 : 0.3) * _blurFade.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: columnTop,
                  left: isOutgoing ? null : horizontalInset,
                  right: isOutgoing ? horizontalInset : null,
                  child: Material(
                    type: MaterialType.transparency,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: (size.width - horizontalInset - 12)
                            .clamp(120.0, size.width),
                      ),
                      child: Transform.scale(
                        scale: 0.96 + (_contentScale.value * 0.04),
                        alignment: isOutgoing
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Opacity(
                          opacity: _contentFade.value.clamp(0.0, 1.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: isOutgoing
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              _EmojiReactionBar(
                                emojis: _quickEmojis,
                                selectedEmoji: widget.selectedEmoji,
                                onEmoji: (emoji) => _animateOut(
                                  () => widget.onEmojiSelected(emoji),
                                ),
                                staggerController: _controller,
                              ),
                              SizedBox(height: kEmojiGap.h),
                              Builder(
                                builder: (context) {
                                  final reserved = _emojiBarHeight() +
                                      kEmojiGap.h +
                                      kMenuGap.h +
                                      _menuHeightEstimate() +
                                      8.h;
                                  final maxBubbleH = (maxColumnHeight - reserved)
                                      .clamp(80.0, maxColumnHeight);
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: maxBubbleH,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: ChatMessageBubbleContent(
                                        message: widget.message,
                                        peerInitials: widget.peerInitials,
                                        peerImageUrl: widget.peerImageUrl,
                                        isGroup: widget.isGroup,
                                        inOverlay: true,
                                        maxHeight: maxBubbleH,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: kMenuGap.h),
                              _MessageActionMenu(
                                message: widget.message,
                                isGroup: widget.isGroup,
                                onAction: (action) => _animateOut(
                                  () => widget.onAction(action),
                                ),
                                staggerController: _controller,
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _EmojiReactionBar extends StatelessWidget {
  final List<String> emojis;
  final String? selectedEmoji;
  final ValueChanged<String> onEmoji;
  final Animation<double> staggerController;

  const _EmojiReactionBar({
    required this.emojis,
    this.selectedEmoji,
    required this.onEmoji,
    required this.staggerController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2E).withOpacity(0.96),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(emojis.length, (index) {
            final start = 0.12 + (index * 0.05);
            final end = (start + 0.32).clamp(0.0, 1.0);
            return AnimatedBuilder(
              animation: staggerController,
              builder: (context, child) {
                final t = Curves.easeOutCubic.transform(
                  ((staggerController.value - start) / (end - start))
                      .clamp(0.0, 1.0),
                );
                return Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 0.85 + (t * 0.15),
                    child: child,
                  ),
                );
              },
              child: GestureDetector(
                onTap: () => onEmoji(emojis[index]),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: selectedEmoji == emojis[index]
                      ? BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Text(emojis[index], style: TextStyle(fontSize: 20.sp)),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MessageActionMenu extends StatelessWidget {
  final ChatMessageItem message;
  final bool isGroup;
  final ValueChanged<ChatMessageAction> onAction;
  final Animation<double> staggerController;

  const _MessageActionMenu({
    required this.message,
    required this.isGroup,
    required this.onAction,
    required this.staggerController,
  });

  List<(ChatMessageAction, String, IconData, bool, bool)> get _items {
    return [
      (
        ChatMessageAction.reply,
        AppStrings.reply,
        Icons.reply_rounded,
        false,
        false,
      ),
      if (message.canEdit)
        (
          ChatMessageAction.edit,
          AppStrings.edit,
          Icons.edit_rounded,
          false,
          false,
        ),
      (
        ChatMessageAction.forward,
        AppStrings.forward,
        Icons.forward_rounded,
        false,
        false,
      ),
      (
        ChatMessageAction.copy,
        AppStrings.copy,
        Icons.copy_rounded,
        false,
        false,
      ),
      if (isGroup &&
          message.isOutgoing &&
          !message.isDeleted &&
          !message.isSystem &&
          int.tryParse(message.id) != null)
        (
          ChatMessageAction.info,
          AppStrings.messageInfo,
          Icons.info_outline_rounded,
          false,
          false,
        ),
      (
        ChatMessageAction.delete,
        AppStrings.delete,
        Icons.delete_outline_rounded,
        true,
        false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return Container(
      width: 200.w,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2E).withOpacity(0.96),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < items.length; i++)
            _AnimatedMenuRow(
              index: i,
              staggerController: staggerController,
              label: context.tr(items[i].$2),
              icon: items[i].$3,
              isDestructive: items[i].$4,
              showTrailingCircle: items[i].$5,
              onTap: () => onAction(items[i].$1),
            ),
        ],
      ),
    );
  }
}

class _AnimatedMenuRow extends StatelessWidget {
  final int index;
  final Animation<double> staggerController;
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool showTrailingCircle;

  const _AnimatedMenuRow({
    required this.index,
    required this.staggerController,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
    this.showTrailingCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final start = 0.18 + (index * 0.06);
    final end = (start + 0.38).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: staggerController,
      builder: (context, child) {
        final t = Curves.easeOutCubic.transform(
          ((staggerController.value - start) / (end - start)).clamp(0.0, 1.0),
        );
        return Transform.translate(
          offset: Offset(0, 8 * (1 - t)),
          child: Opacity(
            opacity: t,
            child: child,
          ),
        );
      },
      child: _MenuRow(
        label: label,
        icon: icon,
        onTap: onTap,
        isDestructive: isDestructive,
        showTrailingCircle: showTrailingCircle,
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool showTrailingCircle;

  const _MenuRow({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
    this.showTrailingCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDestructive ? const Color(0xFFFF6B6B) : Colors.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (showTrailingCircle)
              Container(
                width: 26.w,
                height: 26.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 14.sp),
              )
            else
              Icon(
                icon,
                color: isDestructive ? const Color(0xFFFF6B6B) : Colors.white,
                size: 17.sp,
              ),
          ],
        ),
      ),
    );
  }
}
