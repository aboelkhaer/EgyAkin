import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Durable queue of unsent messages, keyed by chat identity.
/// Survives leaving the chat room and app kills (files + SharedPreferences).
class ChatPendingSendStore {
  ChatPendingSendStore._();
  static final ChatPendingSendStore instance = ChatPendingSendStore._();

  static const _prefsKey = 'chat_pending_sends_v1';

  final Map<String, Map<String, ChatPendingSendEntry>> _byChat = {};

  /// Shared across cubit instances so leaving mid-upload doesn't double-send.
  final Set<String> _inFlightTempIds = {};

  Future<void>? _loadFuture;
  bool _loaded = false;
  Directory? _rootDir;

  String _chatKey(String chatType, int contextId) => '$chatType:$contextId';

  bool isInFlight(String tempId) => _inFlightTempIds.contains(tempId);

  bool tryMarkInFlight(String tempId) => _inFlightTempIds.add(tempId);

  void clearInFlight(String tempId) => _inFlightTempIds.remove(tempId);

  Future<void> ensureLoaded() {
    if (_loaded) return Future.value();
    return _loadFuture ??= _load();
  }

  Future<void> _load() async {
    try {
      final support = await getApplicationSupportDirectory();
      _rootDir = Directory('${support.path}/chat_pending_sends');
      if (!await _rootDir!.exists()) {
        await _rootDir!.create(recursive: true);
      }

      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsKey);
      _byChat.clear();
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          for (final chatEntry in decoded.entries) {
            final list = chatEntry.value;
            if (list is! List) continue;
            final map = <String, ChatPendingSendEntry>{};
            for (final item in list) {
              if (item is! Map) continue;
              final entry = ChatPendingSendEntry.fromJson(
                Map<String, dynamic>.from(item),
              );
              if (entry == null) continue;
              // Drop entries whose media files vanished.
              if (!_filesExist(entry)) continue;
              map[entry.tempId] = entry;
            }
            if (map.isNotEmpty) {
              _byChat[chatEntry.key] = map;
            }
          }
        }
      }
      _loaded = true;
      unawaited(_persist());
    } catch (e) {
      debugPrint('ChatPendingSendStore load failed: $e');
      _loaded = true;
    }
  }

  bool _filesExist(ChatPendingSendEntry entry) {
    for (final f in [...entry.images, ...entry.voices, ...entry.files]) {
      if (!f.existsSync()) return false;
    }
    return true;
  }

  Future<Directory> _ensureRoot() async {
    if (_rootDir != null) return _rootDir!;
    final support = await getApplicationSupportDirectory();
    _rootDir = Directory('${support.path}/chat_pending_sends');
    if (!await _rootDir!.exists()) {
      await _rootDir!.create(recursive: true);
    }
    return _rootDir!;
  }

  Future<List<File>> _copyFiles({
    required String chatKey,
    required String tempId,
    required String kind,
    required List<File> sources,
  }) async {
    if (sources.isEmpty) return const [];
    final root = await _ensureRoot();
    final dir = Directory('${root.path}/$chatKey/$tempId/$kind');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final out = <File>[];
    for (var i = 0; i < sources.length; i++) {
      final src = sources[i];
      if (!await src.exists()) continue;
      // Already under our durable folder — reuse path.
      if (src.path.startsWith(dir.path)) {
        out.add(src);
        continue;
      }
      final name = src.path.split(RegExp(r'[\\/]')).last;
      final destPath = '${dir.path}/${i}_$name';
      final dest = await src.copy(destPath);
      out.add(dest);
    }
    return out;
  }

  void save({
    required String chatType,
    required int contextId,
    required ChatPendingSendEntry entry,
  }) {
    final key = _chatKey(chatType, contextId);
    final map = _byChat.putIfAbsent(key, () => {});
    map[entry.tempId] = entry;
    unawaited(_saveDurable(chatType: chatType, contextId: contextId, entry: entry));
  }

  Future<void> _saveDurable({
    required String chatType,
    required int contextId,
    required ChatPendingSendEntry entry,
  }) async {
    try {
      await ensureLoaded();
      final key = _chatKey(chatType, contextId);
      final images = await _copyFiles(
        chatKey: key,
        tempId: entry.tempId,
        kind: 'images',
        sources: entry.images,
      );
      final voices = await _copyFiles(
        chatKey: key,
        tempId: entry.tempId,
        kind: 'voices',
        sources: entry.voices,
      );
      final files = await _copyFiles(
        chatKey: key,
        tempId: entry.tempId,
        kind: 'files',
        sources: entry.files,
      );
      final durable = entry.copyWithFiles(
        images: images,
        voices: voices,
        files: files,
      );
      final map = _byChat.putIfAbsent(key, () => {});
      map[entry.tempId] = durable;
      await _persist();
    } catch (e) {
      debugPrint('ChatPendingSendStore save failed: $e');
    }
  }

  void remove({
    required String chatType,
    required int contextId,
    required String tempId,
  }) {
    final key = _chatKey(chatType, contextId);
    _byChat[key]?.remove(tempId);
    unawaited(_removeDurable(chatKey: key, tempId: tempId));
  }

  Future<void> _removeDurable({
    required String chatKey,
    required String tempId,
  }) async {
    try {
      await ensureLoaded();
      final root = await _ensureRoot();
      final dir = Directory('${root.path}/$chatKey/$tempId');
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
      await _persist();
    } catch (e) {
      debugPrint('ChatPendingSendStore remove failed: $e');
    }
  }

  List<ChatPendingSendEntry> entriesFor({
    required String chatType,
    required int contextId,
  }) {
    final map = _byChat[_chatKey(chatType, contextId)];
    if (map == null || map.isEmpty) return const [];
    return map.values.toList(growable: false)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  /// Drop every queued send on sign-out (privacy + avoid sending as next user).
  Future<void> clearAll() async {
    await ensureLoaded();
    _byChat.clear();
    _inFlightTempIds.clear();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
    } catch (e) {
      debugPrint('ChatPendingSendStore clearAll prefs failed: $e');
    }
    try {
      final root = _rootDir;
      if (root != null && await root.exists()) {
        await root.delete(recursive: true);
        await root.create(recursive: true);
      }
    } catch (e) {
      debugPrint('ChatPendingSendStore clearAll files failed: $e');
    }
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = <String, dynamic>{};
      for (final entry in _byChat.entries) {
        if (entry.value.isEmpty) continue;
        encoded[entry.key] =
            entry.value.values.map((e) => e.toJson()).toList(growable: false);
      }
      await prefs.setString(_prefsKey, jsonEncode(encoded));
    } catch (e) {
      debugPrint('ChatPendingSendStore persist failed: $e');
    }
  }
}

