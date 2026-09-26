import 'package:egy_akin/features/chat/data/services/chat_archive_prefs.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/doctor_info_view/domain/usecases/block_user_usecase.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_state.dart';
import 'package:egy_akin/features/inbox/presentation/widgets/inbox_chat_more_sheet.dart';
import 'package:egy_akin/features/inbox/presentation/widgets/inbox_compose_overlay.dart';
import 'package:egy_akin/features/inbox/presentation/widgets/inbox_loading_shimmer.dart';
import 'package:egy_akin/features/inbox/presentation/widgets/inbox_thread_tiles.dart';
import 'package:get_it/get_it.dart';

import '../../../../exports.dart';

class InboxScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const InboxScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final GlobalKey _composeButtonKey = GlobalKey();
  bool _composeOverlayOpen = false;
  Rect? _composeOverlayAnchor;
  late final InboxCubit _inboxCubit;
  /// 0..1 while the user pulls; drives the tabs bar before refresh starts.
  double _pullProgress = 0;

  @override
  void initState() {
    super.initState();
    _inboxCubit = context.read<InboxCubit>();
    final userId = widget.currentDoctorModel.id ?? 0;
    final displayName = doctorName(
      firstName: widget.currentDoctorModel.firstName,
      lastName: widget.currentDoctorModel.lastName,
      role: widget.homeDataModel.isSyndicateCardRequired ?? '',
    );
    _inboxCubit.initIfNeeded(currentUserId: userId);
    _inboxCubit.startLiveUpdates(
      currentUserId: userId,
      displayName: displayName,
      imageUrl: widget.currentDoctorModel.image,
    );
  }

  @override
  void dispose() {
    _composeOverlayEntry?.remove();
    _composeOverlayEntry = null;
    _inboxCubit.stopLiveUpdates();
    super.dispose();
  }

  void _openGlobalSearch() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.inboxGlobalSearch,
      arguments: {
        'currentDoctorModel': widget.currentDoctorModel,
        'homeDataModel': widget.homeDataModel,
      },
    );
  }

  void _openThread(InboxThread thread) {
    if (!thread.opensAsChatRoom) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.comingSoon),
      );
      return;
    }

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
        peerIsOnline: thread.isGroupLike ? false : thread.isOnline,
        chatType: thread.isGroupLike
            ? (thread.resolvedChatType == 'group' ||
                    thread.resolvedChatType == 'social_group' ||
                    thread.resolvedChatType == 'case_group'
                ? thread.resolvedChatType
                : 'case_group')
            : thread.resolvedChatType,
        contextId: thread.resolvedContextId,
        conversationId: thread.conversationId,
        peerImageUrl: thread.isGroupLike ? null : thread.imageUrl,
      ),
    )
        .then((_) {
      if (!mounted) return;
      // Ensure active chat is cleared before any refresh / new messages.
      try {
        if (GetIt.I.isRegistered<ChatRealtimeService>()) {
          GetIt.I<ChatRealtimeService>().clearActiveChat();
        }
      } catch (_) {}
      context.read<InboxCubit>().silentRefresh(
            currentUserId: widget.currentDoctorModel.id,
            forceReadConversationId: thread.conversationId,
            bypassThrottle: true,
          );
    });
  }

  OverlayEntry? _composeOverlayEntry;

  void _openComposeOverlay() {
    final box =
        _composeButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final offset = box.localToGlobal(Offset.zero);
    final anchor = offset & box.size;
    _closeComposeOverlay();
    _composeOverlayAnchor = anchor;
    _composeOverlayOpen = true;
    _composeOverlayEntry = OverlayEntry(
      builder: (context) => InboxComposeOverlay(
        anchorRect: anchor,
        onDismiss: _closeComposeOverlay,
        onChoice: _onComposeChoice,
      ),
    );
    // Root overlay so blur covers the bottom nav tabs too.
    final overlay = Overlay.of(context, rootOverlay: true);
    overlay.insert(_composeOverlayEntry!);
  }

  void _closeComposeOverlay() {
    _composeOverlayEntry?.remove();
    _composeOverlayEntry = null;
    if (_composeOverlayOpen || _composeOverlayAnchor != null) {
      setState(() {
        _composeOverlayOpen = false;
        _composeOverlayAnchor = null;
      });
    }
  }

  void _onComposeChoice(InboxComposeChoice choice) {
    switch (choice) {
      case InboxComposeChoice.member:
        navigatorKey.currentState?.pushNamed(
          AppRoutes.inboxMemberSearch,
          arguments: {
            'currentDoctorModel': widget.currentDoctorModel,
            'homeDataModel': widget.homeDataModel,
          },
        );
        break;
      case InboxComposeChoice.group:
        navigatorKey.currentState?.pushNamed(
          AppRoutes.inboxGroupCreate,
          arguments: {
            'currentDoctorModel': widget.currentDoctorModel,
            'homeDataModel': widget.homeDataModel,
          },
        );
        break;
    }
  }

  Future<void> _archiveThread(InboxThread thread) async {
    final ok = await context.read<InboxCubit>().archiveThread(thread);
    if (!mounted || ok) return;
    customSnackBar(
      context: context,
      message: context.tr(AppStrings.archiveFailed),
    );
  }

  void _openArchivedChats() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.inboxArchived,
      arguments: {
        'currentDoctorModel': widget.currentDoctorModel,
        'homeDataModel': widget.homeDataModel,
      },
    );
  }

  Future<void> _toggleReadThread(InboxThread thread) async {
    if (thread.unreadCount > 0) {
      await context.read<InboxCubit>().markThreadRead(thread);
      return;
    }
    final ok = await context.read<InboxCubit>().markThreadUnread(thread);
    if (!mounted || ok) return;
    customSnackBar(
      context: context,
      message: context.tr(AppStrings.markUnreadFailed),
    );
  }

  Future<void> _toggleMuteThread(InboxThread thread) async {
    final mute = !thread.isMuted;
    final ok = await context.read<InboxCubit>().muteThread(
          thread,
          mute: mute,
        );
    if (!mounted || ok) return;
    customSnackBar(
      context: context,
      message: context.tr(AppStrings.muteFailed),
    );
  }

  Future<void> _togglePinThread(InboxThread thread) async {
    final ok = await context.read<InboxCubit>().pinThread(
          thread,
          pinned: !thread.isPinned,
        );
    if (!mounted || ok) return;
    customSnackBar(
      context: context,
      message: context.tr(AppStrings.pinFailed),
    );
  }

  Future<void> _deleteThread(InboxThread thread) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          context.tr(AppStrings.deleteChatFull),
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        content: Text(
          context.tr(AppStrings.deleteChatQuestion),
          style: TextStyle(fontSize: 12.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.tr(AppStrings.cancel)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              context.tr(AppStrings.delete),
              style: const TextStyle(color: Color(0xFFE11D48)),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final ok = await context.read<InboxCubit>().hideThread(thread);
    if (!mounted) return;
    if (ok) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.chatDeleted),
      );
    } else {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.deleteChatFailed),
      );
    }
  }

  Future<void> _openChatMore(InboxThread thread) async {
    final themeState = context.read<ThemeBloc>().state;
    final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
    final primary = HomeDashboardColors.primary(isDark);
    final action = await showInboxChatMoreSheet(
      context: context,
      thread: thread,
      isDark: isDark,
      primary: primary,
    );
    if (!mounted || action == null) return;

    switch (action) {
      case InboxChatMoreAction.mute:
        await _toggleMuteThread(thread);
      case InboxChatMoreAction.contactInfo:
        _openContactOrChatInfo(thread);
      case InboxChatMoreAction.block:
        await _blockThreadUser(thread);
      case InboxChatMoreAction.delete:
        await _deleteThread(thread);
    }
  }

  void _openContactOrChatInfo(InboxThread thread) {
    final isGroup = thread.isGroupLike;

    if (!isGroup && thread.counterpartUserId != null) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.doctorInfoView,
        arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
          doctorId: thread.counterpartUserId.toString(),
          initialIndex: 0,
          currentDoctorModel: widget.currentDoctorModel,
          isSyndicateCardRequired:
              widget.homeDataModel.isSyndicateCardRequired.toString(),
          accountVerification: widget.homeDataModel.verified ?? false,
          currentDoctorRole: widget.homeDataModel.role.toString(),
          currentDoctorPoints:
              int.tryParse(widget.homeDataModel.scoreValue?.toString() ?? '') ??
                  0,
          homeDataModel: widget.homeDataModel,
          isNavigateToTheButtonOfInformationTab: false,
        ),
      );
      return;
    }

    navigatorKey.currentState?.pushNamed(
      AppRoutes.chatInfo,
      arguments: {
        'currentDoctorModel': widget.currentDoctorModel,
        'homeDataModel': widget.homeDataModel,
        'displayName': thread.title,
        'imageUrl': thread.imageUrl,
        'initials': thread.initials,
        'isVerified': thread.isVerified,
        'chatType': thread.resolvedChatType,
        'contextId': thread.resolvedContextId,
        'conversationId': thread.conversationId,
        'isGroup': isGroup,
        'messages': const <ChatMessageItem>[],
      },
    );
  }

  Future<void> _blockThreadUser(InboxThread thread) async {
    final doctorId = thread.counterpartUserId;
    if (doctorId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          '${context.tr(AppStrings.block)} ${thread.title}?',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.tr(AppStrings.cancel)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              context.tr(AppStrings.block),
              style: const TextStyle(color: Color(0xFFE11D48)),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    if (!GetIt.I.isRegistered<BlockUserUsecase>()) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.blockFailed),
      );
      return;
    }

    final result = await GetIt.I<BlockUserUsecase>().execute(
      BlockUserUsecaseInput(
        doctorId: doctorId.toString(),
        status: true,
      ),
    );
    if (!mounted) return;
    result.fold(
      (_) => customSnackBar(
        context: context,
        message: context.tr(AppStrings.blockFailed),
      ),
      (_) async {
        await context.read<InboxCubit>().hideThread(thread);
        if (!mounted) return;
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.userBlocked),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InboxCubit, InboxState>(
      builder: (context, inboxState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
            final primary = HomeDashboardColors.primary(isDark);
            final scaffold = HomeDashboardColors.scaffold(isDark);
            final inboxCubit = context.read<InboxCubit>();

            return inboxState.when(
              initial: () => InboxLoadingShimmer(isDark: isDark),
              loading: () => InboxLoadingShimmer(isDark: isDark),
              error: (message) => Scaffold(
                backgroundColor: scaffold,
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(message),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () => inboxCubit.refresh(),
                        child: Text(context.tr(AppStrings.tryAgain)),
                      ),
                    ],
                  ),
                ),
              ),
              loaded: (threads, counts, filter, isLastPage, currentPage,
                  totalCount, isLoadingMore, isRefreshing) {
                // Pinned always first (above priority), then priority, then rest.
                final pinned = threads.where((t) => t.isPinned).toList();
                final priority = threads
                    .where((t) => !t.isPinned && t.isPriority)
                    .toList();
                final earlier = threads
                    .where((t) => !t.isPinned && !t.isPriority)
                    .toList();
                final earlierCount = totalCount ?? earlier.length;

                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness:
                        isDark ? Brightness.light : Brightness.dark,
                    statusBarBrightness:
                        isDark ? Brightness.dark : Brightness.light,
                    systemStatusBarContrastEnforced: false,
                  ),
                  child: Scaffold(
                    backgroundColor: scaffold,
                    body: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          children: [
                            // Soft purple glow header (title + search + filters)
                            Container(
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: isDark
                                      ? [
                                          const Color(0xFF7C3AED)
                                              .withOpacity(0.40),
                                          const Color(0xFF6D28D9)
                                              .withOpacity(0.18),
                                          const Color(0xFF6D28D9)
                                              .withOpacity(0.0),
                                        ]
                                      : [
                                          const Color(0xFFA78BFA)
                                              .withOpacity(0.36),
                                          const Color(0xFFC4B5FD)
                                              .withOpacity(0.16),
                                          const Color(0xFFC4B5FD)
                                              .withOpacity(0.0),
                                        ],
                                  stops: const [0.0, 0.45, 1.0],
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(28.r),
                                  bottomRight: Radius.circular(28.r),
                                ),
                              ),
                              child: SafeArea(
                                bottom: false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16.w, 8.h, 16.w, 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              context.tr(AppStrings.inbox),
                                              style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w800,
                                                color:
                                                    HomeDashboardColors.title(
                                                        isDark),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            key: _composeButtonKey,
                                            color: primary,
                                            shape: const CircleBorder(),
                                            elevation: 2,
                                            shadowColor:
                                                primary.withOpacity(0.45),
                                            child: InkWell(
                                              customBorder:
                                                  const CircleBorder(),
                                              onTap: _openComposeOverlay,
                                              child: SizedBox(
                                                width: 40.r,
                                                height: 40.r,
                                                child: Icon(
                                                  Icons.edit_rounded,
                                                  color: Colors.white,
                                                  size: 18.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: _SearchField(
                                        isDark: isDark,
                                        onTap: _openGlobalSearch,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    SizedBox(
                                      height: 34.h,
                                      child: _ScrollHintChipRow(
                                        isDark: isDark,
                                        children: [
                                          _FilterChip(
                                            label: inboxCubit.filterTitleFor(
                                              InboxFilter.all,
                                              context.tr(AppStrings.all),
                                            ),
                                            count: inboxCubit
                                                .countFor(InboxFilter.all),
                                            selected: filter == InboxFilter.all,
                                            isDark: isDark,
                                            primary: primary,
                                            onTap: () => inboxCubit
                                                .changeFilter(InboxFilter.all),
                                          ),
                                          SizedBox(width: 8.w),
                                          _FilterChip(
                                            label: context
                                                .tr(AppStrings.individual),
                                            count: inboxCubit
                                                .countFor(InboxFilter.doctors),
                                            selected:
                                                filter == InboxFilter.doctors,
                                            isDark: isDark,
                                            primary: primary,
                                            onTap: () =>
                                                inboxCubit.changeFilter(
                                                    InboxFilter.doctors),
                                          ),
                                          SizedBox(width: 8.w),
                                          _FilterChip(
                                            label: inboxCubit.filterTitleFor(
                                              InboxFilter.patients,
                                              context.tr(AppStrings.patients),
                                            ),
                                            count: inboxCubit
                                                .countFor(InboxFilter.patients),
                                            selected:
                                                filter == InboxFilter.patients,
                                            isDark: isDark,
                                            primary: primary,
                                            onTap: () =>
                                                inboxCubit.changeFilter(
                                                    InboxFilter.patients),
                                          ),
                                          SizedBox(width: 8.w),
                                          _FilterChip(
                                            label: inboxCubit.filterTitleFor(
                                              InboxFilter.groups,
                                              context.tr(AppStrings.groups),
                                            ),
                                            count: inboxCubit
                                                .countFor(InboxFilter.groups),
                                            selected:
                                                filter == InboxFilter.groups,
                                            isDark: isDark,
                                            primary: primary,
                                            onTap: () =>
                                                inboxCubit.changeFilter(
                                                    InboxFilter.groups),
                                          ),
                                          SizedBox(width: 8.w),
                                          _FilterChip(
                                            label: context
                                                .tr(AppStrings.socialGroup),
                                            count: inboxCubit.countFor(
                                                InboxFilter.socialGroups),
                                            selected: filter ==
                                                InboxFilter.socialGroups,
                                            isDark: isDark,
                                            primary: primary,
                                            onTap: () =>
                                                inboxCubit.changeFilter(
                                                    InboxFilter.socialGroups),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    // Always reserve the bar height so soft
                                    // refresh never shoves the chat list.
                                    SizedBox(
                                      height: 2.h,
                                      child: AnimatedOpacity(
                                        opacity: (isRefreshing ||
                                                _pullProgress > 0.02)
                                            ? 1
                                            : 0,
                                        // Instant hide when refresh ends so the
                                        // bar never freezes as a left stub.
                                        duration: Duration.zero,
                                        child: IgnorePointer(
                                          child: isRefreshing
                                              ? LinearProgressIndicator(
                                                  minHeight: 2.h,
                                                  color: primary,
                                                  backgroundColor:
                                                      primary.withOpacity(0.12),
                                                )
                                              : _pullProgress > 0.02
                                                  ? LinearProgressIndicator(
                                                      minHeight: 2.h,
                                                      value: _pullProgress
                                                          .clamp(0.0, 1.0),
                                                      color: primary,
                                                      backgroundColor: primary
                                                          .withOpacity(0.12),
                                                    )
                                                  : const SizedBox.expand(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: threads.isEmpty
                                  ? _InboxSoftPullRefresh(
                                      enabled: !isRefreshing,
                                      onPullProgress: (p) {
                                        if (_pullProgress == p) return;
                                        setState(() => _pullProgress = p);
                                      },
                                      onRefresh: () async {
                                        setState(() => _pullProgress = 0);
                                        await inboxCubit.refresh();
                                      },
                                      child: CustomScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics(),
                                        ),
                                        slivers: [
                                          SliverToBoxAdapter(
                                            child: _ArchivedChatsEntryGate(
                                              isDark: isDark,
                                              primary: primary,
                                              inboxCubit: inboxCubit,
                                              onTap: _openArchivedChats,
                                            ),
                                          ),
                                          SliverFillRemaining(
                                            hasScrollBody: false,
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 32.w),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.forum_outlined,
                                                      size: 40.sp,
                                                      color: HomeDashboardColors
                                                          .subtitle(isDark),
                                                    ),
                                                    SizedBox(height: 12.h),
                                                    Text(
                                                      context.tr(
                                                          AppStrings.noMessages),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            HomeDashboardColors
                                                                .title(isDark),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Text(
                                                      context.tr(AppStrings
                                                          .startChatWithMemberSubtitle),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color:
                                                            HomeDashboardColors
                                                                .subtitle(
                                                                    isDark),
                                                      ),
                                                    ),
                                                    SizedBox(height: 16.h),
                                                    TextButton.icon(
                                                      onPressed:
                                                          _openComposeOverlay,
                                                      icon: const Icon(
                                                          Icons.edit_rounded,
                                                          size: 18),
                                                      label: Text(
                                                        context.tr(
                                                            AppStrings.compose),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : _InboxSoftPullRefresh(
                                      enabled: !isRefreshing,
                                      onPullProgress: (p) {
                                        if (_pullProgress == p) return;
                                        setState(() => _pullProgress = p);
                                      },
                                      onRefresh: () async {
                                        setState(() => _pullProgress = 0);
                                        await inboxCubit.refresh();
                                      },
                                      child: NotificationListener<
                                          ScrollNotification>(
                                        onNotification: (n) {
                                          if (n.metrics.pixels >=
                                                  n.metrics.maxScrollExtent -
                                                      240 &&
                                              !isLastPage &&
                                              !isLoadingMore &&
                                              !isRefreshing) {
                                            inboxCubit.loadMore();
                                          }
                                          return false;
                                        },
                                        child: CustomScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics(),
                                          ),
                                          slivers: [
                                            SliverToBoxAdapter(
                                              child: _ArchivedChatsEntryGate(
                                                isDark: isDark,
                                                primary: primary,
                                                inboxCubit: inboxCubit,
                                                onTap: _openArchivedChats,
                                              ),
                                            ),
                                            if (pinned.isNotEmpty)
                                              SliverPadding(
                                                padding: EdgeInsets.fromLTRB(
                                                    16.w, 8.h, 16.w, 0),
                                                sliver: SliverToBoxAdapter(
                                                  child:
                                                      InboxAnimatedPriorityThreads(
                                                    threads: pinned,
                                                    isDark: isDark,
                                                    primary: primary,
                                                    onThreadTap: _openThread,
                                                    onArchive: _archiveThread,
                                                    onToggleRead:
                                                        _toggleReadThread,
                                                    onTogglePin:
                                                        _togglePinThread,
                                                    onMore: _openChatMore,
                                                  ),
                                                ),
                                              ),
                                            if (priority.isNotEmpty)
                                              SliverPadding(
                                                padding: EdgeInsets.fromLTRB(
                                                    16.w, 8.h, 16.w, 0),
                                                sliver: SliverToBoxAdapter(
                                                  child: _SectionLabel(
                                                    label: inboxCubit
                                                        .sectionTitleFor(
                                                      'priority',
                                                      context.tr(AppStrings
                                                          .priorityUpper),
                                                    ),
                                                    count: priority.length,
                                                    isDark: isDark,
                                                  ),
                                                ),
                                              ),
                                            if (priority.isNotEmpty)
                                              SliverPadding(
                                                padding: EdgeInsets.fromLTRB(
                                                    16.w, 8.h, 16.w, 0),
                                                sliver: SliverToBoxAdapter(
                                                  child:
                                                      InboxAnimatedPriorityThreads(
                                                    threads: priority,
                                                    isDark: isDark,
                                                    primary: primary,
                                                    onThreadTap: _openThread,
                                                    onArchive: _archiveThread,
                                                    onToggleRead:
                                                        _toggleReadThread,
                                                    onTogglePin:
                                                        _togglePinThread,
                                                    onMore: _openChatMore,
                                                  ),
                                                ),
                                              ),
                                            if (earlier.isNotEmpty)
                                              SliverPadding(
                                                padding: EdgeInsets.fromLTRB(
                                                    16.w,
                                                    8.h,
                                                    16.w,
                                                    0),
                                                sliver: SliverToBoxAdapter(
                                                  child: _SectionLabel(
                                                    label: inboxCubit
                                                        .sectionTitleFor(
                                                      'earlier',
                                                      context.tr(AppStrings
                                                          .earlierUpper),
                                                    ),
                                                    count: earlierCount,
                                                    isDark: isDark,
                                                  ),
                                                ),
                                              ),
                                            // Keep mounted (even when empty) so
                                            // archive / pin exit animations finish.
                                            SliverPadding(
                                              padding: EdgeInsets.fromLTRB(
                                                  16.w, 8.h, 16.w, 0),
                                              sliver: InboxGroupedThreadsCard(
                                                threads: earlier,
                                                isDark: isDark,
                                                primary: primary,
                                                asSliver: true,
                                                onThreadTap: _openThread,
                                                onArchive: _archiveThread,
                                                onToggleRead: _toggleReadThread,
                                                onTogglePin: _togglePinThread,
                                                onMore: _openChatMore,
                                              ),
                                            ),
                                            if (isLoadingMore)
                                              SliverToBoxAdapter(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 16.h),
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: 22.r,
                                                      height: 22.r,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: primary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            SliverToBoxAdapter(
                                              child: SizedBox(height: 100.h),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        // Compose overlay is shown via root [Overlay] so the
                        // blur covers bottom navigation tabs as well.
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

/// Pull-to-refresh with no spinner — drives the tabs progress bar only.
class _InboxSoftPullRefresh extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final Future<void> Function() onRefresh;
  final ValueChanged<double> onPullProgress;

  const _InboxSoftPullRefresh({
    required this.child,
    required this.enabled,
    required this.onRefresh,
    required this.onPullProgress,
  });

  @override
  State<_InboxSoftPullRefresh> createState() => _InboxSoftPullRefreshState();
}

class _InboxSoftPullRefreshState extends State<_InboxSoftPullRefresh> {
  static const double _threshold = 64;
  double _pullPx = 0;
  /// Peak pull for this gesture — survives bounce-back so we still refresh.
  double _maxPullPx = 0;
  bool _refreshing = false;
  bool _didHaptic = false;
  int _activePointers = 0;

  void _setPull(double px) {
    final next = px.clamp(0.0, _threshold * 1.6);
    _pullPx = next;
    if (next > _maxPullPx) {
      _maxPullPx = next;
      if (!_didHaptic && _maxPullPx >= _threshold) {
        _didHaptic = true;
        HapticFeedback.selectionClick();
      }
    }
    widget.onPullProgress((_pullPx / _threshold).clamp(0.0, 1.0));
  }

  void _clearGesture({required bool clearProgress}) {
    _pullPx = 0;
    _maxPullPx = 0;
    _didHaptic = false;
    if (clearProgress) widget.onPullProgress(0);
  }

  Future<void> _triggerRefresh() async {
    if (_refreshing) return;
    if (_maxPullPx < _threshold) {
      _clearGesture(clearProgress: true);
      return;
    }
    _refreshing = true;
    _clearGesture(clearProgress: true);
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) _refreshing = false;
    }
  }

  void _onFingerReleased() {
    if (_refreshing || !widget.enabled) return;
    if (_maxPullPx >= _threshold) {
      unawaited(_triggerRefresh());
    } else if (_maxPullPx > 0 || _pullPx > 0) {
      _clearGesture(clearProgress: true);
    }
  }

  bool _onNotification(ScrollNotification n) {
    if (_refreshing) return false;

    if (!widget.enabled) {
      if (_pullPx > 0 || _maxPullPx > 0) {
        _clearGesture(clearProgress: true);
      }
      return false;
    }

    if (n is ScrollUpdateNotification) {
      final m = n.metrics;
      final delta = n.scrollDelta ?? 0;

      // User scrolled into the list — cancel this gesture.
      if (m.pixels > 1) {
        if (_maxPullPx > 0 || _pullPx > 0) {
          _clearGesture(clearProgress: true);
        }
        return false;
      }

      if (m.pixels < 0) {
        // iOS / bouncing physics: overscroll is negative pixels.
        _setPull(-m.pixels);
      } else if (m.extentBefore <= 0 && delta < 0) {
        _setPull(_pullPx - delta);
      } else if (m.pixels <= 0 && delta > 0 && _pullPx > 0) {
        // Bounce-back: shrink the bar, but keep [_maxPullPx] for release.
        _setPull(_pullPx - delta);
      }
    } else if (n is OverscrollNotification) {
      if (n.metrics.pixels > 1) {
        if (_maxPullPx > 0 || _pullPx > 0) {
          _clearGesture(clearProgress: true);
        }
      } else if (n.overscroll < 0) {
        // Android clamping physics.
        _setPull(_pullPx - n.overscroll);
      } else if (n.overscroll > 0 && _pullPx > 0) {
        _setPull(_pullPx - n.overscroll);
      }
    } else if (n is ScrollEndNotification) {
      // Fallback when pointer-up wasn't seen (e.g. fling).
      if (_activePointers == 0) _onFingerReleased();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _activePointers++,
      onPointerUp: (_) {
        _activePointers = (_activePointers - 1).clamp(0, 32);
        if (_activePointers == 0) _onFingerReleased();
      },
      onPointerCancel: (_) {
        _activePointers = (_activePointers - 1).clamp(0, 32);
        if (_activePointers == 0) _onFingerReleased();
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (n) {
          n.disallowIndicator();
          return true;
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: _onNotification,
          child: widget.child,
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const _SearchField({
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Ink(
          height: 42.h,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isDark
                  ? HomeDashboardColors.border(true).withOpacity(0.7)
                  : const Color(0xFFE5E7EB),
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 16.sp,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    context.tr(AppStrings.searchChatsAndMessages),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 11.sp,
                  color: HomeDashboardColors.subtitle(isDark).withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontal chip row with edge fades + trailing chevron so overflow
/// clearly reads as scrollable.
class _ScrollHintChipRow extends StatefulWidget {
  final List<Widget> children;
  final bool isDark;

  const _ScrollHintChipRow({
    required this.children,
    required this.isDark,
  });

  @override
  State<_ScrollHintChipRow> createState() => _ScrollHintChipRowState();
}

class _ScrollHintChipRowState extends State<_ScrollHintChipRow> {
  final ScrollController _controller = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateHints);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateHints());
  }

  @override
  void didUpdateWidget(covariant _ScrollHintChipRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateHints());
  }

  @override
  void dispose() {
    _controller.removeListener(_updateHints);
    _controller.dispose();
    super.dispose();
  }

  void _updateHints() {
    if (!mounted || !_controller.hasClients) return;
    final pos = _controller.position;
    final max = pos.maxScrollExtent;
    final left = pos.pixels > 2;
    final right = max > 2 && pos.pixels < max - 2;
    if (left != _canScrollLeft || right != _canScrollRight) {
      setState(() {
        _canScrollLeft = left;
        _canScrollRight = right;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = HomeDashboardColors.scaffold(widget.isDark);
    final fadeWidth = 28.w;

    return Stack(
      children: [
        ListView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.only(
            left: 16.w,
            right: (_canScrollRight ? 28.w : 16.w),
          ),
          children: widget.children,
        ),
        // Left fade — more content behind
        IgnorePointer(
          child: AnimatedOpacity(
            opacity: _canScrollLeft ? 1 : 0,
            duration: const Duration(milliseconds: 180),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: fadeWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      scaffold,
                      scaffold.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Right fade + chevron cue
        IgnorePointer(
          child: AnimatedOpacity(
            opacity: _canScrollRight ? 1 : 0,
            duration: const Duration(milliseconds: 180),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 36.w,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      width: fadeWidth + 8.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            scaffold,
                            scaffold.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Container(
                        width: 18.r,
                        height: 18.r,
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? const Color(0xFF2A2A2E)
                              : const Color(0xFFE8E8ED),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          size: 14.sp,
                          color: HomeDashboardColors.subtitle(widget.isDark),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final bool isDark;
  final Color primary;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.isDark,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? primary
          : (isDark ? const Color(0xFF2A2A2E) : const Color(0xFFF3F4F6)),
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : HomeDashboardColors.title(isDark),
                ),
              ),
              if (count > 0) ...[
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white.withOpacity(0.22)
                        : primary.withOpacity(isDark ? 0.28 : 0.14),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final int count;
  final bool isDark;

  const _SectionLabel({
    required this.label,
    required this.count,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final line = HomeDashboardColors.border(isDark).withOpacity(0.7);
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(child: Divider(color: line, thickness: 1, height: 1)),
        SizedBox(width: 8.w),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
      ],
    );
  }
}


/// Shows the Archived row only when there is at least one archived chat,
/// with a short entrance animation when it first appears.
class _ArchivedChatsEntryGate extends StatefulWidget {
  final bool isDark;
  final Color primary;
  final InboxCubit inboxCubit;
  final VoidCallback onTap;

  const _ArchivedChatsEntryGate({
    required this.isDark,
    required this.primary,
    required this.inboxCubit,
    required this.onTap,
  });

  @override
  State<_ArchivedChatsEntryGate> createState() =>
      _ArchivedChatsEntryGateState();
}

class _ArchivedChatsEntryGateState extends State<_ArchivedChatsEntryGate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _visible = false;
  bool _listenAttached = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed && mounted) {
          setState(() {});
        }
      });
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _syncVisibility(animate: false);
    widget.inboxCubit.archivedRevision.addListener(_onArchiveChanged);
    ChatArchivePrefs.revision.addListener(_onArchiveChanged);
    _listenAttached = true;
  }

  @override
  void didUpdateWidget(covariant _ArchivedChatsEntryGate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inboxCubit != widget.inboxCubit) {
      oldWidget.inboxCubit.archivedRevision.removeListener(_onArchiveChanged);
      widget.inboxCubit.archivedRevision.addListener(_onArchiveChanged);
      _syncVisibility(animate: false);
    }
  }

  @override
  void dispose() {
    if (_listenAttached) {
      widget.inboxCubit.archivedRevision.removeListener(_onArchiveChanged);
      ChatArchivePrefs.revision.removeListener(_onArchiveChanged);
    }
    _controller.dispose();
    super.dispose();
  }

  bool get _hasArchived =>
      ChatArchivePrefs.count > 0 || widget.inboxCubit.archivedThreads.isNotEmpty;

  void _onArchiveChanged() {
    if (!mounted) return;
    _syncVisibility(animate: true);
  }

  void _syncVisibility({required bool animate}) {
    final next = _hasArchived;
    if (next == _visible) {
      if (next && _controller.status == AnimationStatus.dismissed) {
        _controller.value = 1;
      }
      if (mounted) setState(() {});
      return;
    }
    _visible = next;
    if (!mounted) return;
    setState(() {});
    if (!animate) {
      _controller.value = next ? 1 : 0;
      return;
    }
    if (next) {
      _controller.forward(from: 0);
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: !_visible && _controller.isDismissed
          ? const SizedBox.shrink()
          : FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 0),
                  child: _ArchivedChatsEntry(
                    isDark: widget.isDark,
                    primary: widget.primary,
                    unreadCount: ChatArchivePrefs.unreadTotal,
                    onTap: widget.onTap,
                  ),
                ),
              ),
            ),
    );
  }
}

/// Clean WhatsApp-style archived entry — unread badge only when needed.
class _ArchivedChatsEntry extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final int unreadCount;
  final VoidCallback onTap;

  const _ArchivedChatsEntry({
    required this.isDark,
    required this.primary,
    required this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = HomeDashboardColors.title(isDark);
    final muted = HomeDashboardColors.subtitle(isDark);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
          child: Row(
            children: [
              Icon(
                Icons.archive_outlined,
                size: 18.sp,
                color: muted,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  context.tr(AppStrings.archivedChats),
                  style: TextStyle(
                    color: title,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                ),
              ),
              if (unreadCount > 0) ...[
                Container(
                  constraints: BoxConstraints(minWidth: 18.r, minHeight: 18.r),
                  padding: EdgeInsets.symmetric(
                    horizontal: unreadCount > 9 ? 5.w : 0,
                  ),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    unreadCount > 99 ? '99+' : '$unreadCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
              ],
              Icon(
                Icons.chevron_right_rounded,
                size: 18.sp,
                color: muted.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
