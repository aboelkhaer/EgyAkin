import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_input_bar.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_list.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_overlay.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_header.dart';
import 'package:file_picker/file_picker.dart';

class ChatRoomScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const ChatRoomScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<ChatMessageItem> _messages;
  int? _overlayMessageIndex;
  Rect? _overlayAnchorRect;

  // Demo peer until chat API provides recipient data.
  static const _peerFirstName = 'Mai';
  static const _peerLastName = 'Alaa';

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() => setState(() {}));
    _messages = _demoMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String get _peerDisplayName => doctorName(
        firstName: _peerFirstName,
        lastName: _peerLastName,
        role: 'Verified',
      );

  String get _peerInitials {
    final f = _peerFirstName.isNotEmpty ? _peerFirstName[0] : '';
    final l = _peerLastName.isNotEmpty ? _peerLastName[0] : '';
    return '$f$l'.toUpperCase();
  }

  bool get _peerVerified =>
      widget.homeDataModel.isSyndicateCardRequired == 'Verified' ||
      (widget.homeDataModel.verified ?? false);

  List<ChatMessageItem> _demoMessages() {
    return const [
      ChatMessageItem(
        id: '1',
        text:
            'Hi Dr. Ahmed, I\'ve reviewed the latest lab results for patient #4821. The creatinine levels have improved slightly.',
        timeLabel: '10:24 AM',
        isOutgoing: false,
        showAvatar: true,
      ),
      ChatMessageItem(
        id: '2',
        text:
            'That\'s great news, Dr. Mai. Should we adjust the dosage for the current medication?',
        timeLabel: '10:27 AM',
        isOutgoing: true,
        isRead: true,
      ),
      ChatMessageItem(
        id: '3',
        text:
            'Yes, I recommend reducing the dosage by 25% and scheduling a follow-up in two weeks.',
        timeLabel: '10:28 AM',
        isOutgoing: false,
        showAvatar: true,
      ),
      ChatMessageItem(
        id: '4',
        text: 'Understood. I will update the prescription accordingly.',
        timeLabel: '10:30 AM',
        isOutgoing: true,
        isRead: true,
        reactionEmoji: '👍',
      ),
    ];
  }

  void _showMessageOverlay(
    int index,
    ChatMessageItem message,
    Rect anchorRect,
  ) {
    setState(() {
      _overlayMessageIndex = index;
      _overlayAnchorRect = anchorRect;
    });
  }

  void _dismissMessageOverlay() {
    if (_overlayMessageIndex == null) return;
    setState(() {
      _overlayMessageIndex = null;
      _overlayAnchorRect = null;
    });
  }

  void _applyEmojiReaction(String emoji) {
    final index = _overlayMessageIndex;
    if (index == null || index >= _messages.length) return;
    setState(() {
      _messages = [
        for (var i = 0; i < _messages.length; i++)
          if (i == index)
            _messages[i].copyWith(reactionEmoji: emoji)
          else
            _messages[i],
      ];
      _overlayMessageIndex = null;
      _overlayAnchorRect = null;
    });
  }

  void _handleMessageAction(ChatMessageAction action) {
    final index = _overlayMessageIndex;
    if (index == null || index >= _messages.length) return;
    final message = _messages[index];

    switch (action) {
      case ChatMessageAction.copy:
        Clipboard.setData(ClipboardData(text: message.text));
        if (mounted) {
          customSnackBar(
            context: context,
            message: context.tr(AppStrings.messageCopied),
          );
        }
        break;
      case ChatMessageAction.delete:
        setState(() {
          _messages = [
            for (var i = 0; i < _messages.length; i++)
              if (i != index) _messages[i],
          ];
        });
        break;
      case ChatMessageAction.reply:
      case ChatMessageAction.forward:
      case ChatMessageAction.star:
      case ChatMessageAction.more:
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.comingSoon),
        );
        break;
    }
    _dismissMessageOverlay();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages = [
        ..._messages,
        ChatMessageItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          timeLabel: _formatTime(DateTime.now()),
          isOutgoing: true,
          isRead: false,
        ),
      ];
      _messageController.clear();
    });
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  Future<void> _pickAttachment() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (!mounted || result == null || result.files.isEmpty) return;
      customSnackBar(
        context: context,
        message: '${result.files.length} file(s) selected',
      );
    } catch (_) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.somethingWentWrong),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        final header = ChatRoomHeader(
          displayName: _peerDisplayName,
          initials: _peerInitials,
          isVerified: _peerVerified,
          isOnline: true,
          onCall: () {
            customSnackBar(
              context: context,
              message: context.tr(AppStrings.comingSoon),
            );
          },
          onInfo: () {
            customSnackBar(
              context: context,
              message: context.tr(AppStrings.comingSoon),
            );
          },
        );

        final selectedId = _overlayMessageIndex != null
            ? _messages[_overlayMessageIndex!].id
            : null;

        return Scaffold(
          backgroundColor:
              isDarkMode ? AppColors.darkScaffoldBG : AppColors.scaffoldBG,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              SafeArea(
                child: Column(
                  children: [
                    header,
                    Expanded(
                      child: ChatMessageList(
                        messages: _messages,
                        peerInitials: _peerInitials,
                        selectedMessageId: selectedId,
                        onMessageLongPress: _showMessageOverlay,
                      ),
                    ),
                    ChatInputBar(
                      controller: _messageController,
                      hasText: _messageController.text.trim().isNotEmpty,
                      onAttach: _pickAttachment,
                      onRecordOrSend: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          _sendMessage();
                        } else {
                          customSnackBar(
                            context: context,
                            message: context.tr(AppStrings.comingSoon),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              if (_overlayMessageIndex != null && _overlayAnchorRect != null)
                ChatMessageOverlay(
                  key: ValueKey(_messages[_overlayMessageIndex!].id),
                  message: _messages[_overlayMessageIndex!],
                  anchorRect: _overlayAnchorRect!,
                  peerInitials: _peerInitials,
                  onDismiss: _dismissMessageOverlay,
                  onEmojiSelected: _applyEmojiReaction,
                  onAction: _handleMessageAction,
                ),
            ],
          ),
        );
      },
    );
  }
}