class ChatPendingSendEntry {
  final String tempId;
  final String previewText;
  final String timeLabel;
  final ChatMessageStatus status;
  final String? text;
  final List<File> images;
  final List<File> voices;
  final List<File> files;
  final List<int> voiceDurationsMs;
  final int? replyToId;
  final DateTime createdAt;

  const ChatPendingSendEntry({
    required this.tempId,
    required this.previewText,
    required this.timeLabel,
    required this.status,
    required this.createdAt,
    this.text,
    this.images = const [],
    this.voices = const [],
    this.files = const [],
    this.voiceDurationsMs = const [],
    this.replyToId,
  });

  ChatPendingSendEntry copyWithStatus(ChatMessageStatus status) {
    return ChatPendingSendEntry(
      tempId: tempId,
      previewText: previewText,
      timeLabel: timeLabel,
      status: status,
      createdAt: createdAt,
      text: text,
      images: images,
      voices: voices,
      files: files,
      voiceDurationsMs: voiceDurationsMs,
      replyToId: replyToId,
    );
  }

  ChatPendingSendEntry copyWithFiles({
    List<File>? images,
    List<File>? voices,
    List<File>? files,
  }) {
    return ChatPendingSendEntry(
      tempId: tempId,
      previewText: previewText,
      timeLabel: timeLabel,
      status: status,
      createdAt: createdAt,
      text: text,
      images: images ?? this.images,
      voices: voices ?? this.voices,
      files: files ?? this.files,
      voiceDurationsMs: voiceDurationsMs,
      replyToId: replyToId,
    );
  }

  Map<String, dynamic> toJson() => {
        'tempId': tempId,
        'previewText': previewText,
        'timeLabel': timeLabel,
        'status': status.name,
        'text': text,
        'images': images.map((f) => f.path).toList(),
        'voices': voices.map((f) => f.path).toList(),
        'files': files.map((f) => f.path).toList(),
        'voiceDurationsMs': voiceDurationsMs,
        'replyToId': replyToId,
        'createdAt': createdAt.toIso8601String(),
      };

  static ChatPendingSendEntry? fromJson(Map<String, dynamic> json) {
    final tempId = json['tempId'] as String?;
    if (tempId == null || tempId.isEmpty) return null;
    final statusName = json['status'] as String? ?? 'pending';
    final status = ChatMessageStatus.values.firstWhere(
      (s) => s.name == statusName,
      orElse: () => ChatMessageStatus.pending,
    );
    List<File> filesOf(dynamic raw) {
      if (raw is! List) return const [];
      return raw
          .whereType<String>()
          .map(File.new)
          .toList(growable: false);
    }

    return ChatPendingSendEntry(
      tempId: tempId,
      previewText: json['previewText'] as String? ?? '',
      timeLabel: json['timeLabel'] as String? ?? '',
      status: status == ChatMessageStatus.sending
          ? ChatMessageStatus.pending
          : status,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      text: json['text'] as String?,
      images: filesOf(json['images']),
      voices: filesOf(json['voices']),
      files: filesOf(json['files']),
      voiceDurationsMs: (json['voiceDurationsMs'] as List?)
              ?.whereType<num>()
              .map((n) => n.toInt())
              .toList(growable: false) ??
          const [],
      replyToId: (json['replyToId'] as num?)?.toInt(),
    );
  }

  ChatMessageItem toMessageItem() {
    final attachments = <ChatAttachmentItem>[
      ...images.map((f) => ChatAttachmentItem(localFile: f, type: 'image')),
      for (var i = 0; i < voices.length; i++)
        ChatAttachmentItem(
          localFile: voices[i],
          type: 'voice',
          mimeType: 'audio/mp4',
          durationMs: i < voiceDurationsMs.length && voiceDurationsMs[i] > 0
              ? voiceDurationsMs[i]
              : null,
        ),
      ...files.map(
        (f) => ChatAttachmentItem(
          localFile: f,
          type: 'file',
          originalName: f.path.split(RegExp(r'[\\/]')).last,
        ),
      ),
    ];

    return ChatMessageItem(
      id: tempId,
      text: previewText,
      timeLabel: timeLabel,
      createdAt: createdAt,
      isOutgoing: true,
      status: status,
      clientTempId: tempId,
      attachments: attachments,
      uploadProgress: attachments.isNotEmpty &&
              (status == ChatMessageStatus.sending ||
                  status == ChatMessageStatus.pending)
          ? 0.0
          : null,
    );
  }
}
