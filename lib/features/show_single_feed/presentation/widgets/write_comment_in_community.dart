import 'dart:ui';

import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class WriteCommentInCommunity extends StatefulWidget {
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final PostCommunityModel feed;
  final DoctorModel currentDoctorModel;

  const WriteCommentInCommunity({
    super.key,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.feed,
    required this.currentDoctorModel,
  });

  @override
  State<WriteCommentInCommunity> createState() =>
      _WriteCommentInCommunityState();
}

class _WriteCommentInCommunityState extends State<WriteCommentInCommunity> {
  late final TextEditingController _controller;
  late TextDirection _textDirection;
  late bool _hasText;

  static final _arabicChar = RegExp(r'[\u0600-\u06FF]');
  static final _latinChar = RegExp(r'[A-Za-z]');

  TextDirection _appTextDirection() =>
      context.isRTL ? TextDirection.rtl : TextDirection.ltr;

  TextDirection _directionFor(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return _appTextDirection();
    for (final match in RegExp(r'[A-Za-z\u0600-\u06FF]').allMatches(trimmed)) {
      final ch = match.group(0)!;
      if (_arabicChar.hasMatch(ch)) return TextDirection.rtl;
      if (_latinChar.hasMatch(ch)) return TextDirection.ltr;
    }
    return _appTextDirection();
  }

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ShowSingleFeedCubit>();
    _controller = TextEditingController(text: cubit.commentContent.text);
    _hasText = _controller.text.trim().isNotEmpty;
    _textDirection =
        _hasText ? _directionFor(_controller.text) : _appTextDirection();
    _controller.addListener(() {
      cubit.commentContent.text = _controller.text;
      final nextHasText = _controller.text.trim().isNotEmpty;
      final nextDirection = _directionFor(_controller.text);
      if (!mounted) return;
      // Avoid rebuilding the whole composer (BackdropFilter) on every keystroke.
      if (nextHasText != _hasText || nextDirection != _textDirection) {
        setState(() {
          _hasText = nextHasText;
          _textDirection = nextDirection;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(
    ShowSingleFeedCubit cubit,
    dynamic commentsData,
  ) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // Clear the field + dismiss keyboard immediately for a calm handoff.
    _controller.clear();
    cubit.commentContent.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) {
      setState(() {
        _hasText = false;
        _textDirection = _appTextDirection();
      });
    }

    if (cubit.commentToReply != null) {
      cubit.createReplyOnComment(
        widget.feed.id.toString(),
        cubit.commentToReply!.id.toString(),
        cubit.commentToReply!,
        widget.currentDoctorModel,
        commentText: text,
      );
    } else {
      cubit.createCommentOnPostInCommunity(
        widget.feed.id.toString(),
        text,
        widget.feed,
        commentsData ?? [],
        widget.currentDoctorModel,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ShowSingleFeedCubit.get(context);
    final padding = MediaQuery.paddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    // Lift with the keyboard; keep home-indicator only when keyboard is closed.
    final bottomInset = keyboard > 0 ? keyboard : padding;

    return PermissionGuard(
      permission: AppPermissions.createFeedComment,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
          final primary = HomeDashboardColors.primary(isDark);

          return BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
            buildWhen: (previous, current) {
              bool sendingOf(ShowSingleFeedState s) => s.maybeWhen(
                    loaded: (_, __, ___, isSendCommentLoading, ____, _____,
                            ______, _______, ________, isSendReplyLoading,
                            _________, __________) =>
                        isSendCommentLoading || isSendReplyLoading,
                    orElse: () => false,
                  );
              // Also rebuild when comments list identity changes (for submit payload).
              List? commentsOf(ShowSingleFeedState s) => s.maybeWhen(
                    loaded: (commentsResponse, _, __, ___, ____, _____, ______,
                            _______, ________, _________, __________,
                            ___________) =>
                        commentsResponse.data?.data,
                    orElse: () => null,
                  );
              return sendingOf(previous) != sendingOf(current) ||
                  !identical(commentsOf(previous), commentsOf(current));
            },
            builder: (context, state) {
              final isSending = state.maybeWhen(
                loaded: (
                  _,
                  __,
                  ___,
                  isSendCommentLoading,
                  ____,
                  _____,
                  ______,
                  _______,
                  ________,
                  isSendReplyLoading,
                  _________,
                  __________,
                ) =>
                    isSendCommentLoading || isSendReplyLoading,
                orElse: () => false,
              );

              final commentsData = state.maybeWhen(
                loaded: (commentsResponse, _, __, ___, ____, _____, ______,
                        _______, ________, _________, __________, ___________) =>
                    commentsResponse.data?.data,
                orElse: () => null,
              );

              final canSend = _hasText && !isSending;

              // Always keep the composer mounted to avoid bottom-bar flashes.
              return _ComposerShell(
                isDark: isDark,
                primary: primary,
                bottomInset: bottomInset,
                replyingTo: cubit.commentToReply,
                canSend: canSend,
                isSending: isSending,
                controller: _controller,
                textDirection: _textDirection,
                focusNode: cubit.commentFocusNode,
                onClearReply: () {
                  cubit.clearReplyTarget();
                  setState(() {});
                },
                onSend: () => _submit(cubit, commentsData),
              );
            },
          );
        },
      ),
    );
  }
}

class _ComposerShell extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final double bottomInset;
  final dynamic replyingTo;
  final bool canSend;
  final bool isSending;
  final TextEditingController controller;
  final TextDirection textDirection;
  final FocusNode focusNode;
  final VoidCallback onClearReply;
  final VoidCallback onSend;

  const _ComposerShell({
    required this.isDark,
    required this.primary,
    required this.bottomInset,
    required this.replyingTo,
    required this.canSend,
    required this.isSending,
    required this.controller,
    required this.textDirection,
    required this.focusNode,
    required this.onClearReply,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final replyName = replyingTo == null
        ? null
        : doctorName(
            firstName: replyingTo.doctor!.firstName,
            lastName: replyingTo.doctor!.lastName,
            role: replyingTo.doctor!.isSyndicateCardRequired.toString(),
          );

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(12.w, 10, 12.w, 10 + bottomInset),
          decoration: BoxDecoration(
            color: (isDark ? const Color(0xFF12101A) : Colors.white)
                .withOpacity(0.94),
            border: Border(
              top: BorderSide(
                color: HomeDashboardColors.border(isDark).withOpacity(0.85),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (replyName != null) ...[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(isDark ? 0.16 : 0.08),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: primary.withOpacity(0.22)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.reply_rounded, size: 14.sp, color: primary),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '${context.tr(AppStrings.replyTo)} @$replyName',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: HomeDashboardColors.title(isDark),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onClearReply,
                        child: Icon(
                          Icons.close_rounded,
                          size: 16.sp,
                          color: HomeDashboardColors.danger,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final fieldColor = isDark
                            ? AppColors.darkSurface
                            : const Color(0xFFF3F4F6);

                        return Container(
                          height: 52,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: fieldColor,
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: HomeDashboardColors.border(isDark)
                                  .withOpacity(0.8),
                            ),
                          ),
                          child: TextField(
                            controller: controller,
                            focusNode: focusNode,
                            enabled: !isSending,
                            cursorColor: primary,
                            minLines: 1,
                            maxLines: 1,
                            textDirection: textDirection,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) {
                              if (canSend) onSend();
                            },
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: HomeDashboardColors.title(isDark),
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: context.tr(AppStrings.writeComment),
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: HomeDashboardColors.subtitle(isDark),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  _SendCommentButton(
                    isDark: isDark,
                    primary: primary,
                    canSend: canSend,
                    isSending: isSending,
                    onSend: onSend,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendCommentButton extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool canSend;
  final bool isSending;
  final VoidCallback onSend;

  const _SendCommentButton({
    required this.isDark,
    required this.primary,
    required this.canSend,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final active = canSend || isSending;
    final idleColor =
        isDark ? AppColors.darkSurface : const Color(0xFFF3F4F6);
    final iconIdle = HomeDashboardColors.subtitle(isDark);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: active ? 1 : 0),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      builder: (context, t, _) {
        final bg = Color.lerp(idleColor, primary, t)!;
        final iconColor = Color.lerp(iconIdle, Colors.white, t)!;
        final shadowOpacity = 0.28 * t;

        return Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(shadowOpacity),
                blurRadius: 8 * t,
                offset: Offset(0, 3 * t),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: canSend ? onSend : null,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: isSending
                      ? const SizedBox(
                          key: ValueKey('sending'),
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.send_rounded,
                          key: const ValueKey('idle'),
                          size: 18.sp,
                          color: iconColor,
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
