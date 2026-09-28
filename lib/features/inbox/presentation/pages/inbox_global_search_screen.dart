import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_state.dart';
import 'package:get_it/get_it.dart';

/// Full-screen inbox search across chats + messages (API).
class InboxGlobalSearchScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const InboxGlobalSearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<InboxGlobalSearchScreen> createState() =>
      _InboxGlobalSearchScreenState();
}

class _InboxGlobalSearchScreenState extends State<InboxGlobalSearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  Timer? _imeGuardTimer;

  late final AnimationController _chrome;

  /// Canonical query for results — never trust transient IME commits on scroll.
  String _query = '';
  bool _loading = false;
  bool _loadingMore = false;
  String? _error;
  int _page = 1;
  bool _hasMore = false;
  final List<ChatMessageSearchHit> _hits = [];

  /// Ignores stale API responses when the query changes mid-flight.
  int _searchGeneration = 0;
  /// Sync lock so scroll can't fire parallel page requests before setState.
  bool _pagingInFlight = false;
  /// Blocks TextField onChanged while scroll dismisses the keyboard (IME glitch).
  bool _blockImeQueryEdits = false;

  static const int _perPage = 20;

  ChatRoomRepository get _repo => GetIt.I<ChatRoomRepository>();

  @override
  void initState() {
    super.initState();
    _chrome = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    )..forward();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _imeGuardTimer?.cancel();
    _chrome.dispose();
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _maybeLoadMore();
  }

  /// Scroll / keyboard-dismiss can make iOS IME rewrite the field (e.g. to "yes").
  void _armImeQueryGuard() {
    _blockImeQueryEdits = true;
    _imeGuardTimer?.cancel();
    _restoreQueryIfTampered();
    _imeGuardTimer = Timer(const Duration(milliseconds: 450), () {
      _blockImeQueryEdits = false;
      _restoreQueryIfTampered();
    });
  }

  void _restoreQueryIfTampered() {
    if (!mounted) return;
    if (_controller.text == _query) return;
    _controller.value = TextEditingValue(
      text: _query,
      selection: TextSelection.collapsed(offset: _query.length),
    );
  }

  void _maybeLoadMore() {
    if (!_hasMore || _loadingMore || _loading || _pagingInFlight) return;
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 280) {
      unawaited(_search(reset: false));
    }
  }

  void _onQueryChanged(String value) {
    if (_blockImeQueryEdits) {
      _restoreQueryIfTampered();
      return;
    }
    // No-op if nothing meaningful changed.
    if (value == _query) return;

    setState(() => _query = value);
    _debounce?.cancel();
    final q = value.trim();
    if (q.length < 2) {
      _searchGeneration++;
      _pagingInFlight = false;
      setState(() {
        _hits.clear();
        _error = null;
        _loading = false;
        _loadingMore = false;
        _hasMore = false;
        _page = 1;
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 360), () {
      unawaited(_search(reset: true));
    });
  }

  void _clear() {
    _blockImeQueryEdits = false;
    _imeGuardTimer?.cancel();
    _controller.clear();
    _onQueryChanged('');
    _focusNode.requestFocus();
  }

  bool _computeHasMore({
    required int page,
    required int fetchedCount,
    required ChatPaginatorMeta? meta,
  }) {
    if (meta != null) {
      final current = meta.currentPage ?? page;
      final last = meta.lastPage;
      if (last != null) return current < last;
      final total = meta.total;
      final perPage = meta.perPage ?? _perPage;
      if (total != null && perPage > 0) {
        return page * perPage < total;
      }
    }
    // No meta — keep paging while the server keeps returning a full page.
    return fetchedCount >= _perPage;
  }

  Future<void> _search({required bool reset}) async {
    final q = _query.trim();
    if (q.length < 2) return;
    if (!reset && (_pagingInFlight || _loadingMore || !_hasMore)) return;

    if (!reset) {
      _pagingInFlight = true;
    } else {
      _pagingInFlight = false;
    }

    final generation = reset ? ++_searchGeneration : _searchGeneration;
    final page = reset ? 1 : _page + 1;

    setState(() {
      if (reset) {
        _loading = true;
        _loadingMore = false;
        _error = null;
        _hasMore = true;
      } else {
        _loadingMore = true;
      }
    });

    final result = await _repo.searchMessages(
      query: q,
      page: page,
      perPage: _perPage,
    );
    if (!mounted) return;

    // Drop outdated responses (new typing / new reset search).
    if (generation != _searchGeneration) {
      if (!reset) _pagingInFlight = false;
      return;
    }
    // Query may have changed while the request was in flight.
    if (_query.trim() != q) {
      if (!reset) _pagingInFlight = false;
      return;
    }

    result.fold(
      (failure) {
        setState(() {
          _loading = false;
          _loadingMore = false;
          if (reset) {
            _error = failure.message;
            _hits.clear();
            _hasMore = false;
          }
        });
        _pagingInFlight = false;
      },
      (response) {
        final raw = response.data?.items ?? const <ChatMessageSearchHit>[];
        final meta = response.data?.meta;
        final hasMore = _computeHasMore(
          page: page,
          fetchedCount: raw.length,
          meta: meta,
        );
        setState(() {
          _loading = false;
          _loadingMore = false;
          _page = page;
          _hasMore = hasMore;
          if (reset) {
            _hits
              ..clear()
              ..addAll(raw);
          } else {
            final seen = <String>{
              for (final h in _hits)
                if (h.messageId != null)
                  '${h.messageId}'
                else
                  '${h.conversationId}_${h.createdAt}_${h.content}',
            };
            var appended = 0;
            for (final hit in raw) {
              final key = hit.messageId != null
                  ? '${hit.messageId}'
                  : '${hit.conversationId}_${hit.createdAt}_${hit.content}';
              if (seen.add(key)) {
                _hits.add(hit);
                appended++;
              }
            }
            // All duplicates / empty page → stop paging.
            if (raw.isEmpty || appended == 0) {
              _hasMore = false;
            }
          }
        });
        _pagingInFlight = false;
      },
    );
  }

  List<InboxThread> _matchingChats(List<InboxThread> threads) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return threads
        .where(
          (t) =>
              t.title.toLowerCase().contains(q) ||
              t.subtitle.toLowerCase().contains(q) ||
              t.preview.toLowerCase().contains(q),
        )
        .take(8)
        .toList(growable: false);
  }

  void _openThread(InboxThread thread) {
    if (!thread.opensAsChatRoom) return;
    if (thread.conversationId != null) {
      context.read<InboxCubit>().markConversationRead(thread.conversationId!);
    }
    navigatorKey.currentState
        ?.pushNamed(
      AppRoutes.chatRoom,
      arguments: AppRoutesArgs.chatRoomRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        peerDisplayName: thread.title,
        peerInitials: thread.initials,
        peerVerified: thread.isVerified,
        peerIsOnline: thread.isOnline,
        chatType: thread.resolvedChatType,
        contextId: thread.resolvedContextId,
        conversationId: thread.conversationId,
        peerImageUrl: thread.imageUrl,
      ),
    );
  }

  void _openHit(ChatMessageSearchHit hit) {
    final chatType = ChatApiType.fromApi(hit.chatType) ?? hit.chatType;
    final conversationId = hit.conversationId;
    final contextId = () {
      if (chatType == ChatApiType.group) {
        return hit.contextId ?? conversationId;
      }
      return hit.contextId;
    }();
    if (chatType == null ||
        chatType.isEmpty ||
        (contextId == null && conversationId == null)) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.comingSoon),
      );
      return;
    }

    final title = (hit.conversationTitle ?? '').trim();
    final initials = title.isEmpty
        ? '?'
        : title
            .split(RegExp(r'\s+'))
            .where((p) => p.isNotEmpty)
            .take(2)
            .map((p) => p[0].toUpperCase())
            .join();

    if (conversationId != null) {
      context.read<InboxCubit>().markConversationRead(conversationId);
    }

    navigatorKey.currentState?.pushNamed(
      AppRoutes.chatRoom,
      arguments: AppRoutesArgs.chatRoomRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        peerDisplayName: title.isEmpty
            ? context.tr(AppStrings.chat)
            : title,
        peerInitials: initials,
        chatType: chatType,
        contextId: contextId ?? conversationId,
        conversationId: conversationId,
        focusMessageId: hit.messageId?.toString(),
      ),
    );
  }

  String _senderLabel(ChatMessageSearchHit hit) {
    final sender = hit.sender;
    final myId = widget.currentDoctorModel.id;
    if (sender?.id != null && myId != null && sender!.id == myId) {
      return context.tr(AppStrings.you);
    }
    if (sender == null) return '';
    return ChatMappers.userDisplayName(sender);
  }

  void _dismissKeyboard() {
    if (_focusNode.hasFocus) {
      _armImeQueryGuard();
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final subColor = HomeDashboardColors.subtitle(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: scaffold,
            body: GestureDetector(
              onTap: _dismissKeyboard,
              behavior: HitTestBehavior.deferToChild,
              child: Column(
              children: [
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _chrome,
                    curve: Curves.easeOut,
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.08),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _chrome,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: ListenableBuilder(
                      listenable: _focusNode,
                      builder: (context, _) {
                        return _Header(
                          isDark: isDark,
                          primary: primary,
                          titleColor: titleColor,
                          subColor: subColor,
                          controller: _controller,
                          focusNode: _focusNode,
                          focused: _focusNode.hasFocus,
                          hasText: _query.isNotEmpty,
                          onChanged: _onQueryChanged,
                          onClear: _clear,
                          onBack: () => Navigator.of(context).maybePop(),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<InboxCubit, InboxState>(
                    builder: (context, inboxState) {
                      final threads = inboxState.maybeWhen(
                        loaded: (threads, _, __, ___, ____, _____, ______,
                                _______) =>
                            threads,
                        orElse: () => const <InboxThread>[],
                      );
                      final chats = _matchingChats(threads);
                      final qLen = _query.trim().length;
                      final showIdle = qLen < 2 && !_loading;

                      if (showIdle) {
                        return GestureDetector(
                          onTap: _dismissKeyboard,
                          behavior: HitTestBehavior.opaque,
                          child: _IdleBody(
                            isDark: isDark,
                            primary: primary,
                            titleColor: titleColor,
                            subColor: subColor,
                            queryLength: qLen,
                          ),
                        );
                      }

                      if (_loading && _hits.isEmpty && chats.isEmpty) {
                        return GestureDetector(
                          onTap: _dismissKeyboard,
                          behavior: HitTestBehavior.opaque,
                          child: const Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.4),
                            ),
                          ),
                        );
                      }

                      if (_error != null && _hits.isEmpty && chats.isEmpty) {
                        return GestureDetector(
                          onTap: _dismissKeyboard,
                          behavior: HitTestBehavior.opaque,
                          child: _ErrorBody(
                            message: _error!,
                            titleColor: titleColor,
                            subColor: subColor,
                            onRetry: () => unawaited(_search(reset: true)),
                          ),
                        );
                      }

                      final hasAny = chats.isNotEmpty || _hits.isNotEmpty;
                      if (!hasAny && !_loading) {
                        return GestureDetector(
                          onTap: _dismissKeyboard,
                          behavior: HitTestBehavior.opaque,
                          child: _EmptyBody(
                            isDark: isDark,
                            primary: primary,
                            titleColor: titleColor,
                            subColor: subColor,
                          ),
                        );
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (n) {
                          if (n is ScrollStartNotification) {
                            // Prevent IME/autocorrect from rewriting the query
                            // when the keyboard is dismissed by scrolling.
                            _armImeQueryGuard();
                          }
                          if (n is ScrollUpdateNotification ||
                              n is OverscrollNotification) {
                            _maybeLoadMore();
                          }
                          return false;
                        },
                        child: ListView(
                        controller: _scrollController,
                        // Don't auto-dismiss keyboard on drag — that was
                        // letting iOS rewrite the search text (e.g. to "yes").
                        padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 28.h),
                        children: [
                          if (chats.isNotEmpty) ...[
                            _SectionLabel(
                              label: context.tr(AppStrings.chatsSection),
                              color: subColor,
                            ),
                            SizedBox(height: 6.h),
                            for (var i = 0; i < chats.length; i++)
                              KeyedSubtree(
                                key: ValueKey('chat_${chats[i].id}'),
                                child: _StaggerIn(
                                  index: i,
                                  child: _ChatResultTile(
                                    thread: chats[i],
                                    isDark: isDark,
                                    titleColor: titleColor,
                                    subColor: subColor,
                                    primary: primary,
                                    query: _query.trim(),
                                    onTap: () {
                                      _dismissKeyboard();
                                      _openThread(chats[i]);
                                    },
                                  ),
                                ),
                              ),
                            SizedBox(height: 14.h),
                          ],
                          if (_hits.isNotEmpty || _loading) ...[
                            _SectionLabel(
                              label: context.tr(AppStrings.messagesSection),
                              color: subColor,
                            ),
                            SizedBox(height: 6.h),
                          ],
                          if (_loading && _hits.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child: Center(
                                child: Text(
                                  context.tr(AppStrings.searchingMessages),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: subColor,
                                  ),
                                ),
                              ),
                            ),
                          for (var i = 0; i < _hits.length; i++)
                            KeyedSubtree(
                              key: ValueKey(
                                'msg_${_hits[i].messageId ?? '${_hits[i].conversationId}_${_hits[i].createdAt}_$i'}',
                              ),
                              child: _StaggerIn(
                                index: i,
                                child: _MessageResultTile(
                                  hit: _hits[i],
                                  isDark: isDark,
                                  titleColor: titleColor,
                                  subColor: subColor,
                                  primary: primary,
                                  query: _query.trim(),
                                  senderLabel: _senderLabel(_hits[i]),
                                  onTap: () {
                                    _dismissKeyboard();
                                    _openHit(_hits[i]);
                                  },
                                ),
                              ),
                            ),
                          if (_loadingMore)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const Center(
                                child: SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                  ),
                                ),
                              ),
                            )
                          else if (_hasMore && _hits.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Center(
                                child: TextButton(
                                  onPressed: () =>
                                      unawaited(_search(reset: false)),
                                  child: Text(
                                    context.tr(AppStrings.loadMore),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                      );
                    },
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

class _Header extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color subColor;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool focused;
  final bool hasText;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onBack;

  const _Header({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.subColor,
    required this.controller,
    required this.focusNode,
    required this.focused,
    required this.hasText,
    required this.onChanged,
    required this.onClear,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: isDark
              ? [
                  const Color(0xFF7C3AED).withOpacity(0.34),
                  const Color(0xFF6D28D9).withOpacity(0.12),
                  Colors.transparent,
                ]
              : [
                  const Color(0xFFA78BFA).withOpacity(0.30),
                  const Color(0xFFC4B5FD).withOpacity(0.12),
                  Colors.transparent,
                ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(6.w, 4.h, 14.w, 12.h),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16.sp,
                  color: titleColor,
                ),
              ),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: focused
                          ? primary.withOpacity(0.55)
                          : (isDark
                              ? Colors.white.withOpacity(0.08)
                              : const Color(0xFFE5E7EB)),
                      width: focused ? 1.2 : 1,
                    ),
                    boxShadow: focused && !isDark
                        ? [
                            BoxShadow(
                              color: primary.withOpacity(0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 16.sp,
                        color: focused ? primary : subColor,
                      ),
                      SizedBox(width: 7.w),
                      Expanded(
                        child: TextField(
                          key: const ValueKey('inbox_global_search_field'),
                          controller: controller,
                          focusNode: focusNode,
                          onChanged: onChanged,
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          enableSuggestions: false,
                          smartDashesType: SmartDashesType.disabled,
                          smartQuotesType: SmartQuotesType.disabled,
                          spellCheckConfiguration:
                              const SpellCheckConfiguration.disabled(),
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w500,
                            color: titleColor,
                          ),
                          cursorColor: primary,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            hintText:
                                context.tr(AppStrings.searchChatsAndMessages),
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: subColor,
                            ),
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 160),
                        child: hasText
                            ? GestureDetector(
                                key: const ValueKey('clear'),
                                onTap: onClear,
                                child: Icon(
                                  Icons.cancel_rounded,
                                  size: 16.sp,
                                  color: subColor,
                                ),
                              )
                            : const SizedBox.shrink(key: ValueKey('empty')),
                      ),
                    ],
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

class _SectionLabel extends StatelessWidget {
  final String label;
  final Color color;

  const _SectionLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.7,
          color: color,
        ),
      ),
    );
  }
}

class _StaggerIn extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggerIn({
    required this.index,
    required this.child,
  });

  @override
  State<_StaggerIn> createState() => _StaggerInState();
}

class _StaggerInState extends State<_StaggerIn> {
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    if (_done) return widget.child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 240 + (widget.index.clamp(0, 10) * 22)),
      curve: Curves.easeOutCubic,
      onEnd: () {
        if (mounted) setState(() => _done = true);
      },
      builder: (context, t, child) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 10),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _ChatResultTile extends StatelessWidget {
  final InboxThread thread;
  final bool isDark;
  final Color titleColor;
  final Color subColor;
  final Color primary;
  final String query;
  final VoidCallback onTap;

  const _ChatResultTile({
    required this.thread,
    required this.isDark,
    required this.titleColor,
    required this.subColor,
    required this.primary,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final image = thread.imageUrl?.trim();
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Material(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
            child: Row(
              children: [
                Container(
                  width: 38.r,
                  height: 38.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary.withOpacity(0.12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: image != null && image.isNotEmpty
                      ? CustomCachedNetworkImage(
                          imageUrl: image,
                          width: 38.r,
                          height: 38.r,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            thread.initials,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: primary,
                            ),
                          ),
                        ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HighlightText(
                        text: thread.title,
                        query: query,
                        baseStyle: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                        highlightColor: primary,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        thread.preview,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: subColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 16.sp,
                  color: subColor.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageResultTile extends StatelessWidget {
  final ChatMessageSearchHit hit;
  final bool isDark;
  final Color titleColor;
  final Color subColor;
  final Color primary;
  final String query;
  final String senderLabel;
  final VoidCallback onTap;

  const _MessageResultTile({
    required this.hit,
    required this.isDark,
    required this.titleColor,
    required this.subColor,
    required this.primary,
    required this.query,
    required this.senderLabel,
    required this.onTap,
  });

  String? get _chatType => ChatApiType.fromApi(hit.chatType) ?? hit.chatType;

  ({String label, IconData icon, Color color}) _typeMeta(BuildContext context) {
    switch (_chatType) {
      case ChatApiType.caseGroup:
        return (
          label: context.tr(AppStrings.chatTypeCaseGroup),
          icon: Icons.medical_services_outlined,
          color: const Color(0xFF0EA5E9),
        );
      case ChatApiType.socialGroup:
        return (
          label: context.tr(AppStrings.chatTypeSocialGroup),
          icon: Icons.public_rounded,
          color: const Color(0xFF22C55E),
        );
      case ChatApiType.group:
        return (
          label: context.tr(AppStrings.chatTypeGroup),
          icon: Icons.groups_rounded,
          color: const Color(0xFF8B5CF6),
        );
      case ChatApiType.private:
      default:
        return (
          label: context.tr(AppStrings.chatTypePrivate),
          icon: Icons.person_outline_rounded,
          color: primary,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatTitle = (hit.conversationTitle ?? '').trim();
    final content = (hit.content ?? '').trim();
    final time = ChatMappers.formatInboxTime(hit.createdAt);
    final image = hit.sender?.image?.trim();
    final sender = senderLabel.trim().isEmpty
        ? context.tr(AppStrings.unknownUser)
        : senderLabel.trim();
    final type = _typeMeta(context);
    final isGroupLike = _chatType == ChatApiType.group ||
        _chatType == ChatApiType.socialGroup ||
        _chatType == ChatApiType.caseGroup;
    final showChatContext = chatTitle.isNotEmpty &&
        (isGroupLike || chatTitle.toLowerCase() != sender.toLowerCase());

    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Material(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: type.color.withOpacity(isDark ? 0.16 : 0.10),
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
                            sender.isNotEmpty ? sender[0].toUpperCase() : '?',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: type.color,
                            ),
                          ),
                        ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Line 1: sender ········ time (top-right only)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              sender,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w700,
                                color: titleColor,
                              ),
                            ),
                          ),
                          if (time.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Text(
                                time,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: subColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      // Line 2: type badge + optional chat context
                      Row(
                        children: [
                          _ChatTypeChip(
                            label: type.label,
                            icon: type.icon,
                            color: type.color,
                            isDark: isDark,
                          ),
                          if (showChatContext) ...[
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                context
                                    .tr(AppStrings.sentByInChat)
                                    .replaceAll('{chat}', chatTitle),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: subColor,
                                ),
                              ),
                            ),
                          ] else
                            const Spacer(),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      // Line 3: message snippet
                      _HighlightText(
                        text: content.isEmpty
                            ? context.tr(AppStrings.message)
                            : content,
                        query: query,
                        maxLines: 2,
                        baseStyle: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.25,
                          color: subColor,
                        ),
                        highlightColor: primary,
                      ),
                    ],
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

class _ChatTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _ChatTypeChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.w, 2.h, 6.w, 2.h),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.16 : 0.10),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10.sp, color: color),
          SizedBox(width: 3.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              height: 1.1,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle baseStyle;
  final Color highlightColor;
  final int maxLines;

  const _HighlightText({
    required this.text,
    required this.query,
    required this.baseStyle,
    required this.highlightColor,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final q = query.trim();
    if (q.isEmpty || text.isEmpty) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: baseStyle,
      );
    }
    final lower = text.toLowerCase();
    final qLower = q.toLowerCase();
    final spans = <TextSpan>[];
    var start = 0;
    while (true) {
      final idx = lower.indexOf(qLower, start);
      if (idx < 0) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (idx > start) {
        spans.add(TextSpan(text: text.substring(start, idx)));
      }
      spans.add(
        TextSpan(
          text: text.substring(idx, idx + q.length),
          style: baseStyle.copyWith(
            color: highlightColor,
            fontWeight: FontWeight.w700,
            backgroundColor: highlightColor.withOpacity(0.12),
          ),
        ),
      );
      start = idx + q.length;
    }
    return Text.rich(
      TextSpan(style: baseStyle, children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _IdleBody extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color subColor;
  final int queryLength;

  const _IdleBody({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.subColor,
    required this.queryLength,
  });

  @override
  Widget build(BuildContext context) {
    final needsMore = queryLength > 0 && queryLength < 2;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.92, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: Container(
                width: 58.r,
                height: 58.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      primary.withOpacity(0.18),
                      const Color(0xFF8B5CF6).withOpacity(0.10),
                    ],
                  ),
                ),
                child: Icon(
                  needsMore ? Icons.keyboard_rounded : Icons.travel_explore_rounded,
                  size: 24.sp,
                  color: primary,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              needsMore
                  ? context.tr(AppStrings.typeAtLeastTwoCharactersToSearch)
                  : context.tr(AppStrings.searchChatsAndMessagesTitle),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              context.tr(AppStrings.searchChatsAndMessagesHint),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                height: 1.35,
                color: subColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyBody extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color subColor;

  const _EmptyBody({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 28.sp, color: primary),
            SizedBox(height: 10.h),
            Text(
              context.tr(AppStrings.noResultsFound),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              context.tr(AppStrings.tryDifferentKeywords),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: subColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  final String message;
  final Color titleColor;
  final Color subColor;
  final VoidCallback onRetry;

  const _ErrorBody({
    required this.message,
    required this.titleColor,
    required this.subColor,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: titleColor,
              ),
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: onRetry,
              child: Text(
                context.tr(AppStrings.tryAgain),
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
