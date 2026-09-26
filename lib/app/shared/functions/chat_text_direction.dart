import 'package:flutter/material.dart';

/// Shared chat/post text direction: Arabic starts on the right.
class ChatTextDirection {
  ChatTextDirection._();

  static final RegExp arabicStrong = RegExp(
    r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
  );
  static final RegExp latinStrong = RegExp(r'[A-Za-z]');
  static final RegExp _urlStart = RegExp(r'https?://', caseSensitive: false);

  /// Prefer RTL when the message is Arabic (or Arabic-leading after weak chars).
  /// Skips URLs, digits, emoji, and punctuation so they don't force LTR.
  static TextDirection resolve(
    String text, {
    TextDirection fallback = TextDirection.ltr,
  }) {
    final trimmed = text.trimLeft();
    if (trimmed.isEmpty) return fallback;

    final hasArabic = arabicStrong.hasMatch(trimmed);
    final hasLatin = latinStrong.hasMatch(trimmed);
    if (hasArabic && !hasLatin) return TextDirection.rtl;
    if (!hasArabic && hasLatin) return TextDirection.ltr;

    // Mixed / leading weak chars — first strong letter wins (skip URLs).
    var i = 0;
    final units = trimmed.runes.toList(growable: false);
    while (i < units.length) {
      final ch = String.fromCharCode(units[i]);
      final rest = String.fromCharCodes(units.skip(i));
      final url = _urlStart.matchAsPrefix(rest);
      if (url != null) {
        // Skip until whitespace or end.
        i += url.end;
        while (i < units.length) {
          final c = String.fromCharCode(units[i]);
          if (c.trim().isEmpty) break;
          i++;
        }
        continue;
      }
      if (arabicStrong.hasMatch(ch)) return TextDirection.rtl;
      if (latinStrong.hasMatch(ch)) return TextDirection.ltr;
      i++;
    }

    if (hasArabic) return TextDirection.rtl;
    return fallback;
  }
}
