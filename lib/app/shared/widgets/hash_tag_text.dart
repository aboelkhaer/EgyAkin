import 'package:flutter/gestures.dart';
import 'package:any_link_preview/any_link_preview.dart'; // Add this import
import '../../../exports.dart'; // Assuming this handles building the hashtag text

class HashtagText extends StatefulWidget {
  final String content;
  final int? trimLines;
  final String trimCollapsedText;
  final String trimExpandedText;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String? highlightWord; // Words to highlight
  final bool disableTrimLines; // New parameter to disable trim lines

  const HashtagText({
    super.key,
    required this.content,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.trimLines = 2, // The number of lines before collapsing
    this.trimCollapsedText = '... See more',
    this.trimExpandedText = '',
    this.highlightWord, // Default empty list
    this.disableTrimLines = false, // Default to false (trim lines enabled)
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
        // Calculate if text overflows (only if trim lines are enabled)
        final span = buildHashtagText(
          widget.content,
          widget.currentDoctorModel,
          widget.homeDataModel,
          widget.highlightWord, // Pass the highlight words
        );

        // Check if trim lines are disabled
        final shouldShowToggle = widget.disableTrimLines
            ? false // Disable toggle if trim lines are disabled
            : _checkTextOverflow(span, constraints.maxWidth);

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
                maxLines: widget.disableTrimLines
                    ? null // No max lines if trim lines are disabled
                    : (isExpanded ? null : widget.trimLines),
                overflow: widget.disableTrimLines
                    ? TextOverflow
                        .visible // No overflow if trim lines are disabled
                    : (isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis),
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
              // Add link previews here
              ..._buildLinkPreviews(widget.content),
            ],
          ),
        );
      },
    );
  }

  // Helper function to check if text overflows
  bool _checkTextOverflow(TextSpan span, double maxWidth) {
    final tp = TextPainter(
      text: span,
      maxLines: widget.trimLines,
      textDirection:
          _isArabic(widget.content) ? TextDirection.rtl : TextDirection.ltr,
    );
    tp.layout(maxWidth: maxWidth);
    return tp.didExceedMaxLines;
  }

  // Helper function to detect URLs and build link previews
  List<Widget> _buildLinkPreviews(String content) {
    final urlRegExp = RegExp(
      r'https?://[^\s]+',
      caseSensitive: false,
    );
    final matches = urlRegExp.allMatches(content);
    List<Widget> previews = [];

    for (final match in matches) {
      final url = match.group(0)!;
      previews.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AnyLinkPreview(
            link: url,
            displayDirection: UIDirection.uiDirectionVertical,
            cache: const Duration(days: 7), // Cache the preview for 7 days
            placeholderWidget:
                const CircularProgressIndicator(), // Show a loader while loading
            errorWidget: const Text(
                'Unable to load preview'), // Show this if the preview fails
          ),
        ),
      );
    }

    return previews;
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
  final RegExp urlRegExp = RegExp(r'https?://[^\s]+'); // Detect URLs
  final String? highlightLower =
      highlightWord?.toLowerCase().trim(); // Normalize highlight word

  List<TextSpan> spans = [];
  int currentIndex = 0;

  // Match hashtags, URLs, and words separately
  final RegExp regex = RegExp(
      r'#[a-zA-Z0-9_]+|https?://[^\s]+|\b\w+\b'); // Detect hashtags, URLs, & words

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
    } else if (urlRegExp.hasMatch(matchText)) {
      // If it's a URL, skip it here (handled in _buildLinkPreviews)
      spans.add(const TextSpan(text: ' ')); // Replace URL with space
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
