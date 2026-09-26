import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity_labels.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:egy_akin/features/inbox/presentation/widgets/inbox_animated_thread_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../exports.dart';

class InboxThreadCard extends StatelessWidget {
  final InboxThread thread;
  final bool isDark;
  final Color primary;
  final bool grouped;
  final bool isArchivedList;
  final VoidCallback onTap;
  final Future<void> Function(InboxThread thread)? onArchive;
  final Future<void> Function(InboxThread thread)? onToggleRead;
  final Future<void> Function(InboxThread thread)? onTogglePin;
  final Future<void> Function(InboxThread thread)? onMore;

  const InboxThreadCard({
    required this.thread,
    required this.isDark,
    required this.primary,
    required this.onTap,
    this.grouped = false,
    this.isArchivedList = false,
    this.onArchive,
    this.onToggleRead,
    this.onTogglePin,
    this.onMore,
  });

  Color get _avatarBg {
    switch (thread.kind) {
      case InboxThreadKind.caseNote:
        return const Color(0xFFF59E0B).withOpacity(0.16);
      case InboxThreadKind.support:
        return const Color(0xFF3B82F6).withOpacity(0.16);
      case InboxThreadKind.consult:
        return primary.withOpacity(0.14);
      case InboxThreadKind.patient:
        return const Color(0xFF22C55E).withOpacity(0.14);
      case InboxThreadKind.admin:
        return const Color(0xFFEF4444).withOpacity(0.14);
      case InboxThreadKind.doctor:
      case InboxThreadKind.group:
        return isDark ? const Color(0xFF2A2A2E) : const Color(0xFFF3F4F6);
    }
  }

  Color get _avatarFg {
    switch (thread.kind) {
      case InboxThreadKind.caseNote:
        return const Color(0xFFF59E0B);
      case InboxThreadKind.support:
        return const Color(0xFF3B82F6);
      case InboxThreadKind.consult:
        return primary;
      case InboxThreadKind.patient:
        return const Color(0xFF22C55E);
      case InboxThreadKind.admin:
        return const Color(0xFFEF4444);
      case InboxThreadKind.doctor:
      case InboxThreadKind.group:
        return HomeDashboardColors.subtitle(isDark);
    }
  }

  IconData? get _avatarIcon {
    switch (thread.kind) {
      case InboxThreadKind.caseNote:
        return Icons.post_add_rounded;
      case InboxThreadKind.support:
        return Icons.support_agent_rounded;
      case InboxThreadKind.admin:
        return Icons.campaign_rounded;
      case InboxThreadKind.consult:
        return Icons.medical_services_outlined;
      default:
        return null;
    }
  }

  bool get _isGroupChatType => thread.isGroupLike;

