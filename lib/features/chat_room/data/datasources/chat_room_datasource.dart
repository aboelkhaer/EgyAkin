import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_conversations_list_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_media_list_models.dart';

import '../../../../exports.dart';

abstract class ChatRoomDataSource {
  Future<ChatMessagesListModelResponse> getMessages({
    required int contextId,
    required String chatType,
    int? before,
  });

  Future<ChatMessageEnvelopeModelResponse> sendMessage({
    required int contextId,
    required String chatType,
    String? content,
    int? replyToId,
    bool isForwarded,
    List<File> images,
    List<File> voices,
    List<int> voiceDurationsSeconds,
    List<File> files,
    CancelToken? cancelToken,
  });

  Future<ChatMessageEnvelopeModelResponse> forwardMessage({
    required int conversationId,
    required int messageId,
    required String chatType,
    required int contextId,
  });

  Future<ChatReactionsEnvelopeModelResponse> toggleReaction({
    required int conversationId,
    required int messageId,
    required String reaction,
  });

  Future<ChatEnvelopeModel> deleteMessage({
    required int conversationId,
    required int messageId,
    bool forEveryone = false,
  });

  Future<ChatMessageEnvelopeModelResponse> editMessage({
    required int conversationId,
    required String chatType,
    required int messageId,
    required String content,
  });

  Future<ChatUsersSearchModelResponse> searchUsers(String query);

  Future<ChatMessageSearchModelResponse> searchMessages({
    required String query,
    int page = 1,
    int perPage = 30,
  });

  Future<ChatConversationEnvelopeModelResponse> createGroup({
    required String name,
    String? description,
    required List<int> participantIds,
  });

  Future<ChatConversationEnvelopeModelResponse> getConversation({
    required int contextId,
    required String chatType,
  });

  Future<ChatConversationEnvelopeModelResponse> updateConversation({
    required int contextId,
    required String chatType,
    String? name,
    File? image,
  });

  Future<ChatEnvelopeModel> addParticipants({
    required int contextId,
    required String chatType,
    required List<int> userIds,
  });

  Future<ChatEnvelopeModel> leaveConversation({
    required int contextId,
    required String chatType,
  });

  Future<ChatEnvelopeModel> removeParticipant({
    required int contextId,
    required String chatType,
    required int userId,
  });

  Future<ChatEnvelopeModel> setConversationMute({
    required int contextId,
    required String chatType,
    required bool mute,
  });

  Future<ChatEnvelopeModel> setConversationPin({
    required int contextId,
    required String chatType,
    required bool pinned,
  });

  Future<ChatEnvelopeModel> setConversationArchive({
    required int contextId,
    required String chatType,
    required bool archived,
  });

  Future<ChatEnvelopeModel> setConversationHidden({
    required int contextId,
    required String chatType,
    required bool hidden,
  });

  Future<ChatEnvelopeModel> setConversationUnread({
    required int contextId,
    required String chatType,
    required bool unread,
  });

  Future<ChatEnvelopeModel> markDelivered({
    required int contextId,
    required String chatType,
  });

  Future<ChatEnvelopeModel> sendTyping({
    required int contextId,
    required String chatType,
    required bool isTyping,
    String? activity,
  });

  Future<ChatConversationsListModelResponse> getConversations({
    int? archived,
    String? type,
    int page = 1,
  });

  Future<ChatMediaListModelResponse> getConversationMedia({
    required int contextId,
    required String chatType,
    required String mediaType,
    int page = 1,
  });
}

class ChatRoomDataSourceImpl implements ChatRoomDataSource {
  final ApiServices _apiServices;

  ChatRoomDataSourceImpl(this._apiServices);

  @override
  Future<ChatMessagesListModelResponse> getMessages({
    required int contextId,
    required String chatType,
    int? before,
  }) {
    return _apiServices.getChatMessages(contextId, chatType, before);
  }

  @override
  Future<ChatMessageEnvelopeModelResponse> sendMessage({
    required int contextId,
    required String chatType,
    String? content,
    int? replyToId,
    bool isForwarded = false,
    List<File> images = const [],
    List<File> voices = const [],
    List<int> voiceDurationsSeconds = const [],
    List<File> files = const [],
    CancelToken? cancelToken,
  }) {
    return _apiServices.sendChatMessage(
      contextId,
      chatType,
      (content != null && content.isNotEmpty) ? content : null,
      replyToId,
      isForwarded ? '1' : null,
      images,
      voices,
      voiceDurationsSeconds.map((s) => s.toString()).toList(growable: false),
      files,
      cancelToken,
    );
  }

  @override
  Future<ChatMessageEnvelopeModelResponse> forwardMessage({
    required int conversationId,
    required int messageId,
    required String chatType,
    required int contextId,
  }) {
    return _apiServices.forwardChatMessage(
      conversationId,
      messageId,
      {
        'targets': [
          {
            'id': contextId,
            'chat_type': chatType,
          },
        ],
      },
    );
  }

  @override
  Future<ChatReactionsEnvelopeModelResponse> toggleReaction({
    required int conversationId,
    required int messageId,
    required String reaction,
  }) {
    return _apiServices.toggleChatReaction(
      conversationId,
      {
        'message_id': messageId,
        'reaction': reaction,
      },
    );
  }

