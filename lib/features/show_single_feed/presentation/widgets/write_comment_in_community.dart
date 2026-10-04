import 'dart:ui';

import 'package:egy_akin/app/shared/functions/chat_text_direction.dart';
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
  late final HashtagTextEditingController _controller;
  late TextDirection _textDirection;
  late bool _hasText;

  TextDirection _appTextDirection() =>
      context.isRTL ? TextDirection.rtl : TextDirection.ltr;

  TextDirection _directionFor(String text) => ChatTextDirection.resolve(
        text,
        fallback: _appTextDirection(),
      );

  TextStyle _hashtagStyle(Color primary) => TextStyle(
        color: primary,
        fontWeight: FontWeight.w700,
        fontFamily: 'Tajawal',
      );

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ShowSingleFeedCubit>();
    _controller = HashtagTextEditingController(
      text: cubit.commentContent.text,
      hashtagStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
        fontFamily: 'Tajawal',
      ),
    );
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
    final safeBottom = MediaQuery.viewPaddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    return PermissionGuard(
      permission: AppPermissions.createFeedComment,
      child: ListenableBuilder(
        listenable: cubit.commentFocusNode,
        builder: (context, _) {
          // Always follow the live keyboard inset — switching to safeBottom the
          // instant focus drops (while the keyboard is still animating away)
          // made the bar jump to the floor then snap back up.
          final commentFocused = cubit.commentFocusNode.hasFocus;
          final bottomInset =
              keyboard > safeBottom ? keyboard : safeBottom;
          // Hide only when another field owns the keyboard (e.g. poll option).
          // On plain dismiss, primary focus is null — keep the bar visible and
          // ride the keyboard down to its resting place.
          final otherFieldOwnsKeyboard = keyboard > safeBottom &&
              !commentFocused &&
              (FocusManager.instance.primaryFocus?.hasFocus ?? false);
          final hideBehindKeyboard = otherFieldOwnsKeyboard;

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
              final primary = HomeDashboardColors.primary(isDark);
              _controller.updateHashtagStyle(_hashtagStyle(primary));

              return BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
                buildWhen: (previous, current) {
                  bool sendingOf(ShowSingleFeedState s) => s.maybeWhen(
                        loaded: (_,
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
                                __________) =>
                            isSendCommentLoading || isSendReplyLoading,
                        orElse: () => false,
                      );
                  List? commentsOf(ShowSingleFeedState s) => s.maybeWhen(
                        loaded: (commentsResponse,
                                _,
                                __,
                                ___,
                                ____,
                                _____,
                                ______,
                                _______,
                                ________,
                                _________,
                                __________,
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
                    loaded: (commentsResponse,
                            _,
                            __,
                            ___,
                            ____,
                            _____,
                            ______,
                            _______,
                            ________,
                            _________,
                            __________,
                            ___________) =>
                        commentsResponse.data?.data,
                    orElse: () => null,
                  );

                  final canSend = _hasText && !isSending;

                  // Always keep the composer mounted to avoid bottom-bar flashes.
                  return IgnorePointer(
                    ignoring: hideBehindKeyboard,
                    child: Opacity(
                      opacity: hideBehindKeyboard ? 0 : 1,
                      child: _ComposerShell(
                        isDark: isDark,
                        primary: primary,
                        bottomInset: bottomInset,
                        replyingTo: cubit.commentToReply,
                        hasText: _hasText,
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
                      ),
                    ),
                  );
                },
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
  final bool hasText;
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
    required this.hasText,
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
    final replyName =
        replyingTo == null ? null : doctorDisplayName(replyingTo.doctor);

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
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6),
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
                        const barHeight = 44.0;
                        const maxLines = 5;
                        final borderColor =
                            HomeDashboardColors.border(isDark).withOpacity(0.8);

                        // Same growth + hint centering model as chat composer.
                        return ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: barHeight,
                            maxHeight: (barHeight * maxLines) + 12,
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              TextField(
                                controller: controller,
                                focusNode: focusNode,
                                enabled: !isSending,
                                cursorColor: primary,
                                minLines: 1,
                                maxLines: maxLines,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                textDirection: textDirection,
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  height: 1.2,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Tajawal',
                                  color: HomeDashboardColors.title(isDark),
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: fieldColor,
                                  hintText: null,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 10.h,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22.r),
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22.r),
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22.r),
                                    borderSide: BorderSide(color: primary),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22.r),
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                ),
                              ),
                              if (!hasText)
                                IgnorePointer(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      16.w,
                                      10.h,
                                      16.w,
                                      0,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        context.tr(AppStrings.writeComment),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        textDirection: textDirection,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          height: 1.2,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Tajawal',
                                          color: HomeDashboardColors.subtitle(
                                            isDark,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
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
    final idleColor = isDark ? AppColors.darkSurface : const Color(0xFFF3F4F6);
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
          width: 44,
          height: 44,
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
