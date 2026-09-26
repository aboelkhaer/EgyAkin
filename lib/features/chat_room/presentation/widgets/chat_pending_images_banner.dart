import 'dart:io';

import 'package:egy_akin/exports.dart';

/// Reply-style preview of images staged for send above [ChatInputBar].
/// Tap the banner to open the system gallery again; tap a thumb X to remove one.
class ChatPendingImagesBanner extends StatelessWidget {
  final List<File> files;
  final VoidCallback onClose;
  final VoidCallback? onTap;
  final ValueChanged<int>? onRemoveAt;

  const ChatPendingImagesBanner({
    super.key,
    required this.files,
    required this.onClose,
    this.onTap,
    this.onRemoveAt,
  });

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) return const SizedBox.shrink();

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final bgColor =
            isDark ? const Color(0xFF1C1826) : const Color(0xFFF3F4F6);
        final accentColor = AppColors.primary;
        final textColor = isDark
            ? Colors.white.withOpacity(0.6)
            : const Color(0xFF6B7280);
        final count = files.length;
        final label = count > 1
            ? '$count ${context.tr(AppStrings.photosPlural)}'
            : context.tr(AppStrings.photo);

        return Material(
          color: bgColor,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.fromLTRB(6.w, 6.h, 2.w, 6.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.06)
                        : const Color(0xFFE5E7EB),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 3.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr(AppStrings.selected),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                            color: accentColor,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Icon(
                              Icons.photo_camera_outlined,
                              size: 12.sp,
                              color: textColor,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  height: 1.15,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (files.length > 1) ...[
                          SizedBox(height: 6.h),
                          SizedBox(
                            height: 36.w,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: files.length,
                              separatorBuilder: (_, __) => SizedBox(width: 6.w),
                              itemBuilder: (_, i) => _Thumb(
                                file: files[i],
                                onRemove: onRemoveAt == null
                                    ? null
                                    : () => onRemoveAt!(i),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (files.length == 1) ...[
                    SizedBox(width: 6.w),
                    _Thumb(
                      file: files.first,
                      onRemove: onRemoveAt == null
                          ? null
                          : () => onRemoveAt!(0),
                    ),
                  ],
                  GestureDetector(
                    onTap: onClose,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.all(6.r),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16.sp,
                        color: isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Thumb extends StatelessWidget {
  final File file;
  final VoidCallback? onRemove;

  const _Thumb({required this.file, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36.w,
      height: 36.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.file(
              file,
              width: 36.w,
              height: 36.w,
              fit: BoxFit.cover,
            ),
          ),
          if (onRemove != null)
            Positioned(
              right: -4,
              top: -4,
              child: GestureDetector(
                onTap: onRemove,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 16.r,
                  height: 16.r,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 10.sp, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
