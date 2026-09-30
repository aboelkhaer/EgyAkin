import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';

import '../../../../exports.dart';

/// Local set of user ids **you** blocked in 1:1 chat, plus list/block/unblock API.
///
/// Inbox still returns private threads after a block — compare
/// counterpart user id with [isBlocked] to show a "Blocked" badge.
class ChatBlockService {
  ChatBlockService(this._api, this._networkInfo);

  final ApiServices _api;
  final NetworkInfo _networkInfo;

  final Set<int> _blockedIds = {};
  List<ChatUserModel> _blockedUsers = const [];

  /// Bumps whenever the blocked set / list changes (inbox badges, chat UI).
  final ValueNotifier<int> revision = ValueNotifier<int>(0);

  Set<int> get blockedIds => Set.unmodifiable(_blockedIds);
  List<ChatUserModel> get blockedUsers =>
      List<ChatUserModel>.unmodifiable(_blockedUsers);

  bool isBlocked(int? userId) =>
      userId != null && userId > 0 && _blockedIds.contains(userId);

  static bool isRecipientUnavailableFailure(Failure failure) {
    if (failure.code != ResponseCode.forbidden) return false;
    final m = failure.message.trim().toLowerCase();
    return m.contains('chat_recipient_unavailable') ||
        m.contains('recipient_unavailable');
  }

  void _bump() => revision.value++;

  void clear() {
    _blockedIds.clear();
    _blockedUsers = const [];
    _bump();
  }

  Future<Either<Failure, List<ChatUserModel>>> refresh() async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSource.noInternetConnection.getFailure());
    }
    try {
      final response = await _api.getChatBlockedUsers();
      final list = response.data ?? const <ChatUserModel>[];
      _blockedUsers = List<ChatUserModel>.of(list);
      _blockedIds
        ..clear()
        ..addAll(
          list.map((u) => u.id).whereType<int>().where((id) => id > 0),
        );
      _bump();
      return Right(_blockedUsers);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, void>> blockUser(int userId) async {
    if (userId <= 0) {
      return Left(Failure(ResponseCode.badRequest, 'Invalid user'));
    }
    if (!await _networkInfo.isConnected) {
      return Left(DataSource.noInternetConnection.getFailure());
    }
    try {
      await _api.blockChatUser(userId);
      _blockedIds.add(userId);
      if (!_blockedUsers.any((u) => u.id == userId)) {
        _blockedUsers = [..._blockedUsers, ChatUserModel(id: userId)];
      }
      _bump();
      unawaited(refresh());
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, void>> unblockUser(int userId) async {
    if (userId <= 0) {
      return Left(Failure(ResponseCode.badRequest, 'Invalid user'));
    }
    if (!await _networkInfo.isConnected) {
      return Left(DataSource.noInternetConnection.getFailure());
    }
    try {
      await _api.unblockChatUser(userId);
      _blockedIds.remove(userId);
      _blockedUsers =
          _blockedUsers.where((u) => u.id != userId).toList(growable: false);
      _bump();
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