  @override
  Widget build(BuildContext context) {
    // Ad-hoc chat groups get a dedicated compact row (social groups keep the
    // standard card — they already look clean).
    if (thread.chatType == ChatApiType.group) {
      return _AdHocGroupThreadRow(
        thread: thread,
        isDark: isDark,
        primary: primary,
        grouped: grouped,
        isArchivedList: isArchivedList,
        onTap: onTap,
        onArchive: onArchive,
        onToggleRead: onToggleRead,
        onTogglePin: onTogglePin,
        onMore: onMore,
      );
    }

    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: grouped ? 12.w : 12.w,
        vertical: grouped ? 11.h : 12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _ThreadAvatar(
                thread: thread,
                radius: 20.r,
                backgroundColor: _avatarBg,
                foregroundColor: _avatarFg,
                icon: _avatarIcon,
              ),
              if (_isGroupChatType)
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: _GroupAvatarBadge(
                    primary: primary,
                    borderColor: HomeDashboardColors.cardBg(isDark),
                    size: 15.r,
                  ),
                ),
              // 1:1 chats only — patient/case groups never show online/offline.
              if (!_isGroupChatType)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 10.r,
                    height: 10.r,
                    decoration: BoxDecoration(
                      color: thread.isOnline
                          ? HomeDashboardColors.online
                          : (isDark
                              ? const Color(0xFF6B7280)
                              : const Color(0xFF9CA3AF)),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: HomeDashboardColors.cardBg(isDark),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              thread.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                          ),
                          if (thread.isVerified) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.verified_rounded,
                              size: 12.sp,
                              color: HomeDashboardColors.success,
                            ),
                          ],
                          if (thread.isUrgent) ...[
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFF59E0B).withOpacity(0.18),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                context.tr(AppStrings.urgentUpper),
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFFD97706),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w),
                    if (thread.isAdminBadge) ...[
                      Icon(
                        Icons.verified_user_rounded,
                        size: 13.sp,
                        color: const Color(0xFFEF4444),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    if (thread.isMuted) ...[
                      Icon(
                        Icons.volume_off_rounded,
                        size: 12.sp,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    if (thread.isPinned) ...[
                      _PinnedBadge(
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      thread.timeLabel == AppStrings.now
                          ? context.tr(AppStrings.now)
                          : thread.timeLabel,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  thread.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    if (!thread.hasPeerActivity &&
                        thread.unreadCount == 0 &&
                        thread.lastMessageStatus != null) ...[
                      _InboxStatusTicks(
                        status: thread.lastMessageStatus!,
                        isDark: isDark,
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Expanded(
                      child: thread.hasPeerActivity
                          ? Text(
                              ChatComposerActivityLabels.short(
                                context,
                                thread.peerActivity.isActive
                                    ? thread.peerActivity
                                    : ChatComposerActivity.typing,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            )
                          : _InboxPreviewLine(
                              thread: thread,
                              isDark: isDark,
                            ),
                    ),
                    if (thread.unreadCount > 0) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${thread.unreadCount}',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return InboxSwipeableRow(
      thread: thread,
      isArchivedList: isArchivedList,
      onArchive: onArchive,
      onToggleRead: onToggleRead,
      onTogglePin: onTogglePin,
      onMore: onMore,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(grouped ? 0 : 16.r),
          child: grouped
              ? content
              : Ink(
                  decoration: HomeDashboardDecor.card(isDark),
                  child: content,
                ),
        ),
      ),
    );
  }
}

/// Small groups icon overlay used on all group chat avatars in inbox.
class _GroupAvatarBadge extends StatelessWidget {
  final Color primary;
  final Color borderColor;
  final double size;

  const _GroupAvatarBadge({
    required this.primary,
    required this.borderColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: primary,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Icon(
        Icons.groups_rounded,
        size: size * 0.56,
        color: Colors.white,
      ),
    );
  }
}

class _AdHocGroupThreadRow extends StatelessWidget {
  final InboxThread thread;
  final bool isDark;
  final Color primary;
  final bool grouped;
  final bool isArchivedList;
  final VoidCallback onTap;
  final Future<void> Function(InboxThread thread)? onArchive;
  final Future<void> Function(InboxThread thread)? onToggleRead;
  final Future<void> Function(InboxThread thread)? onTogglePin;
  final Future<void> Function(InboxThread thread)? onMore;

  const _AdHocGroupThreadRow({
    required this.thread,
    required this.isDark,
    required this.primary,
    required this.grouped,
    required this.onTap,
    this.isArchivedList = false,
    this.onArchive,
    this.onToggleRead,
    this.onTogglePin,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = HomeDashboardColors.title(isDark);
    final muted = HomeDashboardColors.subtitle(isDark);
    final cardBg = HomeDashboardColors.cardBg(isDark);
    final unread = thread.unreadCount > 0;

    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primary.withOpacity(isDark ? 0.35 : 0.22),
                      primary.withOpacity(isDark ? 0.12 : 0.08),
                    ],
                  ),
                  border: Border.all(
                    color: primary.withOpacity(isDark ? 0.28 : 0.18),
                    width: 1.2,
                  ),
                ),
                child: ClipOval(
                  child: thread.imageUrl != null &&
                          thread.imageUrl!.trim().isNotEmpty
                      ? ChatAuthCachedImage(
                          imageUrl: thread.imageUrl!,
                          width: 44.r,
                          height: 44.r,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            thread.initials,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: primary,
                            ),
                          ),
                        ),
                ),
              ),
              Positioned(
                right: -1,
                bottom: -1,
                child: _GroupAvatarBadge(
                  primary: primary,
                  borderColor: cardBg,
                  size: 16.r,
                ),
              ),
            ],
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        thread.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:
                              unread ? FontWeight.w700 : FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (thread.isMuted) ...[
                      Icon(
                        Icons.volume_off_rounded,
                        size: 12.sp,
                        color: muted,
                      ),
                      SizedBox(width: 4.w),
                    ],
                    if (thread.isPinned) ...[
                      _PinnedBadge(color: muted),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      thread.timeLabel == AppStrings.now
                          ? context.tr(AppStrings.now)
                          : thread.timeLabel,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: unread ? primary : muted,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (!thread.hasPeerActivity &&
                        thread.unreadCount == 0 &&
                        thread.lastMessageStatus != null) ...[
                      _InboxStatusTicks(
                        status: thread.lastMessageStatus!,
                        isDark: isDark,
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Expanded(
                      child: thread.hasPeerActivity
                          ? Text(
                              ChatComposerActivityLabels.short(
                                context,
                                thread.peerActivity.isActive
                                    ? thread.peerActivity
                                    : ChatComposerActivity.typing,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            )
                          : _InboxPreviewLine(
                              thread: thread,
                              isDark: isDark,
                            ),
                    ),
                    if (unread) ...[
                      SizedBox(width: 8.w),
                      Container(
                        constraints: BoxConstraints(minWidth: 18.r),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${thread.unreadCount}',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return InboxSwipeableRow(
      thread: thread,
      isArchivedList: isArchivedList,
      onArchive: onArchive,
      onToggleRead: onToggleRead,
      onTogglePin: onTogglePin,
      onMore: onMore,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(grouped ? 0 : 16.r),
          child: grouped
              ? content
              : Ink(
                  decoration: HomeDashboardDecor.card(isDark),
                  child: content,
                ),
        ),
      ),
    );
  }
}

class _InboxPreviewLine extends StatelessWidget {
  final InboxThread thread;
  final bool isDark;

  const _InboxPreviewLine({
    required this.thread,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final unread = thread.unreadCount > 0;
    final color = unread
        ? HomeDashboardColors.title(isDark)
        : HomeDashboardColors.subtitle(isDark);
    final weight = unread ? FontWeight.w700 : FontWeight.w500;

    IconData? icon;
    // Normalize API content like "[2 images]" before rendering.
    String label = ChatMappers.normalizeMediaPlaceholder(thread.preview);
    var kind = thread.previewKind;
    if (kind == InboxPreviewKind.text) {
      kind = ChatMappers.previewKindFromText(label);
    }
    final count = () {
      final fromText = ChatMappers.previewCountFromText(label);
      if (fromText > 1) return fromText;
      if (thread.previewCount > 1) return thread.previewCount;
      return fromText;
    }();

    switch (kind) {
      case InboxPreviewKind.photo:
        icon = Icons.photo_camera_outlined;
        label = count > 1
            ? '$count ${context.tr(AppStrings.photosPlural)}'
            : context.tr(AppStrings.photo);
      case InboxPreviewKind.voice:
        icon = Icons.mic_rounded;
        final dur = ChatMappers.voiceDurationFromPlaceholder(thread.preview) ??
            ChatMappers.voiceDurationFromPlaceholder(label);
        label = dur == null
            ? context.tr(AppStrings.voiceMessage)
            : '${context.tr(AppStrings.voiceMessage)} · $dur';
      case InboxPreviewKind.file:
        icon = Icons.insert_drive_file_rounded;
        if (count > 1) {
          label = '$count ${context.tr(AppStrings.attachmentsPlural)}';
        } else if (label.startsWith('[File: ') && label.endsWith(']')) {
          label = label.substring(7, label.length - 1);
        } else {
          label = context.tr(AppStrings.file);
        }
      case InboxPreviewKind.text:
        icon = null;
        if (ChatMappers.isImagePlaceholder(label)) {
          icon = Icons.photo_camera_outlined;
          final n = ChatMappers.previewCountFromText(label);
          label = n > 1
              ? '$n ${context.tr(AppStrings.photosPlural)}'
              : context.tr(AppStrings.photo);
        } else if (ChatMappers.isFilePlaceholder(label)) {
          icon = Icons.insert_drive_file_rounded;
          final n = ChatMappers.previewCountFromText(label);
          label = n > 1
              ? '$n ${context.tr(AppStrings.attachmentsPlural)}'
              : context.tr(AppStrings.file);
        } else if (ChatMappers.isVoicePlaceholder(label) ||
            ChatMappers.isVoicePlaceholder(thread.preview)) {
          icon = Icons.mic_rounded;
          final dur = ChatMappers.voiceDurationFromPlaceholder(thread.preview) ??
              ChatMappers.voiceDurationFromPlaceholder(label);
          label = dur == null
              ? context.tr(AppStrings.voiceMessage)
              : '${context.tr(AppStrings.voiceMessage)} · $dur';
        } else if (label.startsWith('[') &&
            label.endsWith(']') &&
            label.length > 2) {
          // Never show raw API placeholder brackets in the inbox row.
          label = label.substring(1, label.length - 1);
        }
    }

    final text = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: weight,
        color: color,
      ),
    );

    if (icon == null) return text;

    return Row(
      children: [
        Icon(icon, size: 14.sp, color: color),
        SizedBox(width: 4.w),
        Expanded(child: text),
      ],
    );
  }
}

