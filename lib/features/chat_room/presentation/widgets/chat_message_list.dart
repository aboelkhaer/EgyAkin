import 'dart:ui';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_bubble.dart';
import 'package:intl/intl.dart';

class ChatMessageList extends StatefulWidget {
  final List<ChatMessageItem> messages;
  final String? peerImageUrl;
  final String peerInitials;
  final bool isGroup;
  final void Function(int index, ChatMessageItem message, Rect anchorRect)?
      onMessageLongPress;
  final void Function(ChatMessageItem message)? onMessageTap;
  final bool selectionMode;
  final Set<String> selectedMessageIds;
  final String? selectedMessageId;
  final String? flashMessageId;
  final VoidCallback? onBackgroundTap;
  final Map<int, GlobalKey>? messageTileKeys;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback? onLoadOlder;
  final void Function(ChatMessageItem message)? onResend;
  final void Function(ChatMessageItem message)? onCancelUpload;
  final void Function(ChatMessageItem message)? onReactionTap;
  final void Function(ChatMessageItem message)? onSwipeToReply;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;
  final ValueChanged<String>? onFlashFinished;

  /// Space under the floating header.
  /// On a reverse list this is applied as [padding.top].
  final double topOverlayInset;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.peerInitials,
    this.peerImageUrl,
    this.isGroup = false,
    this.onMessageLongPress,
    this.onMessageTap,
    this.selectionMode = false,
    this.selectedMessageIds = const {},
    this.selectedMessageId,
    this.flashMessageId,
    this.onBackgroundTap,
    this.messageTileKeys,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.onLoadOlder,
    this.onResend,
    this.onCancelUpload,
    this.onReactionTap,
    this.onSwipeToReply,
    this.onReplyQuoteTap,
    this.onFlashFinished,
    this.topOverlayInset = 0,
  });

  @override
  State<ChatMessageList> createState() => ChatMessageListState();
}

class ChatMessageListState extends State<ChatMessageList> {
  late final ScrollController _scrollController;
  final Set<String> _seenIds = {};
  final Map<String, GlobalKey> _keysByMessageId = {};
  String? _latestAnimatedId;

  /// WhatsApp-style floating day label under the header while scrolling.
  String? _pinnedLabel;
  bool _pinnedVisible = false;
  Timer? _pinHideTimer;
  bool _pinUpdateScheduled = false;
  final GlobalKey _listViewportKey = GlobalKey();

