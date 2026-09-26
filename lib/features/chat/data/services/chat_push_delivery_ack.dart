import 'dart:convert';

import 'package:egy_akin/app/constants/api_end_point.dart';
import 'package:egy_akin/app/constants/local_storage_key.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Marks chat messages **delivered** when a chat push reaches this device.
///
/// Backend contract:
/// `POST /api/v3/chat/conversations/{context_id}/receipts/delivered?chat_type=…`
/// with `Authorization: Bearer <token>` from SharedPreferences.
///
/// Must stay dependency-light — runs from the FCM background isolate where
/// GetIt / DioFactory may not exist.
class ChatPushDeliveryAck {
  ChatPushDeliveryAck._();

  static const _validChatTypes = {
    ChatApiType.private,
    ChatApiType.caseGroup,
    ChatApiType.group,
    ChatApiType.socialGroup,
  };

  static final Map<String, DateTime> _recentAcks = {};
  static const _dedupeWindow = Duration(seconds: 8);

  /// Call from: background handler, foreground push, notification tap, resume.
  static Future<void> ackFromRemoteMessageData(
    Map<String, dynamic> data,
  ) async {
    try {
      final normalized = _normalizeData(data);

      final chatType = _resolveChatType(normalized);
      var contextId = _asInt(
        normalized['context_id'] ?? normalized['contextId'],
      );

      // Typical FCM payloads omit context_id but still include sender /
      // conversation ids — resolve the REST address the same way the inbox does.
      if (contextId == null || contextId <= 0) {
        if (chatType == ChatApiType.private) {
          contextId = _asInt(
            normalized['sender_id'] ??
                normalized['senderId'] ??
                normalized['from_user_id'] ??
                normalized['counterpart_id'] ??
                normalized['peer_id'],
          );
        } else if (chatType == ChatApiType.group ||
            chatType == ChatApiType.socialGroup ||
            chatType == ChatApiType.caseGroup) {
          contextId = _asInt(
            normalized['conversation_id'] ??
                normalized['conversationId'] ??
                normalized['group_id'] ??
                normalized['groupId'],
          );
        }
      }
      contextId ??= _asInt(
        normalized['conversation_id'] ?? normalized['conversationId'],
      );

      if (contextId == null || contextId <= 0 || chatType == null) {
        debugPrint(
          'ChatPushDeliveryAck: skip missing context_id/chat_type '
          'keys=${normalized.keys.toList()}',
        );
        return;
      }

      final senderId = _asInt(
        normalized['sender_id'] ??
            normalized['senderId'] ??
            normalized['from_user_id'],
      );
      final selfId = await _currentUserId();
      if (selfId != null && senderId != null && senderId == selfId) {
        return;
      }

      final dedupeKey = '$chatType:$contextId';
      final now = DateTime.now();
      final last = _recentAcks[dedupeKey];
      if (last != null && now.difference(last) < _dedupeWindow) return;
      _recentAcks[dedupeKey] = now;
      _recentAcks.removeWhere(
        (_, t) => now.difference(t) > const Duration(minutes: 2),
      );

      // Background isolate: read token from disk (no in-memory session).
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppLocalStrings.keyToken)?.trim() ?? '';
      if (token.isEmpty) {
        debugPrint('ChatPushDeliveryAck: no auth token in SharedPreferences');
        return;
      }

      final uri = Uri.parse(
        '${ApiEndPoint.chatConversations}/$contextId/receipts/delivered',
      ).replace(queryParameters: {'chat_type': chatType});

      final response = await http
          .post(
            uri,
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 12));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint(
          'ChatPushDeliveryAck failed: ${response.statusCode} ${response.body}',
        );
      } else {
        debugPrint(
          'ChatPushDeliveryAck ok context_id=$contextId chat_type=$chatType',
        );
      }
    } catch (e, st) {
      debugPrint('ChatPushDeliveryAck error: $e\n$st');
    }
  }

  /// Parse JSON string payload from a local-notification tap.
  static Future<void> ackFromPayloadString(String? payload) async {
    if (payload == null || payload.trim().isEmpty) return;
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map) {
        await ackFromRemoteMessageData(
          Map<String, dynamic>.from(decoded),
        );
      }
    } catch (e) {
      debugPrint('ChatPushDeliveryAck payload parse failed: $e');
    }
  }

  /// FCM / APNs sometimes nest routing fields; flatten common shapes.
  /// Kept local so this file stays isolate-safe (no GetIt / nav imports).
  static Map<String, dynamic> _normalizeData(Map<String, dynamic> data) {
    final out = <String, dynamic>{};
    void merge(Map raw) {
      raw.forEach((key, value) {
        out[key.toString()] = value;
      });
    }

    merge(data);

    final nested = data['data'];
    if (nested is Map) {
      merge(Map<String, dynamic>.from(nested));
    } else if (nested is String && nested.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(nested);
        if (decoded is Map) merge(Map<String, dynamic>.from(decoded));
      } catch (_) {}
    }

    return out;
  }

  static String? _resolveChatType(Map<String, dynamic> data) {
    final raw = (data['chat_type'] ??
            data['chatType'] ??
            data['conversation_type'] ??
            data['conversationType'] ??
            '')
        .toString()
        .trim()
        .toLowerCase();
    if (raw.isNotEmpty) {
      if (_validChatTypes.contains(raw)) return raw;
      switch (raw) {
        case 'private_chat':
        case 'dm':
        case 'direct':
        case 'one_to_one':
          return ChatApiType.private;
        case 'case':
        case 'casegroup':
          return ChatApiType.caseGroup;
        case 'social':
        case 'socialgroup':
        case 'social_chat':
          return ChatApiType.socialGroup;
        case 'group_chat':
        case 'ad_hoc':
        case 'adhoc':
          return ChatApiType.group;
      }
    }

    // Infer private when the payload only identifies a peer sender.
    final hasSender = _asInt(
          data['sender_id'] ?? data['senderId'] ?? data['from_user_id'],
        ) !=
        null;
    final type = (data['type'] ?? '').toString().trim().toLowerCase();
    final looksLikeChat = type == 'chat_message' ||
        type == 'chat' ||
        type == 'message' ||
        type == 'new_message';
    if (looksLikeChat && hasSender) return ChatApiType.private;
    return null;
  }

  static int? _asInt(Object? value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString().trim());
  }

  static Future<int?> _currentUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(AppLocalStrings.currentDoctorId);
      final fromKey = int.tryParse(stored?.trim() ?? '');
      if (fromKey != null && fromKey > 0) return fromKey;

      final raw = prefs.getString(AppLocalStrings.doctorData);
      if (raw == null || raw.isEmpty) return null;
      final map = jsonDecode(raw);
      if (map is! Map) return null;
      return _asInt(map['id']);
    } catch (_) {
      return null;
    }
  }
}
