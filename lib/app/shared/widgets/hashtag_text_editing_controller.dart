import 'package:flutter/material.dart';

/// Colors `#hashtags` (and optional `*bold*`) while the user types.
/// Same behavior as create-post — no Unicode isolates (caret stays correct).
class HashtagTextEditingController extends TextEditingController {
  HashtagTextEditingController({
    String? text,
    required this.hashtagStyle,
  }) : super(text: text);

  TextStyle hashtagStyle;

  static final RegExp patternRegex = RegExp(
    r'(#[a-zA-Z0-9_\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+)|(\*[^*]+\*)',
  );

  void updateHashtagStyle(TextStyle style) {
    if (hashtagStyle == style) return;
    hashtagStyle = style;
    notifyListeners();
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    if (withComposing && value.composing.isValid && value.isComposingRangeValid) {
      return super.buildTextSpan(
        context: context,
        style: style,
        withComposing: withComposing,
      );
    }

    final text = value.text;
    if (text.isEmpty || !patternRegex.hasMatch(text)) {
      return TextSpan(style: style, text: text);
    }

    final boldStyle = (style ?? const TextStyle()).merge(
      const TextStyle(fontWeight: FontWeight.w800),
    );
    final starStyle = (style ?? const TextStyle()).merge(
      TextStyle(
        fontWeight: FontWeight.w500,
        color: (style?.color ?? Colors.grey).withOpacity(0.45),
      ),
    );

    final children = <InlineSpan>[];
    var start = 0;
    for (final match in patternRegex.allMatches(text)) {
      if (match.start > start) {
        children.add(TextSpan(
          text: text.substring(start, match.start),
          style: style,
        ));
      }

      final matched = match.group(0)!;
      if (matched.startsWith('#')) {
        children.add(TextSpan(
          text: matched,
          style: style?.merge(hashtagStyle) ?? hashtagStyle,
        ));
      } else if (matched.startsWith('*') && matched.endsWith('*')) {
        children.add(TextSpan(text: '*', style: starStyle));
        children.add(TextSpan(
          text: matched.substring(1, matched.length - 1),
          style: boldStyle,
        ));
        children.add(TextSpan(text: '*', style: starStyle));
      }

      start = match.end;
    }
    if (start < text.length) {
      children.add(TextSpan(
        text: text.substring(start),
        style: style,
      ));
    }

    return TextSpan(style: style, children: children);
  }
}