class _InboxStatusTicks extends StatelessWidget {
  final ChatMessageStatus status;
  final bool isDark;

  const _InboxStatusTicks({
    required this.status,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final muted = HomeDashboardColors.subtitle(isDark);
    const seenColor = Color(0xFF34B7F1);

    switch (status) {
      case ChatMessageStatus.sending:
        return SizedBox(
          width: 12.sp,
          height: 12.sp,
          child: CircularProgressIndicator(
            strokeWidth: 1.4,
            color: muted,
          ),
        );
      case ChatMessageStatus.pending:
        return Icon(
          Icons.access_time_rounded,
          size: 14.sp,
          color: muted,
        );
      case ChatMessageStatus.failed:
        return Icon(
          Icons.error_outline_rounded,
          size: 14.sp,
          color: const Color(0xFFEF4444),
        );
      case ChatMessageStatus.sent:
        return Icon(
          Icons.done_rounded,
          size: 14.sp,
          color: muted,
        );
      case ChatMessageStatus.delivered:
        return Icon(
          Icons.done_all_rounded,
          size: 14.sp,
          color: muted,
        );
      case ChatMessageStatus.seen:
        return Icon(
          Icons.done_all_rounded,
          size: 14.sp,
          color: seenColor,
        );
    }
  }
}

class _ThreadAvatar extends StatelessWidget {
  final InboxThread thread;
  final double radius;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? icon;

