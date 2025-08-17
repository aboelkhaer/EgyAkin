import 'package:egy_akin/exports.dart';
import 'package:share_plus/share_plus.dart';
import 'package:egy_akin/app/services/deep_link_handler.dart';

class ShareButton extends StatelessWidget {
  final PostCommunityModel feed;

  const ShareButton({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            try {
              // Generate the deep link URLs using the handler
              final deepLinkHandler = DeepLinkHandler();
              final universalLink = deepLinkHandler.generatePostDeepLink(feed.id.toString());
              final customSchemeLink = deepLinkHandler.generateCustomSchemeLink(feed.id.toString());

              // App store links as fallback
              const appStoreUrl =
                  'https://apps.apple.com/eg/app/egyakin/id6738606085';
              const playStoreUrl =
                  'https://play.google.com/store/apps/details?id=com.incode.EgyAkin&hl=en';

              final shareText = '''
Check out this post on EgyAkin!

Open in app: $universalLink

Don't have the app yet?
iOS: $appStoreUrl
Android: $playStoreUrl
''';

              await Share.share(
                shareText,
                subject: 'EgyAkin Post',
                
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to share: ${e.toString()}')),
              );
            }
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Row(
            children: [
              Icon(
                Icons.share,
                size: 22,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
