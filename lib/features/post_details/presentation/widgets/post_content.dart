import '../../../../exports.dart';

class PostContent extends StatelessWidget {
  final String content;
  const PostContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: HtmlWidget(content, onTapUrl: (url) {
            launchURL(
                url: url,
                onError: (error) {
                  showErrorDialog(context, error);
                });
            return true;
          }),
        ),
      ],
    );
  }
}
