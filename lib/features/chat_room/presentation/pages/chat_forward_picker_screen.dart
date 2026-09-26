import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_state.dart';
import 'package:get_it/get_it.dart';

class ChatForwardPickerScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final List<ChatMessageItem> messages;
  final int? sourceConversationId;
  final String? excludeChatType;
  final int? excludeContextId;

  const ChatForwardPickerScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.messages,
    this.sourceConversationId,
    this.excludeChatType,
    this.excludeContextId,
  });

  @override
  State<ChatForwardPickerScreen> createState() =>
      _ChatForwardPickerScreenState();
}

class _ChatForwardPickerScreenState extends State<ChatForwardPickerScreen> {
  String _query = '';
  bool _sending = false;

  List<InboxThread> _threadsOf(InboxCubit cubit) {
    return cubit.state.maybeWhen(
      loaded: (threads, _, __, ___, ____, _____, ______, _______) => threads,
      orElse: () => const <InboxThread>[],
    );
  }

  String _previewFor(ChatMessageItem msg) {
    final text = msg.text.trim();
    if (text.isNotEmpty &&
        text != '[Image]' &&
        text != '[Voice]' &&
        text != '[File]' &&
        text != '[Voice message]' &&
        text != '[Photo]' &&
        text != '[Attachment]' &&
        !text.startsWith('[File:')) {
      return text;
    }
    if (msg.attachments.any((a) => a.isImage)) return '[Image]';
    if (msg.attachments.any((a) => a.isVoice)) return '[Voice]';
    if (msg.attachments.any((a) => a.isFile)) return '[File]';
    return text.isEmpty ? '[Message]' : text;
  }

  Future<int?> _resolveConversationId({
    required ChatRoomRepository repo,
    required String chatType,
    required int contextId,
    int? conversationId,
  }) async {
    if (conversationId != null && conversationId > 0) return conversationId;
    final result = await repo.getConversation(
      contextId: contextId,
      chatType: chatType,
    );
    return result.fold((_) => null, (r) => r.data?.id);
  }

