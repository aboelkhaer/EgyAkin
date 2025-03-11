import 'package:flutter/gestures.dart';
import '../../../exports.dart'; // Assuming this handles building the hashtag text

class HashtagText extends StatefulWidget {
  final String content;
  final int trimLines;
  final String trimCollapsedText;
  final String trimExpandedText;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String? highlightWord; // Words to highlight
  const HashtagText({
    super.key,
    required this.content,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.trimLines = 2, // The number of lines before collapsing
    this.trimCollapsedText = '... See more',
    this.trimExpandedText = '',
    this.highlightWord, // Default empty list
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
        final span = buildHashtagText(
          widget.content,
          widget.currentDoctorModel,
          widget.homeDataModel,
          widget.highlightWord, // Pass the highlight words
        );
        final tp = TextPainter(
          text: span,
          maxLines: widget.trimLines,
          textDirection: _isArabic(widget.content)
              ? TextDirection.rtl
              : TextDirection.ltr, // Dynamically set the text direction
        );
        tp.layout(maxWidth: constraints.maxWidth);

        // Check if the text exceeds the trimLines limit
        final shouldShowToggle = tp.didExceedMaxLines;

        // The entire text is wrapped in GestureDetector
        return GestureDetector(
          onTap: shouldShowToggle
              ? () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                }
              : null, // Disable onTap if text does not exceed trimLines
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: isExpanded ? null : widget.trimLines,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                text: buildHashtagText(
                  widget.content,
                  widget.currentDoctorModel,
                  widget.homeDataModel,
                  widget.highlightWord, // Pass the highlight words here
                ),
                textDirection: _isArabic(widget.content)
                    ? TextDirection.rtl
                    : TextDirection.ltr, // Text direction based on content
              ),
              if (shouldShowToggle ||
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

// Build the RichText with clickable hashtags and highlighted words
TextSpan buildHashtagText(
  String content,
  DoctorModel currentDoctorModel,
  HomeModelResponse homeDataModel,
  String? highlightWord, // Word to highlight
) {
  final RegExp hashtagRegExp = RegExp(r'#[a-zA-Z0-9_]+'); // Detect hashtags
  final String? highlightLower =
      highlightWord?.toLowerCase().trim(); // Normalize highlight word

  List<TextSpan> spans = [];
  int currentIndex = 0;

  // Match hashtags and words separately (handles punctuation correctly)
  final RegExp regex =
      RegExp(r'#[a-zA-Z0-9_]+|\b\w+\b'); // Detect hashtags & words

  for (final match in regex.allMatches(content)) {
    String matchText = match.group(0)!; // Extract the matched text
    String lowerMatchText = matchText.toLowerCase();

    // Add any text before the matched word
    if (match.start > currentIndex) {
      spans.add(TextSpan(text: content.substring(currentIndex, match.start)));
    }
    if (highlightLower != null && lowerMatchText == highlightLower) {
      // If it's the highlight word, add yellow background
      spans.add(
        TextSpan(
          text: matchText,
          style: TextStyle(
            backgroundColor: Colors.yellow.shade200,
            color: Colors.blue,
            // fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (hashtagRegExp.hasMatch(matchText)) {
      // If it's a hashtag, make it clickable
      spans.add(
        TextSpan(
          text: matchText,
          style: const TextStyle(
            color: Colors.blue,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              navigatorKey.currentState?.pushNamed(
                AppRoutes.communitySearch,
                arguments: AppRoutesArgs.communitySearchRouteArgs(
                  currentDoctorModel: currentDoctorModel,
                  homeDataModel: homeDataModel,
                  initialValueInSearch: matchText,
                ),
              );
            },
        ),
      );
    } else {
      // Normal text
      spans.add(TextSpan(
          text: matchText, style: const TextStyle(color: Colors.black)));
    }

    currentIndex = match.end;
  }

  // Add remaining text after last match
  if (currentIndex < content.length) {
    spans.add(TextSpan(text: content.substring(currentIndex)));
  }

  return TextSpan(style: const TextStyle(color: Colors.black), children: spans);
}
