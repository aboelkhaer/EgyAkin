import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_member_search_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_member_search_state.dart';

import '../../../../exports.dart';

class InboxMemberSearchScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const InboxMemberSearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<InboxMemberSearchScreen> createState() =>
      _InboxMemberSearchScreenState();
}

class _InboxMemberSearchScreenState extends State<InboxMemberSearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late final AnimationController _intro;
  late final Animation<double> _introFade;
  late final Animation<Offset> _introSlide;
  bool _searchFocused = false;
  final Set<int> _onlineUserIds = {};
  StreamSubscription<ChatRealtimeEvent>? _presenceSub;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _introFade = CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic);
    _introSlide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));

    _searchFocusNode.addListener(() {
      if (!mounted) return;
      setState(() => _searchFocused = _searchFocusNode.hasFocus);
    });
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
    _listenToPresence();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _intro.forward();
      _searchFocusNode.requestFocus();
    });
  }

  void _listenToPresence() {
    if (!sl.isRegistered<ChatRealtimeService>()) return;
    final realtime = sl<ChatRealtimeService>();
    _seedOnlineIds(realtime);
    unawaited(_refreshPresence(realtime));
    _presenceSub = realtime.events.listen((event) {
      if (event is! ChatAppPresenceChangedEvent) return;
      final bool changed;
      if (event.isOnline) {
        changed = _onlineUserIds.add(event.userId);
      } else {
        // Inbox may still mark them online via conversation presence.
        final keepOnline = sl.isRegistered<InboxCubit>() &&
            sl<InboxCubit>().onlineCounterpartUserIds.contains(event.userId);
        changed = keepOnline ? false : _onlineUserIds.remove(event.userId);
      }
      if (changed && mounted) setState(() {});
    });
  }

  void _seedOnlineIds(ChatRealtimeService realtime) {
    _onlineUserIds
      ..clear()
      ..addAll(realtime.appOnlineUserIds);
    if (sl.isRegistered<InboxCubit>()) {
      _onlineUserIds.addAll(sl<InboxCubit>().onlineCounterpartUserIds);
    }
  }

  Future<void> _refreshPresence(ChatRealtimeService realtime) async {
    final userId = widget.currentDoctorModel.id;
    if (userId == null) return;
    await realtime.ensureAppPresence(
      currentUserId: userId,
      forceReenter: true,
    );
    await realtime.refreshAppPresenceSnapshot();
    if (!mounted) return;
    _seedOnlineIds(realtime);
    setState(() {});
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    _presenceSub?.cancel();
    _intro.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _openChatWithUser(ChatUserModel user) {
    final userId = user.id;
    if (userId == null) return;
    final isOnline = _onlineUserIds.contains(userId);

    navigatorKey.currentState?.pushNamed(
      AppRoutes.chatRoom,
      arguments: AppRoutesArgs.chatRoomRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        peerDisplayName: ChatMappers.userDisplayName(user),
        peerInitials: ChatMappers.userInitials(user),
        peerVerified: ChatMappers.userIsVerified(user),
        peerIsOnline: isOnline,
        chatType: ChatApiType.private,
        contextId: userId,
        peerImageUrl: user.image,
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<InboxMemberSearchCubit>().onQueryChanged('');
    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final title = HomeDashboardColors.title(isDark);
        final subtitle = HomeDashboardColors.subtitle(isDark);
        final scaffold =
            isDark ? AppColors.darkScaffoldBG : const Color(0xFFF5F6FA);

        return GestureDetector(
          onTap: _dismissKeyboard,
          behavior: HitTestBehavior.deferToChild,
          child: Scaffold(
            backgroundColor: scaffold,
            body: Stack(
              children: [
                // Soft brand wash behind the header — keeps focus on search.
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 220.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark
                            ? [
                                primary.withOpacity(0.22),
                                scaffold,
                              ]
                            : [
                                primary.withOpacity(0.10),
                                scaffold,
                              ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: FadeTransition(
                    opacity: _introFade,
                    child: SlideTransition(
                      position: _introSlide,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _HeaderBar(
                            title: title,
                            subtitle: subtitle,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                            child: _SearchField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              isDark: isDark,
                              primary: primary,
                              focused: _searchFocused,
                              hasText: _searchController.text.isNotEmpty,
                              onChanged: context
                                  .read<InboxMemberSearchCubit>()
                                  .onQueryChanged,
                              onClear: _clearSearch,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: _dismissKeyboard,
                              behavior: HitTestBehavior.opaque,
                              child: BlocBuilder<InboxMemberSearchCubit,
                                  InboxMemberSearchState>(
                                builder: (context, state) {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 280),
                                    switchInCurve: Curves.easeOutCubic,
                                    switchOutCurve: Curves.easeInCubic,
                                    transitionBuilder: (child, animation) {
                                      final fade = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOut,
                                      );
                                      final slide = Tween<Offset>(
                                        begin: const Offset(0, 0.03),
                                        end: Offset.zero,
                                      ).animate(fade);
                                      return FadeTransition(
                                        opacity: fade,
                                        child: SlideTransition(
                                          position: slide,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: KeyedSubtree(
                                      key: ValueKey(state.runtimeType),
                                      child: state.when(
                                        initial: () => _EmptyState(
                                          isDark: isDark,
                                          primary: primary,
                                          icon: Icons.forum_rounded,
                                          title: context.tr(
                                            AppStrings.startChatWithMember,
                                          ),
                                          message: context.tr(
                                            AppStrings
                                                .startChatWithMemberSubtitle,
                                          ),
                                        ),
                                        hint: () => _EmptyState(
                                          isDark: isDark,
                                          primary: primary,
                                          icon: Icons.keyboard_rounded,
                                          title: context.tr(
                                            AppStrings
                                                .typeAtLeastTwoCharactersToSearch,
                                          ),
                                          message: context.tr(
                                            AppStrings.searchMemberToChat,
                                          ),
                                        ),
                                        loading: () =>
                                            _LoadingList(isDark: isDark),
                                        empty: () => _EmptyState(
                                          isDark: isDark,
                                          primary: primary,
                                          icon: Icons.person_search_rounded,
                                          title: context
                                              .tr(AppStrings.noResultsFound),
                                          message: context.tr(
                                            AppStrings.searchMemberToChat,
                                          ),
                                        ),
                                        error: (message) => _EmptyState(
                                          isDark: isDark,
                                          primary: primary,
                                          icon: Icons.error_outline_rounded,
                                          title: message,
                                          message: context.tr(
                                            AppStrings.searchMemberToChat,
                                          ),
                                        ),
                                        loaded: (users) => _ResultsList(
                                          isDark: isDark,
                                          primary: primary,
                                          users: users,
                                          onlineUserIds: _onlineUserIds,
                                          onTap: _openChatWithUser,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final Color title;
  final Color subtitle;

  const _HeaderBar({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6.w, 4.h, 16.w, 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: title,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(AppStrings.startChatWithMember),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: title,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  context.tr(AppStrings.startChatWithMemberSubtitle),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: subtitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isDark;
  final Color primary;
  final bool focused;
  final bool hasText;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.focusNode,
    required this.isDark,
    required this.primary,
    required this.focused,
    required this.hasText,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final fill = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final border = focused
        ? primary.withOpacity(0.85)
        : HomeDashboardColors.border(isDark).withOpacity(0.55);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      height: 50.h,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border, width: focused ? 1.6 : 1),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: primary.withOpacity(isDark ? 0.28 : 0.16),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: focused
                  ? primary.withOpacity(isDark ? 0.25 : 0.12)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_rounded,
              size: 18.sp,
              color: focused ? primary : HomeDashboardColors.subtitle(isDark),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              textInputAction: TextInputAction.search,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: HomeDashboardColors.title(isDark),
              ),
              cursorColor: primary,
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: context.tr(AppStrings.searchMemberToChat),
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: hasText
                ? IconButton(
                    key: const ValueKey('clear'),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: 32.w,
                      minHeight: 32.h,
                    ),
                    onPressed: onClear,
                    icon: Icon(
                      Icons.cancel_rounded,
                      size: 18.sp,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final IconData icon;
  final String title;
  final String message;

  const _EmptyState({
    required this.isDark,
    required this.primary,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
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
              builder: (context, scale, child) => Transform.scale(
                scale: scale,
                child: child,
              ),
              child: Container(
                width: 88.r,
                height: 88.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primary.withOpacity(isDark ? 0.35 : 0.18),
                      primary.withOpacity(isDark ? 0.12 : 0.06),
                    ],
                  ),
                  border: Border.all(
                    color: primary.withOpacity(0.2),
                  ),
                ),
                child: Icon(icon, size: 36.sp, color: primary),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.45,
                fontWeight: FontWeight.w500,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingList extends StatelessWidget {
  final bool isDark;

  const _LoadingList({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return _ShimmerTile(isDark: isDark, delayMs: index * 60);
      },
    );
  }
}

class _ShimmerTile extends StatefulWidget {
  final bool isDark;
  final int delayMs;

  const _ShimmerTile({
    required this.isDark,
    required this.delayMs,
  });

  @override
  State<_ShimmerTile> createState() => _ShimmerTileState();
}

class _ShimmerTileState extends State<_ShimmerTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    Future<void>.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _pulse.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = widget.isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE8E9EE);
    final highlight =
        widget.isDark ? const Color(0xFF3A3A40) : const Color(0xFFF4F5F8);

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_pulse.value);
        final color = Color.lerp(base, highlight, t)!;
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1C1C1E) : Colors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Row(
            children: [
              Container(
                width: 46.r,
                height: 46.r,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 10.h,
                      width: 96.w,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ResultsList extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final List<ChatUserModel> users;
  final Set<int> onlineUserIds;
  final ValueChanged<ChatUserModel> onTap;

  const _ResultsList({
    required this.isDark,
    required this.primary,
    required this.users,
    required this.onlineUserIds,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 28.h),
      itemCount: users.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final user = users[index];
        final userId = user.id;
        final isOnline =
            userId != null && onlineUserIds.contains(userId);
        return _StaggeredResult(
          index: index,
          child: _MemberResultTile(
            isDark: isDark,
            primary: primary,
            user: user,
            isOnline: isOnline,
            onTap: () => onTap(user),
          ),
        );
      },
    );
  }
}

class _StaggeredResult extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggeredResult({
    required this.index,
    required this.child,
  });

  @override
  State<_StaggeredResult> createState() => _StaggeredResultState();
}

class _StaggeredResultState extends State<_StaggeredResult>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    final delay = (widget.index * 45).clamp(0, 280);
    Future<void>.delayed(Duration(milliseconds: delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

class _MemberResultTile extends StatefulWidget {
  final bool isDark;
  final Color primary;
  final ChatUserModel user;
  final bool isOnline;
  final VoidCallback onTap;

  const _MemberResultTile({
    required this.isDark,
    required this.primary,
    required this.user,
    required this.isOnline,
    required this.onTap,
  });

  @override
  State<_MemberResultTile> createState() => _MemberResultTileState();
}

class _MemberResultTileState extends State<_MemberResultTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final isDark = widget.isDark;
    final primary = widget.primary;
    final isOnline = widget.isOnline;
    final name = ChatMappers.userDisplayName(user);
    final initials = ChatMappers.userInitials(user);
    final specialty = user.specialty?.trim() ?? '';
    final workplace = user.workingplace?.trim() ?? '';
    final subtitle = [specialty, workplace]
        .where((part) => part.isNotEmpty)
        .join(' · ');
    final imageUrl = user.image?.trim();
    final presenceColor = isOnline
        ? HomeDashboardColors.online
        : (isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF));
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.45),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.28 : 0.05),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primary.withOpacity(0.22),
                        width: 1.5,
                      ),
                    ),
                    child: imageUrl == null || imageUrl.isEmpty
                        ? HomeInitialsAvatar(initials: initials, radius: 22)
                        : CircleAvatar(
                            radius: 22.r,
                            backgroundColor: primary.withOpacity(0.12),
                            child: ClipOval(
                              child: CustomCachedNetworkImage(
                                imageUrl: imageUrl,
                                height: 44.r,
                                width: 44.r,
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 12.r,
                      height: 12.r,
                      decoration: BoxDecoration(
                        color: presenceColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: cardBg, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: HomeDashboardColors.title(isDark),
                            ),
                          ),
                        ),
                        if (ChatMappers.userIsVerified(user)) ...[
                          SizedBox(width: 4.w),
                          const VerificationIcon(
                            duration: 0,
                            isSmaller: true,
                          ),
                        ],
                      ],
                    ),
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ],
                    SizedBox(height: 4.h),
                    Text(
                      context.tr(
                        isOnline ? AppStrings.onlineNow : AppStrings.offline,
                      ),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: presenceColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.22 : 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chat_bubble_rounded,
                      size: 13.sp,
                      color: primary,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      context.tr(AppStrings.chat),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: primary,
                      ),
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
}
