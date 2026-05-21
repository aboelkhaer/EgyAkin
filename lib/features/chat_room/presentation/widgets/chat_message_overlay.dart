import 'dart:ui';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_bubble.dart';

enum ChatMessageAction { reply, forward, copy, star, delete, more }

class ChatMessageOverlay extends StatefulWidget {
  final ChatMessageItem message;
  final Rect anchorRect;
  final String peerInitials;
  final String? peerImageUrl;
  final VoidCallback onDismiss;
  final ValueChanged<String> onEmojiSelected;
  final ValueChanged<ChatMessageAction> onAction;

  const ChatMessageOverlay({
    super.key,
    required this.message,
    required this.anchorRect,
    required this.peerInitials,
    this.peerImageUrl,
    required this.onDismiss,
    required this.onEmojiSelected,
    required this.onAction,
  });

  @override
  State<ChatMessageOverlay> createState() => _ChatMessageOverlayState();
}

class _ChatMessageOverlayState extends State<ChatMessageOverlay>
    with SingleTickerProviderStateMixin {
  static const _quickEmojis = ['👍', '❤️', '😂', '😮', '😢', '🙏', '🥰'];

  /// Tune spacing here (logical pixels — stable on first open).
  static const double kEmojiGap = 10;
  static const double kMenuGap = 10;

  final GlobalKey _messageKey = GlobalKey();

  late Rect _anchorRect;
  late final AnimationController _controller;
  late final Animation<double> _blurFade;
  late final Animation<double> _emojiScale;
  late final Animation<double> _menuFade;

  @override
  void initState() {
    super.initState();
    _anchorRect = widget.anchorRect;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
    );

    _blurFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.45, curve: Curves.easeOut),
    );

    _emojiScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.78, curve: Curves.easeOutBack),
    );

    _menuFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.9, curve: Curves.easeOut),
    );

    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureMessageRect();
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _measureMessageRect());
    });
  }

  @override
  void didUpdateWidget(ChatMessageOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.anchorRect != widget.anchorRect) {
      _anchorRect = widget.anchorRect;
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _measureMessageRect());
    }
  }

  void _measureMessageRect() {
    if (!mounted) return;
    final box = _messageKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final measured = box.localToGlobal(Offset.zero) & box.size;
    final changed = (_anchorRect.top - measured.top).abs() > 0.5 ||
        (_anchorRect.bottom - measured.bottom).abs() > 0.5 ||
        (_anchorRect.left - measured.left).abs() > 0.5 ||
        (_anchorRect.width - measured.width).abs() > 0.5;

    if (changed) {
      setState(() => _anchorRect = measured);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final size = MediaQuery.sizeOf(context);
        const menuHeight = 220.0;

        final bubbleTop = _anchorRect.top;
        final bubbleLeft = _anchorRect.left;
        final bubbleWidth = _anchorRect.width > 0 ? _anchorRect.width : null;

        // Region ends exactly [kEmojiGap] above the message top; bar aligns to bottom.
        final emojiRegionHeight =
            (_anchorRect.top - kEmojiGap).clamp(0.0, size.height);

        var menuTop = _anchorRect.bottom + kMenuGap;
        if (menuTop + menuHeight > size.height - 24) {
          menuTop = _anchorRect.top - menuHeight - kMenuGap;
        }

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Full-screen blur — header, status bar, input, everything.
                Positioned(
                  top: 0,
                  left: 0,
                  width: size.width,
                  height: size.height,
                  child: GestureDetector(
                    onTap: widget.onDismiss,
                    behavior: HitTestBehavior.opaque,
                    child: Opacity(
                      opacity: _blurFade.value,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10 * _blurFade.value + 2,
                          sigmaY: 10 * _blurFade.value + 2,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(
                              (isDarkMode ? 0.4 : 0.28) * _blurFade.value),
                        ),
                      ),
                    ),
                  ),
                ),
                // Message — sharp, drawn before emoji bar so reactions stay on top.
                Positioned(
                  top: bubbleTop,
                  left: bubbleLeft,
                  width: bubbleWidth,
                  child: KeyedSubtree(
                    key: _messageKey,
                    child: ChatMessageBubbleContent(
                      message: widget.message,
                      peerInitials: widget.peerInitials,
                      peerImageUrl: widget.peerImageUrl,
                      inOverlay: true,
                    ),
                  ),
                ),
                // Emoji bar — bottom edge is always [kEmojiGap] above the message.
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: emojiRegionHeight,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.scale(
                      scale: 0.82 + (_emojiScale.value * 0.18),
                      child: Opacity(
                        opacity: _emojiScale.value.clamp(0.0, 1.0),
                        child: _EmojiReactionBar(
                          emojis: _quickEmojis,
                          onEmoji: widget.onEmojiSelected,
                          onMore: () => widget.onAction(ChatMessageAction.more),
                          staggerController: _controller,
                        ),
                      ),
                    ),
                  ),
                ),
                // Action menu — fade + scale only (no Y offset that breaks gaps).
                Positioned(
                  top: menuTop,
                  left: widget.message.isOutgoing ? null : 20.w,
                  right: widget.message.isOutgoing ? 20.w : null,
                  child: Opacity(
                    opacity: _menuFade.value,
                    child: Transform.scale(
                      scale: 0.94 + (_menuFade.value * 0.06),
                      alignment: widget.message.isOutgoing
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: _MessageActionMenu(
                        onAction: widget.onAction,
                        staggerController: _controller,
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
  final ValueChanged<String> onEmoji;
  final VoidCallback onMore;
  final Animation<double> staggerController;

  const _EmojiReactionBar({
    required this.emojis,
    required this.onEmoji,
    required this.onMore,
    required this.staggerController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 260.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2E).withOpacity(0.94),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(emojis.length, (index) {
            final start = 0.18 + (index * 0.055);
            final end = (start + 0.35).clamp(0.0, 1.0);
            return AnimatedBuilder(
              animation: staggerController,
              builder: (context, child) {
                final t = Curves.easeOutBack.transform(
                  ((staggerController.value - start) / (end - start))
                      .clamp(0.0, 1.0),
                );
                return Transform.scale(
                  scale: t,
                  child: Opacity(
                    opacity: t.clamp(0.0, 1.0),
                    child: child,
                  ),
                );
              },
              child: GestureDetector(
                onTap: () => onEmoji(emojis[index]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Text(emojis[index], style: TextStyle(fontSize: 17.sp)),
                ),
              ),
            );
          }),
          AnimatedBuilder(
            animation: staggerController,
            builder: (context, child) {
              const start = 0.55;
              const end = 0.92;
              final t = Curves.easeOutBack.transform(
                ((staggerController.value - start) / (end - start))
                    .clamp(0.0, 1.0),
              );
              return Transform.scale(
                scale: t,
                child: Opacity(opacity: t.clamp(0.0, 1.0), child: child),
              );
            },
            child: GestureDetector(
              onTap: onMore,
              child: Container(
                width: 26.w,
                height: 26.w,
                margin: EdgeInsets.only(left: 2.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 15.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageActionMenu extends StatelessWidget {
  final ValueChanged<ChatMessageAction> onAction;
  final Animation<double> staggerController;

  const _MessageActionMenu({
    required this.onAction,
    required this.staggerController,
  });

  static const _items = [
    (
      ChatMessageAction.reply,
      AppStrings.reply,
      Icons.reply_rounded,
      false,
      false
    ),
    (
      ChatMessageAction.forward,
      AppStrings.forward,
      Icons.forward_rounded,
      false,
      false
    ),
    (ChatMessageAction.copy, AppStrings.copy, Icons.copy_rounded, false, false),
    (
      ChatMessageAction.star,
      AppStrings.star,
      Icons.star_outline_rounded,
      false,
      false
    ),
    (
      ChatMessageAction.delete,
      AppStrings.delete,
      Icons.delete_outline_rounded,
      true,
      false
    ),
    (
      ChatMessageAction.more,
      AppStrings.moreOptions,
      Icons.more_horiz_rounded,
      false,
      true
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168.w,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2E).withOpacity(0.96),
        borderRadius: BorderRadius.circular(10.r),
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
          for (var i = 0; i < _items.length; i++) ...[
            if (i == 5)
              Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.white.withOpacity(0.1),
              ),
            _AnimatedMenuRow(
              index: i,
              staggerController: staggerController,
              label: context.tr(_items[i].$2),
              icon: _items[i].$3,
              isDestructive: _items[i].$4,
              showTrailingCircle: _items[i].$5,
              onTap: () => onAction(_items[i].$1),
            ),
          ],
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
    final start = 0.22 + (index * 0.07);
    final end = (start + 0.4).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: staggerController,
      builder: (context, child) {
        final t = Curves.easeOutCubic.transform(
          ((staggerController.value - start) / (end - start)).clamp(0.0, 1.0),
        );
        return Transform.translate(
          offset: Offset(0, 10 * (1 - t)),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (showTrailingCircle)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 13.sp),
              )
            else
              Icon(
                icon,
                color: isDestructive ? const Color(0xFFFF6B6B) : Colors.white,
                size: 16.sp,
              ),
          ],
        ),
      ),
    );
  }
}
