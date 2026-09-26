import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_cubit.dart';
import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_state.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:intl/intl.dart';

/// Professional WhatsApp-style message info with live receipt updates.
class ChatSeenBySheet extends StatefulWidget {
  final ChatMessageItem initialMessage;
  final int? currentUserId;
  final int memberCount;
  final ChatRoomCubit? cubit;

  const ChatSeenBySheet({
    super.key,
    required this.initialMessage,
    this.currentUserId,
    this.memberCount = 0,
    this.cubit,
  });

  static Future<void> show(
    BuildContext context, {
    required ChatMessageItem message,
    int? currentUserId,
    int memberCount = 0,
  }) {
    ChatRoomCubit? cubit;
    try {
      cubit = context.read<ChatRoomCubit>();
    } catch (_) {
      cubit = null;
    }

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (sheetContext) {
        Widget sheet = ChatSeenBySheet(
          initialMessage: message,
          currentUserId: currentUserId,
          memberCount: memberCount,
          cubit: cubit,
        );
        if (cubit != null) {
          sheet = BlocProvider.value(value: cubit, child: sheet);
        }
        return sheet;
      },
    );
  }

  @override
  State<ChatSeenBySheet> createState() => _ChatSeenBySheetState();
}

class _ChatSeenBySheetState extends State<ChatSeenBySheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 580),
    )..forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  ChatMessageItem _liveMessage(ChatRoomState? state) {
    final id = widget.initialMessage.id;
    final tempId = widget.initialMessage.clientTempId;
    final fromCubit = widget.cubit?.messageById(id) ??
        (tempId != null ? widget.cubit?.messageById(tempId) : null);
    if (fromCubit != null) return fromCubit;

    if (state != null) {
      final messages = state.maybeWhen(
        loaded: (messages, _, __, ___, ____, _____, ______, _______, ________,
                _________, __________, ___________) =>
            messages,
        orElse: () => const <ChatMessageItem>[],
      );
      for (final m in messages) {
        if (m.id == id ||
            (tempId != null && m.clientTempId == tempId) ||
            (tempId != null && m.id == tempId)) {
          return m;
        }
      }
    }
    return widget.initialMessage;
  }

  String _previewText(ChatMessageItem message) {
    final text = message.text.trim();
    if (text.isNotEmpty &&
        !text.startsWith('[') &&
        text != '[Image]' &&
        text != '[Voice message]' &&
        text != '[File]') {
      return text;
    }
    if (message.hasVoice) return '🎤 Voice message';
    if (message.hasImages) return '📷 Photo';
    if (message.hasFiles) return '📎 File';
    return text.isEmpty ? 'Message' : text;
  }

  @override
  Widget build(BuildContext context) {
    final body = widget.cubit == null
        ? _buildSheet(context, widget.initialMessage)
        : BlocBuilder<ChatRoomCubit, ChatRoomState>(
            builder: (context, state) {
              return _buildSheet(context, _liveMessage(state));
            },
          );

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final maxH = MediaQuery.sizeOf(context).height * 0.82;
        final minH = MediaQuery.sizeOf(context).height * 0.42;

        return GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          behavior: HitTestBehavior.opaque,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {},
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeOutCubic,
                builder: (context, t, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - t) * 48),
                    child: Opacity(opacity: t, child: child),
                  );
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: maxH,
                    minHeight: minH,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark
                            ? const [
                                Color(0xFF241C33),
                                Color(0xFF15111F),
                              ]
                            : const [
                                Color(0xFFF7F4FF),
                                Colors.white,
                              ],
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28.r),
                      ),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : const Color(0xFFE9E2FF),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.18),
                          blurRadius: 40,
                          offset: const Offset(0, -12),
                        ),
                      ],
                    ),
                    child: body,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSheet(BuildContext context, ChatMessageItem message) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final titleColor = isDark ? AppColors.darkTitle : AppColors.title;
        final muted =
            isDark ? AppColors.darkDescription : AppColors.description;

        final seen = message.seenByPeople.isNotEmpty
            ? message.seenByPeople
            : [
                for (final p in message.reads)
                  ChatDeliveryPerson(
                    id: p.id,
                    name: p.name,
                    initials: p.initials,
                    imageUrl: p.imageUrl,
                    isVerified: p.isVerified,
                    kind: ChatDeliveryReceiptKind.seen,
                  ),
              ];
        final delivered = message.deliveredOnlyPeople;
        final remaining = message.remainingPeople;
        final total = message.deliveryPeople.isNotEmpty
            ? message.deliveryPeople.length
            : (seen.length + delivered.length + remaining.length);
        final seenN = seen.length;
        final deliveredN = delivered.length;
        final remainingN = remaining.length;
        final hasRoster = total > 0;

        var rowIndex = 0;

        return Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.2)
                    : const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            SizedBox(height: 14.h),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Row(
                children: [
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          Color(0xFF7C3AED),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.done_all_rounded,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr(AppStrings.messageInfo),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: titleColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Container(
                              width: 6.r,
                              height: 6.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF34D399),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF34D399)
                                        .withOpacity(0.55),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Live',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: muted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            // Message preview card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            AppColors.primary.withOpacity(0.28),
                            const Color(0xFF2A2140),
                          ]
                        : [
                            AppColors.primary.withOpacity(0.12),
                            const Color(0xFFF3EEFF),
                          ],
                  ),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.25),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        _previewText(message),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                          height: 1.35,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      message.timeLabel,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (hasRoster) ...[
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _ReceiptProgressBar(
                  seen: seenN,
                  delivered: deliveredN,
                  remaining: remainingN,
                  total: total,
                  isDark: isDark,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatPill(
                        label: context.tr(AppStrings.seenBy),
                        value: '$seenN',
                        color: const Color(0xFF34B7F1),
                        isDark: isDark,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _StatPill(
                        label: context.tr(AppStrings.deliveredTo),
                        value: '$deliveredN',
                        color: const Color(0xFFA78BFA),
                        isDark: isDark,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _StatPill(
                        label: context.tr(AppStrings.remainingMembers),
                        value: '$remainingN',
                        color: muted,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 8.h),
            Expanded(
              child: !hasRoster && seen.isEmpty
                  ? _EmptyWaitingState(
                      isDark: isDark,
                      muted: muted,
                      titleColor: titleColor,
                    )
                  : ListView(
                      padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 28.h),
                      children: [
                        _section(
                          context: context,
                          title: context.tr(AppStrings.seenBy),
                          accent: const Color(0xFF34B7F1),
                          icon: Icons.done_all_rounded,
                          people: seen,
                          kind: ChatDeliveryReceiptKind.seen,
                          isDark: isDark,
                          titleColor: titleColor,
                          muted: muted,
                          rowIndex: () => rowIndex++,
                        ),
                        _section(
                          context: context,
                          title: context.tr(AppStrings.deliveredTo),
                          accent: const Color(0xFFA78BFA),
                          icon: Icons.done_all_rounded,
                          people: delivered,
                          kind: ChatDeliveryReceiptKind.delivered,
                          isDark: isDark,
                          titleColor: titleColor,
                          muted: muted,
                          rowIndex: () => rowIndex++,
                        ),
                        _section(
                          context: context,
                          title: context.tr(AppStrings.remainingMembers),
                          accent: muted,
                          icon: Icons.schedule_rounded,
                          people: remaining,
                          kind: ChatDeliveryReceiptKind.remaining,
                          isDark: isDark,
                          titleColor: titleColor,
                          muted: muted,
                          rowIndex: () => rowIndex++,
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _section({
    required BuildContext context,
    required String title,
    required Color accent,
    required IconData icon,
    required List<ChatDeliveryPerson> people,
    required ChatDeliveryReceiptKind kind,
    required bool isDark,
    required Color titleColor,
    required Color muted,
    required int Function() rowIndex,
  }) {
    if (people.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: isDark
              ? Colors.white.withOpacity(0.04)
              : Colors.white.withOpacity(0.85),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.07)
                : const Color(0xFFE9E2FF),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 6.h),
              child: Row(
                children: [
                  Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accent.withOpacity(isDark ? 0.22 : 0.16),
                    ),
                    child: Icon(icon, size: 14.sp, color: accent),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: accent.withOpacity(0.15),
                    ),
                    child: Text(
                      '${people.length}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...people.map((person) {
              final i = rowIndex();
              final start = (0.05 + i * 0.04).clamp(0.0, 0.78);
              final anim = CurvedAnimation(
                parent: _intro,
                curve: Interval(
                  start,
                  (start + 0.28).clamp(0.0, 1.0),
                  curve: Curves.easeOutCubic,
                ),
              );
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.12),
                    end: Offset.zero,
                  ).animate(anim),
                  child: _ReceiptUserRow(
                    person: person,
                    kind: kind,
                    accent: accent,
                    isDark: isDark,
                    titleColor: titleColor,
                    muted: muted,
                    isMe: widget.currentUserId != null &&
                        person.id == widget.currentUserId,
                  ),
                ),
              );
            }),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }
}

