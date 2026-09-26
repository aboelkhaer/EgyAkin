import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_conversations_list_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_media_list_models.dart';
import 'package:egy_akin/features/chat_room/data/datasources/chat_room_datasource.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';

import '../../../../exports.dart';

class ChatRoomRepositoryImpl extends ChatRoomRepository {
  final ChatRoomDataSource chatRoomRemoteDataSource;
  final NetworkInfo networkInfo;

  ChatRoomRepositoryImpl(this.chatRoomRemoteDataSource, this.networkInfo);

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() call) async {
    if (!await networkInfo.isConnected) {
      return Left(DataSource.noInternetConnection.getFailure());
    }
    try {
      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
      final response = await call();
      return Right(response);
    } catch (error) {
      debugPrint(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ChatMessagesListModelResponse>> getMessages({
    required int contextId,
    required String chatType,
    int? before,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.getMessages(
        contextId: contextId,
        chatType: chatType,
        before: before,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatMessageEnvelopeModelResponse>> sendMessage({
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
    return _guard(
      () => chatRoomRemoteDataSource.sendMessage(
        contextId: contextId,
        chatType: chatType,
        content: content,
        replyToId: replyToId,
        isForwarded: isForwarded,
        images: images,
        voices: voices,
        voiceDurationsSeconds: voiceDurationsSeconds,
        files: files,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatMessageEnvelopeModelResponse>> forwardMessage({
    required int conversationId,
    required int messageId,
    required String chatType,
    required int contextId,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.forwardMessage(
        conversationId: conversationId,
        messageId: messageId,
        chatType: chatType,
        contextId: contextId,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatReactionsEnvelopeModelResponse>> toggleReaction({
    required int conversationId,
    required int messageId,
    required String reaction,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.toggleReaction(
        conversationId: conversationId,
        messageId: messageId,
        reaction: reaction,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> deleteMessage({
    required int conversationId,
    required int messageId,
    bool forEveryone = false,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.deleteMessage(
        conversationId: conversationId,
        messageId: messageId,
        forEveryone: forEveryone,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatMessageEnvelopeModelResponse>> editMessage({
    required int conversationId,
    required String chatType,
    required int messageId,
    required String content,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.editMessage(
        conversationId: conversationId,
        chatType: chatType,
        messageId: messageId,
        content: content,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatUsersSearchModelResponse>> searchUsers(
      String query) {
    return _guard(() => chatRoomRemoteDataSource.searchUsers(query));
  }

  @override
  Future<Either<Failure, ChatMessageSearchModelResponse>> searchMessages({
    required String query,
    int page = 1,
    int perPage = 30,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.searchMessages(
        query: query,
        page: page,
        perPage: perPage,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatConversationEnvelopeModelResponse>> createGroup({
    required String name,
    String? description,
    required List<int> participantIds,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.createGroup(
        name: name,
        description: description,
        participantIds: participantIds,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatConversationEnvelopeModelResponse>>
      getConversation({
    required int contextId,
    required String chatType,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.getConversation(
        contextId: contextId,
        chatType: chatType,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatConversationEnvelopeModelResponse>>
      updateConversation({
    required int contextId,
    required String chatType,
    String? name,
    File? image,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.updateConversation(
        contextId: contextId,
        chatType: chatType,
        name: name,
        image: image,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> addParticipants({
    required int contextId,
    required String chatType,
    required List<int> userIds,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.addParticipants(
        contextId: contextId,
        chatType: chatType,
        userIds: userIds,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> leaveConversation({
    required int contextId,
    required String chatType,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.leaveConversation(
        contextId: contextId,
        chatType: chatType,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> removeParticipant({
    required int contextId,
    required String chatType,
    required int userId,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.removeParticipant(
        contextId: contextId,
        chatType: chatType,
        userId: userId,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> setConversationMute({
    required int contextId,
    required String chatType,
    required bool mute,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.setConversationMute(
        contextId: contextId,
        chatType: chatType,
        mute: mute,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> setConversationPin({
    required int contextId,
    required String chatType,
    required bool pinned,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.setConversationPin(
        contextId: contextId,
        chatType: chatType,
        pinned: pinned,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> setConversationArchive({
    required int contextId,
    required String chatType,
    required bool archived,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.setConversationArchive(
        contextId: contextId,
        chatType: chatType,
        archived: archived,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> setConversationHidden({
    required int contextId,
    required String chatType,
    required bool hidden,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.setConversationHidden(
        contextId: contextId,
        chatType: chatType,
        hidden: hidden,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> setConversationUnread({
    required int contextId,
    required String chatType,
    required bool unread,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.setConversationUnread(
        contextId: contextId,
        chatType: chatType,
        unread: unread,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> markDelivered({
    required int contextId,
    required String chatType,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.markDelivered(
        contextId: contextId,
        chatType: chatType,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatEnvelopeModel>> sendTyping({
    required int contextId,
    required String chatType,
    required bool isTyping,
    String? activity,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.sendTyping(
        contextId: contextId,
        chatType: chatType,
        isTyping: isTyping,
        activity: activity,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatConversationsListModelResponse>> getConversations({
    int? archived,
    String? type,
    int page = 1,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.getConversations(
        archived: archived,
        type: type,
        page: page,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatMediaListModelResponse>> getConversationMedia({
    required int contextId,
    required String chatType,
    required String mediaType,
    int page = 1,
  }) {
    return _guard(
      () => chatRoomRemoteDataSource.getConversationMedia(
        contextId: contextId,
        chatType: chatType,
        mediaType: mediaType,
        page: page,
      ),
    );
  }
}
