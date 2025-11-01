import 'package:egy_akin/exports.dart';
import 'package:share_plus/share_plus.dart';
import 'package:egy_akin/app/services/deep_link_handler.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';

class ShareButton extends StatefulWidget {
  final PostCommunityModel feed;

  const ShareButton({super.key, required this.feed});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool _isLoading = false;
  final GlobalKey _shareButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Row(
          children: [
            InkWell(
              key: _shareButtonKey,
              onTap: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        // Generate the deep link URLs using the handler
                        final deepLinkHandler = DeepLinkHandler();
                        final universalLink = deepLinkHandler
                            .generatePostDeepLink(widget.feed.id.toString());

                        // App store links as fallback
                        const appStoreUrl =
                            'https://apps.apple.com/eg/app/egyakin/id6738606085';
                        const playStoreUrl =
                            'https://play.google.com/store/apps/details?id=com.incode.EgyAkin&hl=en';

                        final shareText = '''
${context.tr(AppStrings.checkOutThisPostOnEgyAkin)}

${context.tr(AppStrings.openInApp)}: $universalLink

${context.tr(AppStrings.dontHaveTheAppYet)}
iOS: $appStoreUrl
Android: $playStoreUrl
''';

                        // Get the position of the share button
                        final RenderBox? renderBox =
                            _shareButtonKey.currentContext?.findRenderObject()
                                as RenderBox?;

                        final Rect? sharePositionOrigin = renderBox != null
                            ? Rect.fromLTWH(
                                renderBox.localToGlobal(Offset.zero).dx,
                                renderBox.localToGlobal(Offset.zero).dy,
                                renderBox.size.width,
                                renderBox.size.height,
                              )
                            : null;

                        await Share.share(
                          shareText,
                          subject: context.tr(AppStrings.egyAkinFeed),
                          sharePositionOrigin: sharePositionOrigin,
                        );
                      } catch (e) {
                        customSnackBar(
                            context: context,
                            message:
                                '${context.tr(AppStrings.failedToShare)}: ${e.toString()}');
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: [
                  _isLoading
                      ? SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDarkMode
                                  ? AppColors.darkTitle
                                  : Colors.grey.shade400,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.share,
                          size: 22,
                          color: isDarkMode
                              ? AppColors.darkTitle
                              : Colors.grey.shade400,
                        ),
                ],
              ),
            ),
            SizedBox(width: 20.w),
          ],
        );
      },
    );
  }
}
