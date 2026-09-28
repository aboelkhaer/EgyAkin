import 'dart:io';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:open_file/open_file.dart';

/// WhatsApp-style document row — downloads signed `/chat/files/{id}` with
/// Bearer auth (same as images / voice), then opens the local file.
class ChatFileBubble extends StatefulWidget {
  final ChatAttachmentItem attachment;
  final bool isOutgoing;
  final bool isDarkMode;
  final bool isUploading;
  final bool showRetry;
  final double uploadProgress;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onRetryUpload;
  final VoidCallback? onExpired;

  const ChatFileBubble({
    super.key,
    required this.attachment,
    required this.isOutgoing,
    required this.isDarkMode,
    this.isUploading = false,
    this.showRetry = false,
    this.uploadProgress = 0,
    this.onCancelUpload,
    this.onRetryUpload,
    this.onExpired,
  });

  @override
  State<ChatFileBubble> createState() => _ChatFileBubbleState();
}

class _ChatFileBubbleState extends State<ChatFileBubble> {
  bool _loading = false;

  String get _displayName {
    final name = widget.attachment.originalName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final local = widget.attachment.localFile?.path;
    if (local != null && local.isNotEmpty) {
      return local.split(Platform.pathSeparator).last;
    }
    return 'File';
  }

  String get _subtitle {
    final mime = widget.attachment.mimeType?.trim();
    if (mime != null && mime.isNotEmpty) {
      final slash = mime.lastIndexOf('/');
      if (slash >= 0 && slash < mime.length - 1) {
        return mime.substring(slash + 1).toUpperCase();
      }
      return mime;
    }
    final dot = _displayName.lastIndexOf('.');
    if (dot >= 0 && dot < _displayName.length - 1) {
      return _displayName.substring(dot + 1).toUpperCase();
    }
    return 'DOCUMENT';
  }

  Future<void> _open() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      final local = widget.attachment.localFile;
      if (local != null && await local.exists()) {
        await OpenFile.open(local.path);
        return;
      }

      final resolved = resolveChatAttachmentUrl(widget.attachment.url);
      if (resolved.isEmpty) {
        throw StateError('File URL empty');
      }

      final cacheId = widget.attachment.id?.toString() ??
          resolved.hashCode.toUnsigned(32).toRadixString(16);
      // Same auth as images/voice: Bearer + Accept on signed chat file URLs.
      final accept = (widget.attachment.mimeType?.trim().isNotEmpty ?? false)
          ? widget.attachment.mimeType!.trim()
          : '*/*';
      final file = await downloadChatProtectedFile(
        url: resolved,
        cacheId: cacheId,
        filePrefix: 'chat_doc',
        mimeType: widget.attachment.mimeType,
        originalName: widget.attachment.originalName ?? _displayName,
        accept: accept,
      );
      if (!mounted) return;
      final result = await OpenFile.open(file.path);
      if (!mounted) return;
      if (result.type != ResultType.done) {
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.errorOpeningFile),
        );
      }
    } catch (_) {
      if (!mounted) return;
      widget.onExpired?.call();
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.errorOpeningFile),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onPrimary = widget.isOutgoing;
    final fg = onPrimary
        ? Colors.white
        : (widget.isDarkMode ? AppColors.darkTitle : AppColors.title);
    final muted = onPrimary
        ? Colors.white.withOpacity(0.75)
        : (widget.isDarkMode
            ? AppColors.darkDescription
            : AppColors.description);
    final tileBg = onPrimary
        ? Colors.white.withOpacity(0.14)
        : (widget.isDarkMode
            ? Colors.white.withOpacity(0.06)
            : Colors.black.withOpacity(0.05));
    final iconBg = onPrimary
        ? Colors.white.withOpacity(0.22)
        : AppColors.primary.withOpacity(0.12);

    final row = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap:
            widget.isUploading || widget.showRetry || _loading ? null : _open,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          constraints: BoxConstraints(minWidth: 180.w, maxWidth: 260.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: tileBg,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: _loading
                    ? SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: onPrimary ? Colors.white : AppColors.primary,
                        ),
                      )
                    : Icon(
                        Icons.insert_drive_file_rounded,
                        size: 22.sp,
                        color: onPrimary ? Colors.white : AppColors.primary,
                      ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _displayName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: fg,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.download_rounded,
                size: 18.sp,
                color: muted,
              ),
            ],
          ),
        ),
      ),
    );

    if (!widget.isUploading && !widget.showRetry) return row;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Stack(
        alignment: Alignment.center,
        children: [
          row,
          Positioned.fill(
            child: ColoredBox(color: Colors.black.withOpacity(0.35)),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.showRetry
                  ? widget.onRetryUpload
                  : widget.onCancelUpload,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 52.r,
                height: 52.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!widget.showRetry)
                      SizedBox(
                        width: 44.r,
                        height: 44.r,
                        child: CircularProgressIndicator(
                          value: widget.uploadProgress > 0
                              ? widget.uploadProgress.clamp(0.0, 1.0)
                              : null,
                          strokeWidth: 2.6,
                          color: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0.25),
                        ),
                      ),
                    Container(
                      width: 30.r,
                      height: 30.r,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.showRetry
                            ? Icons.refresh_rounded
                            : Icons.close_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