  const _ThreadAvatar({
    required this.thread,
    required this.radius,
    required this.backgroundColor,
    required this.foregroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = thread.imageUrl?.trim();
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final initialsText = Text(
      thread.initials,
      style: TextStyle(
        fontSize: radius * 0.55,
        fontWeight: FontWeight.w700,
        color: foregroundColor,
      ),
    );

    if (hasImage && icon == null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: ClipOval(
          child: ChatAuthCachedImage(
            imageUrl: imageUrl,
            height: radius * 2,
            width: radius * 2,
            errorWidget: SizedBox(
              width: radius * 2,
              height: radius * 2,
              child: Center(child: initialsText),
            ),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: icon != null
          ? Icon(icon, color: foregroundColor, size: radius * 0.9)
          : initialsText,
    );
  }
}

class InboxGroupedThreadsCard extends StatelessWidget {
  final List<InboxThread> threads;
  final bool isDark;
  final Color primary;
  final bool isArchivedList;
  final ValueChanged<InboxThread> onThreadTap;
  final Future<void> Function(InboxThread thread)? onArchive;
  final Future<void> Function(InboxThread thread)? onToggleRead;
  final Future<void> Function(InboxThread thread)? onTogglePin;
  final Future<void> Function(InboxThread thread)? onMore;
  final Widget? emptyPlaceholder;

  /// When true, returns a [SliverList] for a parent [CustomScrollView].
  final bool asSliver;

  const InboxGroupedThreadsCard({
    required this.threads,
    required this.isDark,
    required this.primary,
    required this.onThreadTap,
    this.isArchivedList = false,
    this.onArchive,
    this.onToggleRead,
    this.onTogglePin,
    this.onMore,
    this.emptyPlaceholder,
    this.asSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    final list = InboxAnimatedThreadList(
      key: ValueKey(isArchivedList ? 'inbox-archived-list' : 'inbox-earlier-list'),
      threads: threads,
      asSliver: asSliver,
      removeSlideTowardEnd: !isArchivedList,
      itemExtent: 78.h,
      separatorBuilder: (context, _) => Divider(
        height: 1,
        indent: 54.w,
        color: HomeDashboardColors.border(isDark).withOpacity(0.55),
      ),
      frameBuilder: asSliver
          ? null
          : (context, list, isVisuallyEmpty) {
              if (isVisuallyEmpty) {
                return emptyPlaceholder ?? const SizedBox.shrink();
              }
              return Container(
                decoration: HomeDashboardDecor.card(isDark),
                clipBehavior: Clip.hardEdge,
                child: list,
              );
            },
      itemBuilder: (context, thread, index, visibleCount) {
        return InboxThreadCard(
          thread: thread,
          isDark: isDark,
          primary: primary,
          grouped: true,
          isArchivedList: isArchivedList,
          onTap: () => onThreadTap(thread),
          onArchive: onArchive,
          onToggleRead: onToggleRead,
          onTogglePin: onTogglePin,
          onMore: onMore,
        );
      },
    );

    if (!asSliver) return list;

    // Card chrome around a virtualized sliver list.
    if (threads.isEmpty) {
      return SliverToBoxAdapter(
        child: emptyPlaceholder ?? const SizedBox.shrink(),
      );
    }
    return DecoratedSliver(
      decoration: HomeDashboardDecor.card(isDark),
      sliver: list,
    );
  }
}

/// Standalone (priority) thread cards with the same insert/remove/reorder motion.
class InboxAnimatedPriorityThreads extends StatelessWidget {
  final List<InboxThread> threads;
  final bool isDark;
  final Color primary;
  final ValueChanged<InboxThread> onThreadTap;
  final Future<void> Function(InboxThread thread)? onArchive;
  final Future<void> Function(InboxThread thread)? onToggleRead;
  final Future<void> Function(InboxThread thread)? onTogglePin;
  final Future<void> Function(InboxThread thread)? onMore;

  const InboxAnimatedPriorityThreads({
    required this.threads,
    required this.isDark,
    required this.primary,
    required this.onThreadTap,
    this.onArchive,
    this.onToggleRead,
    this.onTogglePin,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return InboxAnimatedThreadList(
      key: const ValueKey('inbox-priority-list'),
      threads: threads,
      removeSlideTowardEnd: true,
      itemExtent: 88.h,
      separatorBuilder: (context, _) => SizedBox(height: 8.h),
      itemBuilder: (context, thread, index, visibleCount) {
        return InboxThreadCard(
          thread: thread,
          isDark: isDark,
          primary: primary,
          onTap: () => onThreadTap(thread),
          onArchive: onArchive,
          onToggleRead: onToggleRead,
          onTogglePin: onTogglePin,
          onMore: onMore,
        );
      },
    );
  }
}

class _PinnedBadge extends StatefulWidget {
  final Color color;

  const _PinnedBadge({required this.color});

  @override
  State<_PinnedBadge> createState() => _PinnedBadgeState();
}

class _PinnedBadgeState extends State<_PinnedBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounce;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    )..forward();
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounce,
      builder: (context, child) {
        final t = Curves.elasticOut.transform(_bounce.value.clamp(0.0, 1.0));
        final scale = 0.65 + (0.35 * t);
        return Transform.scale(scale: scale, child: child);
      },
      child: Icon(
        Icons.push_pin_rounded,
        size: 12.sp,
        color: widget.color,
      ),
    );
  }
}

class InboxSwipeableRow extends StatelessWidget {
  final InboxThread thread;
  final Widget child;
  final bool isArchivedList;
  final Future<void> Function(InboxThread thread)? onArchive;
  final Future<void> Function(InboxThread thread)? onToggleRead;
  final Future<void> Function(InboxThread thread)? onTogglePin;
  final Future<void> Function(InboxThread thread)? onMore;