  Future<void> _forwardTo(InboxThread thread) async {
    if (_sending) return;
    final chatType = thread.resolvedChatType;
    final contextId = thread.resolvedContextId;
    if (chatType == null || contextId == null) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.comingSoon),
      );
      return;
    }

    final toSend = widget.messages;
    if (toSend.isEmpty) return;

    final cannotForwardLabel = context.tr(AppStrings.cannotForwardMedia);
    setState(() => _sending = true);

    final repo = GetIt.I<ChatRoomRepository>();

    // Source conversation that owns the message(s).
    var sourceConversationId = widget.sourceConversationId;
    if (sourceConversationId == null || sourceConversationId <= 0) {
      if (widget.excludeChatType != null && widget.excludeContextId != null) {
        sourceConversationId = await _resolveConversationId(
          repo: repo,
          chatType: widget.excludeChatType!,
          contextId: widget.excludeContextId!,
        );
      }
    }
    if (!mounted) return;
    if (sourceConversationId == null || sourceConversationId <= 0) {
      setState(() => _sending = false);
      customSnackBar(
        context: context,
        message: cannotForwardLabel,
      );
      return;
    }

    final targetConversationId = await _resolveConversationId(
      repo: repo,
      chatType: chatType,
      contextId: contextId,
      conversationId: thread.conversationId,
    );
    if (!mounted) return;
    if (targetConversationId == null) {
      setState(() => _sending = false);
      customSnackBar(
        context: context,
        message: cannotForwardLabel,
      );
      return;
    }

    var forwarded = 0;
    String? lastFailure;
    String? lastPreview;
    var lastPreviewCount = 1;

    for (final msg in toSend) {
      final messageId = int.tryParse(msg.id);
      if (messageId == null || msg.isDeleted || msg.isSystem) {
        lastFailure = cannotForwardLabel;
        continue;
      }

      final result = await repo.forwardMessage(
        conversationId: sourceConversationId,
        messageId: messageId,
        chatType: chatType,
        contextId: contextId,
      );

      final failed = result.fold(
        (f) => f.message,
        (response) {
          if (response.value == false) {
            return response.message ?? cannotForwardLabel;
          }
          return null;
        },
      );
      if (failed != null) {
        lastFailure = failed;
        continue;
      }

      forwarded++;
      lastPreview = _previewFor(msg);
      lastPreviewCount = msg.attachments.where((a) => a.isImage).length;
      if (lastPreviewCount < 1) lastPreviewCount = 1;
    }

    if (!mounted) return;
    setState(() => _sending = false);

    if (forwarded == 0) {
      customSnackBar(
        context: context,
        message: lastFailure ?? cannotForwardLabel,
      );
      return;
    }

    try {
      final inbox = GetIt.I<InboxCubit>();
      inbox.applyOutgoingPreview(
        chatType: chatType,
        contextId: contextId,
        conversationId: targetConversationId,
        preview: lastPreview ?? '[Message]',
        previewCount: lastPreviewCount,
      );
      inbox.markConversationRead(targetConversationId);
    } catch (_) {}

    final chatArgs = AppRoutesArgs.chatRoomRouteArgs(
      currentDoctorModel: widget.currentDoctorModel,
      homeDataModel: widget.homeDataModel,
      peerDisplayName: thread.title,
      peerInitials: thread.initials,
      peerVerified: thread.isVerified,
      peerIsOnline: thread.isOnline,
      chatType: chatType,
      contextId: contextId,
      conversationId: targetConversationId,
      peerImageUrl: thread.imageUrl,
    );

    // Close picker, then open the destination chat (WhatsApp-style).
    final nav = navigatorKey.currentState;
    if (nav != null) {
      nav.pop(true);
      nav.pushNamed(AppRoutes.chatRoom, arguments: chatArgs);
    } else if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final bg = isDark ? AppColors.darkScaffoldBG : Colors.white;
        final titleColor = isDark ? AppColors.darkTitle : AppColors.title;
        final subColor =
            isDark ? AppColors.darkDescription : AppColors.description;

        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: bg,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.close_rounded,
                  color: AppColors.primary, size: 22.sp),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              context.tr(AppStrings.forwardTo),
              style: TextStyle(
                color: titleColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: BlocBuilder<InboxCubit, InboxState>(
            builder: (context, state) {
              final cubit = context.read<InboxCubit>();
              final all = _threadsOf(cubit).where((t) {
                if (!t.opensAsChatRoom) return false;
                if (widget.excludeChatType != null &&
                    widget.excludeContextId != null &&
                    t.resolvedChatType == widget.excludeChatType &&
                    t.resolvedContextId == widget.excludeContextId) {
                  return false;
                }
                return true;
              }).toList();

              final q = _query.trim().toLowerCase();
              final threads = q.isEmpty
                  ? all
                  : all
                      .where((t) => t.title.toLowerCase().contains(q))
                      .toList();

              return Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: TextField(
                      onChanged: (v) => setState(() => _query = v),
                      decoration: InputDecoration(
                        hintText: context.tr(AppStrings.search),
                        prefixIcon: const Icon(Icons.search_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  if (_sending) const LinearProgressIndicator(minHeight: 2),
                  Expanded(
                    child: threads.isEmpty
                        ? Center(
                            child: Text(
                              context.tr(AppStrings.noResultsFound),
                              style: TextStyle(color: subColor),
                            ),
                          )
                        : ListView.separated(
                            itemCount: threads.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 1,
                              color: subColor.withOpacity(0.12),
                            ),
                            itemBuilder: (context, index) {
                              final t = threads[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 22.r,
                                  backgroundColor:
                                      AppColors.primary.withOpacity(0.15),
                                  child: t.imageUrl != null &&
                                          t.imageUrl!.isNotEmpty
                                      ? ClipOval(
                                          child: CustomCachedNetworkImage(
                                            imageUrl: t.imageUrl!,
                                            width: 44.r,
                                            height: 44.r,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Text(
                                          t.title.isNotEmpty
                                              ? t.title[0].toUpperCase()
                                              : '?',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ),
                                title: Text(
                                  t.title,
                                  style: TextStyle(
                                    color: titleColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onTap:
                                    _sending ? null : () => _forwardTo(t),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
