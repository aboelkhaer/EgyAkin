import 'package:egy_akin/exports.dart';

class ChatRoomHeader extends StatelessWidget {
  final String displayName;
  final String? imageUrl;
  final String initials;
  final bool isVerified;
  final bool isOnline;
  final VoidCallback? onCall;
  final VoidCallback? onInfo;

  const ChatRoomHeader({
    super.key,
    required this.displayName,
    required this.initials,
    this.imageUrl,
    this.isVerified = false,
    this.isOnline = true,
    this.onCall,
    this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final borderColor =
            isDarkMode ? AppColors.darkBorder : Colors.grey.shade300;
        final titleColor = isDarkMode ? AppColors.darkTitle : AppColors.title;
        final scaffoldBg =
            isDarkMode ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: scaffoldBg,
            border: Border(
              bottom: BorderSide(color: borderColor, width: 2),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
              _ChatAvatar(
                imageUrl: imageUrl,
                initials: initials,
                isOnline: isOnline,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: titleColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          SizedBox(width: 3.w),
                          Image.asset(
                            AppImages.verified,
                            height: 14.h,
                            width: 14.w,
                            color: Colors.green.shade600,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      context.tr(AppStrings.onlineNow),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: isDarkMode
                            ? AppColors.darkDescription
                            : AppColors.description,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onCall,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.phone_outlined,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
              IconButton(
                onPressed: onInfo,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final bool isOnline;

  const _ChatAvatar({
    required this.initials,
    this.imageUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? ClipOval(
                  child: CustomCachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: 36.r,
                    height: 36.r,
                    fit: BoxFit.cover,
                  ),
                )
              : Text(
                  initials,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                  ),
                ),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                color: Colors.green.shade500,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
