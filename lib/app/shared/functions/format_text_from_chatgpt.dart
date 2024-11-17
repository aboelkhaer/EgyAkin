import '../../../exports.dart';

class TextFormatter {
  static List<InlineSpan> formatText(String text) {
    final List<InlineSpan> spans = [];
    final RegExp regex =
        RegExp(r'\*\*(.*?)\*\*'); // Matches text enclosed in **

    int start = 0;

    text.splitMapJoin(
      regex,
      onMatch: (match) {
        final boldText = match.group(1)!;
        if (start != match.start) {
          spans.add(TextSpan(text: text.substring(start, match.start)));
        }
        spans.add(TextSpan(
          text: boldText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
        start = match.end;
        return ''; // Return empty since we're building spans
      },
      onNonMatch: (nonMatch) {
        spans.add(TextSpan(text: nonMatch));
        return ''; // Process all parts
      },
    );

    return spans;
  }
}

class FormattedTextWidget extends StatelessWidget {
  final String inputText;

  const FormattedTextWidget({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
        children: TextFormatter.formatText(inputText),
      ),
    );
  }
}
