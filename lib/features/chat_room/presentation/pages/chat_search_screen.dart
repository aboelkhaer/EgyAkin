import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:get_it/get_it.dart';

class ChatSearchScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String? peerDisplayName;
  final String? peerImageUrl;
  final List<ChatMessageItem> messages;
  final String? chatType;
  final int? contextId;
  final int? conversationId;

  const ChatSearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.peerDisplayName,
    this.peerImageUrl,
    this.messages = const [],
    this.chatType,
    this.contextId,
    this.conversationId,
  });

  @override
  State<ChatSearchScreen> createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends State<ChatSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  String _query = '';
  bool _loading = false;
  bool _loadingMore = false;
  bool _searchFocused = false;
  String? _error;
  int _page = 1;
  bool _hasMore = false;
  final List<ChatMessageSearchHit> _hits = [];

  ChatRoomRepository get _repo => GetIt.I<ChatRoomRepository>();

  bool get _canUseApi =>
      widget.chatType != null &&
      widget.chatType!.isNotEmpty &&
      (widget.contextId != null || widget.conversationId != null);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!mounted) return;
      setState(() => _searchFocused = _focusNode.hasFocus);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    setState(() => _query = value);
    _debounce?.cancel();
    final q = value.trim();
    if (q.length < 2) {
      setState(() {
        _hits.clear();
        _error = null;
        _loading = false;
        _hasMore = false;
        _page = 1;
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 380), () {
      unawaited(_search(reset: true));
    });
  }

  void _clearQuery() {
    _controller.clear();
    _onQueryChanged('');
    _focusNode.requestFocus();
  }

  bool _belongsToThisChat(ChatMessageSearchHit hit) {
    final conversationId = widget.conversationId;
    if (conversationId != null && hit.conversationId == conversationId) {
      return true;
    }
    final chatType = widget.chatType;
    final contextId = widget.contextId;
    if (chatType != null &&
        hit.chatType == chatType &&
        contextId != null &&
        hit.contextId == contextId) {
      return true;
    }
    // Ad-hoc group: path id is the conversation id.
    if (chatType == ChatApiType.group &&
        conversationId != null &&
        hit.contextId == conversationId) {
      return true;
    }
    return false;
  }

  Future<void> _search({required bool reset}) async {
    final q = _query.trim();
    if (q.length < 2) return;

    if (!_canUseApi) {
      _searchLocal(q);
      return;
    }

    final page = reset ? 1 : _page + 1;
    setState(() {
      if (reset) {
        _loading = true;
        _error = null;
      } else {
        _loadingMore = true;
      }
    });

    final result = await _repo.searchMessages(
      query: q,
      page: page,
      perPage: 40,
    );
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _loading = false;
          _loadingMore = false;
          if (reset) {
            _error = failure.message;
            // Fall back to in-memory messages if the API fails.
            _searchLocal(q);
          }
        });
      },
      (response) {
        final raw = response.data?.items ?? const <ChatMessageSearchHit>[];
        final scoped = raw.where(_belongsToThisChat).toList(growable: false);
        final meta = response.data?.meta;
        final hasMore = () {
          if (meta != null) {
            final current = meta.currentPage ?? page;
            final last = meta.lastPage;
            if (last != null) return current < last;
            final total = meta.total;
            final per = meta.perPage ?? 40;
            if (total != null && per > 0) return page * per < total;
          }
          return raw.length >= 40;
        }();
        setState(() {
          _loading = false;
          _loadingMore = false;
          _page = page;
          _hasMore = hasMore;
          if (reset) {
            _hits
              ..clear()
              ..addAll(scoped);
          } else {
            final seen = _hits.map((h) => h.messageId).toSet();
            for (final hit in scoped) {
              if (hit.messageId == null || seen.add(hit.messageId)) {
                _hits.add(hit);
              }
            }
          }
          // Keep paging while scoped results are thin but more API pages exist.
          if (_hits.isEmpty && _hasMore && page < 8) {
            unawaited(_search(reset: false));
          }
        });
      },
    );
  }

  void _searchLocal(String q) {
    final lower = q.toLowerCase();
    final myId = widget.currentDoctorModel.id;
    final myImage = widget.currentDoctorModel.image?.trim();
    final peerImage = widget.peerImageUrl?.trim();

    final local = widget.messages
        .where((m) =>
            !m.isSystem && !m.isDeleted && m.text.toLowerCase().contains(lower))
        .toList()
        .reversed
        .map((m) {
      final parts = m.senderName.trim().split(RegExp(r'\s+'));
      final first = parts.isNotEmpty ? parts.first : null;
      final last = parts.length > 1 ? parts.sublist(1).join(' ') : null;
      final image = () {
        final fromMsg = m.senderImageUrl?.trim();
        if (fromMsg != null && fromMsg.isNotEmpty) return fromMsg;
        if (m.isOutgoing) {
          return (myImage != null && myImage.isNotEmpty) ? myImage : null;
        }
        return (peerImage != null && peerImage.isNotEmpty) ? peerImage : null;
      }();

      return ChatMessageSearchHit(
        messageId: int.tryParse(m.id),
        conversationId: widget.conversationId,
        chatType: widget.chatType,
        contextId: widget.contextId,
        content: m.text,
        createdAt: m.createdAt?.toUtc().toIso8601String(),
        sender: ChatUserModel(
          id: m.senderId ?? (m.isOutgoing ? myId : null),
          name: first,
          lname: last,
          image: image,
        ),
      );
    }).toList(growable: false);

    setState(() {
      _hits
        ..clear()
        ..addAll(local);
      _hasMore = false;
      _loading = false;
      _loadingMore = false;
    });
  }

  String _senderLabel(ChatMessageSearchHit hit) {
    final sender = hit.sender;
    if (sender == null) {
      return (widget.peerDisplayName ?? '').trim();
    }
    final first = (sender.name ?? '').trim();
    final last = (sender.lname ?? '').trim();
    final full = ('$first $last').trim();
    return full;
  }

  /// Prefer API sender image, then local message cache, then peer / self photo.
  String? _imageForHit(ChatMessageSearchHit hit) {
    final fromApi = hit.sender?.image?.trim();
    if (fromApi != null && fromApi.isNotEmpty) return fromApi;

    if (_isSelfHit(hit)) {
      final mine = widget.currentDoctorModel.image?.trim();
      if (mine != null && mine.isNotEmpty) return mine;
    }

    final messageId = hit.messageId?.toString();
    if (messageId != null) {
      for (final m in widget.messages) {
        if (m.id == messageId) {
          final img = m.senderImageUrl?.trim();
          if (img != null && img.isNotEmpty) return img;
          if (m.isOutgoing) {
            final mine = widget.currentDoctorModel.image?.trim();
            if (mine != null && mine.isNotEmpty) return mine;
          } else {
            final peer = widget.peerImageUrl?.trim();
            if (peer != null && peer.isNotEmpty) return peer;
          }
          break;
        }
      }
    }

    final senderId = hit.sender?.id;
    if (senderId != null) {
      for (final m in widget.messages) {
        if (m.senderId == senderId) {
          final img = m.senderImageUrl?.trim();
          if (img != null && img.isNotEmpty) return img;
        }
      }
    }

    final peer = widget.peerImageUrl?.trim();
    if (peer != null && peer.isNotEmpty) return peer;
    return null;
  }

  bool _isSelfHit(ChatMessageSearchHit hit) {
    final sid = hit.sender?.id;
    final myId = widget.currentDoctorModel.id;
    if (sid != null && myId != null && sid == myId) return true;

    final label = _senderLabel(hit).toLowerCase();
    if (label.isEmpty) return false;
    final mine = [
      widget.currentDoctorModel.firstName,
      widget.currentDoctorModel.lastName,
    ]
        .whereType<String>()
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .join(' ')
        .toLowerCase();
    return mine.isNotEmpty && label == mine;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold = isDark ? AppColors.darkScaffoldBG : Colors.white;
        final titleColor = isDark ? AppColors.darkTitle : AppColors.title;
        final subColor =
            isDark ? AppColors.darkDescription : AppColors.description;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final q = _query.trim();

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.deferToChild,
          child: Scaffold(
            backgroundColor: scaffold,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SearchHeader(
                    controller: _controller,
                    focusNode: _focusNode,
                    isDark: isDark,
                    primary: primary,
                    titleColor: titleColor,
                    subColor: subColor,
                    focused: _searchFocused,
                    hasText: _query.isNotEmpty,
                    onChanged: _onQueryChanged,
                    onClear: _clearQuery,
                    onSubmitted: (_) => unawaited(_search(reset: true)),
                    onBack: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: KeyedSubtree(
                        key: ValueKey<String>(
                          q.length < 2
                              ? 'idle'
                              : _loading && _hits.isEmpty
                                  ? 'loading'
                                  : _hits.isEmpty
                                      ? 'empty'
                                      : 'results',
                        ),
                        child: _buildBody(
                          isDark: isDark,
                          titleColor: titleColor,
                          subColor: subColor,
                          primary: primary,
                          q: q,
                        ),
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

  Widget _buildBody({
    required bool isDark,
    required Color titleColor,
    required Color subColor,
    required Color primary,
    required String q,
  }) {
    if (q.length < 2) {
      return _IdleState(
        isDark: isDark,
        primary: primary,
        titleColor: titleColor,
        subColor: subColor,
        queryLength: q.length,
      );
    }
    if (_loading && _hits.isEmpty) {
      return _LoadingState(subColor: subColor, primary: primary);
    }
    if (_error != null && _hits.isEmpty) {
      return _MessageState(
        icon: Icons.error_outline_rounded,
        title: _error!,
        subtitle: context.tr(AppStrings.searchMessages),
        titleColor: titleColor,
        subColor: subColor,
        primary: primary,
      );
    }
    if (_hits.isEmpty) {
      return _MessageState(
        icon: Icons.search_off_rounded,
        title: context.tr(AppStrings.noResultsFound),
        subtitle: context.tr(AppStrings.tryDifferentSearchTerms),
        titleColor: titleColor,
        subColor: subColor,
        primary: primary,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 6.h),
          child: Text(
            '${_hits.length}${_hasMore ? '+' : ''} ${context.tr(AppStrings.results)}',
            style: TextStyle(
              color: subColor.withOpacity(0.9),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 20.h),
            itemCount: _hits.length + (_hasMore ? 1 : 0),
            separatorBuilder: (_, __) => Divider(
              height: 1,
              thickness: 0.5,
              indent: 62.w,
              endIndent: 16.w,
              color: isDark
                  ? AppColors.darkBorder.withOpacity(0.4)
                  : const Color(0xFFE5E5EA),
            ),
            itemBuilder: (context, index) {
              if (index >= _hits.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: _loadingMore
                        ? SizedBox(
                            width: 18.r,
                            height: 18.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: primary,
                            ),
                          )
                        : TextButton(
                            onPressed: () => unawaited(_search(reset: false)),
                            style: TextButton.styleFrom(
                              foregroundColor: primary,
                              textStyle: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: Text(context.tr(AppStrings.loadMore)),
                          ),
                  ),
                );
              }

              final hit = _hits[index];
              return _SearchResultTile(
                hit: hit,
                query: q,
                sender: _senderLabel(hit),
                imageUrl: _imageForHit(hit),
                isDark: isDark,
                titleColor: titleColor,
                subColor: subColor,
                primary: primary,
                onTap: () {
                  final id = hit.messageId;
                  if (id == null) return;
                  Navigator.of(context).pop('$id');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color subColor;
  final bool focused;
  final bool hasText;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onBack;

  const _SearchHeader({
    required this.controller,
    required this.focusNode,
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.subColor,
    required this.focused,
    required this.hasText,
    required this.onChanged,
    required this.onClear,
    required this.onSubmitted,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final fill = isDark ? AppColors.darkSurface : const Color(0xFFF2F2F7);
    final iconColor = subColor;
    final fieldText = titleColor;
    final ring = focused
        ? primary.withOpacity(isDark ? 0.45 : 0.28)
        : Colors.transparent;

    return Padding(
      padding: EdgeInsets.fromLTRB(2.w, 4.h, 12.w, 6.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.all(8.r),
            constraints: BoxConstraints.tightFor(width: 40.r, height: 40.r),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.sp,
              color: titleColor,
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              height: 36.h,
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ring, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 17.sp, color: iconColor),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      autofocus: true,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w500,
                        color: fieldText,
                        height: 1.2,
                      ),
                      cursorColor: primary,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: context.tr(AppStrings.searchMessages),
                        hintStyle: TextStyle(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w400,
                          color: iconColor,
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
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: EdgeInsets.all(2.r),
                              child: Icon(
                                Icons.cancel_rounded,
                                size: 16.sp,
                                color: iconColor,
                              ),
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
    );
  }
}

class _IdleState extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color subColor;
  final int queryLength;

  const _IdleState({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.subColor,
    required this.queryLength,
  });

  @override
  Widget build(BuildContext context) {
    final needsMoreChars = queryLength > 0 && queryLength < 2;
    final title = needsMoreChars
        ? context.tr(AppStrings.typeAtLeastTwoCharactersToSearch)
        : context.tr(AppStrings.searchForMessages);
    final subtitle = needsMoreChars
        ? context.tr(AppStrings.findMessagesInThisChat)
        : context.tr(AppStrings.typeAtLeastTwoCharactersToSearch);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.r,
              height: 52.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppColors.darkSurface : AppColors.subBG,
              ),
              child: Icon(
                needsMoreChars ? Icons.keyboard_rounded : Icons.search_rounded,
                size: 22.sp,
                color: primary.withOpacity(0.85),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: titleColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subColor,
                fontSize: 12.sp,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  final Color subColor;
  final Color primary;

  const _LoadingState({
    required this.subColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20.r,
            height: 20.r,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: primary,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            context.tr(AppStrings.searchingMessages),
            style: TextStyle(
              color: subColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subColor;
  final Color primary;

  const _MessageState({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32.sp, color: primary.withOpacity(0.7)),
            SizedBox(height: 12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: titleColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subColor,
                fontSize: 12.sp,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final ChatMessageSearchHit hit;
  final String query;
  final String sender;
  final String? imageUrl;
  final bool isDark;
  final Color titleColor;
  final Color subColor;
  final Color primary;
  final VoidCallback onTap;

  const _SearchResultTile({
    required this.hit,
    required this.query,
    required this.sender,
    required this.imageUrl,
    required this.isDark,
    required this.titleColor,
    required this.subColor,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = (hit.content ?? '').trim();
    final dateLabel = ChatMappers.formatInboxTime(hit.createdAt);
    final initials =
        sender.isNotEmpty ? ChatMappers.initialsFromTitle(sender) : '?';
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    final avatarSize = 36.r;
    final baseStyle = TextStyle(
      color: subColor,
      fontSize: 12.5.sp,
      height: 1.28,
      fontWeight: FontWeight.w400,
    );
    final matchStyle = TextStyle(
      color: isDark ? Colors.white : titleColor,
      fontSize: 12.5.sp,
      height: 1.28,
      fontWeight: FontWeight.w600,
      backgroundColor: primary.withOpacity(isDark ? 0.28 : 0.16),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 9.h, 14.w, 9.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  width: avatarSize,
                  height: avatarSize,
                  color: primary.withOpacity(isDark ? 0.2 : 0.1),
                  alignment: Alignment.center,
                  child: hasImage
                      ? CustomCachedNetworkImage(
                          imageUrl: imageUrl!,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          initials,
                          style: TextStyle(
                            color: primary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Expanded(
                          child: Text(
                            sender.isEmpty
                                ? context.tr(AppStrings.message)
                                : sender,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                        ),
                        if (dateLabel.isNotEmpty) ...[
                          SizedBox(width: 8.w),
                          Text(
                            dateLabel,
                            style: TextStyle(
                              color: subColor.withOpacity(0.85),
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text.rich(
                      TextSpan(
                        children: _highlightSpans(
                          text: content.isEmpty ? '—' : content,
                          query: query,
                          baseStyle: baseStyle,
                          matchStyle: matchStyle,
                        ),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _highlightSpans({
    required String text,
    required String query,
    required TextStyle baseStyle,
    required TextStyle matchStyle,
  }) {
    final q = query.trim();
    if (q.isEmpty || text == '—') {
      return [TextSpan(text: text, style: baseStyle)];
    }

    final lower = text.toLowerCase();
    final needle = q.toLowerCase();
    final spans = <InlineSpan>[];
    var start = 0;

    while (true) {
      final index = lower.indexOf(needle, start);
      if (index < 0) {
        if (start < text.length) {
          spans.add(TextSpan(text: text.substring(start), style: baseStyle));
        }
        break;
      }
      if (index > start) {
        spans.add(
          TextSpan(text: text.substring(start, index), style: baseStyle),
        );
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + needle.length),
          style: matchStyle,
        ),
      );
      start = index + needle.length;
    }

    return spans;
  }
}
