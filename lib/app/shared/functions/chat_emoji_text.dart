import 'package:flutter/material.dart';

/// Shared emoji painting for chat composer + bubbles.
///
/// Tajawal has no emoji glyphs. At an Arabic (RTL) ↔ emoji boundary the
/// fallback run often leaves a visible hole. We paint emoji in their own
/// span (system emoji fonts) and, for display-only text, wrap them with
/// RLM so they stay glued to adjacent Arabic.
class ChatEmojiText {
  ChatEmojiText._();

  static final RegExp emojiRegex = RegExp(
    r'(?:\p{Extended_Pictographic}(?:\uFE0F)?(?:\u200D\p{Extended_Pictographic}(?:\uFE0F)?)*)',
    unicode: true,
  );

  static const List<String> fallbacks = [
    'Apple Color Emoji',
    'Segoe UI Emoji',
    'Noto Color Emoji',
    'Android Emoji',
  ];

  /// Right-to-left mark — display-only glue for Arabic ↔ emoji.
  static const String rlm = '\u200F';

  static TextStyle styleForEmoji(TextStyle? base) {
    return TextStyle(
      inherit: false,
      color: base?.color,
      fontSize: base?.fontSize,
      height: base?.height,
      fontWeight: base?.fontWeight,
      letterSpacing: 0,
      // Prefer a real emoji face as primary so Tajawal never owns the run.
      fontFamily: 'Apple Color Emoji',
      fontFamilyFallback: fallbacks,
    );
  }

  /// Split [text] into Tajawal runs + emoji runs.
  ///
  /// Set [glueWithRlm] only for **display** widgets (bubbles). Never enable
  /// it in [TextEditingController.buildTextSpan] — caret offsets must match
  /// the raw controller text.
  static List<InlineSpan> spans(
    String text,
    TextStyle? style, {
    bool glueWithRlm = false,
  }) {
    if (text.isEmpty) return const [];
    if (!emojiRegex.hasMatch(text)) {
      return [TextSpan(text: text, style: style)];
    }

    final children = <InlineSpan>[];
    var start = 0;
    for (final match in emojiRegex.allMatches(text)) {
      if (match.start > start) {
        children.add(TextSpan(
          text: text.substring(start, match.start),
          style: style,
        ));
      }
      final emoji = match.group(0)!;
      children.add(TextSpan(
        text: glueWithRlm ? '$rlm$emoji$rlm' : emoji,
        style: styleForEmoji(style),
      ));
      start = match.end;
    }
    if (start < text.length) {
      children.add(TextSpan(text: text.substring(start), style: style));
    }
    return children;
  }

  static TextSpan rich(
    String text,
    TextStyle? style, {
    bool glueWithRlm = false,
  }) {
    if (text.isEmpty || !emojiRegex.hasMatch(text)) {
      return TextSpan(style: style, text: text);
    }
    return TextSpan(
      style: style,
      children: spans(text, style, glueWithRlm: glueWithRlm),
    );
  }
}