class _ReceiptProgressBar extends StatelessWidget {
  final int seen;
  final int delivered;
  final int remaining;
  final int total;
  final bool isDark;

  const _ReceiptProgressBar({
    required this.seen,
    required this.delivered,
    required this.remaining,
    required this.total,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final t = total <= 0 ? 1 : total;
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: SizedBox(
        height: 8.h,
        child: Row(
          children: [
            if (seen > 0)
              Expanded(
                flex: seen,
                child: Container(color: const Color(0xFF34B7F1)),
              ),
            if (delivered > 0)
              Expanded(
                flex: delivered,
                child: Container(color: const Color(0xFFA78BFA)),
              ),
            if (remaining > 0)
              Expanded(
                flex: remaining,
                child: Container(
                  color: isDark
                      ? Colors.white.withOpacity(0.12)
                      : const Color(0xFFE5E7EB),
                ),
              ),
            if (seen == 0 && delivered == 0 && remaining == 0)
              Expanded(
                flex: t,
                child: Container(
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : const Color(0xFFE5E7EB),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _StatPill({
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: color.withOpacity(isDark ? 0.14 : 0.1),
        border: Border.all(color: color.withOpacity(0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyWaitingState extends StatelessWidget {
  final bool isDark;
  final Color muted;
  final Color titleColor;

  const _EmptyWaitingState({
    required this.isDark,
    required this.muted,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.35),
                    const Color(0xFF7C3AED).withOpacity(0.2),
                  ],
                ),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.35),
                ),
              ),
              child: Icon(
                Icons.mark_chat_unread_rounded,
                size: 26.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              context.tr(AppStrings.noOneHasSeenYet),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              context.tr(AppStrings.messageInfoEmpty),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w500,
                color: muted,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptUserRow extends StatelessWidget {
  final ChatDeliveryPerson person;
  final ChatDeliveryReceiptKind kind;
  final Color accent;
  final bool isDark;
  final Color titleColor;
  final Color muted;
  final bool isMe;

  const _ReceiptUserRow({
    required this.person,
    required this.kind,
    required this.accent,
    required this.isDark,
    required this.titleColor,
    required this.muted,
    required this.isMe,
  });

  String? _timeLabel() {
    final at = person.at;
    if (at == null) return null;
    return DateFormat.jm().format(at);
  }

  @override
  Widget build(BuildContext context) {
    final image = person.imageUrl?.trim();
    final time = _timeLabel();
    final statusIcon = switch (kind) {
      ChatDeliveryReceiptKind.seen => Icons.done_all_rounded,
      ChatDeliveryReceiptKind.delivered => Icons.done_all_rounded,
      ChatDeliveryReceiptKind.remaining => Icons.schedule_rounded,
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: isDark
              ? Colors.white.withOpacity(0.03)
              : AppColors.primary.withOpacity(0.03),
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accent.withOpacity(0.55), width: 1.6),
              ),
              padding: EdgeInsets.all(1.5.r),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : const Color(0xFFEDE9FE),
                ),
                clipBehavior: Clip.antiAlias,
                child: image != null && image.isNotEmpty
                    ? CustomCachedNetworkImage(
                        imageUrl: image,
                        width: 40.r,
                        height: 40.r,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text(
                          person.initials,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMe ? context.tr(AppStrings.you) : person.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                  if (person.isVerified || time != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      [
                        if (person.isVerified)
                          context.tr(AppStrings.verified),
                        if (time != null) time,
                      ].join(' · '),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: muted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(statusIcon, size: 16.sp, color: accent),
          ],
        ),
      ),
    );
  }
}
