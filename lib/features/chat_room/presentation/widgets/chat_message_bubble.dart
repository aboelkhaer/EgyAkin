import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageItem message;
  final String? peerImageUrl;
  final String peerInitials;
  final void Function(Rect anchorRect)? onLongPress;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.peerInitials,
    this.peerImageUrl,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ChatMessageBubbleContent(
      message: message,
      peerInitials: peerInitials,
      peerImageUrl: peerImageUrl,
      onLongPress: onLongPress,
    );
  }
}

/// Time + read ticks shown inside the message bubble.
class ChatMessageMetaRow extends StatelessWidget {
  final ChatMessageItem message;
  final bool alignEnd;
  final bool onPrimaryBackground;

  const ChatMessageMetaRow({
    super.key,
    required this.message,
    this.alignEnd = false,
    this.onPrimaryBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final timeColor = onPrimaryBackground
            ? Colors.white.withOpacity(0.78)
            : (isDarkMode
                ? AppColors.darkDescription
                : AppColors.description);

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(
              message.timeLabel,
              style: TextStyle(
                fontSize: 10.sp,
                color: timeColor,
              ),
            ),
            if (message.isRead) ...[
              SizedBox(width: 3.w),
              Icon(
                Icons.done_all_rounded,
                size: 14.sp,
                color: onPrimaryBackground
                    ? Colors.white.withOpacity(0.9)
                    : Colors.blue.shade400,
              ),
            ],
          ],
        );
      },
    );
  }
}

/// The bubble card only (text + time inside). Used in list and overlay.
class MessageBubbleCard extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final bool isOutgoing;
  final void Function(Rect anchorRect)? onLongPress;

  const MessageBubbleCard({
    super.key,
    required this.message,
    required this.isDarkMode,
    required this.isOutgoing,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 6.h),
      decoration: BoxDecoration(
        color: isOutgoing
            ? AppColors.primary
            : (isDarkMode ? AppColors.darkCardBG : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          topRight: Radius.circular(14.r),
          bottomLeft: Radius.circular(isOutgoing ? 14.r : 4.r),
          bottomRight: Radius.circular(isOutgoing ? 4.r : 14.r),
        ),
        boxShadow: isOutgoing
            ? null
            : (isDarkMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]),
      ),
      child: Column(
        crossAxisAlignment:
            isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.text,
            style: TextStyle(
              color: isOutgoing
                  ? Colors.white
                  : (isDarkMode ? AppColors.darkTitle : AppColors.title),
              fontSize: 12.sp,
              height: 1.35,
            ),
          ),
          SizedBox(height: 4.h),
          ChatMessageMetaRow(
            message: message,
            alignEnd: isOutgoing,
            onPrimaryBackground: isOutgoing,
          ),
        ],
      ),
    );

    final bubble = Stack(
      clipBehavior: Clip.none,
      children: [
        card,
        if (message.reactionEmoji != null)
          Positioned(
            right: isOutgoing ? -4.w : null,
            left: isOutgoing ? null : -4.w,
            bottom: -10.h,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                message.reactionEmoji!,
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ),
      ],
    );

    if (onLongPress == null) return bubble;

    return _BubbleLongPressTarget(
      onLongPress: onLongPress,
      child: bubble,
    );
  }
}

/// Shared bubble UI for list items and long-press overlay.
class ChatMessageBubbleContent extends StatelessWidget {
  final ChatMessageItem message;
  final String? peerImageUrl;
  final String peerInitials;
  final bool inOverlay;
  final void Function(Rect anchorRect)? onLongPress;

  const ChatMessageBubbleContent({
    super.key,
    required this.message,
    required this.peerInitials,
    this.peerImageUrl,
    this.inOverlay = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        if (inOverlay) {
          return MessageBubbleCard(
            message: message,
            isDarkMode: isDarkMode,
            isOutgoing: message.isOutgoing,
          );
        }

        if (message.isOutgoing) {
          return _OutgoingBubble(
            message: message,
            isDarkMode: isDarkMode,
            onLongPress: onLongPress,
          );
        }
        return _IncomingBubble(
          message: message,
          isDarkMode: isDarkMode,
          peerImageUrl: peerImageUrl,
          peerInitials: peerInitials,
          onLongPress: onLongPress,
        );
      },
    );
  }
}

class _BubbleLongPressTarget extends StatelessWidget {
  final void Function(Rect anchorRect)? onLongPress;
  final Widget child;

  const _BubbleLongPressTarget({
    required this.child,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    if (onLongPress == null) return child;

    return Builder(
      builder: (targetContext) {
        return GestureDetector(
          onLongPress: () {
            final box = targetContext.findRenderObject() as RenderBox?;
            if (box == null || !box.hasSize) return;
            final offset = box.localToGlobal(Offset.zero);
            onLongPress!(offset & box.size);
          },
          behavior: HitTestBehavior.opaque,
          child: child,
        );
      },
    );
  }
}

class _OutgoingBubble extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final void Function(Rect anchorRect)? onLongPress;

  const _OutgoingBubble({
    required this.message,
    required this.isDarkMode,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 48.w, right: 12.w, bottom: 4.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: MessageBubbleCard(
          message: message,
          isDarkMode: isDarkMode,
          isOutgoing: true,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}

class _IncomingBubble extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final String? peerImageUrl;
  final String peerInitials;
  final void Function(Rect anchorRect)? onLongPress;

  const _IncomingBubble({
    required this.message,
    required this.isDarkMode,
    this.peerImageUrl,
    required this.peerInitials,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 48.w, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.showAvatar)
            Padding(
              padding: EdgeInsets.only(right: 6.w, bottom: 4.h),
              child: CircleAvatar(
                radius: 12.r,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: peerImageUrl != null && peerImageUrl!.isNotEmpty
                    ? ClipOval(
                        child: CustomCachedNetworkImage(
                          imageUrl: peerImageUrl!,
                          width: 24.r,
                          height: 24.r,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        peerInitials,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 9.sp,
                        ),
                      ),
              ),
            )
          else
            SizedBox(width: 30.w),
          Flexible(
            child: MessageBubbleCard(
              message: message,
              isDarkMode: isDarkMode,
              isOutgoing: false,
              onLongPress: onLongPress,
            ),
          ),
        ],
      ),
    );
  }
}
