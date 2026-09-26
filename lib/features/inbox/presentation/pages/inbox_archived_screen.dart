import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/widgets/inbox_thread_tiles.dart';
import 'package:get_it/get_it.dart';

import '../../../../exports.dart';

/// Archived chats — same realtime row behavior as the main chats list.
class InboxArchivedScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const InboxArchivedScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<InboxArchivedScreen> createState() => _InboxArchivedScreenState();
}

class _InboxArchivedScreenState extends State<InboxArchivedScreen> {
  bool _loading = true;
  InboxCubit? _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _cubit = context.read<InboxCubit>();
      _cubit!.setArchivedScreenActive(true);
      unawaited(_load());
    });
  }

  @override
  void dispose() {
    _cubit?.setArchivedScreenActive(false);
    super.dispose();
  }

  Future<void> _load() async {
    final cubit = _cubit ?? context.read<InboxCubit>();
    setState(() => _loading = true);
    await cubit.loadArchivedThreads();
    if (!mounted) return;
    setState(() => _loading = false);
  }

  InboxCubit get _requireCubit =>
      _cubit ?? context.read<InboxCubit>();

  void _openThread(InboxThread thread) {
    if (!thread.opensAsChatRoom) return;
    final cubit = _requireCubit;
    if (thread.conversationId != null) {
      cubit.markConversationRead(thread.conversationId!);
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
    )
        .then((_) {
      if (!mounted) return;
      try {
        if (GetIt.I.isRegistered<ChatRealtimeService>()) {
          GetIt.I<ChatRealtimeService>().clearActiveChat();
        }
      } catch (_) {}
      // Soft refresh so unread/presence stay in sync after leaving the room.
      unawaited(cubit.loadArchivedThreads());
    });
  }

  Future<void> _unarchive(InboxThread thread) async {
    final ok = await _requireCubit.unarchiveThread(thread);
    if (!mounted) return;
    if (!ok) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.unarchiveFailed),
      );
    }
  }

  Future<void> _toggleRead(InboxThread thread) async {
    final cubit = _requireCubit;
    if (thread.unreadCount > 0) {
      await cubit.markThreadRead(thread);
    } else {
      await cubit.markThreadUnread(thread);
    }
  }

  Future<void> _togglePin(InboxThread thread) async {
    final cubit = _requireCubit;
    final ok = await cubit.pinThread(
      thread,
      pinned: !thread.isPinned,
    );
    if (!mounted || ok) return;
    customSnackBar(
      context: context,
      message: context.tr(AppStrings.pinFailed),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = _cubit ?? context.read<InboxCubit>();
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final title = HomeDashboardColors.title(isDark);
        final subtitle = HomeDashboardColors.subtitle(isDark);

        return Scaffold(
          backgroundColor: scaffold,
          appBar: AppBar(
            backgroundColor: scaffold,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
              color: title,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              context.tr(AppStrings.archivedChats),
              style: TextStyle(
                color: title,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: ValueListenableBuilder<int>(
            valueListenable: cubit.archivedRevision,
            builder: (context, _, __) {
              final threads = cubit.archivedThreads;
              if (_loading && threads.isEmpty) {
                return Center(child: CircularProgressIndicator(color: primary));
              }
              return RefreshIndicator(
                color: primary,
                onRefresh: _load,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                  children: [
                    InboxGroupedThreadsCard(
                      threads: threads,
                      isDark: isDark,
                      primary: primary,
                      isArchivedList: true,
                      onThreadTap: _openThread,
                      onArchive: _unarchive,
                      onToggleRead: _toggleRead,
                      onTogglePin: _togglePin,
                      emptyPlaceholder: Padding(
                        padding: EdgeInsets.only(top: 120.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.archive_outlined,
                              size: 42.sp,
                              color: subtitle,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              context.tr(AppStrings.noArchivedChats),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: title,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                context.tr(AppStrings.noArchivedChatsSubtitle),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: subtitle,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
