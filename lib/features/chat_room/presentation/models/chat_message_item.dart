class ChatMessageItem {
  final String id;
  final String text;
  final String timeLabel;
  final bool isOutgoing;
  final bool isRead;
  final bool showAvatar;
  final String? reactionEmoji;

  const ChatMessageItem({
    required this.id,
    required this.text,
    required this.timeLabel,
    required this.isOutgoing,
    this.isRead = false,
    this.showAvatar = false,
    this.reactionEmoji,
  });

  ChatMessageItem copyWith({
    String? reactionEmoji,
    bool clearReaction = false,
  }) {
    return ChatMessageItem(
      id: id,
      text: text,
      timeLabel: timeLabel,
      isOutgoing: isOutgoing,
      isRead: isRead,
      showAvatar: showAvatar,
      reactionEmoji:
          clearReaction ? null : (reactionEmoji ?? this.reactionEmoji),
    );
  }
}
