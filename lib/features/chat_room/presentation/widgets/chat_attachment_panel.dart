import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_background.dart';

import '../../../../exports.dart';

class ChatAttachmentPanel extends StatelessWidget {
  final VoidCallback onPhoto;
  final VoidCallback onCamera;
  final VoidCallback onDocument;
  /// Same footprint as the system keyboard (WhatsApp-style).
  final double height;

  const ChatAttachmentPanel({
    super.key,
    required this.onPhoto,
    required this.onCamera,
    required this.onDocument,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final borderColor =
            (isDark ? AppColors.darkBorder : Colors.grey.shade300)
                .withOpacity(0.45);

        return ChatRoomGlassSurface(
          isDark: isDark,
          border: Border(top: BorderSide(color: borderColor, width: 1)),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // While closing, height animates down — avoid Column overflow.
                if (constraints.maxHeight < 72) {
                  return const SizedBox.expand();
                }
                return Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _AttachmentOption(
                            label: context.tr(AppStrings.gallery),
                            icon: Icons.photo_library_rounded,
                            color: const Color(0xFF8B5CF6),
                            onTap: onPhoto,
                            isDark: isDark,
                          ),
                          SizedBox(width: 28.w),
                          _AttachmentOption(
                            label: context.tr(AppStrings.camera),
                            icon: Icons.photo_camera_rounded,
                            color: const Color(0xFFEF4444),
                            onTap: onCamera,
                            isDark: isDark,
                          ),
                          SizedBox(width: 28.w),
                          _AttachmentOption(
                            label: context.tr(AppStrings.document),
                            icon: Icons.insert_drive_file_rounded,
                            color: const Color(0xFF3B82F6),
                            onTap: onDocument,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _AttachmentOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isDark;

  const _AttachmentOption({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.r,
                height: 56.r,
                decoration: BoxDecoration(
                  color: color.withOpacity(isDark ? 0.22 : 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 26.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.darkDescription
                      : AppColors.description,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