  /// WhatsApp-style jump-to-latest control.
  bool _showScrollToBottom = false;
  static const double _scrollToBottomThreshold = 160;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    for (final m in widget.messages) {
      _seenIds.add(m.clientTempId ?? m.id);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _schedulePinnedDateUpdate(show: false);
    });
  }

  @override
  void didUpdateWidget(covariant ChatMessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.isEmpty) return;
    final newest = widget.messages.last;
    final identity = newest.clientTempId ?? newest.id;
    if (!_seenIds.contains(identity)) {
      // System notices (rename, etc.) should appear without the send pop-in.
      if (!newest.isSystem) {
        _latestAnimatedId = identity;
      }
      for (final m in widget.messages) {
        _seenIds.add(m.clientTempId ?? m.id);
      }
    }
    if (!identical(oldWidget.messages, widget.messages)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _schedulePinnedDateUpdate(show: false);
      });
    }
  }

  @override
  void dispose() {
    _pinHideTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  GlobalKey _keyForMessageId(String id) =>
      _keysByMessageId.putIfAbsent(id, GlobalKey.new);

  /// Blocks scroll-triggered [onLoadOlder] while a programmatic jump runs.
  bool _jumpLock = false;

  /// Scrolls to [messageId]. Loads must already include it in [messages].
  Future<bool> scrollToMessageId(String messageId) async {
    _jumpLock = true;
    try {
      for (var i = 0; i < 30; i++) {
        if (!mounted) return false;
        if (widget.messages.any((m) => m.id == messageId)) break;
        await Future<void>.delayed(const Duration(milliseconds: 32));
      }

      final messageIndex = widget.messages.indexWhere((m) => m.id == messageId);
      if (messageIndex < 0) return false;

      await WidgetsBinding.instance.endOfFrame;
      await Future<void>.delayed(const Duration(milliseconds: 64));
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted || !_scrollController.hasClients) return false;

      for (var attempt = 0; attempt < 60; attempt++) {
        if (!mounted) return false;
        final ctx = _keysByMessageId[messageId]?.currentContext;
        if (ctx != null && ctx.mounted) {
          await Scrollable.ensureVisible(
            ctx,
            duration:
                attempt < 2 ? Duration.zero : const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            alignment: 0.32,
          );
          return true;
        }

        if (!_scrollController.hasClients) return false;
        final len = widget.messages.length;
        if (len <= 1) return false;

        final listIndex = len - 1 - messageIndex;
        final max = _scrollController.position.maxScrollExtent;
        final viewport = _scrollController.position.viewportDimension;
        if (max <= 0) {
          await Future<void>.delayed(const Duration(milliseconds: 40));
          await WidgetsBinding.instance.endOfFrame;
          continue;
        }

        // Reverse list: older messages sit toward [maxScrollExtent].
        final ratio = (listIndex / (len - 1)).clamp(0.0, 1.0);
        final estimated = (max * ratio).clamp(0.0, max);
        final crawl = (attempt * viewport * 0.75).clamp(0.0, max);
        final target = (estimated > crawl ? estimated : crawl).clamp(0.0, max);

        _scrollController.jumpTo(target);
        await WidgetsBinding.instance.endOfFrame;
        await Future<void>.delayed(const Duration(milliseconds: 20));

        if (_keysByMessageId[messageId]?.currentContext == null) {
          final next =
              (_scrollController.offset + viewport * 0.85).clamp(0.0, max);
          if ((next - _scrollController.offset).abs() < 1.0) {
            await Future<void>.delayed(const Duration(milliseconds: 36));
          } else {
            _scrollController.jumpTo(next);
            await WidgetsBinding.instance.endOfFrame;
          }
        }
      }

      if (!mounted) return false;
      final ctx = _keysByMessageId[messageId]?.currentContext;
      if (ctx == null || !ctx.mounted) return false;
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        alignment: 0.32,
      );
      return true;
    } catch (_) {
      return false;
    } finally {
      _jumpLock = false;
    }
  }

  void _onScroll() {
    _schedulePinnedDateUpdate(show: true);
    _updateScrollToBottomVisibility();

    if (_jumpLock) return;
    if (!widget.hasMore || widget.isLoadingMore || widget.onLoadOlder == null) {
      return;
    }
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 120) {
      widget.onLoadOlder!();
    }
  }

  void _updateScrollToBottomVisibility() {
    if (!_scrollController.hasClients) return;
    // reverse:true → offset ~0 is the latest messages.
    final show = _scrollController.offset > _scrollToBottomThreshold;
    if (show == _showScrollToBottom) return;
    setState(() => _showScrollToBottom = show);
  }

  Future<void> _scrollToLatest() async {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels <= 0.5) {
      if (_showScrollToBottom) {
        setState(() => _showScrollToBottom = false);
      }
      return;
    }
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
    if (!mounted) return;
    if (_showScrollToBottom) {
      setState(() => _showScrollToBottom = false);
    }
  }

  void _schedulePinnedDateUpdate({required bool show}) {
    if (show) {
      _pinHideTimer?.cancel();
      if (!_pinnedVisible && mounted) {
        setState(() => _pinnedVisible = true);
      }
      _pinHideTimer = Timer(const Duration(milliseconds: 1000), () {
        if (!mounted) return;
        setState(() => _pinnedVisible = false);
      });
    }

    if (_pinUpdateScheduled) return;
    _pinUpdateScheduled = true;
    // Coalesce to one compute per frame pair — avoid O(n) key walks every
    // scroll notification.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pinUpdateScheduled = false;
        if (!mounted) return;
        _computePinnedDate();
      });
    });
  }

  void _computePinnedDate() {
    if (widget.messages.isEmpty) {
      if (_pinnedLabel != null) {
        setState(() => _pinnedLabel = null);
      }
      return;
    }

    final viewportCtx = _listViewportKey.currentContext;
    final viewportBox = viewportCtx?.findRenderObject() as RenderBox?;
    if (viewportBox == null || !viewportBox.hasSize) {
      final fallback = widget.messages.last.createdAt ?? DateTime.now();
      final label = _dateSeparatorLabel(context, fallback);
      if (label != _pinnedLabel) {
        setState(() => _pinnedLabel = label);
      }
      return;
    }

    final pinGlobalY =
        viewportBox.localToGlobal(Offset(0, widget.topOverlayInset + 10.h)).dy;
    final viewportTop = viewportBox.localToGlobal(Offset.zero).dy;
    final viewportBottom =
        viewportBox.localToGlobal(Offset(0, viewportBox.size.height)).dy;

    // Prefer the row covering the pin line; otherwise the visually topmost
    // visible row (min global Y). Works for both scroll directions.
    ChatMessageItem? covering;
    double? coveringTop;
    ChatMessageItem? topMost;
    double? topMostY;

    for (final message in widget.messages) {
      final ctx = _keysByMessageId[message.id]?.currentContext;
      if (ctx == null || !ctx.mounted) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached || !box.hasSize) continue;

      final top = box.localToGlobal(Offset.zero).dy;
      final bottom = top + box.size.height;

      // Skip rows fully above the pin or fully below the viewport.
      if (bottom <= pinGlobalY) continue;
      if (top >= viewportBottom) continue;
      // Also ignore anything still above the list viewport itself.
      if (bottom <= viewportTop) continue;

      if (top <= pinGlobalY && bottom > pinGlobalY) {
        // Among covering rows, prefer the one closest to the pin (largest top).
        if (coveringTop == null || top >= coveringTop) {
          covering = message;
          coveringTop = top;
        }
      }

      if (topMostY == null || top < topMostY) {
        topMost = message;
        topMostY = top;
      }
    }

    final chosen = covering ?? topMost ?? widget.messages.last;
    final label = _dateSeparatorLabel(
      context,
      chosen.createdAt ?? DateTime.now(),
    );
    if (label != _pinnedLabel) {
      setState(() => _pinnedLabel = label);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return GestureDetector(
          onTap: widget.onBackgroundTap,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            key: _listViewportKey,
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification ||
                      notification is ScrollStartNotification) {
                    _schedulePinnedDateUpdate(show: true);
                  } else if (notification is ScrollEndNotification) {
                    _schedulePinnedDateUpdate(show: true);
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.fromLTRB(
                    4.w,
                    // reverse:true → top padding is under the floating header.
                    8.h + widget.topOverlayInset,
                    4.w,
                    12.h,
                  ),
                  cacheExtent: 480,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount:
                      widget.messages.length + (widget.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (widget.isLoadingMore &&
                        index == widget.messages.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      );
                    }

                    final messageIndex = widget.messages.length - 1 - index;
                    final message = widget.messages[messageIndex];
                    final identity = message.clientTempId ?? message.id;
                    final shouldAnimate =
                        identity == _latestAnimatedId && !message.isSystem;
                    final isFlashing = widget.flashMessageId == message.id;
                    final showDateChip = _isFirstMessageOfDay(
                      widget.messages,
                      messageIndex,
                    );

                    final tile = _LongPressMessageTile(
                      tileKey: widget.messageTileKeys?[messageIndex],
                      index: messageIndex,
                      message: message,
                      peerImageUrl: widget.peerImageUrl,
                      peerInitials: widget.peerInitials,
                      isGroup: widget.isGroup,
                      isFlashing: isFlashing,
                      onFlashFadeOutCompleted: isFlashing
                          ? () => widget.onFlashFinished?.call(message.id)
                          : null,
                      onMessageLongPress: widget.onMessageLongPress,
                      onMessageTap: widget.onMessageTap,
                      selectionMode: widget.selectionMode,
                      isSelected:
                          widget.selectedMessageIds.contains(message.id),
                      hideWhileSelected: widget.selectedMessageId == message.id,
                      onResend: widget.onResend == null
                          ? null
                          : () => widget.onResend!(message),
                      onCancelUpload: widget.onCancelUpload == null ||
                              !message.isUploading ||
                              message.clientTempId == null
                          ? null
                          : () => widget.onCancelUpload!(message),
                      onReactionTap: widget.onReactionTap == null
                          ? null
                          : () => widget.onReactionTap!(message),
                      onReplyQuoteTap: widget.onReplyQuoteTap,
                    );

                    final messageTile = _AnimatedMessageTile(
                      key: ValueKey(identity),
                      animate: shouldAnimate,
                      isDeleting: message.isDeleting,
                      isOutgoing: message.isOutgoing,
                      keepAlive: message.hasImages || message.hasVoice,
                      child: widget.onSwipeToReply != null &&
                              !widget.selectionMode &&
                              !message.isDeleted &&
                              !message.isSystem
                          ? _SwipeToReplyWrapper(
                              isOutgoing: message.isOutgoing,
                              onSwipe: () => widget.onSwipeToReply!(message),
                              child: tile,
                            )
                          : tile,
                    );

                    // Key the full row (date chip + bubble) so the sticky
                    // pin tracks correctly when scrolling either direction.
                    return KeyedSubtree(
                      key: _keyForMessageId(message.id),
                      child: showDateChip
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _DateChip(
                                  isDarkMode: isDarkMode,
                                  label: _dateSeparatorLabel(
                                    context,
                                    message.createdAt ?? DateTime.now(),
                                  ),
                                  pinned: false,
                                ),
                                messageTile,
                              ],
                            )
                          : messageTile,
                    );
                  },
                ),
              ),
              Positioned(
                top: widget.topOverlayInset + 2.h,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: _pinnedVisible && _pinnedLabel != null ? 1 : 0,
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 240),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        final slide = Tween<Offset>(
                          begin: const Offset(0, -0.25),
                          end: Offset.zero,
                        ).animate(animation);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: slide,
                            child: child,
                          ),
                        );
                      },
                      child: _pinnedLabel == null
                          ? const SizedBox.shrink()
                          : _DateChip(
                              key: ValueKey(_pinnedLabel),
                              isDarkMode: isDarkMode,
                              label: _pinnedLabel!,
                              pinned: true,
                            ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12.w,
                bottom: 10.h,
                child: _ScrollToBottomButton(
                  visible: _showScrollToBottom,
                  isDarkMode: isDarkMode,
                  onTap: _scrollToLatest,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollToBottomButton extends StatefulWidget {
  final bool visible;
  final bool isDarkMode;
  final VoidCallback onTap;

  const _ScrollToBottomButton({
    required this.visible,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  State<_ScrollToBottomButton> createState() => _ScrollToBottomButtonState();
}

class _ScrollToBottomButtonState extends State<_ScrollToBottomButton>
    with TickerProviderStateMixin {
  late final AnimationController _bob;
  late final AnimationController _shine;

  @override
  void initState() {
    super.initState();
    _bob = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _shine = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    if (widget.visible) {
      _bob.repeat(reverse: true);
      _shine.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _ScrollToBottomButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !_bob.isAnimating) {
      _bob.repeat(reverse: true);
      _shine.repeat();
    } else if (!widget.visible && _bob.isAnimating) {
      _bob
        ..stop()
        ..value = 0;
      _shine
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _bob.dispose();
    _shine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.primary;
    final size = 32.r;

    return IgnorePointer(
      ignoring: !widget.visible,
      child: AnimatedScale(
        scale: widget.visible ? 1 : 0.6,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutBack,
        child: AnimatedOpacity(
          opacity: widget.visible ? 1 : 0,
          duration: const Duration(milliseconds: 160),
          child: AnimatedSlide(
            offset: widget.visible ? Offset.zero : const Offset(0, 0.3),
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            child: GestureDetector(
              onTap: widget.onTap,
              child: AnimatedBuilder(
                animation: Listenable.merge([_bob, _shine]),
                builder: (context, _) {
                  final bobY = Tween<double>(begin: -1.6, end: 1.6)
                      .transform(Curves.easeInOut.transform(_bob.value));
                  final shineX = Tween<double>(begin: -1.2, end: 1.2)
                      .transform(Curves.easeInOutSine.transform(_shine.value));

                  return Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(
                            widget.isDarkMode ? 0.55 : 0.35,
                          ),
                          blurRadius: 14,
                          spreadRadius: -1,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            widget.isDarkMode ? 0.5 : 0.16,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Glass / tinted base.
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: const ColoredBox(color: Colors.transparent),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  accent,
                                  Color.lerp(accent, Colors.white, 0.35)!,
                                  Color.lerp(accent, const Color(0xFF6D28D9), 0.35)!,
                                  accent,
                                ],
                              ),
                            ),
                          ),
                          // Inner frosted disc.
                          Padding(
                            padding: EdgeInsets.all(1.6.r),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: widget.isDarkMode
                                      ? [
                                          const Color(0xFF2B2148)
                                              .withOpacity(0.92),
                                          const Color(0xFF17122A)
                                              .withOpacity(0.96),
                                        ]
                                      : [
                                          Colors.white.withOpacity(0.95),
                                          const Color(0xFFF3EEFF)
                                              .withOpacity(0.92),
                                        ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(
                                    widget.isDarkMode ? 0.18 : 0.7,
                                  ),
                                  width: 0.8,
                                ),
                              ),
                            ),
                          ),
                          // Sweeping light streak.
                          Transform.translate(
                            offset: Offset(shineX * 10.w, -shineX * 4.h),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 14.r,
                                height: 10.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(
                                        widget.isDarkMode ? 0.35 : 0.7,
                                      ),
                                      Colors.white.withOpacity(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Bouncing chevron.
                          Transform.translate(
                            offset: Offset(0, bobY),
                            child: Icon(
                              Icons.south_rounded,
                              size: 15.sp,
                              color: widget.isDarkMode
                                  ? Colors.white
                                  : accent,
                              shadows: [
                                Shadow(
                                  color: accent.withOpacity(0.45),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedMessageTile extends StatefulWidget {
  final Widget child;
  final bool animate;
  final bool isDeleting;
  final bool isOutgoing;
  final bool keepAlive;

  const _AnimatedMessageTile({
    super.key,
    required this.child,
    required this.animate,
    required this.isOutgoing,
    this.isDeleting = false,
    this.keepAlive = false,
  });

  @override
  State<_AnimatedMessageTile> createState() => _AnimatedMessageTileState();
}

class _AnimatedMessageTileState extends State<_AnimatedMessageTile>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _controller;
  AnimationController? _exitController;
  Animation<double>? _fade;
  Animation<double>? _scale;
  Animation<Offset>? _fromComposer;
  Animation<double>? _exitFade;
  Animation<double>? _exitSize;
  Animation<Offset>? _exitSlide;
  Animation<double>? _exitScale;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  AnimationController get _c {
    _ensureAnimations();
    return _controller!;
  }

  AnimationController get _exit {
    _ensureAnimations();
    return _exitController!;
  }

  void _ensureAnimations() {
    if (_controller != null &&
        _exitController != null &&
        _fade != null &&
        _scale != null &&
        _fromComposer != null &&
        _exitFade != null &&
        _exitSize != null &&
        _exitSlide != null &&
        _exitScale != null) {
      return;
    }

    _controller?.dispose();
    _exitController?.dispose();

    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _controller = controller;

    final exit = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _exitController = exit;

    const land = Cubic(0.22, 1.0, 0.36, 1.0);

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _scale = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.85, curve: land),
      ),
    );
    _fromComposer = Tween<Offset>(
      begin: Offset(widget.isOutgoing ? 0.06 : -0.06, 0.22),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: land,
      ),
    );

    final exitCurve = CurvedAnimation(
      parent: exit,
      curve: Curves.easeInOutCubic,
    );
    _exitFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: exit,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    _exitSize = Tween<double>(begin: 1, end: 0).animate(exitCurve);
    _exitScale = Tween<double>(begin: 1, end: 0.86).animate(exitCurve);
    _exitSlide = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(widget.isOutgoing ? 0.12 : -0.12, -0.04),
    ).animate(exitCurve);

    if (widget.animate) {
      controller.forward();
    } else {
      controller.value = 1;
    }
    // Soft-delete keeps the tile height — bubble morphs in place.
    exit.value = 0;
  }

  @override
  void initState() {
    super.initState();
    _ensureAnimations();
  }

  @override
  void didUpdateWidget(covariant _AnimatedMessageTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    _ensureAnimations();
    if (widget.animate && !oldWidget.animate) {
      _c.forward(from: 0);
    }
    // Soft-delete morph is handled by MessageBubbleCard AnimatedSwitcher.
    // Keep exit size factor at 1 so the deleted placeholder stays visible.
    if (widget.isDeleting != oldWidget.isDeleting) {
      _exit.value = 0;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _exitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _ensureAnimations();
    final origin =
        widget.isOutgoing ? Alignment.bottomRight : Alignment.bottomLeft;

    final entered = FadeTransition(
      opacity: _fade!,
      child: SlideTransition(
        position: _fromComposer!,
        child: ScaleTransition(
          scale: _scale!,
          alignment: origin,
          child: widget.child,
        ),
      ),
    );

    return SizeTransition(
      sizeFactor: _exitSize!,
      axisAlignment: widget.isOutgoing ? 1.0 : -1.0,
      child: FadeTransition(
        opacity: _exitFade!,
        child: SlideTransition(
          position: _exitSlide!,
          child: ScaleTransition(
            scale: _exitScale!,
            alignment: origin,
            child: entered,
          ),
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final bool isDarkMode;
  final String label;
  final bool pinned;

  const _DateChip({
    super.key,
    required this.isDarkMode,
    required this.label,
    this.pinned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: pinned ? 0 : 14.h,
          bottom: pinned ? 0 : 8.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: (isDarkMode ? Colors.black : Colors.white).withOpacity(
            pinned ? (isDarkMode ? 0.55 : 0.92) : (isDarkMode ? 0.32 : 0.72),
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: (isDarkMode ? Colors.white : AppColors.primary)
                .withOpacity(pinned ? 0.12 : 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(pinned ? 0.18 : 0.04),
              blurRadius: pinned ? 12 : 8,
              offset: Offset(0, pinned ? 4 : 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color:
                isDarkMode ? AppColors.darkDescription : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

bool _isSameCalendarDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool _isFirstMessageOfDay(List<ChatMessageItem> messages, int messageIndex) {
  final current = messages[messageIndex].createdAt;
  if (current == null) return messageIndex == 0;
  if (messageIndex == 0) return true;
  final previous = messages[messageIndex - 1].createdAt;
  if (previous == null) return true;
  return !_isSameCalendarDay(current.toLocal(), previous.toLocal());
}

/// WhatsApp-style day labels: Today / Yesterday / weekday / date.
String _dateSeparatorLabel(BuildContext context, DateTime raw) {
  final date = raw.toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(date.year, date.month, date.day);
  final diffDays = today.difference(day).inDays;

  if (diffDays == 0) {
    return context.tr(AppStrings.today).toUpperCase();
  }
  if (diffDays == 1) {
    return context.tr(AppStrings.yesterday).toUpperCase();
  }
  if (diffDays > 1 && diffDays < 7) {
    final locale = context.currentLocale?.toString() ?? 'en';
    return DateFormat.EEEE(locale).format(day).toUpperCase();
  }
  final locale = context.currentLocale?.toString() ?? 'en';
  if (day.year == today.year) {
    return DateFormat.MMMd(locale).format(day);
  }
  return DateFormat.yMMMd(locale).format(day);
}

/// WhatsApp-style swipe-to-reply: swipe right; reply icon stays on the left.
class _SwipeToReplyWrapper extends StatefulWidget {
  final bool isOutgoing;
  final VoidCallback onSwipe;
  final Widget child;

  const _SwipeToReplyWrapper({
    required this.isOutgoing,
    required this.onSwipe,
    required this.child,
  });

  @override
  State<_SwipeToReplyWrapper> createState() => _SwipeToReplyWrapperState();
}

class _SwipeToReplyWrapperState extends State<_SwipeToReplyWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _dragOffset = 0;
  bool _triggered = false;
  bool _isDragging = false;
  bool _disposed = false;
  Offset? _startPoint;
  static const double _triggerThreshold = 60;

  /// Minimum horizontal distance before we commit to a swipe (lets long-press win).
  static const double _dragStartSlop = 12;

  /// Leave screen edges free for iOS/Android back / system gestures.
  static const double _edgeGuard = 36;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(_onAnimTick);
  }

  void _onAnimTick() {
    if (!mounted || _disposed) return;
    setState(() {
      _dragOffset = _dragOffset * (1 - _controller.value);
    });
  }

  @override
  void dispose() {
    _disposed = true;
    _controller.removeListener(_onAnimTick);
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  bool _isInEdgeGuard(Offset globalPosition) {
    final width = MediaQuery.sizeOf(context).width;
    return globalPosition.dx <= _edgeGuard ||
        globalPosition.dx >= width - _edgeGuard;
  }

  void _onPointerDown(PointerDownEvent event) {
    // Don't steal edge swipes used to navigate back.
    if (_isInEdgeGuard(event.position)) {
      _startPoint = null;
      _isDragging = false;
      _triggered = false;
      return;
    }
    _startPoint = event.localPosition;
    _isDragging = false;
    _triggered = false;
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_disposed || !mounted) return;
    if (_startPoint == null) return;
    final delta = event.localPosition - _startPoint!;

    // Don't start swiping until the finger has moved enough horizontally
    // AND more horizontal than vertical (avoids hijacking scroll/long-press).
    if (!_isDragging) {
      if (delta.dx.abs() < _dragStartSlop) return;
      if (delta.dy.abs() > delta.dx.abs()) return;
      // WhatsApp: only swipe to the right.
      if (delta.dx <= 0) return;
      // If the gesture drifted into an edge zone, abort.
      if (_isInEdgeGuard(event.position)) {
        _resetOffsetImmediate();
        return;
      }
      _isDragging = true;
    }

    _dragOffset = delta.dx.clamp(0, _triggerThreshold * 1.3);
    if (!_triggered && _dragOffset >= _triggerThreshold) {
      _triggered = true;
      HapticFeedback.lightImpact();
    }
    setState(() {});
  }

  void _snapBack() {
    _startPoint = null;
    _isDragging = false;
    _triggered = false;
    if (_disposed || !mounted) {
      _dragOffset = 0;
      return;
    }
    if (_dragOffset == 0) return;
    _controller.forward(from: 0);
  }

  void _resetOffsetImmediate() {
    _startPoint = null;
    _isDragging = false;
    _triggered = false;
    _dragOffset = 0;
    if (!_disposed && mounted) setState(() {});
  }

  void _onPointerUp(PointerUpEvent event) {
    // onSwipe rebuilds the list and can dispose this State — never animate
    // snap-back after invoking the callback (that caused forward()-after-dispose).
    final shouldSwipe = _triggered && !_disposed && mounted;
    if (shouldSwipe) {
      _resetOffsetImmediate();
      widget.onSwipe();
      return;
    }
    _snapBack();
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _snapBack();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_dragOffset / _triggerThreshold).clamp(0.0, 1.0);

    // Full-row hit target (not just the bubble) so swipe works from any
    // position on the message row — empty space included.
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (progress > 0.08)
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Opacity(
                  opacity: progress,
                  child: Transform.scale(
                    scale: 0.65 + (0.35 * progress),
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.14),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.reply_rounded,
                        size: 18.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(_dragOffset, 0),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}

class _LongPressMessageTile extends StatelessWidget {
  final int index;
  final GlobalKey? tileKey;
  final ChatMessageItem message;
  final String? peerImageUrl;
  final String peerInitials;
  final bool isGroup;
  final void Function(int index, ChatMessageItem message, Rect anchorRect)?
      onMessageLongPress;
  final void Function(ChatMessageItem message)? onMessageTap;
  final bool selectionMode;
  final bool isSelected;
  final bool hideWhileSelected;
  final bool isFlashing;
  final VoidCallback? onFlashFadeOutCompleted;
  final VoidCallback? onResend;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onReactionTap;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;

  const _LongPressMessageTile({
    this.tileKey,
    required this.index,
    required this.message,
    required this.peerInitials,
    this.peerImageUrl,
    this.isGroup = false,
    this.onMessageLongPress,
    this.onMessageTap,
    this.selectionMode = false,
    this.isSelected = false,
    this.hideWhileSelected = false,
    this.isFlashing = false,
    this.onFlashFadeOutCompleted,
    this.onResend,
    this.onCancelUpload,
    this.onReactionTap,
    this.onReplyQuoteTap,
  });

  bool get _selectable =>
      !message.isDeleted && !message.isSystem && !message.isDeleting;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode =
            themeState is ThemeLoaded && themeState.isDarkMode;

        final bubble = ChatMessageBubble(
          message: message,
          peerImageUrl: peerImageUrl,
          peerInitials: peerInitials,
          isGroup: isGroup,
          onLongPress: (selectionMode ||
                  onMessageLongPress == null ||
                  !_selectable)
              ? null
              : (rect) => onMessageLongPress!(index, message, rect),
          onResend: selectionMode ? null : onResend,
          onCancelUpload: selectionMode ? null : onCancelUpload,
          onReactionTap:
              (selectionMode || message.isDeleted) ? null : onReactionTap,
          onReplyQuoteTap:
              (selectionMode || message.isDeleted) ? null : onReplyQuoteTap,
        );

        Widget content = Opacity(
          opacity: hideWhileSelected ? 0 : 1,
          child: KeyedSubtree(
            key: tileKey,
            child: _FlashHighlight(
              active: isFlashing,
              isOutgoing: message.isOutgoing,
              onFadeOutCompleted: onFlashFadeOutCompleted,
              child: bubble,
            ),
          ),
        );

        if (!_selectable) return content;

        const selectAnim = Duration(milliseconds: 280);
        const selectCurve = Curves.easeOutCubic;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: selectionMode && onMessageTap != null
                ? () => onMessageTap!(message)
                : null,
            onLongPress: selectionMode && onMessageTap != null
                ? () {
                    HapticFeedback.lightImpact();
                    onMessageTap!(message);
                  }
                : null,
            splashColor: AppColors.primary.withOpacity(0.12),
            highlightColor: AppColors.primary.withOpacity(0.08),
            child: AnimatedContainer(
              duration: selectAnim,
              curve: selectCurve,
              color: isSelected
                  ? AppColors.primary.withOpacity(isDarkMode ? 0.18 : 0.12)
                  : Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRect(
                    child: AnimatedAlign(
                      duration: selectAnim,
                      curve: selectCurve,
                      alignment: Alignment.centerLeft,
                      widthFactor: selectionMode ? 1 : 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 2.w),
                        child: AnimatedScale(
                          duration: selectAnim,
                          curve: selectCurve,
                          scale: selectionMode ? 1 : 0.6,
                          child: AnimatedOpacity(
                            duration: selectAnim,
                            curve: selectCurve,
                            opacity: selectionMode ? 1 : 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 16.r,
                              height: 16.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isDarkMode
                                          ? Colors.white38
                                          : Colors.black26),
                                  width: 1.4,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 160),
                                child: isSelected
                                    ? Icon(
                                        Icons.check_rounded,
                                        key: const ValueKey('on'),
                                        size: 11.sp,
                                        color: Colors.white,
                                      )
                                    : SizedBox(
                                        key: const ValueKey('off'),
                                        width: 11.sp,
                                        height: 11.sp,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: selectionMode
                        ? IgnorePointer(child: content)
                        : content,
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

/// Soft WhatsApp-style flash when scrolling to a replied message.
/// Owns its fade in/out so clearing the highlight never asserts mid-lerp.
class _FlashHighlight extends StatefulWidget {
  final bool active;
  final bool isOutgoing;
  final Widget child;
  final VoidCallback? onFadeOutCompleted;

  const _FlashHighlight({
    required this.active,
    required this.isOutgoing,
    required this.child,
    this.onFadeOutCompleted,
  });

  @override
  State<_FlashHighlight> createState() => _FlashHighlightState();
}

class _FlashHighlightState extends State<_FlashHighlight>
    with SingleTickerProviderStateMixin {
  static const _fadeDuration = Duration(milliseconds: 380);
  static const _holdDuration = Duration(milliseconds: 1100);

  late final AnimationController _controller;
  late final Animation<double> _opacity;
  Timer? _holdTimer;
  bool _notifiedFadeOut = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _fadeDuration);
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _controller.addStatusListener(_onStatus);
    if (widget.active) {
      _controller.value = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !widget.active) return;
        _startHoldCycle();
      });
    }
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.dismissed) return;
    if (_notifiedFadeOut) return;
    _notifiedFadeOut = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onFadeOutCompleted?.call();
    });
  }

  void _startHoldCycle() {
    _notifiedFadeOut = false;
    _holdTimer?.cancel();
    _controller.forward();
    _holdTimer = Timer(_holdDuration, () {
      if (!mounted) return;
      _controller.reverse();
    });
  }

  @override
  void didUpdateWidget(covariant _FlashHighlight oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _startHoldCycle();
    } else if (!widget.active && oldWidget.active) {
      _holdTimer?.cancel();
      if (_controller.value > 0) {
        _controller.reverse();
      } else if (!_notifiedFadeOut) {
        _notifiedFadeOut = true;
        widget.onFadeOutCompleted?.call();
      }
    }
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.isOutgoing
        ? AppColors.primary.withOpacity(0.3)
        : const Color(0xFF8B5CF6).withOpacity(0.28);

    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        final t = _opacity.value.clamp(0.0, 1.0);
        return CustomPaint(
          foregroundPainter: t > 0.01
              ? _FlashOverlayPainter(
                  progress: t,
                  color: glow,
                  radius: 16.r,
                )
              : null,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _FlashOverlayPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double radius;

  _FlashOverlayPainter({
    required this.progress,
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || size.isEmpty) return;
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final fill = Paint()
      ..color = color.withOpacity(0.22 * progress)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = color.withOpacity(0.9 * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawRRect(rrect, fill);
    canvas.drawRRect(rrect, stroke);
  }

  @override
  bool shouldRepaint(covariant _FlashOverlayPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.radius != radius;
  }
}
