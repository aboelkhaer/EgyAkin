import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_conversations_list_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_media_list_models.dart';

import '../../../../exports.dart';

abstract class ChatRoomRepository {
  Future<Either<Failure, ChatMessagesListModelResponse>> getMessages({
    required int contextId,
    required String chatType,
    int? before,
  });

  Future<Either<Failure, ChatMessageEnvelopeModelResponse>> sendMessage({
    required int contextId,
    required String chatType,
    String? content,
    int? replyToId,
    bool isForwarded = false,
    List<File> images,
    List<File> voices,
    List<int> voiceDurationsSeconds,
    List<File> files,
    CancelToken? cancelToken,
  });

  Future<Either<Failure, ChatMessageEnvelopeModelResponse>> forwardMessage({
    required int conversationId,
    required int messageId,
    required String chatType,
    required int contextId,
  });

  Future<Either<Failure, ChatReactionsEnvelopeModelResponse>> toggleReaction({
    required int conversationId,
    required int messageId,
    required String reaction,
  });

  Future<Either<Failure, ChatEnvelopeModel>> deleteMessage({
    required int conversationId,
    required int messageId,
    bool forEveryone = false,
  });

  Future<Either<Failure, ChatMessageEnvelopeModelResponse>> editMessage({
    required int conversationId,
    required String chatType,
    required int messageId,
    required String content,
  });

  Future<Either<Failure, ChatUsersSearchModelResponse>> searchUsers(
      String query);

  Future<Either<Failure, ChatMessageSearchModelResponse>> searchMessages({
    required String query,
    int page = 1,
    int perPage = 30,
  });

  Future<Either<Failure, ChatConversationEnvelopeModelResponse>> createGroup({
    required String name,
    String? description,
    required List<int> participantIds,
  });

  Future<Either<Failure, ChatConversationEnvelopeModelResponse>>
      getConversation({
    required int contextId,
    required String chatType,
  });

  Future<Either<Failure, ChatConversationEnvelopeModelResponse>>
      updateConversation({
    required int contextId,
    required String chatType,
    String? name,
    File? image,
  });

  Future<Either<Failure, ChatEnvelopeModel>> addParticipants({
    required int contextId,
    required String chatType,
    required List<int> userIds,
  });

  Future<Either<Failure, ChatEnvelopeModel>> leaveConversation({
    required int contextId,
    required String chatType,
  });

  Future<Either<Failure, ChatEnvelopeModel>> removeParticipant({
    required int contextId,
    required String chatType,
    required int userId,
  });

  Future<Either<Failure, ChatEnvelopeModel>> setConversationMute({
    required int contextId,
    required String chatType,
    required bool mute,
  });

  Future<Either<Failure, ChatEnvelopeModel>> setConversationPin({
    required int contextId,
    required String chatType,
    required bool pinned,
  });

  Future<Either<Failure, ChatEnvelopeModel>> setConversationArchive({
    required int contextId,
    required String chatType,
    required bool archived,
  });

  Future<Either<Failure, ChatEnvelopeModel>> setConversationHidden({
    required int contextId,
    required String chatType,
    required bool hidden,
  });

  Future<Either<Failure, ChatEnvelopeModel>> setConversationUnread({
    required int contextId,
    required String chatType,
    required bool unread,
  });

  Future<Either<Failure, ChatEnvelopeModel>> markDelivered({
    required int contextId,
    required String chatType,
  });

  Future<Either<Failure, ChatEnvelopeModel>> sendTyping({
    required int contextId,
    required String chatType,
    required bool isTyping,
    String? activity,
  });

  Future<Either<Failure, ChatConversationsListModelResponse>> getConversations({
    int? archived,
    String? type,
    int page = 1,
  });

  Future<Either<Failure, ChatMediaListModelResponse>> getConversationMedia({
    required int contextId,
    required String chatType,
    required String mediaType,
    int page = 1,
  });
}
