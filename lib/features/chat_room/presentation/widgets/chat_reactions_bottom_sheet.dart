import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';

/// Bottom sheet listing who reacted to a message, grouped by emoji.
class ChatReactionsBottomSheet extends StatefulWidget {
  final List<ChatReactionGroupView> reactions;
  final String? initialEmoji;
  final int? currentUserId;

  const ChatReactionsBottomSheet({
    super.key,
    required this.reactions,
    this.initialEmoji,
    this.currentUserId,
  });

  static Future<void> show(
    BuildContext context, {
    required List<ChatReactionGroupView> reactions,
    String? initialEmoji,
    int? currentUserId,
  }) {
    if (reactions.isEmpty) return Future.value();

    final totalPeople = reactions.fold<int>(
      0,
      (sum, g) => sum + (g.users.isNotEmpty ? g.users.length : g.count),
    );
    final heightFactor = (0.36 + (totalPeople * 0.05)).clamp(0.36, 0.68);

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (sheetContext) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final isDark =
                themeState is ThemeLoaded && themeState.isDarkMode;
            final sheetHeight =
                MediaQuery.sizeOf(context).height * heightFactor;

            return GestureDetector(
              onTap: () => Navigator.of(sheetContext).maybePop(),
              behavior: HitTestBehavior.opaque,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {}, // absorb taps on the sheet itself
                  child: Container(
                    width: double.infinity,
                    height: sheetHeight,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1C1826)
                          : Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.28),
                          blurRadius: 28,
                          offset: const Offset(0, -8),
                        ),
                      ],
                    ),
                    child: ChatReactionsBottomSheet(
                      reactions: reactions,
                      initialEmoji: initialEmoji,
                      currentUserId: currentUserId,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  State<ChatReactionsBottomSheet> createState() =>
      _ChatReactionsBottomSheetState();
}

class _ChatReactionsBottomSheetState extends State<ChatReactionsBottomSheet> {
  late String _selectedEmoji;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialEmoji;
    final hasInitial =
        initial != null && widget.reactions.any((g) => g.emoji == initial);
    _selectedEmoji = hasInitial ? initial : widget.reactions.first.emoji;
  }

  ChatReactionGroupView get _selectedGroup => widget.reactions.firstWhere(
        (g) => g.emoji == _selectedEmoji,
        orElse: () => widget.reactions.first,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final titleColor = isDark ? Colors.white : const Color(0xFF111827);
        final muted = isDark
            ? Colors.white.withOpacity(0.55)
            : const Color(0xFF6B7280);
        final divider = isDark
            ? Colors.white.withOpacity(0.06)
            : const Color(0xFFEEF0F4);
        final chipBg = isDark
            ? Colors.white.withOpacity(0.06)
            : const Color(0xFFF3F4F6);

        final total = widget.reactions.fold<int>(0, (s, g) => s + g.count);
        final users = _selectedGroup.users;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 12.h),
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: muted.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Container(
                    width: 40.r,
                    height: 40.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.9),
                          const Color(0xFF8B5CF6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      _selectedGroup.emoji,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr(AppStrings.reactions),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                            color: titleColor,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          total == 1
                              ? context.tr(AppStrings.oneReaction)
                              : context
                                  .tr(AppStrings.reactionsCount)
                                  .replaceAll('{count}', '$total'),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final group in widget.reactions) ...[
                        _EmojiFilterChip(
                          emoji: group.emoji,
                          count: group.count,
                          selected: group.emoji == _selectedEmoji,
                          isDark: isDark,
                          onTap: () =>
                              setState(() => _selectedEmoji = group.emoji),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 28.h),
                itemCount: users.isEmpty ? _selectedGroup.count : users.length,
                separatorBuilder: (_, __) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Divider(height: 1, thickness: 1, color: divider),
                ),
                itemBuilder: (context, index) {
                  final person = users.isEmpty
                      ? ChatReactionPerson(
                          name: context.tr(AppStrings.unknownUser),
                          initials: '?',
                        )
                      : users[index];
                  final isMe = widget.currentUserId != null &&
                      person.id == widget.currentUserId;
                  return _ReactionUserRow(
                    person: person,
                    emoji: _selectedGroup.emoji,
                    isDark: isDark,
                    titleColor: titleColor,
                    muted: muted,
                    isMe: isMe,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmojiFilterChip extends StatelessWidget {
  final String emoji;
  final int count;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  const _EmojiFilterChip({
    required this.emoji,
    required this.count,
    required this.selected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.w),
      child: Material(
        color: selected
            ? (isDark ? Colors.white.withOpacity(0.12) : Colors.white)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: selected
                  ? Border.all(
                      color: AppColors.primary.withOpacity(0.45),
                    )
                  : null,
              boxShadow: selected && !isDark
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: TextStyle(fontSize: 16.sp)),
                SizedBox(width: 6.w),
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? AppColors.primary
                        : (isDark
                            ? Colors.white.withOpacity(0.7)
                            : const Color(0xFF4B5563)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReactionUserRow extends StatelessWidget {
  final ChatReactionPerson person;
  final String emoji;
  final bool isDark;
  final Color titleColor;
  final Color muted;
  final bool isMe;

  const _ReactionUserRow({
    required this.person,
    required this.emoji,
    required this.isDark,
    required this.titleColor,
    required this.muted,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = person.imageUrl?.trim();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.25),
                  const Color(0xFF8B5CF6).withOpacity(0.18),
                ],
              ),
            ),
            padding: EdgeInsets.all(2.r),
            child: CircleAvatar(
              backgroundColor:
                  isDark ? const Color(0xFF2A2438) : Colors.white,
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? ClipOval(
                      child: CustomCachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 40.r,
                        height: 40.r,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      person.initials,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    isMe ? 'You' : person.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.15,
                      color: isMe ? AppColors.primary : titleColor,
                    ),
                  ),
                ),
                if (person.isVerified) ...[
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.verified_rounded,
                    size: 15.sp,
                    color: const Color(0xFF22C55E),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(emoji, style: TextStyle(fontSize: 20.sp)),
        ],
      ),
    );
  }
}