  @override
  Future<ChatEnvelopeModel> deleteMessage({
    required int conversationId,
    required int messageId,
    bool forEveryone = false,
  }) {
    if (forEveryone) {
      return _apiServices.deleteChatMessageForEveryone(
        conversationId,
        messageId,
      );
    }
    return _apiServices.deleteChatMessageForMe(
      conversationId,
      messageId,
      {
        'conversation_id': conversationId,
        'message_id': messageId,
      },
    );
  }

  @override
  Future<ChatMessageEnvelopeModelResponse> editMessage({
    required int conversationId,
    required String chatType,
    required int messageId,
    required String content,
  }) {
    // Path `{id}` is conversation_id (not context_id).
    return _apiServices.editChatMessage(
      conversationId,
      messageId,
      {
        'chat_type': chatType,
        'content': content,
      },
    );
  }

  @override
  Future<ChatUsersSearchModelResponse> searchUsers(String query) {
    return _apiServices.searchChatUsers(query);
  }

  @override
  Future<ChatMessageSearchModelResponse> searchMessages({
    required String query,
    int page = 1,
    int perPage = 30,
  }) {
    return _apiServices.searchChatMessages(query, page, perPage);
  }

  @override
  Future<ChatConversationEnvelopeModelResponse> createGroup({
    required String name,
    String? description,
    required List<int> participantIds,
  }) {
    return _apiServices.createGroupConversation({
      'type': ChatApiType.group,
      'name': name,
      if (description != null) 'description': description,
      'participant_ids': participantIds,
    });
  }

  @override
  Future<ChatConversationEnvelopeModelResponse> getConversation({
    required int contextId,
    required String chatType,
  }) {
    return _apiServices.getChatConversation(contextId, chatType);
  }

  @override
  Future<ChatConversationEnvelopeModelResponse> updateConversation({
    required int contextId,
    required String chatType,
    String? name,
    File? image,
  }) {
    if (image != null) {
      return _apiServices.updateChatConversationMedia(
        contextId,
        chatType,
        'PUT',
        chatType,
        image,
      );
    }
    return _apiServices.updateChatConversation(
      contextId,
      chatType,
      {
        'chat_type': chatType,
        if (name != null) 'name': name,
      },
    );
  }

  @override
  Future<ChatEnvelopeModel> addParticipants({
    required int contextId,
    required String chatType,
    required List<int> userIds,
  }) {
    return _apiServices.addChatParticipants(contextId, {
      'chat_type': chatType,
      'user_ids': userIds,
    });
  }

  @override
  Future<ChatEnvelopeModel> leaveConversation({
    required int contextId,
    required String chatType,
  }) {
    return _apiServices.leaveChatConversation(contextId, {
      'chat_type': chatType,
    });
  }

  @override
  Future<ChatEnvelopeModel> removeParticipant({
    required int contextId,
    required String chatType,
    required int userId,
  }) {
    return _apiServices.removeChatParticipant(contextId, userId, chatType);
  }

  @override
  Future<ChatEnvelopeModel> setConversationMute({
    required int contextId,
    required String chatType,
    required bool mute,
  }) {
    return _apiServices.setChatConversationMute(contextId, {
      'chat_type': chatType,
      'mute': mute,
    });
  }

  @override
  Future<ChatEnvelopeModel> setConversationPin({
    required int contextId,
    required String chatType,
    required bool pinned,
  }) {
    return _apiServices.setChatConversationPin(contextId, {
      'chat_type': chatType,
      'pinned': pinned,
    });
  }

  @override
  Future<ChatEnvelopeModel> setConversationArchive({
    required int contextId,
    required String chatType,
    required bool archived,
  }) {
    return _apiServices.setChatConversationArchive(contextId, {
      'chat_type': chatType,
      'archived': archived,
    });
  }

  @override
  Future<ChatEnvelopeModel> setConversationHidden({
    required int contextId,
    required String chatType,
    required bool hidden,
  }) {
    return _apiServices.setChatConversationHidden(contextId, {
      'chat_type': chatType,
      'hidden': hidden,
    });
  }

  @override
  Future<ChatEnvelopeModel> setConversationUnread({
    required int contextId,
    required String chatType,
    required bool unread,
  }) {
    return _apiServices.setChatConversationUnread(contextId, {
      'chat_type': chatType,
      'unread': unread,
    });
  }

  @override
  Future<ChatEnvelopeModel> markDelivered({
    required int contextId,
    required String chatType,
  }) {
    return _apiServices.markChatDelivered(contextId, chatType);
  }

  @override
  Future<ChatEnvelopeModel> sendTyping({
    required int contextId,
    required String chatType,
    required bool isTyping,
    String? activity,
  }) {
    return _apiServices.sendChatTyping(
      contextId,
      {
        'chat_type': chatType,
        'is_typing': isTyping,
        if (activity != null && activity.isNotEmpty) 'activity': activity,
      },
    );
  }

  @override
  Future<ChatConversationsListModelResponse> getConversations({
    int? archived,
    String? type,
    int page = 1,
  }) {
    return _apiServices.getChatConversations(
      archived: archived,
      type: type,
      page: page,
    );
  }

  @override
  Future<ChatMediaListModelResponse> getConversationMedia({
    required int contextId,
    required String chatType,
    required String mediaType,
    int page = 1,
  }) {
    return _apiServices.getChatConversationMedia(
      contextId,
      type: mediaType,
      chatType: chatType,
      page: page,
    );
  }
}
