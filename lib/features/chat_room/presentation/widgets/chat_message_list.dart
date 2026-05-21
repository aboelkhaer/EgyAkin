import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_bubble.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessageItem> messages;
  final String? peerImageUrl;
  final String peerInitials;
  final void Function(int index, ChatMessageItem message, Rect anchorRect)?
      onMessageLongPress;
  final String? selectedMessageId;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.peerInitials,
    this.peerImageUrl,
    this.onMessageLongPress,
    this.selectedMessageId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.darkSurface
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  context.tr(AppStrings.today).toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            ...List.generate(messages.length, (index) {
              final message = messages[index];
              return _LongPressMessageTile(
                key: ValueKey(message.id),
                index: index,
                message: message,
                peerImageUrl: peerImageUrl,
                peerInitials: peerInitials,
                onMessageLongPress: onMessageLongPress,
                hideWhileSelected: selectedMessageId == message.id,
              );
            }),
          ],
        );
      },
    );
  }
}

class _LongPressMessageTile extends StatelessWidget {
  final int index;
  final ChatMessageItem message;
  final String? peerImageUrl;
  final String peerInitials;
  final void Function(int index, ChatMessageItem message, Rect anchorRect)?
      onMessageLongPress;
  final bool hideWhileSelected;

  const _LongPressMessageTile({
    super.key,
    required this.index,
    required this.message,
    required this.peerInitials,
    this.peerImageUrl,
    this.onMessageLongPress,
    this.hideWhileSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: hideWhileSelected ? 0 : 1,
      child: ChatMessageBubble(
        message: message,
        peerImageUrl: peerImageUrl,
        peerInitials: peerInitials,
        onLongPress: onMessageLongPress == null
            ? null
            : (rect) => onMessageLongPress!(index, message, rect),
      ),
    );
  }
}
