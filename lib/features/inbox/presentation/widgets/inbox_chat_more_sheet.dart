import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';

/// WhatsApp-style "More" sheet opened from the inbox swipe action.
Future<InboxChatMoreAction?> showInboxChatMoreSheet({
  required BuildContext context,
  required InboxThread thread,
  required bool isDark,
  required Color primary,
}) {
  return showModalBottomSheet<InboxChatMoreAction>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (ctx) => _InboxChatMoreSheet(
      thread: thread,
      isDark: isDark,
      primary: primary,
    ),
  );
}

enum InboxChatMoreAction {
  mute,
  contactInfo,
  block,
  delete,
}

class _InboxChatMoreSheet extends StatelessWidget {
  final InboxThread thread;
  final bool isDark;
  final Color primary;

  const _InboxChatMoreSheet({
    required this.thread,
    required this.isDark,
    required this.primary,
  });

  bool get _isGroup =>
      thread.chatType == 'group' ||
      thread.chatType == 'social_group' ||
      thread.chatType == 'case_group';

  bool get _canBlock =>
      !_isGroup && (thread.counterpartUserId ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    final sheetBg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7);
    final cardBg = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final title = HomeDashboardColors.title(isDark);
    final divider = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.06);
    final destructive = const Color(0xFFFF3B30);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: sheetBg,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 12.h, 8.w, 10.h),
                    child: Row(
                      children: [
                        _SheetAvatar(
                          thread: thread,
                          primary: primary,
                          isDark: isDark,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            thread.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: title,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Material(
                          color: isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.06),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => Navigator.pop(context),
                            child: SizedBox(
                              width: 28.r,
                              height: 28.r,
                              child: Icon(
                                Icons.close_rounded,
                                size: 16.sp,
                                color: HomeDashboardColors.subtitle(isDark),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 12.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        children: [
                          _MoreRow(
                            icon: thread.isMuted
                                ? Icons.notifications_active_outlined
                                : Icons.notifications_off_outlined,
                            label: context.tr(
                              thread.isMuted
                                  ? AppStrings.unmute
                                  : AppStrings.mute,
                            ),
                            color: title,
                            onTap: () => Navigator.pop(
                              context,
                              InboxChatMoreAction.mute,
                            ),
                          ),
                          Divider(height: 1, thickness: 1, color: divider),
                          _MoreRow(
                            icon: Icons.info_outline_rounded,
                            label: context.tr(
                              _isGroup
                                  ? AppStrings.chatInfo
                                  : AppStrings.contactInfo,
                            ),
                            color: title,
                            onTap: () => Navigator.pop(
                              context,
                              InboxChatMoreAction.contactInfo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 12.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        children: [
                          if (_canBlock) ...[
                            _MoreRow(
                              icon: Icons.block,
                              label:
                                  '${context.tr(AppStrings.block)} ${thread.title}',
                              color: destructive,
                              onTap: () => Navigator.pop(
                                context,
                                InboxChatMoreAction.block,
                              ),
                            ),
                            Divider(height: 1, thickness: 1, color: divider),
                          ],
                          _MoreRow(
                            icon: Icons.delete_outline_rounded,
                            label: context.tr(AppStrings.deleteChatFull),
                            color: destructive,
                            onTap: () => Navigator.pop(
                              context,
                              InboxChatMoreAction.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetAvatar extends StatelessWidget {
  final InboxThread thread;
  final Color primary;
  final bool isDark;

  const _SheetAvatar({
    required this.thread,
    required this.primary,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final url = thread.imageUrl?.trim() ?? '';
    final size = 36.r;
    final initials = Text(
      thread.initials,
      style: TextStyle(
        color: primary,
        fontWeight: FontWeight.w700,
        fontSize: 11.sp,
      ),
    );

    return CircleAvatar(
      radius: 18.r,
      backgroundColor: primary.withOpacity(isDark ? 0.22 : 0.12),
      child: url.isEmpty
          ? initials
          : ClipOval(
              child: ChatAuthCachedImage(
                imageUrl: url,
                height: size,
                width: size,
                // Quiet fill — headers are usually already warmed by the list.
                placeholder: ColoredBox(
                  color: primary.withOpacity(isDark ? 0.22 : 0.12),
                ),
                errorWidget: SizedBox(
                  width: size,
                  height: size,
                  child: Center(child: initials),
                ),
              ),
            ),
    );
  }
}

class _MoreRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MoreRow({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          child: Row(
            children: [
              Icon(icon, size: 18.sp, color: color),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
