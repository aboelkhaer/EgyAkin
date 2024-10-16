// Build the RichText with clickable hashtags
import 'package:flutter/gestures.dart';

import '../../../exports.dart';

TextSpan buildHashtagText(String content) {
  final RegExp hashtagRegExp = RegExp(r'#[a-zA-Z0-9_]+');
  final List<TextSpan> spans = [];
  int currentIndex = 0;

  hashtagRegExp.allMatches(content).forEach((match) {
    // Add non-hashtag text
    if (match.start > currentIndex) {
      spans.add(TextSpan(text: content.substring(currentIndex, match.start)));
    }

    // Add clickable hashtag
    spans.add(
      TextSpan(
        text: match.group(0),
        style: const TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            print('Hashtag clicked: ${match.group(0)}');
            // Handle hashtag click (e.g., navigate or show a new screen)
          },
      ),
    );

    currentIndex = match.end;
  });

  // Add remaining text after the last hashtag
  if (currentIndex < content.length) {
    spans.add(TextSpan(text: content.substring(currentIndex)));
  }

  return TextSpan(style: const TextStyle(color: Colors.black), children: spans);
}
