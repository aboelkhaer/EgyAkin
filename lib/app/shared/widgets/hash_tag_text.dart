import 'package:egy_akin/app/shared/widgets/link_preview_widget.dart';
import 'package:flutter/gestures.dart';
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
    this.disableTrimLines = false,
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
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
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
    final urlRegExp = RegExp(r'https?://[^\s]+', caseSensitive: false);
    final matches = urlRegExp.allMatches(content);
    List<Widget> previews = [];

    for (final match in matches) {
      final url = match.group(0)!;
      previews.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: LinkPreviewWidget(url: url), // Use custom widget
        ),
      );
    }

    return previews;
  }
}

TextSpan buildHashtagText(
  String content,
  DoctorModel currentDoctorModel,
  HomeModelResponse homeDataModel,
  String? highlightWord,
) {
  // Constants for styling
  const TextStyle defaultTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: Colors.black,
  );

  final TextStyle highlightStyle = defaultTextStyle.copyWith(
    backgroundColor: Colors.yellow.shade200,
    color: Colors.blue,
  );

  final TextStyle hashtagStyle = defaultTextStyle.copyWith(
    color: Colors.blue,
  );

  // Regex patterns
  final RegExp hashtagRegExp = RegExp(r'#[a-zA-Z0-9_]+');
  final RegExp urlRegExp = RegExp(r'https?://[^\s]+');
  final RegExp wordRegExp = RegExp(r'(#[a-zA-Z0-9_]+|\b\w+\b)');

  // Safe handling of highlight word
  final String? normalizedHighlight = highlightWord?.trim().toLowerCase();
  final bool isHighlightHashtag = normalizedHighlight?.startsWith('#') ?? false;
  final String? highlightWithoutHash = isHighlightHashtag
      ? normalizedHighlight?.substring(1)
      : normalizedHighlight;

  List<TextSpan> spans = [];
  int currentIndex = 0;

  // Helper function to add non-matched text
  void addPlainText(int start, int end) {
    if (start < end && end <= content.length) {
      spans.add(TextSpan(
        text: content.substring(start, end),
        style: defaultTextStyle,
      ));
    }
  }

  // First pass: Split content into segments (URLs vs non-URLs)
  final urlMatches = urlRegExp.allMatches(content);
  if (urlMatches.isEmpty) {
    // Process entire content if no URLs
    _processTextSegment(
      content,
      spans,
      currentDoctorModel,
      homeDataModel,
      highlightWord,
      defaultTextStyle,
      highlightStyle,
      hashtagStyle,
      hashtagRegExp,
      wordRegExp,
      normalizedHighlight,
      isHighlightHashtag,
      highlightWithoutHash,
    );
  } else {
    // Process segments between URLs
    currentIndex = 0;
    for (final urlMatch in urlMatches) {
      // Process text before URL
      if (urlMatch.start > currentIndex) {
        final segment = content.substring(currentIndex, urlMatch.start);
        _processTextSegment(
          segment,
          spans,
          currentDoctorModel,
          homeDataModel,
          highlightWord,
          defaultTextStyle,
          highlightStyle,
          hashtagStyle,
          hashtagRegExp,
          wordRegExp,
          normalizedHighlight,
          isHighlightHashtag,
          highlightWithoutHash,
        );
      }

      // Skip adding the URL text (we'll show the preview instead)
      // Just add a space to maintain text flow if needed
      spans.add(const TextSpan(text: ' '));

      currentIndex = urlMatch.end;
    }

    // Process remaining text after last URL
    if (currentIndex < content.length) {
      final segment = content.substring(currentIndex);
      _processTextSegment(
        segment,
        spans,
        currentDoctorModel,
        homeDataModel,
        highlightWord,
        defaultTextStyle,
        highlightStyle,
        hashtagStyle,
        hashtagRegExp,
        wordRegExp,
        normalizedHighlight,
        isHighlightHashtag,
        highlightWithoutHash,
      );
    }
  }

  return TextSpan(children: spans);
}

void _processTextSegment(
  String segment,
  List<TextSpan> spans,
  DoctorModel currentDoctorModel,
  HomeModelResponse homeDataModel,
  String? highlightWord,
  TextStyle defaultTextStyle,
  TextStyle highlightStyle,
  TextStyle hashtagStyle,
  RegExp hashtagRegExp,
  RegExp wordRegExp,
  String? normalizedHighlight,
  bool isHighlightHashtag,
  String? highlightWithoutHash,
) {
  int currentIndex = 0;

  for (final wordMatch in wordRegExp.allMatches(segment)) {
    final String? wordText = wordMatch.group(0);
    if (wordText == null) continue;

    final String lowerWordText = wordText.toLowerCase();
    final bool isWordHashtag = wordText.startsWith('#');
    final String wordWithoutHash =
        isWordHashtag ? lowerWordText.substring(1) : lowerWordText;

    // Add text before the word
    if (wordMatch.start > currentIndex) {
      spans.add(TextSpan(
        text: segment.substring(currentIndex, wordMatch.start),
        style: defaultTextStyle,
      ));
    }

    // Check for highlight match
    if (normalizedHighlight != null &&
        (lowerWordText == normalizedHighlight ||
            (isHighlightHashtag && lowerWordText == normalizedHighlight) ||
            (!isWordHashtag && wordWithoutHash == highlightWithoutHash) ||
            (isWordHashtag && wordWithoutHash == highlightWithoutHash))) {
      spans.add(TextSpan(
        text: wordText,
        style: highlightStyle,
      ));
    } else if (hashtagRegExp.hasMatch(wordText)) {
      // Clickable hashtag
      spans.add(TextSpan(
        text: wordText,
        style: hashtagStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.communitySearch,
              arguments: AppRoutesArgs.communitySearchRouteArgs(
                currentDoctorModel: currentDoctorModel,
                homeDataModel: homeDataModel,
                initialValueInSearch: wordText,
              ),
            );
          },
      ));
    } else {
      // Normal text
      spans.add(TextSpan(
        text: wordText,
        style: defaultTextStyle,
      ));
    }

    currentIndex = wordMatch.end;
  }

  // Add remaining text after last word
  if (currentIndex < segment.length) {
    spans.add(TextSpan(
      text: segment.substring(currentIndex),
      style: defaultTextStyle,
    ));
  }
}
