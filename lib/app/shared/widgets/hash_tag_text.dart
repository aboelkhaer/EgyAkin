import 'package:egy_akin/app/shared/widgets/link_preview_widget.dart';
import 'package:flutter/gestures.dart';
import '../../../exports.dart';

class HashtagText extends StatefulWidget {
  final String content;
  final int? trimLines;
  final String trimCollapsedText;
  final String trimExpandedText;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String? highlightWord;
  final bool disableTrimLines;

  const HashtagText({
    super.key,
    required this.content,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.trimLines = 2,
    this.trimCollapsedText = '... See more',
    this.trimExpandedText = '',
    this.highlightWord,
    this.disableTrimLines = false,
  });

  @override
  _HashtagTextState createState() => _HashtagTextState();
}

class _HashtagTextState extends State<HashtagText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return LayoutBuilder(
          builder: (context, constraints) {
            final span = _buildHashtagTextSpan(isDarkMode);
            final shouldShowToggle = widget.disableTrimLines
                ? false
                : _checkTextOverflow(span, constraints.maxWidth);

            return GestureDetector(
              onTap: shouldShowToggle
                  ? () => setState(() => isExpanded = !isExpanded)
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: widget.disableTrimLines
                        ? null
                        : (isExpanded ? null : widget.trimLines),
                    overflow: widget.disableTrimLines
                        ? TextOverflow.visible
                        : (isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis),
                    text: span,
                    textDirection: _getTextDirection(widget.content),
                  ),
                  if (shouldShowToggle || isExpanded)
                    Text(
                      isExpanded
                          ? widget.trimExpandedText
                          : widget.trimCollapsedText,
                      style: TextStyle(
                        color: isDarkMode ? AppColors.darkPrimary : Colors.blue,
                      ),
                    ),
                  ..._buildLinkPreviews(widget.content),
                ],
              ),
            );
          },
        );
      },
    );
  }

  TextSpan _buildHashtagTextSpan(bool isDarkMode) {
    final defaultTextStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: isDarkMode ? AppColors.darkTitle : Colors.black,
    );

    final hashtagStyle = defaultTextStyle.copyWith(
      color: isDarkMode ? AppColors.darkPrimary : Colors.blue,
      fontWeight: FontWeight.w700,
    );

    final boldStyle = defaultTextStyle.copyWith(
      fontWeight: FontWeight.bold,
    );

    final spans = <TextSpan>[];
    final text = widget.content;

    final patternRegex = RegExp(
      r'(#[a-zA-Z0-9_\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+)|(https?://[^\s]+)|(\*[^*]+\*)',
    );

    int currentIndex = 0;
    for (final match in patternRegex.allMatches(text)) {
      if (match.start > currentIndex) {
        spans.add(_buildNormalTextSpan(
            text.substring(currentIndex, match.start), isDarkMode));
      }

      final matchedText = match.group(0)!;
      if (matchedText.startsWith('http')) {
        spans.add(const TextSpan(text: ' '));
      } else if (matchedText.startsWith('#')) {
        spans.add(TextSpan(
          text: _directionalHashtag(matchedText),
          style: hashtagStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => _onHashtagTap(matchedText),
        ));
      } else if (matchedText.startsWith('*') && matchedText.endsWith('*')) {
        final boldText = matchedText.substring(1, matchedText.length - 1);
        spans.add(TextSpan(
          text: boldText,
          style: boldStyle,
        ));
      }

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(_buildNormalTextSpan(text.substring(currentIndex), isDarkMode));
    }

    return TextSpan(style: defaultTextStyle, children: spans);
  }

  TextSpan _buildNormalTextSpan(String text, bool isDarkMode) {
    final defaultStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: isDarkMode ? AppColors.darkTitle : Colors.black,
    );

    final highlightStyle = defaultStyle.copyWith(
      backgroundColor:
          isDarkMode ? Colors.yellow.shade400 : Colors.yellow.shade200,
      color: isDarkMode ? AppColors.darkPrimary : Colors.blue,
    );

    if (widget.highlightWord == null ||
        widget.highlightWord!.isEmpty ||
        !text.toLowerCase().contains(widget.highlightWord!.toLowerCase())) {
      return TextSpan(text: text, style: defaultStyle);
    }

    // Only highlight the matching word(s), not the whole segment
    final spans = <TextSpan>[];
    final searchLower = widget.highlightWord!.toLowerCase();
    int start = 0;
    int index;
    int fromIndex = 0;
    while ((index = text.toLowerCase().indexOf(searchLower, fromIndex)) != -1) {
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: defaultStyle,
        ));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + searchLower.length),
        style: highlightStyle,
      ));
      start = fromIndex = index + searchLower.length;
    }
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: defaultStyle,
      ));
    }

    return TextSpan(children: spans);
  }

  void _onHashtagTap(String hashtag) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.communitySearch,
      arguments: AppRoutesArgs.communitySearchRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        initialValueInSearch: hashtag,
      ),
    );
  }

  /// EN: '#' on the left (LTR isolate). AR: '#' on the right (RTL isolate).
  String _directionalHashtag(String hashtag) {
    final isArabic = RegExp(
      r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
    ).hasMatch(hashtag);
    if (isArabic) {
      return '\u2067$hashtag\u2069'; // RLI … PDI
    }
    return '\u2066$hashtag\u2069'; // LRI … PDI
  }

  TextDirection _getTextDirection(String text) {
    // Match create-post: direction from the first strong letter, not "any Arabic".
    // Otherwise mixed EN/AR hashtags get reordered and '#' jumps after words.
    for (final rune in text.trimLeft().runes) {
      final ch = String.fromCharCode(rune);
      if (RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]')
          .hasMatch(ch)) {
        return TextDirection.rtl;
      }
      if (RegExp(r'[A-Za-z]').hasMatch(ch)) {
        return TextDirection.ltr;
      }
    }
    return TextDirection.ltr;
  }

  bool _checkTextOverflow(TextSpan span, double maxWidth) {
    final tp = TextPainter(
      text: span,
      maxLines: widget.trimLines,
      textDirection: _getTextDirection(widget.content),
    );
    tp.layout(maxWidth: maxWidth);
    return tp.didExceedMaxLines;
  }

  List<Widget> _buildLinkPreviews(String content) {
    final urlRegExp = RegExp(r'https?://[^\s]+', caseSensitive: false);
    return urlRegExp.allMatches(content).map((match) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: LinkPreviewWidget(url: match.group(0)!),
        ),
      );
    }).toList();
  }
}
