import 'package:egy_akin/app/shared/widgets/link_preview_widget.dart';
import 'package:flutter/gestures.dart';
import '../../../exports.dart';
import '../../services/theme_bloc.dart';

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

  bool _isArabic(String text) {
    final arabicPattern = RegExp(
        r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    return arabicPattern.hasMatch(text);
  }

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

    final highlightStyle = defaultTextStyle.copyWith(
      backgroundColor:
          isDarkMode ? Colors.yellow.shade800 : Colors.yellow.shade200,
      color: isDarkMode ? AppColors.darkPrimary : Colors.blue,
    );

    final hashtagStyle = defaultTextStyle.copyWith(
      color: isDarkMode ? AppColors.darkPrimary : Colors.blue,
    );

    final boldStyle = defaultTextStyle.copyWith(
      fontWeight: FontWeight.bold,
    );

    final spans = <TextSpan>[];
    final text = widget.content;

    // Updated regex to include asterisk patterns
    final patternRegex = RegExp(
      r'(#[a-zA-Z0-9_\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+)|(https?://[^\s]+)|(\*[^*]+\*)',
    );

    int currentIndex = 0;
    for (final match in patternRegex.allMatches(text)) {
      // Add text before the match
      if (match.start > currentIndex) {
        spans.add(_buildNormalTextSpan(
            text.substring(currentIndex, match.start), isDarkMode));
      }

      // Handle the matched content
      final matchedText = match.group(0)!;
      if (matchedText.startsWith('http')) {
        // Skip URLs (they'll be handled by link preview)
        spans.add(const TextSpan(text: ' '));
      } else if (matchedText.startsWith('#')) {
        // Handle hashtags
        spans.add(TextSpan(
          text: matchedText,
          style: hashtagStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => _onHashtagTap(matchedText),
        ));
      } else if (matchedText.startsWith('*') && matchedText.endsWith('*')) {
        // Handle bold text between asterisks
        final boldText = matchedText.substring(1, matchedText.length - 1);
        spans.add(TextSpan(
          text: boldText,
          style: boldStyle,
        ));
      }

      currentIndex = match.end;
    }

    // Add remaining text after last match
    if (currentIndex < text.length) {
      spans.add(_buildNormalTextSpan(text.substring(currentIndex), isDarkMode));
    }

    return TextSpan(children: spans);
  }

  TextSpan _buildNormalTextSpan(String text, bool isDarkMode) {
    final highlightStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w500,
      height: 1.4,
      backgroundColor:
          isDarkMode ? Colors.yellow.shade800 : Colors.yellow.shade200,
      color: isDarkMode ? AppColors.darkPrimary : Colors.blue,
    );

    if (widget.highlightWord != null &&
        text.toLowerCase().contains(widget.highlightWord!.toLowerCase())) {
      return TextSpan(text: text, style: highlightStyle);
    }
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: isDarkMode ? AppColors.darkTitle : Colors.black,
      ),
    );
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

  TextDirection _getTextDirection(String text) {
    if (_isArabic(text)) return TextDirection.rtl;
    final hasArabic = _isArabic(text);
    final hasEnglish = RegExp(r'[a-zA-Z]').hasMatch(text);
    if (hasArabic && hasEnglish) return TextDirection.rtl;
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