  const InboxSwipeableRow({
    required this.thread,
    required this.child,
    this.isArchivedList = false,
    this.onArchive,
    this.onToggleRead,
    this.onTogglePin,
    this.onMore,
  });

  static const _archiveGreen = Color(0xFF00A884);
  static const _moreGray = Color(0xFF667781);
  static const _unreadGreen = Color(0xFF00A884);
  static const _pinTeal = Color(0xFF25D366);

  @override
  Widget build(BuildContext context) {
    if (!thread.opensAsChatRoom) return child;

    final isUnread = thread.unreadCount > 0;
    final labelStyle = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      height: 1.1,
      color: Colors.white,
    );

    Widget action({
      required Color color,
      required IconData icon,
      required String label,
      required VoidCallback onPressed,
      Color? foreground,
    }) {
      final fg = foreground ?? Colors.white;
      return CustomSlidableAction(
        onPressed: (_) => onPressed(),
        backgroundColor: color,
        foregroundColor: fg,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22.sp, color: fg),
            SizedBox(height: 6.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: labelStyle.copyWith(color: fg),
            ),
          ],
        ),
      );
    }

    return ClipRect(
      child: Slidable(
        key: ValueKey('inbox_swipe_${thread.id}'),
        // Swipe right → Read (/ Pin on inbox only)
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: isArchivedList ? 0.28 : 0.42,
          dismissible: DismissiblePane(
            dismissThreshold: 0.52,
            dismissalDuration: const Duration(milliseconds: 280),
            resizeDuration: const Duration(milliseconds: 220),
            closeOnCancel: true,
            motion: const InversedDrawerMotion(),
            confirmDismiss: () async {
              // Fire immediately so the green expand + close stays snappy.
              onToggleRead?.call(thread);
              // Keep the row — snap the pane closed after the expand gesture.
              return false;
            },
            onDismissed: () {},
          ),
          children: [
            action(
              color: _unreadGreen,
              foreground: Colors.black87,
              icon: isUnread
                  ? Icons.mark_chat_read_outlined
                  : Icons.mark_chat_unread_outlined,
              label: context.tr(
                isUnread ? AppStrings.markAsRead : AppStrings.markAsUnread,
              ),
              onPressed: () => onToggleRead?.call(thread),
            ),
            if (!isArchivedList)
              action(
                color: _pinTeal,
                icon: thread.isPinned
                    ? Icons.push_pin_outlined
                    : Icons.push_pin_rounded,
                label: context.tr(
                  thread.isPinned ? AppStrings.unpinChat : AppStrings.pinChat,
                ),
                onPressed: () => onTogglePin?.call(thread),
              ),
          ],
        ),
        // Swipe left → More + Archive (or Unarchive when viewing archived)
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: isArchivedList ? 0.28 : 0.42,
          dismissible: DismissiblePane(
            dismissThreshold: 0.52,
            dismissalDuration: const Duration(milliseconds: 280),
            resizeDuration: const Duration(milliseconds: 220),
            closeOnCancel: true,
            motion: const InversedDrawerMotion(),
            confirmDismiss: () async {
              onArchive?.call(thread);
              // Cubit removes the row on success; cancel so a failed archive
              // doesn't leave a blank hole.
              return false;
            },
            onDismissed: () {},
          ),
          children: isArchivedList
              ? [
                  action(
                    color: _archiveGreen,
                    icon: Icons.unarchive_rounded,
                    label: context.tr(AppStrings.unarchive),
                    onPressed: () => onArchive?.call(thread),
                  ),
                ]
              : [
                  action(
                    color: _moreGray,
                    icon: Icons.more_horiz_rounded,
                    label: context.tr(AppStrings.more),
                    onPressed: () => onMore?.call(thread),
                  ),
                  action(
                    color: _archiveGreen,
                    icon: Icons.archive_rounded,
                    label: context.tr(AppStrings.archive),
                    onPressed: () => onArchive?.call(thread),
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}
