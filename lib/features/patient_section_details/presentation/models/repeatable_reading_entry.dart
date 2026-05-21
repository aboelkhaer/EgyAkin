import 'dart:convert';

import 'package:intl/intl.dart';

/// One repeatable reading: ISO timestamp + value sent to the API.
class RepeatableReadingEntry {
  final DateTime dateTime;
  final String value;

  const RepeatableReadingEntry({
    required this.dateTime,
    required this.value,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': dateTime.toIso8601String(),
        'value': value,
      };

  static RepeatableReadingEntry? fromDynamic(dynamic raw) {
    if (raw is String) {
      final trimmed = raw.trim();
      if (trimmed.startsWith('{')) {
        try {
          return fromDynamic(jsonDecode(trimmed));
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    if (raw is! Map) return null;

    final map = Map<String, dynamic>.from(
      raw.map((key, value) => MapEntry(key.toString(), value)),
    );

    final ts = map['timestamp'] ??
        map['date'] ??
        map['datetime'] ??
        map['time'] ??
        map['created_at'];
    final valRaw = map['value'] ?? map['val'] ?? map['reading'];
    final val = valRaw?.toString().trim();
    if (val == null || val.isEmpty) return null;

    // Skip API wrapper rows where readings live inside `value` as JSON text.
    if (_isNullTimestamp(ts) && _looksLikeEmbeddedReadingsPayload(valRaw)) {
      return null;
    }

    if (_isNullTimestamp(ts)) return null;

    final parsed = _parseTimestamp(ts);
    if (parsed == null) return null;

    return RepeatableReadingEntry(dateTime: parsed, value: val);
  }

  static bool _isNullTimestamp(dynamic ts) {
    if (ts == null) return true;
    final s = ts.toString().trim().toLowerCase();
    return s.isEmpty || s == 'null';
  }

  static bool _looksLikeEmbeddedReadingsPayload(dynamic valRaw) {
    if (valRaw is List) return true;
    final str = valRaw.toString().trim();
    return str.startsWith('[') || str.startsWith('{');
  }

  static DateTime? _parseTimestamp(dynamic ts) {
    if (ts is DateTime) return ts;
    if (ts is num) {
      final n = ts.toInt();
      if (n > 9999999999) {
        return DateTime.fromMillisecondsSinceEpoch(n, isUtc: true).toLocal();
      }
      return DateTime.fromMillisecondsSinceEpoch(n * 1000, isUtc: true).toLocal();
    }
    return DateTime.tryParse(ts.toString().trim());
  }

  /// Parses readings embedded in `value` (JSON string or list).
  static List<dynamic> _parseEmbeddedReadings(dynamic valRaw) {
    if (valRaw == null) return [];

    if (valRaw is List) {
      return valRaw
          .map(
            (e) => e is Map
                ? Map<String, dynamic>.from(
                    e.map((k, v) => MapEntry(k.toString(), v)),
                  )
                : e,
          )
          .toList();
    }

    final str = valRaw.toString().trim();
    if (str.isEmpty || str == 'null') return [];
    if (!str.startsWith('[') && !str.startsWith('{')) return [];

    try {
      final decoded = jsonDecode(str);
      return normalizeAnswerToList(decoded);
    } catch (_) {
      return [];
    }
  }

  /// Expands one API row (direct reading or wrapper with encoded list in `value`).
  static List<dynamic> _expandAnswerItem(dynamic item) {
    if (item == null) return [];

    if (item is String) {
      final trimmed = item.trim();
      if (trimmed.startsWith('[') || trimmed.startsWith('{')) {
        try {
          return normalizeAnswerToList(jsonDecode(trimmed));
        } catch (_) {
          return [];
        }
      }
      return [];
    }

    if (item is! Map) return [item];

    final map = Map<String, dynamic>.from(
      item.map((key, value) => MapEntry(key.toString(), value)),
    );

    final valRaw = map['value'] ?? map['val'] ?? map['reading'];
    final embedded = _parseEmbeddedReadings(valRaw);
    if (embedded.isNotEmpty) return embedded;

    final ts = map['timestamp'] ??
        map['date'] ??
        map['datetime'] ??
        map['time'] ??
        map['created_at'];

    if (!_isNullTimestamp(ts)) {
      return [map];
    }

    return [];
  }

  /// Normalizes API `answer` into a list of reading maps.
  static List<dynamic> normalizeAnswerToList(dynamic answer) {
    if (answer == null) return [];

    if (answer is String) {
      final trimmed = answer.trim();
      if (trimmed.isEmpty) return [];
      if (trimmed.startsWith('[') || trimmed.startsWith('{')) {
        try {
          return normalizeAnswerToList(jsonDecode(trimmed));
        } catch (_) {
          return [];
        }
      }
      return [];
    }

    if (answer is List) {
      final expanded = <dynamic>[];
      for (final item in answer) {
        expanded.addAll(_expandAnswerItem(item));
      }
      return expanded;
    }

    if (answer is Map) {
      final expanded = _expandAnswerItem(answer);
      if (expanded.isNotEmpty) return expanded;

      final map = Map<String, dynamic>.from(
        answer.map((key, value) => MapEntry(key.toString(), value)),
      );

      for (final key in ['readings', 'items', 'data', 'answers']) {
        final nested = map[key];
        if (nested is List) return normalizeAnswerToList(nested);
      }

      final keys = map.keys.toList();
      final allNumericKeys =
          keys.isNotEmpty && keys.every((k) => int.tryParse(k) != null);
      if (allNumericKeys) {
        keys.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
        return keys.map((k) => map[k]).where((e) => e != null).toList();
      }

      if (map.values.every((v) => v is Map)) {
        return map.values.toList();
      }
    }

    return [];
  }

  static List<RepeatableReadingEntry> listFromAnswer(dynamic answer) {
    final list = normalizeAnswerToList(answer);
    if (list.isEmpty) return [];
    return list
        .map(fromDynamic)
        .whereType<RepeatableReadingEntry>()
        .toList();
  }

  static List<Map<String, dynamic>> toApiPayload(
          List<RepeatableReadingEntry> entries) =>
      entries.map((e) => e.toJson()).toList();

  String get displayDate => DateFormat('d MMM yyyy').format(dateTime);

  String? get displayTime {
    if (dateTime.hour == 0 && dateTime.minute == 0) return null;
    return DateFormat('HH:mm').format(dateTime);
  }

  String get displayLabel {
    final time = displayTime;
    if (time == null) return displayDate;
    return '$displayDate • $time';
  }

  RepeatableReadingEntry copyWith({
    DateTime? dateTime,
    String? value,
  }) {
    return RepeatableReadingEntry(
      dateTime: dateTime ?? this.dateTime,
      value: value ?? this.value,
    );
  }
}

String formatRepeatableAnswerForDisplay(dynamic answer) {
  final entries = RepeatableReadingEntry.listFromAnswer(answer);
  if (entries.isEmpty) return '...';
  return entries
      .map((e) => '${e.displayDate}: ${e.value}')
      .join('\n');
}
