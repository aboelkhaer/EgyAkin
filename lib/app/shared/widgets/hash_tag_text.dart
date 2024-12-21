import 'package:flutter/material.dart';
import 'package:egy_akin/app/shared/functions/hash_tags.dart'; // Assuming this handles building the hashtag text

class HashtagText extends StatefulWidget {
  final String content;
  final int trimLines;
  final String trimCollapsedText;
  final String trimExpandedText;

  const HashtagText({
    super.key,
    required this.content,
    this.trimLines = 2, // The number of lines before collapsing
    this.trimCollapsedText = '... See more',
    this.trimExpandedText = '',
    // this.trimExpandedText = ' Show less',
  });

  @override
  _HashtagTextState createState() => _HashtagTextState();
}

class _HashtagTextState extends State<HashtagText> {
  bool isExpanded = false;

  // Helper function to detect Arabic content
  bool _isArabic(String text) {
    final arabicPattern = RegExp(r'[\u0600-\u06FF]');
    return arabicPattern.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate if text overflows
        final span = buildHashtagText(widget.content);
        final tp = TextPainter(
          text: span,
          maxLines: widget.trimLines,
          textDirection: _isArabic(widget.content)
              ? TextDirection.rtl
              : TextDirection.ltr, // Dynamically set the text direction
        );
        tp.layout(maxWidth: constraints.maxWidth);

        // The entire text is wrapped in GestureDetector
        return GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: isExpanded ? null : widget.trimLines,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                text: buildHashtagText(widget.content),
                textDirection: _isArabic(widget.content)
                    ? TextDirection.rtl
                    : TextDirection.ltr, // Text direction based on content
              ),
              if (tp.didExceedMaxLines ||
                  isExpanded) // Show toggle text only if necessary
                Text(
                  isExpanded
                      ? widget.trimExpandedText
                      : widget.trimCollapsedText,
                  style: const TextStyle(color: Colors.blue),
                ),
            ],
          ),
        );
      },
    );
  }
}
