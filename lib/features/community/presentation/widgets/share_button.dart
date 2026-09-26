import 'package:egy_akin/features/community/presentation/widgets/share_post_sheet.dart';

import '../../../../exports.dart';

class ShareButton extends StatelessWidget {
  final PostCommunityModel feed;

  const ShareButton({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return InkWell(
          onTap: () => showSharePostSheet(context: context, feed: feed),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          child: Icon(
            Icons.share_outlined,
            size: 20.sp,
            color: isDarkMode ? AppColors.darkTitle : Colors.grey.shade400,
          ),
        );
      },
    );
  }
}
