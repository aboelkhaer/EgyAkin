import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';

part 'chat_room_state.freezed.dart';

@freezed
class ChatRoomState with _$ChatRoomState {
  const factory ChatRoomState.initial() = _Initial;
  const factory ChatRoomState.loading() = _Loading;
  const factory ChatRoomState.loaded({
    required List<ChatMessageItem> messages,
    int? conversationId,
    @Default(false) bool hasMore,
    @Default(false) bool isSending,
    @Default(false) bool isLoadingMore,
    @Default(false) bool peerIsTyping,
    @Default(ChatComposerActivity.none) ChatComposerActivity peerActivity,
    String? peerTypingName,
    /// Peer is currently in this conversation channel (Ably presence).
    @Default(false) bool peerIsOnline,
    /// Message the user is replying to (shown as a banner above input).
    ChatMessageItem? replyToMessage,
    /// Message currently being edited (WhatsApp-style banner above input).
    ChatMessageItem? editingMessage,
    /// Bumps when group roster changes so the header subtitle rebuilds.
    @Default(0) int rosterVersion,
  }) = _Loaded;
  const factory ChatRoomState.error(String message) = _Error;
}
