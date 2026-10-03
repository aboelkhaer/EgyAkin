import 'dart:io';

import 'package:egy_akin/exports.dart' hide ImageSource;
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity_labels.dart';
import 'package:egy_akin/features/chat/data/services/chat_block_service.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_cubit.dart';
import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_state.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_panel.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_emoji_panel.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_input_bar.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_list.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_background.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_loading_shimmer.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_message_overlay.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_header.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_selection_header.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_delete_messages_sheet.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_reactions_bottom_sheet.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_reply_banner.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_pending_images_banner.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_seen_by_sheet.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_typing_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class ChatRoomScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String? peerDisplayName;
  final String? peerInitials;
  final bool? peerVerified;
  final bool? peerIsOnline;
  final String? chatType;
  final int? contextId;
  final int? conversationId;
  final String? peerImageUrl;
  /// When set, scrolls to and flashes this message after the room loads.
  final String? focusMessageId;

  const ChatRoomScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.peerDisplayName,
    this.peerInitials,
    this.peerVerified,
    this.peerIsOnline,
    this.chatType,
    this.contextId,
    this.conversationId,
    this.peerImageUrl,
    this.focusMessageId,
  });

  bool get usesApi => chatType != null && contextId != null;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin, RouteAware {
  static final ValueNotifier<int> _noBlockRevision = ValueNotifier<int>(0);
  static const Duration _chromeAnimDuration = Duration(milliseconds: 280);
  static const Duration _composerSwapDuration = Duration(milliseconds: 420);

  ChatRoomCubit? _chatCubit;
  bool _routeObserved = false;
  bool _isUnblocking = false;

  final HashtagTextEditingController _messageController =
      HashtagTextEditingController(
    hashtagStyle: const TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Tajawal',
      height: 1.2,
    ),
  );
  final FocusNode _messageFocusNode = FocusNode();
  late List<ChatMessageItem> _messages = [];
  int? _overlayMessageIndex;
  Rect? _overlayAnchorRect;
  bool _attachmentPanelOpen = false;
  bool _emojiPanelOpen = false;

  /// Panel still painted while its close animation finishes.
  bool _closingAttachmentPanel = false;
  bool _closingEmojiPanel = false;

  /// Last known system keyboard height — emoji/attach panels match this.
  double _keyboardHeight = 0;

  /// Keep composer elevated while the system keyboard is animating in
  /// (emoji/attach → keyboard), so the field never drops to the bottom.
  bool _holdingKeyboardInset = false;
  Timer? _holdKeyboardInsetTimer;
  late final AnimationController _chromeController;
  Animation<double>? _chromeAnimation;
  double _chromeHeight = 0;
  bool _chromeAnimating = false;
  bool _restoreKeyboardAfterOverlay = false;
  bool _overlayLockPosition = true;
  bool _overlayAnchorFromBottom = false;
  double _keyboardInsetAtOverlayOpen = 0;
  double _headerOverlayHeight = 0;
  final ImagePicker _imagePicker = ImagePicker();
  final Map<int, GlobalKey> _messageTileKeys = {};
  final GlobalKey<ChatMessageListState> _messageListKey =
      GlobalKey<ChatMessageListState>();
  String? _flashMessageId;
  bool _isSeekingMessage = false;
  bool _didHandleFocusMessage = false;
  String? _headerDisplayName;
  String? _headerImageUrl;
  bool _selectionMode = false;
  ChatSelectionIntent? _selectionIntent;
  final Set<String> _selectedMessageIds = {};
  /// Images staged for send via the normal composer (reply-style banner).
  final List<File> _pendingImages = [];

  // Demo peer until chat API provides recipient data.
  static const _fallbackPeerFirstName = 'Mai';
  static const _fallbackPeerLastName = 'Alaa';

  String get _peerDisplayName =>
      _headerDisplayName ??
      widget.peerDisplayName ??
      doctorName(
        firstName: _fallbackPeerFirstName,
        lastName: _fallbackPeerLastName,
        role: 'Verified',
      );

  String? get _peerImageUrl => _headerImageUrl ?? widget.peerImageUrl;

  String? _resolvedPeerImageUrl(BuildContext context) {
    final local = _peerImageUrl?.trim();
    if (local != null && local.isNotEmpty) return local;
    if (!widget.usesApi) return null;
    try {
      final fromCubit = context.read<ChatRoomCubit>().peerImageUrl?.trim();
      if (fromCubit != null && fromCubit.isNotEmpty) return fromCubit;
    } catch (_) {}
    return null;
  }

  String get _peerInitials {
    if (widget.peerInitials != null && widget.peerInitials!.isNotEmpty) {
      return widget.peerInitials!;
    }
    final f =
        _fallbackPeerFirstName.isNotEmpty ? _fallbackPeerFirstName[0] : '';
    final l = _fallbackPeerLastName.isNotEmpty ? _fallbackPeerLastName[0] : '';
    return '$f$l'.toUpperCase();
  }

  bool get _peerVerified {
    // Verification badge is for private doctor chats only — not groups.
    if (_isGroupChat) return false;
    return widget.peerVerified ??
        (widget.homeDataModel.isSyndicateCardRequired == 'Verified' ||
            (widget.homeDataModel.verified ?? false));
  }

  /// Never default to online — that caused Online→Offline flicker while loading.
  bool get _peerIsOnline => widget.peerIsOnline ?? false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _messageFocusNode.addListener(_onComposerFocusChanged);
    _chromeController = AnimationController(
      vsync: this,
      duration: _chromeAnimDuration,
    );
    _chromeController.addListener(_onChromeAnimationTick);
    _chromeController.addStatusListener(_onChromeAnimationStatus);
    if (widget.usesApi) {
      // Cubit.init already kicks off loadMessages; keep a safety call for
      // routes that mount without going through init.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final cubit = context.read<ChatRoomCubit>();
        cubit.state.maybeWhen(
          initial: () => cubit.loadMessages(),
          orElse: () {},
        );
      });
    } else {
    _messages = _demoMessages();
      _scheduleFocusMessageJump();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _chromeHeight = _idleChromeHeight(context);
    });
  }

  void _scheduleFocusMessageJump() {
    final target = widget.focusMessageId?.trim();
    if (target == null || target.isEmpty || _didHandleFocusMessage) return;
    _didHandleFocusMessage = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      // Let the list finish its first layout after load.
      await Future<void>.delayed(const Duration(milliseconds: 180));
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;
      await _jumpToMessageId(target);
    });
  }

  void _onChromeAnimationTick() {
    if (!mounted || _chromeAnimation == null) return;
    setState(() => _chromeHeight = _chromeAnimation!.value);
  }

  void _onChromeAnimationStatus(AnimationStatus status) {
    // Ignore dismissed — forward(from: 0) emits it when restarting.
    if (status != AnimationStatus.completed) return;
    if (!mounted) return;
    setState(() {
      _chromeAnimating = false;
      _closingAttachmentPanel = false;
      _closingEmojiPanel = false;
    });
  }

  void _onComposerFocusChanged() {
    if (_messageFocusNode.hasFocus &&
        (_isBottomPanelOpen || _closingAttachmentPanel || _closingEmojiPanel)) {
      _chromeController.stop();
      _chromeAnimating = false;
      _closingAttachmentPanel = false;
      _closingEmojiPanel = false;
      setState(() {
        _emojiPanelOpen = false;
        _attachmentPanelOpen = false;
        _holdingKeyboardInset = true;
      });
      _armKeyboardInsetHold();
    }
  }

  void _rememberKeyboardHeight(BuildContext context) {
    final inset = _liveKeyboardInset(context);
    // Only grow — while the keyboard dismisses, insets shrink through
    // intermediate values; storing those made the attach/emoji panel shorter
    // than the real keyboard next time.
    if (inset >= 180 && inset > _keyboardHeight) {
      _keyboardHeight = inset;
    }
  }

  /// Prefer the larger of MediaQuery + platform viewInsets (most reliable).
  double _liveKeyboardInset(BuildContext context) {
    final mqInset = MediaQuery.viewInsetsOf(context).bottom;
    double platformInset = 0;
    final views = WidgetsBinding.instance.platformDispatcher.views;
    if (views.isNotEmpty) {
      final view = views.first;
      platformInset = view.viewInsets.bottom / view.devicePixelRatio;
    }
    return mqInset > platformInset ? mqInset : platformInset;
  }

  bool get _isBottomPanelOpen => _attachmentPanelOpen || _emojiPanelOpen;

  bool get _isRenderingAttachmentPanel =>
      _attachmentPanelOpen || _closingAttachmentPanel;

  bool get _isRenderingEmojiPanel => _emojiPanelOpen || _closingEmojiPanel;

  /// Shared height for emoji + attachment panels (= last full keyboard height).
  double _composerPanelHeight(BuildContext context) {
    if (_keyboardHeight >= 180) return _keyboardHeight;
    final screenH = MediaQuery.sizeOf(context).height;
    return (screenH * 0.42).clamp(280.0, 360.0);
  }

  double _idleChromeHeight(BuildContext context) {
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    final safe = MediaQuery.viewPaddingOf(context).bottom;
    return inset > safe ? inset : safe;
  }

  /// WhatsApp: reserve bottom space for keyboard OR our panel — never collapse
  /// the composer to the screen bottom while switching.
  double _bottomInset(BuildContext context) {
    if (_chromeAnimating) return _chromeHeight;

    if (_isBottomPanelOpen || _holdingKeyboardInset) {
      return _composerPanelHeight(context);
    }

    return _idleChromeHeight(context);
  }

  void _animateChromeHeight({
    required double from,
    required double to,
  }) {
    if ((from - to).abs() < 1) {
      _chromeController.stop();
      _chromeAnimating = false;
      _chromeHeight = to;
      if (mounted) setState(() {});
      return;
    }
    // Match keyboard feel: longer travel ≈ ~280ms.
    final distance = (to - from).abs();
    final ms = (180 + (distance / 360) * 120).clamp(180, 300).round();
    _chromeController.duration = Duration(milliseconds: ms);
    _chromeAnimating = true;
    _chromeHeight = from;
    _chromeAnimation = Tween<double>(begin: from, end: to).animate(
      CurvedAnimation(
        parent: _chromeController,
        curve: Curves.easeOutCubic,
      ),
    );
    _chromeController.forward(from: 0);
    if (mounted) setState(() {});
  }

  void _armKeyboardInsetHold() {
    _holdKeyboardInsetTimer?.cancel();
    // Safety: if the keyboard never opens, don't leave empty space forever.
    _holdKeyboardInsetTimer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted || !_holdingKeyboardInset) return;
      setState(() => _holdingKeyboardInset = false);
    });
  }

  void _releaseKeyboardInsetHoldIfReady(double inset) {
    if (!_holdingKeyboardInset || !mounted) return;
    final held = _composerPanelHeight(context);
    // Wait until the keyboard is essentially at full height.
    if (inset < held - 2) return;
    _holdKeyboardInsetTimer?.cancel();
    _holdKeyboardInsetTimer = null;
    setState(() => _holdingKeyboardInset = false);
  }

  void _showSystemKeyboardFromPanel() {
    _chromeController.stop();
    _chromeAnimating = false;
    _closingAttachmentPanel = false;
    _closingEmojiPanel = false;
    setState(() {
      _attachmentPanelOpen = false;
      _emojiPanelOpen = false;
      _holdingKeyboardInset = true;
    });
    _armKeyboardInsetHold();
    // Focus after this frame so the held inset is committed first.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _messageFocusNode.requestFocus();
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final views = WidgetsBinding.instance.platformDispatcher.views;
    if (views.isEmpty) return;
    final view = views.first;
    final inset = view.viewInsets.bottom / view.devicePixelRatio;
    // Only record the peak keyboard height (ignore dismiss animation).
    if (inset >= 180 && inset > _keyboardHeight) {
      _keyboardHeight = inset;
    }
    if (!_holdingKeyboardInset || !mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_holdingKeyboardInset) return;
      _releaseKeyboardInsetHoldIfReady(inset);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // While we were backgrounded, peer push-ack → delivered may have fired
    // on Ably without us. Soft-refresh to pick up ✓✓ / seen.
    if (state == AppLifecycleState.resumed && widget.usesApi && mounted) {
      unawaited(context.read<ChatRoomCubit>().loadMessages(refresh: false));
    }
  }

  List<ChatMessageItem> _messagesFromState(ChatRoomState state) {
    return state.maybeWhen(
      loaded: (messages, _, __, ___, ____, _____, ______, ________, _________,
              __________, ___________, ____________) =>
          messages,
      orElse: () => const [],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.usesApi) _chatCubit ??= context.read<ChatRoomCubit>();
    if (!_routeObserved) {
      final route = ModalRoute.of(context);
      if (route != null) {
        appRouteObserver.subscribe(this, route);
        _routeObserved = true;
      }
    }
  }

  /// A chat pushed on top of this one (push tap / forward) just closed.
  @override
  void didPopNext() {
    _chatCubit?.onVisibleAgain();
  }

  void _clearActiveChat() {
    try {
      if (GetIt.I.isRegistered<ChatRealtimeService>()) {
        GetIt.I<ChatRealtimeService>().clearActiveChat(
          conversationId: _chatCubit?.conversationId ?? widget.conversationId,
        );
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_routeObserved) appRouteObserver.unsubscribe(this);
    // Clear active chat immediately so inbox treats new messages as unread
    // (don't wait for async Cubit.close / getMessages).
    _clearActiveChat();
    _messageFocusNode.removeListener(_onComposerFocusChanged);
    _holdKeyboardInsetTimer?.cancel();
    _chromeController
      ..removeListener(_onChromeAnimationTick)
      ..removeStatusListener(_onChromeAnimationStatus)
      ..dispose();
    _messageFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
    _holdKeyboardInsetTimer?.cancel();
    _holdKeyboardInsetTimer = null;
    if (_attachmentPanelOpen || _emojiPanelOpen) {
      _closePanelsAnimated();
      return;
    }
    if (_holdingKeyboardInset) {
      setState(() => _holdingKeyboardInset = false);
    }
  }

  void _closePanelsAnimated() {
    if (!_isBottomPanelOpen && !_chromeAnimating) return;
    final from = _bottomInset(context);
    final to = MediaQuery.viewPaddingOf(context).bottom;
    final closingAttach = _attachmentPanelOpen || _closingAttachmentPanel;
    final closingEmoji = _emojiPanelOpen || _closingEmojiPanel;
    setState(() {
      _attachmentPanelOpen = false;
      _emojiPanelOpen = false;
      _holdingKeyboardInset = false;
      _closingAttachmentPanel = closingAttach;
      _closingEmojiPanel = closingEmoji;
    });
    _animateChromeHeight(from: from, to: to);
  }

  void _openAttachmentPanel() {
    // Capture full keyboard height BEFORE unfocus (dismiss shrinks insets).
    _rememberKeyboardHeight(context);
    final live = _liveKeyboardInset(context);
    if (live >= 180) _keyboardHeight = live;
    _holdKeyboardInsetTimer?.cancel();
    _holdKeyboardInsetTimer = null;

    final from = _bottomInset(context);
    final to = _composerPanelHeight(context);
    final comingFromKeyboard = live >= 180;
    final alreadyAtPanelHeight = (from - to).abs() < 1;

    setState(() {
      _emojiPanelOpen = false;
      _closingEmojiPanel = false;
      _closingAttachmentPanel = false;
      _attachmentPanelOpen = true;
      _holdingKeyboardInset = false;
    });
    FocusManager.instance.primaryFocus?.unfocus();

    // Keyboard → panel (or panel ↔ panel): height already matches.
    // Idle → panel: slide up like the keyboard.
    if (!comingFromKeyboard && !alreadyAtPanelHeight) {
      _animateChromeHeight(from: from, to: to);
    } else {
      _chromeController.stop();
      _chromeAnimating = false;
      _chromeHeight = to;
    }
  }

  void _openKeyboardFromAttachment() {
    if (!_attachmentPanelOpen && !_emojiPanelOpen) return;
    _showSystemKeyboardFromPanel();
  }

  void _onAttachButtonPressed() {
    if (_attachmentPanelOpen) {
      _openKeyboardFromAttachment();
      return;
    }
    _openAttachmentPanel();
  }

  void _closeAttachmentPanel() {
    if (!_attachmentPanelOpen && !_closingAttachmentPanel) return;
    _closePanelsAnimated();
  }

  void _toggleEmojiPanel() {
    if (_emojiPanelOpen) {
      _showSystemKeyboardFromPanel();
      return;
    }
    _rememberKeyboardHeight(context);
    final live = _liveKeyboardInset(context);
    if (live >= 180) _keyboardHeight = live;
    _holdKeyboardInsetTimer?.cancel();
    _holdKeyboardInsetTimer = null;

    final from = _bottomInset(context);
    final to = _composerPanelHeight(context);
    final comingFromKeyboard = live >= 180;
    final alreadyAtPanelHeight = (from - to).abs() < 1;

    setState(() {
      _attachmentPanelOpen = false;
      _closingAttachmentPanel = false;
      _closingEmojiPanel = false;
      _emojiPanelOpen = true;
      _holdingKeyboardInset = false;
    });
    FocusManager.instance.primaryFocus?.unfocus();

    if (!comingFromKeyboard && !alreadyAtPanelHeight) {
      _animateChromeHeight(from: from, to: to);
    } else {
      _chromeController.stop();
      _chromeAnimating = false;
      _chromeHeight = to;
    }
  }

  void _insertEmoji(String emoji) {
    // WhatsApp-style tick when picking an emoji into the composer.
    HapticFeedback.lightImpact();
    final value = _messageController.value;
    final text = value.text;
    final selection = value.selection;
    final start = selection.isValid ? selection.start : text.length;
    final end = selection.isValid ? selection.end : text.length;
    final safeStart = start.clamp(0, text.length);
    final safeEnd = end.clamp(0, text.length);
    final next = text.replaceRange(safeStart, safeEnd, emoji);
    final cursor = safeStart + emoji.length;
    _messageController.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: cursor),
    );
    if (widget.usesApi) {
      context.read<ChatRoomCubit>().onComposerChanged(next);
    }
  }

  void _emojiBackspace() {
    final value = _messageController.value;
    final text = value.text;
    if (text.isEmpty) return;
    final selection = value.selection;
    if (selection.isValid && selection.start != selection.end) {
      final start = selection.start.clamp(0, text.length);
      final end = selection.end.clamp(0, text.length);
      final next = text.replaceRange(start, end, '');
      _messageController.value = TextEditingValue(
        text: next,
        selection: TextSelection.collapsed(offset: start),
      );
    } else {
      final cursor = selection.isValid ? selection.start : text.length;
      if (cursor <= 0) return;
      final chars = text.characters;
      final before = chars.take(cursor).toList();
      if (before.isEmpty) return;
      before.removeLast();
      final after = chars.skip(cursor).toString();
      final next = before.join() + after;
      _messageController.value = TextEditingValue(
        text: next,
        selection: TextSelection.collapsed(offset: before.join().length),
      );
    }
    if (widget.usesApi) {
      context.read<ChatRoomCubit>().onComposerChanged(_messageController.text);
    }
  }

  Future<void> _pickPhotosFromGallery() async {
    _closeAttachmentPanel();
    try {
      final images = await _imagePicker.pickMultiImage(
        imageQuality: 85,
        requestFullMetadata: false,
      );
      if (!mounted || images.isEmpty) return;
      setState(() {
        for (final x in images) {
          final path = x.path;
          if (_pendingImages.any((f) => f.path == path)) continue;
          _pendingImages.add(File(path));
        }
      });
      _messageFocusNode.requestFocus();
    } catch (_) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.somethingWentWrong),
      );
    }
  }

  Future<void> _pickPhotoFromCamera() async {
    _closeAttachmentPanel();
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        requestFullMetadata: false,
      );
      if (!mounted || image == null) return;
      setState(() => _pendingImages.add(File(image.path)));
      _messageFocusNode.requestFocus();
    } catch (_) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.somethingWentWrong),
      );
    }
  }

  void _clearPendingImages() {
    if (_pendingImages.isEmpty) return;
    setState(() => _pendingImages.clear());
  }

  /// What the server accepts per field (`images[]`, `voices[]`, `files[]`).
  /// Anything else fails the whole message with 422.
  static const _imageExtensions = {'jpg', 'jpeg', 'png', 'gif', 'webp'};
  static const _voiceExtensions = {'mp3', 'wav', 'ogg', 'm4a', 'aac'};
  static const _documentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'txt',
    'csv',
  ];
  static const _maxImageMb = 10;
  static const _maxVoiceOrFileMb = 20;

  Future<void> _pickDocument() async {
    _closeAttachmentPanel();
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: _documentExtensions,
      );
      if (!mounted || result == null || result.files.isEmpty) return;
      final paths = result.files
          .where((f) => f.path != null && f.path!.isNotEmpty)
          .map((f) => File(f.path!))
          .toList(growable: false);
      if (paths.isEmpty) return;
      await _sendAttachments(paths);
    } catch (_) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.somethingWentWrong),
      );
    }
  }

  Future<void> _sendAttachments(
    List<File> picked, {
    String? captionOverride,
  }) async {
    if (!widget.usesApi || picked.isEmpty) return;

    final images = <File>[];
    final voices = <File>[];
    final files = <File>[];
    final tooLargeTemplate = context.tr(AppStrings.chatFileTooLarge);
    final notAllowedTemplate = context.tr(AppStrings.chatFileTypeNotAllowed);
    String? rejection;

    // One unsupported or oversized file would fail the whole message
    // (photos included) — drop it here and say why.
    for (final file in picked) {
      final name = file.uri.pathSegments.isEmpty
          ? file.path
          : file.uri.pathSegments.last;
      final dot = name.lastIndexOf('.');
      final ext = dot < 0 ? '' : name.substring(dot + 1).toLowerCase();
      final List<File> bucket;
      final int maxMb;
      if (_imageExtensions.contains(ext)) {
        bucket = images;
        maxMb = _maxImageMb;
      } else if (_voiceExtensions.contains(ext)) {
        bucket = voices;
        maxMb = _maxVoiceOrFileMb;
      } else if (_documentExtensions.contains(ext)) {
        bucket = files;
        maxMb = _maxVoiceOrFileMb;
      } else {
        rejection ??= notAllowedTemplate.replaceAll('{name}', name);
        continue;
      }
      int bytes;
      try {
        bytes = await file.length();
      } catch (_) {
        continue;
      }
      if (bytes > maxMb * 1024 * 1024) {
        rejection ??= tooLargeTemplate
            .replaceAll('{name}', name)
            .replaceAll('{size}', '$maxMb');
        continue;
      }
      bucket.add(file);
    }
    if (!mounted) return;
    if (rejection != null) {
      customSnackBar(context: context, message: rejection);
    }
    if (images.isEmpty && voices.isEmpty && files.isEmpty) return;

    final caption = (captionOverride ?? _messageController.text).trim();
    _messageController.clear();
    await context.read<ChatRoomCubit>().sendMessage(
          text: caption.isEmpty ? null : caption,
          images: images,
          voices: voices,
          files: files,
        );
  }

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
        status: ChatMessageStatus.seen,
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
        status: ChatMessageStatus.delivered,
        reactionEmoji: '👍',
      ),
    ];
  }

  void _showMessageOverlay(
    int index,
    ChatMessageItem message,
    Rect anchorRect,
  ) {
    if (_selectionMode) {
      _toggleMessageSelection(message);
      return;
    }

    final messages = widget.usesApi
        ? _messagesFromState(context.read<ChatRoomCubit>().state)
        : _messages;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    _restoreKeyboardAfterOverlay =
        keyboardInset > 0 || _messageFocusNode.hasFocus;
    _keyboardInsetAtOverlayOpen = keyboardInset;
    _overlayLockPosition = messages.length > 1 && index < messages.length - 2;
    _overlayAnchorFromBottom = index == messages.length - 1;

    setState(() {
      _overlayMessageIndex = index;
      _overlayAnchorRect = anchorRect;
    });

    _dismissKeyboard();
  }

  bool _canSelectMessage(ChatMessageItem message) =>
      !message.isDeleted && !message.isSystem && !message.isDeleting;

  void _enterSelectionMode(
    ChatMessageItem message, {
    required ChatSelectionIntent intent,
  }) {
    if (!_canSelectMessage(message)) return;
    _dismissKeyboard();
    if (widget.usesApi) {
      final cubit = context.read<ChatRoomCubit>();
      cubit.clearReply();
      cubit.clearEditing();
      _messageController.clear();
    }
    setState(() {
      _selectionMode = true;
      _selectionIntent = intent;
      _selectedMessageIds
        ..clear()
        ..add(message.id);
    });
    HapticFeedback.selectionClick();
  }

  void _exitSelectionMode() {
    if (!_selectionMode && _selectedMessageIds.isEmpty) return;
    setState(() {
      _selectionMode = false;
      _selectionIntent = null;
      _selectedMessageIds.clear();
    });
  }

  void _toggleMessageSelection(ChatMessageItem message) {
    if (!_canSelectMessage(message)) return;
    setState(() {
      if (_selectedMessageIds.contains(message.id)) {
        _selectedMessageIds.remove(message.id);
        if (_selectedMessageIds.isEmpty) {
          _selectionMode = false;
          _selectionIntent = null;
        }
      } else {
        _selectionMode = true;
        _selectedMessageIds.add(message.id);
      }
    });
    HapticFeedback.selectionClick();
  }

  List<ChatMessageItem> _selectedMessagesFrom(List<ChatMessageItem> all) {
    return [
      for (final m in all)
        if (_selectedMessageIds.contains(m.id)) m,
    ];
  }

  Future<void> _forwardSelectedMessages(List<ChatMessageItem> all) async {
    final selected = _selectedMessagesFrom(all);
    if (selected.isEmpty) return;
    final cubit = widget.usesApi ? context.read<ChatRoomCubit>() : null;
    final result = await navigatorKey.currentState?.pushNamed(
      AppRoutes.chatForward,
      arguments: {
        'currentDoctorModel': widget.currentDoctorModel,
        'homeDataModel': widget.homeDataModel,
        'messages': selected,
        'sourceConversationId':
            widget.conversationId ?? cubit?.conversationId,
        'excludeChatType': widget.chatType,
        'excludeContextId': widget.contextId,
      },
    );
    if (!mounted) return;
    if (result == true) {
      _exitSelectionMode();
    }
  }

  Future<void> _confirmDeleteSelected(List<ChatMessageItem> all) async {
    final selected = _selectedMessagesFrom(all);
    if (selected.isEmpty) return;
    // "For me only" copy only when every selected message is from someone else.
    final deleteForMeOnly = selected.every((m) => !m.isOutgoing);
    final confirmed = await showChatDeleteMessagesSheet(
      context: context,
      count: selected.length,
      deleteForMeOnly: deleteForMeOnly,
    );
    if (!mounted || !confirmed) return;
    unawaited(_deleteSelectedMessages(selected));
  }

  Future<void> _deleteSelectedMessages(List<ChatMessageItem> selected) async {
    final ids = selected.map((m) => m.id).toList();
    final outgoingIds = {
      for (final m in selected)
        if (m.isOutgoing) m.id,
    };
    _exitSelectionMode();
    // Let selection chrome animate out before bubbles morph.
    await Future<void>.delayed(const Duration(milliseconds: 240));
    if (!mounted) return;

    if (widget.usesApi) {
      final cubit = context.read<ChatRoomCubit>();
      // Local-only failed/cancelled uploads have no server id — discard them.
      for (final m in selected) {
        final tempId = m.clientTempId;
        if (tempId != null && int.tryParse(m.id) == null) {
          cubit.discardOptimisticSend(tempId);
        }
      }
      final messageIds = <int>[
        for (final idStr in ids)
          if (int.tryParse(idStr) != null) int.parse(idStr),
      ];
      if (messageIds.isEmpty) return;
      final ok = await cubit.deleteMessages(messageIds);
      if (!mounted || ok) return;
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.deleteMessageFailed),
      );
      return;
    }

    setState(() {
      _messages = [
        for (final m in _messages)
          if (ids.contains(m.id)) m.copyWith(isDeleting: true) else m,
      ];
    });
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() {
      _messages = [
        for (final m in _messages)
          if (!ids.contains(m.id))
            m
          else if (outgoingIds.contains(m.id))
            // Own messages → WhatsApp soft-delete placeholder.
            m.copyWith(
              isDeleting: false,
              isDeleted: true,
              attachments: const [],
              clearReaction: true,
              clearReplyTo: true,
            )
          // Others' messages → hide (delete for me).
      ];
    });
  }

  void _scheduleKeyboardRestore() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _messageFocusNode.requestFocus();
    });
  }

  void _dismissMessageOverlay({bool restoreKeyboard = true}) {
    if (_overlayMessageIndex == null) return;
    final shouldRestore = restoreKeyboard && _restoreKeyboardAfterOverlay;
    setState(() {
      _overlayMessageIndex = null;
      _overlayAnchorRect = null;
      _restoreKeyboardAfterOverlay = false;
      _keyboardInsetAtOverlayOpen = 0;
    });
    if (shouldRestore) {
      _scheduleKeyboardRestore();
    }
  }

  String? _myReactionEmojiFor(ChatMessageItem message) {
    if (!widget.usesApi) return null;
    final userId = context.read<ChatRoomCubit>().currentUserId;
    if (userId == null) return null;
    for (final group in message.reactions) {
      if (group.users.any((u) => u.id == userId)) return group.emoji;
    }
    return null;
  }

  void _applyEmojiReaction(String emoji) {
    // Same light tick WhatsApp uses when reacting from the emoji bar.
    HapticFeedback.lightImpact();
    final index = _overlayMessageIndex;
    if (index == null) return;

    if (widget.usesApi) {
      final cubit = context.read<ChatRoomCubit>();
      final messageId = cubit.messageIdAt(index);
      // Apply optimistically *before* revealing the list bubble so the badge
      // does not flash empty/old → new when the overlay closes.
      if (messageId != null) {
        cubit.toggleReaction(messageId: messageId, emoji: emoji);
      }
      _dismissMessageOverlay(restoreKeyboard: _restoreKeyboardAfterOverlay);
      return;
    }

    if (index >= _messages.length) return;
    final shouldRestoreKeyboard = _restoreKeyboardAfterOverlay;

    setState(() {
      _overlayMessageIndex = null;
      _overlayAnchorRect = null;
      _restoreKeyboardAfterOverlay = false;
      _keyboardInsetAtOverlayOpen = 0;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
    setState(() {
      _messages = [
        for (var i = 0; i < _messages.length; i++)
          if (i == index)
            _messages[i].copyWith(reactionEmoji: emoji)
          else
            _messages[i],
      ];
      });
      if (shouldRestoreKeyboard) {
        _scheduleKeyboardRestore();
      }
    });
  }

  GlobalKey _tileKeyFor(int index) =>
      _messageTileKeys.putIfAbsent(index, GlobalKey.new);

  Future<void> _onReplyQuoteTap(ChatReplyItem reply) async {
    await _jumpToMessageId('${reply.id}');
  }

  Future<void> _jumpToMessageId(String targetId) async {
    if (_isSeekingMessage) return;
    setState(() => _isSeekingMessage = true);

    try {
      final cubit = widget.usesApi ? context.read<ChatRoomCubit>() : null;

      var messages =
          widget.usesApi ? _messagesFromState(cubit!.state) : _messages;

      String? resolvedId = _resolveMessageIdInList(messages, targetId);
      if (resolvedId == null && cubit != null) {
        final loaded = await cubit.ensureMessageLoaded(targetId);
        if (!mounted) return;
        if (!loaded) {
          customSnackBar(
            context: context,
            message: context.tr(AppStrings.originalMessageNotAvailable),
          );
          return;
        }
        // Wait for BlocBuilder → ListView to receive expanded history.
        await WidgetsBinding.instance.endOfFrame;
        await Future<void>.delayed(const Duration(milliseconds: 80));
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        messages = _messagesFromState(cubit.state);
        resolvedId = cubit.resolveMessageId(targetId) ??
            _resolveMessageIdInList(messages, targetId);
      }

      if (resolvedId == null) {
        if (!mounted) return;
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.originalMessageNotAvailable),
        );
        return;
      }

      if (_messageListKey.currentState == null) {
        await Future<void>.delayed(const Duration(milliseconds: 120));
        await WidgetsBinding.instance.endOfFrame;
      }
      if (!mounted) return;

      final ok =
          await _messageListKey.currentState?.scrollToMessageId(resolvedId) ??
              false;
      if (!mounted) return;
      if (!ok) {
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.originalMessageNotAvailable),
        );
        return;
      }

      setState(() => _flashMessageId = resolvedId);
    } catch (_) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.originalMessageNotAvailable),
      );
    } finally {
      if (mounted) {
        setState(() => _isSeekingMessage = false);
      }
    }
  }

  String? _resolveMessageIdInList(
    List<ChatMessageItem> messages,
    String targetId,
  ) {
    final t = targetId.trim();
    if (t.isEmpty || t == '0') return null;
    for (final m in messages) {
      if (m.id == t || m.clientTempId == t) return m.id;
      for (final a in m.attachments) {
        if (a.id != null && '${a.id}' == t) return m.id;
      }
    }
    return null;
  }

  void _onFlashFinished(String messageId) {
    if (!mounted) return;
    if (_flashMessageId != messageId) return;
    setState(() => _flashMessageId = null);
  }

  void _handleMessageAction(ChatMessageAction action) {
    final index = _overlayMessageIndex;
    if (index == null) return;

    final messages = widget.usesApi
        ? _messagesFromState(context.read<ChatRoomCubit>().state)
        : _messages;
    if (index >= messages.length) return;
    final message = messages[index];

    switch (action) {
      case ChatMessageAction.copy:
        final copyText = _copyableText(message);
        if (copyText == null) {
          customSnackBar(
            context: context,
            message: context.tr(AppStrings.cannotForwardMedia),
          );
          break;
        }
        Clipboard.setData(ClipboardData(text: copyText));
        if (mounted) {
          customSnackBar(
            context: context,
            message: context.tr(AppStrings.messageCopied),
          );
        }
        break;
      case ChatMessageAction.forward:
        _dismissMessageOverlay(restoreKeyboard: false);
        _enterSelectionMode(
          message,
          intent: ChatSelectionIntent.forward,
        );
        return;
      case ChatMessageAction.delete:
        HapticFeedback.lightImpact();
        _dismissMessageOverlay(restoreKeyboard: false);
        _enterSelectionMode(
          message,
          intent: ChatSelectionIntent.delete,
        );
        return;
      case ChatMessageAction.reply:
        if (widget.usesApi) {
          context.read<ChatRoomCubit>().setReplyTo(message);
        }
        _restoreKeyboardAfterOverlay = false;
        _dismissMessageOverlay(restoreKeyboard: false);
        _scheduleKeyboardRestore();
        return;
      case ChatMessageAction.edit:
        if (!widget.usesApi || !message.canEdit) break;
        context.read<ChatRoomCubit>().setEditing(message);
        _messageController.text = message.text;
        _messageController.selection = TextSelection.collapsed(
          offset: _messageController.text.length,
        );
        _restoreKeyboardAfterOverlay = false;
        _dismissMessageOverlay(restoreKeyboard: false);
        _scheduleKeyboardRestore();
        return;
      case ChatMessageAction.info:
        _dismissMessageOverlay(restoreKeyboard: false);
        final cubit =
            widget.usesApi ? context.read<ChatRoomCubit>() : null;
        unawaited(
          ChatSeenBySheet.show(
            context,
            message: message,
            currentUserId: widget.currentDoctorModel.id,
            memberCount: cubit?.memberCount ?? 0,
          ),
        );
        return;
    }
    _dismissMessageOverlay();
  }

  String? _copyableText(ChatMessageItem message) {
    final text = message.text.trim();
    final placeholders = {
      '[Image]',
      '[Photo]',
      '[Voice]',
      '[Voice message]',
      '[File]',
      '[Attachment]',
    };
    if (text.isNotEmpty && !placeholders.contains(text)) return text;
    if (message.hasVoice) return context.tr(AppStrings.voiceMessage);
    if (message.hasImages) return context.tr(AppStrings.photo);
    if (message.attachments.isNotEmpty) return context.tr(AppStrings.file);
    return text.isEmpty ? null : text;
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    final hasPendingImages = _pendingImages.isNotEmpty;

    if (hasPendingImages) {
      if (!widget.usesApi) {
        setState(() => _pendingImages.clear());
        return;
      }
      final cubit = context.read<ChatRoomCubit>();
      if (!cubit.isReady) {
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.chatNotReady),
        );
        return;
      }
      final files = List<File>.from(_pendingImages);
      setState(() => _pendingImages.clear());
      await _sendAttachments(files, captionOverride: text);
      return;
    }

    if (text.isEmpty) return;

    if (widget.usesApi) {
      final cubit = context.read<ChatRoomCubit>();
      if (!cubit.isReady) {
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.chatNotReady),
        );
        return;
      }

      // WhatsApp: checkmark while editing saves in place.
      if (cubit.editingMessage != null) {
        _messageController.clear();
        final error = await cubit.editMessage(text);
        if (!mounted) return;
        if (error != null) {
          customSnackBar(
            context: context,
            message: context.tr(error),
          );
        }
        return;
      }

      // Clear immediately for a smooth WhatsApp-like feel.
      _messageController.clear();
      final error = await cubit.sendMessage(text: text);
      if (!mounted) return;
      // Bubble shows pending/failed + Resend; only surface "not ready" errors.
      if (error != null) {
        customSnackBar(context: context, message: error);
      }
      return;
    }

    setState(() {
      _messages = [
        ..._messages,
        ChatMessageItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          timeLabel: _formatTime(DateTime.now()),
          isOutgoing: true,
          status: ChatMessageStatus.sent,
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

  bool get _isGroupChat => ChatMappers.isAnyGroupChat(widget.chatType);

  /// WhatsApp-style subtitle: roster names, else names from messages, else empty.
  String _groupMembersSubtitle(List<ChatMessageItem> messages) {
    final you = context.tr(AppStrings.you);
    if (widget.usesApi) {
      try {
        final cubit = context.read<ChatRoomCubit>();
        final fromApi = cubit.membersSubtitlePreview(youLabel: you).trim();
        // Once we have a roster (even a single "You"), prefer it over
        // message-derived names so removed members disappear immediately.
        if (fromApi.isNotEmpty || cubit.memberCount > 0) {
          if (fromApi.isNotEmpty) return fromApi;
          return '${cubit.memberCount} ${context.tr(AppStrings.members)}';
        }
      } catch (_) {}
    }
    final names = <String>[];
    final seen = <String>{};
    for (final m in messages) {
      if (m.isOutgoing) {
        if (seen.add(you.toLowerCase())) names.add(you);
        continue;
      }
      final first = ChatComposerActivityLabels.firstNameOf(m.senderName);
      if (first.isEmpty) continue;
      final key = first.toLowerCase();
      if (seen.add(key)) names.add(first);
      if (names.length >= 8) break;
    }
    if (names.isEmpty) return '';
    return names.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.usesApi) {
      return _buildChatScaffold(context, livePeerIsOnline: _peerIsOnline);
    }
    // Rebuild header when app/conversation presence flips during loading
    // (loaded state is the only Bloc field that carries peerIsOnline).
    return ValueListenableBuilder<bool>(
      valueListenable: context.read<ChatRoomCubit>().peerIsOnlineLive,
      builder: (context, liveOnline, _) {
        return _buildChatScaffold(context, livePeerIsOnline: liveOnline);
      },
    );
  }

  Widget _buildChatScaffold(
    BuildContext context, {
    required bool livePeerIsOnline,
  }) {
    return BlocBuilder<ChatRoomCubit, ChatRoomState>(
      builder: (context, chatState) {
        _rememberKeyboardHeight(context);
        final messages =
            widget.usesApi ? _messagesFromState(chatState) : _messages;
        if (widget.usesApi &&
            !_didHandleFocusMessage &&
            (widget.focusMessageId?.trim().isNotEmpty ?? false) &&
            messages.isNotEmpty) {
          _scheduleFocusMessageJump();
        }
        final isLoading = widget.usesApi &&
            chatState.maybeWhen(
              loading: () => true,
              initial: () => true,
              orElse: () => false,
            );
        final hasMore = widget.usesApi &&
            chatState.maybeWhen(
              loaded: (_, __, hasMore, ___, ____, _____, ______, ________,
                      _________, __________, ___________, ____________) =>
                  hasMore,
              orElse: () => false,
            );
        final isLoadingMore = widget.usesApi &&
            chatState.maybeWhen(
              loaded: (_, __, ___, ____, isLoadingMore, _____, ______, ________,
                      _________, __________, ___________, ____________) =>
                  isLoadingMore,
              orElse: () => false,
            );
        final peerActivity = widget.usesApi
            ? chatState.maybeWhen(
                loaded: (_,
                        __,
                        ___,
                        ____,
                        _____,
                        ______,
                        peerActivity,
                        ________,
                        _________,
                        __________,
                        ___________,
                        ____________) =>
                    peerActivity,
                orElse: () => ChatComposerActivity.none,
              )
            : ChatComposerActivity.none;
        final peerIsTyping = peerActivity.isActive;
        final peerTypingName = chatState.maybeWhen(
          loaded: (_, __, ___, ____, _____, ______, _______, peerTypingName,
                  _________, __________, ___________, ____________) =>
              peerTypingName,
          orElse: () => null,
        );
        final replyToMessage = widget.usesApi
            ? chatState.maybeWhen(
                loaded: (_, __, ___, ____, _____, ______, _______, ________,
                        _________, replyToMessage, __________, ___________) =>
                    replyToMessage,
                orElse: () => null,
              )
            : null;
        final editingMessage = widget.usesApi
            ? chatState.maybeWhen(
                loaded: (_, __, ___, ____, _____, ______, _______, ________,
                        _________, __________, editingMessage, ___________) =>
                    editingMessage,
                orElse: () => null,
              )
            : null;
        // Prefer live notifier (app + conversation presence) over route args /
        // loaded snapshot so Online is not stale during shimmer or after resume.
        final peerIsOnline = widget.usesApi
            ? livePeerIsOnline
            : _peerIsOnline;
        final chatError = chatState.maybeWhen(
          error: (message) => message,
          orElse: () => null,
        );

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
            final isDarkMode =
                themeState is ThemeLoaded && themeState.isDarkMode;
            final resolvedPeerImage = _resolvedPeerImageUrl(context);

            final roomHeader = ChatRoomHeader(
          displayName: _peerDisplayName,
          initials: _peerInitials,
              imageUrl: resolvedPeerImage,
          isVerified: _peerVerified,
              isOnline: peerIsOnline,
              isGroup: _isGroupChat,
              membersSubtitle:
                  _isGroupChat ? _groupMembersSubtitle(messages) : null,
              peerActivity: peerActivity,
              typingName: peerTypingName,
              onInfo: () {
                final msgs = messages;
                final isGroup = _isGroupChat;
                final cubit =
                    widget.usesApi ? context.read<ChatRoomCubit>() : null;
                final headerImage = resolvedPeerImage;
                unawaited(() async {
                  final result = await navigatorKey.currentState?.pushNamed(
                    AppRoutes.chatInfo,
                    arguments: {
                      'currentDoctorModel': widget.currentDoctorModel,
                      'homeDataModel': widget.homeDataModel,
                      'displayName': _peerDisplayName,
                      'imageUrl': headerImage,
                      'initials': _peerInitials,
                      'isVerified': _peerVerified,
                      'chatType': widget.chatType,
                      'contextId': widget.contextId,
                      'conversationId': widget.conversationId ??
                          (widget.usesApi ? cubit?.conversationId : null),
                      'isGroup': isGroup,
                      'messages': msgs,
                    },
                  );
                  if (!mounted) return;
                  if (result == 'left_group') {
                    navigatorKey.currentState?.pop();
                    return;
                  }
                  if (result is Map) {
                    final map = Map<String, dynamic>.from(result);
                    if (map['profileUpdated'] == true) {
                      setState(() {
                        final name = map['displayName'];
                        if (name is String && name.trim().isNotEmpty) {
                          _headerDisplayName = name.trim();
                        }
                        if (map.containsKey('imageUrl')) {
                          final img = map['imageUrl'];
                          _headerImageUrl =
                              img is String && img.isNotEmpty ? img : null;
                        }
                      });
                      final renamedTo = map['renamedTo'];
                      if (mounted &&
                          cubit != null &&
                          renamedTo is String &&
                          renamedTo.trim().isNotEmpty) {
                        final hint = context
                            .tr(AppStrings.youChangedGroupNameTo)
                            .replaceAll('{name}', renamedTo.trim());
                        cubit.insertLocalSystemMessage(hint);
                      }
                    }
                    if (isGroup &&
                        cubit != null &&
                        map['rosterUpdated'] == true) {
                      final raw = map['participants'];
                      if (raw is List) {
                        cubit.setParticipants(
                          raw.whereType<ChatUserModel>().toList(),
                        );
                      }
                      final removed = map['removedNames'];
                      if (removed is List) {
                        for (final n in removed) {
                          if (n is! String || n.trim().isEmpty) continue;
                          final hint = context
                              .tr(AppStrings.youRemovedFromGroup)
                              .replaceAll('{name}', n.trim());
                          cubit.insertLocalSystemMessage(hint);
                        }
                      }
                      final added = map['addedNames'];
                      if (added is List) {
                        for (final n in added) {
                          if (n is! String || n.trim().isEmpty) continue;
                          final hint = context
                              .tr(AppStrings.youAddedToGroup)
                              .replaceAll('{name}', n.trim());
                          cubit.insertLocalSystemMessage(hint);
                        }
                      }
                      // Defer refresh so the API roster has committed.
                      Future<void>.delayed(
                        const Duration(milliseconds: 450),
                        () {
                          if (!mounted) return;
                          unawaited(cubit.refreshConversationDetails());
                        },
                      );
                    } else if (isGroup && cubit != null) {
                      unawaited(cubit.refreshConversationDetails());
                    }
                  } else if (isGroup && cubit != null) {
                    unawaited(cubit.refreshConversationDetails());
                  }
                  if (result is String &&
                      result.isNotEmpty &&
                      result != 'left_group') {
                    unawaited(_jumpToMessageId(result));
                  }
                }());
              },
            );

            final selectionHeader = _selectionIntent == null
                ? null
                : ChatSelectionHeader(
                    selectedCount: _selectedMessageIds.length,
                    intent: _selectionIntent!,
                    onClose: _exitSelectionMode,
                    onForward: _selectionIntent == ChatSelectionIntent.forward
                        ? () => _forwardSelectedMessages(messages)
                        : null,
                    onDelete: _selectionIntent == ChatSelectionIntent.delete
                        ? () => _confirmDeleteSelected(messages)
                        : null,
                  );

            final header = AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                final slide = Tween<Offset>(
                  begin: const Offset(0, -0.12),
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
              child: KeyedSubtree(
                key: ValueKey(
                  _selectionMode ? 'selection_header' : 'room_header',
                ),
                child: _selectionMode && selectionHeader != null
                    ? selectionHeader
                    : roomHeader,
              ),
            );

            final selectedId = _overlayMessageIndex != null &&
                    _overlayMessageIndex! < messages.length
                ? messages[_overlayMessageIndex!].id
            : null;

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                // Dark icons on light header; light icons on dark header.
                statusBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                    isDarkMode ? Brightness.dark : Brightness.light,
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor:
                    ChatRoomGlassSurface.solidBarColor(isDarkMode),
                systemNavigationBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
                systemNavigationBarContrastEnforced: false,
              ),
              child: PopScope(
                canPop: !_selectionMode,
                onPopInvokedWithResult: (didPop, _) {
                  if (!didPop) {
                    if (_selectionMode) {
                      _exitSelectionMode();
                    }
                    return;
                  }
                  // Leaving chat room — inbox must treat following messages as unread.
                  _clearActiveChat();
                },
                child: ChatHashtagScope(
                  currentDoctorModel: widget.currentDoctorModel,
                  homeDataModel: widget.homeDataModel,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: isDarkMode
                        ? const Color(0xFF15111F)
                        : const Color(0xFFEDE7FF),
                    body: ChatRoomBackground(
                      isDark: isDarkMode,
                      child: Stack(
            children: [
                          Column(
                  children: [
                    Expanded(
                                child: Stack(
                                  clipBehavior: Clip.hardEdge,
                                  children: [
                                    Positioned.fill(
                                      child: isLoading && messages.isEmpty
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                top: _headerOverlayHeight > 0
                                                    ? _headerOverlayHeight
                                                    : MediaQuery.paddingOf(
                                                                context)
                                                            .top +
                                                        56.h,
                                              ),
                                              child: ChatRoomLoadingShimmer(
                                                isDark: isDarkMode,
                                              ),
                                            )
                                          : chatError != null &&
                                                  messages.isEmpty
                                              ? Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(24.w),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .cloud_off_rounded,
                                                          size: 36.sp,
                                                          color: isDarkMode
                                                              ? AppColors
                                                                  .darkDescription
                                                              : Colors.grey
                                                                  .shade500,
                                                        ),
                                                        SizedBox(height: 12.h),
                                                        Text(
                                                          chatError,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: isDarkMode
                                                                ? AppColors
                                                                    .darkTitle
                                                                : AppColors
                                                                    .title,
                                                          ),
                                                        ),
                                                        SizedBox(height: 16.h),
                                                        TextButton.icon(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    ChatRoomCubit>()
                                                                .loadMessages();
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .refresh_rounded,
                                                            size: 18.sp,
                                                          ),
                                                          label: Text(
                                                            context.tr(
                                                              AppStrings
                                                                  .tryAgain,
                                                            ),
                                                          ),
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                AppColors
                                                                    .primary,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : messages.isEmpty
                                                  ? GestureDetector(
                                                      behavior:
                                                          HitTestBehavior.opaque,
                                                      onTap: _dismissKeyboard,
                                                      child:
                                                          _ChatEmptyMessagesState(
                                                        isDark: isDarkMode,
                                                        isGroup: _isGroupChat,
                                                        topInset:
                                                            _headerOverlayHeight >
                                                                    0
                                                                ? _headerOverlayHeight
                                                                : MediaQuery
                                                                        .paddingOf(
                                                                            context)
                                                                    .top +
                                                                    56.h,
                                                      ),
                                                    )
                                                  : ChatMessageList(
                                                  key: _messageListKey,
                                                  messages: messages,
                        peerInitials: _peerInitials,
                                                  peerImageUrl: resolvedPeerImage,
                                                  isGroup: _isGroupChat,
                        selectedMessageId: selectedId,
                                                  selectionMode: _selectionMode,
                                                  selectedMessageIds:
                                                      _selectedMessageIds,
                                                  flashMessageId:
                                                      _flashMessageId,
                                                  topOverlayInset:
                                                      _headerOverlayHeight > 0
                                                          ? _headerOverlayHeight
                                                          : MediaQuery.paddingOf(
                                                                      context)
                                                                  .top +
                                                              56.h,
                                                  hasMore: hasMore,
                                                  isLoadingMore: isLoadingMore,
                                                  onLoadOlder: widget.usesApi
                                                      ? () => context
                                                          .read<ChatRoomCubit>()
                                                          .loadOlderMessages()
                                                      : null,
                                                  onResend: widget.usesApi
                                                      ? (message) {
                                                          final tempId = message
                                                              .clientTempId;
                                                          if (tempId == null)
                                                            return;
                                                          context
                                                              .read<
                                                                  ChatRoomCubit>()
                                                              .resendMessage(
                                                                  tempId);
                                                        }
                                                      : null,
                                                  onCancelUpload: widget.usesApi
                                                      ? (message) {
                                                          final tempId = message
                                                              .clientTempId;
                                                          if (tempId == null) {
                                                            return;
                                                          }
                                                          context
                                                              .read<
                                                                  ChatRoomCubit>()
                                                              .cancelSend(
                                                                  tempId);
                                                        }
                                                      : null,
                                                  onReactionTap: (message) {
                                                    if (_selectionMode) return;
                                                    if (message
                                                        .reactions.isEmpty) {
                                                      return;
                                                    }
                                                    ChatReactionsBottomSheet
                                                        .show(
                                                      context,
                                                      reactions:
                                                          message.reactions,
                                                      initialEmoji:
                                                          message.reactionEmoji,
                                                      currentUserId: context
                                                          .read<ChatRoomCubit>()
                                                          .currentUserId,
                                                    );
                                                  },
                                                  messageTileKeys: {
                                                    for (var i = 0;
                                                        i < messages.length;
                                                        i++)
                                                      i: _tileKeyFor(i),
                                                  },
                                                  onMessageLongPress:
                                                      _showMessageOverlay,
                                                  onMessageTap: _selectionMode
                                                      ? _toggleMessageSelection
                                                      : null,
                                                  onBackgroundTap:
                                                      _dismissKeyboard,
                                                  onReplyQuoteTap:
                                                      _onReplyQuoteTap,
                                                  onFlashFinished:
                                                      _onFlashFinished,
                                                  onSwipeToReply: widget.usesApi
                                                      ? (message) {
                                                          context
                                                              .read<
                                                                  ChatRoomCubit>()
                                                              .setReplyTo(
                                                                  message);
                                                          _messageFocusNode
                                                              .requestFocus();
                                                        }
                                                      : null,
                                                ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: _HeaderSizeReporter(
                                        onHeight: (height) {
                                          if ((height - _headerOverlayHeight)
                                                  .abs() <
                                              0.5) {
                                            return;
                                          }
                                          setState(() =>
                                              _headerOverlayHeight = height);
                                        },
                                        child: header,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable:
                                    GetIt.I.isRegistered<ChatBlockService>()
                                        ? GetIt.I<ChatBlockService>().revision
                                        : _noBlockRevision,
                                builder: (context, _, __) {
                                  final roomCubit = widget.usesApi
                                      ? context.read<ChatRoomCubit>()
                                      : null;
                                  final peerId = widget.chatType ==
                                              ChatApiType.private ||
                                          (ChatApiType.fromApi(
                                                  widget.chatType) ==
                                              ChatApiType.private)
                                      ? widget.contextId
                                      : null;
                                  final iBlocked = roomCubit?.iBlockedPeer ==
                                          true ||
                                      (GetIt.I.isRegistered<
                                              ChatBlockService>() &&
                                          GetIt.I<ChatBlockService>()
                                              .isBlocked(peerId));
                                  final messagingLocked = roomCubit != null &&
                                      (roomCubit.recipientUnavailable ||
                                          iBlocked ||
                                          _isUnblocking);

                                  if (messagingLocked &&
                                      (_messageFocusNode.hasFocus ||
                                          _attachmentPanelOpen ||
                                          _emojiPanelOpen)) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      if (!mounted) return;
                                      _messageFocusNode.unfocus();
                                      if (_attachmentPanelOpen) {
                                        _closeAttachmentPanel();
                                      }
                                      if (_emojiPanelOpen) {
                                        setState(() {
                                          _emojiPanelOpen = false;
                                        });
                                      }
                                    });
                                  }

                                  Widget footerChild;
                                  if (_selectionMode) {
                                    footerChild = ColoredBox(
                                      key: const ValueKey('sel_pad'),
                                      color: ChatRoomGlassSurface
                                          .solidBarColor(isDarkMode),
                                      child: SizedBox(
                                        height: MediaQuery.viewPaddingOf(
                                                context)
                                            .bottom,
                                      ),
                                    );
                                  } else if (messagingLocked) {
                                    footerChild = _BlockedMemberFooter(
                                      key: const ValueKey('composer_locked'),
                                      iBlockedPeer: iBlocked || _isUnblocking,
                                      isDark: isDarkMode,
                                      isUnblocking: _isUnblocking,
                                      onUnblock: (iBlocked || _isUnblocking)
                                          ? () async {
                                              if (_isUnblocking) return;
                                              setState(
                                                  () => _isUnblocking = true);
                                              final cubit = context
                                                  .read<ChatRoomCubit>();
                                              final ok =
                                                  await cubit.unblockPeer();
                                              if (!mounted) return;
                                              setState(
                                                  () => _isUnblocking = false);
                                              if (!ok) {
                          customSnackBar(
                            context: context,
                                                  message: context.tr(
                                                    AppStrings.unblockFailed,
                                                  ),
                                                );
                                              }
                                            }
                                          : null,
                                    );
                                  } else {
                                    footerChild = Column(
                                      key: const ValueKey('composer'),
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                            ChatTypingIndicator(
                                              name: peerTypingName ??
                                                  _peerDisplayName,
                                              isDark: isDarkMode,
                                              visible: peerIsTyping,
                                              activity: peerActivity,
                                            ),
                                            ChatReplyBanner(
                                              message: editingMessage ??
                                                  replyToMessage,
                                              isEditing:
                                                  editingMessage != null,
                                              myDisplayName: doctorName(
                                                firstName: widget
                                                    .currentDoctorModel
                                                    .firstName,
                                                lastName: widget
                                                    .currentDoctorModel
                                                    .lastName,
                                                role: widget.homeDataModel
                                                        .isSyndicateCardRequired ??
                                                    '',
                                              ),
                                              peerDisplayName:
                                                  _peerDisplayName,
                                              onClose: () {
                                                final cubit = context
                                                    .read<ChatRoomCubit>();
                                                if (cubit.editingMessage !=
                                                    null) {
                                                  cubit.clearEditing();
                                                  _messageController.clear();
                                                } else {
                                                  cubit.clearReply();
                        }
                      },
                    ),
                                            if (_pendingImages.isNotEmpty &&
                                                editingMessage == null)
                                              ChatPendingImagesBanner(
                                                files: _pendingImages,
                                                onTap: _pickPhotosFromGallery,
                                                onRemoveAt: (i) {
                                                  if (i < 0 ||
                                                      i >=
                                                          _pendingImages
                                                              .length) {
                                                    return;
                                                  }
                                                  setState(() =>
                                                      _pendingImages
                                                          .removeAt(i));
                                                },
                                                onClose: _clearPendingImages,
                                              ),
                                            ValueListenableBuilder<
                                                TextEditingValue>(
                                              valueListenable:
                                                  _messageController,
                                              builder: (context, value, _) {
                                                final hasComposerContent =
                                                    value.text
                                                            .trim()
                                                            .isNotEmpty ||
                                                        _pendingImages
                                                            .isNotEmpty;
                                                return ChatInputBar(
                                                  controller:
                                                      _messageController,
                                                  focusNode:
                                                      _messageFocusNode,
                                                  hasText:
                                                      hasComposerContent,
                                                  isEditing:
                                                      editingMessage != null,
                                                  attachmentPanelOpen:
                                                      _attachmentPanelOpen,
                                                  emojiPanelOpen:
                                                      _emojiPanelOpen,
                                                  reserveBottomSafeArea:
                                                      false,
                                                  onAttach:
                                                      _onAttachButtonPressed,
                                                  onOpenKeyboard:
                                                      _openKeyboardFromAttachment,
                                                  onEmoji: _toggleEmojiPanel,
                                                  onChanged: widget.usesApi
                                                      ? context
                                                          .read<
                                                              ChatRoomCubit>()
                                                          .onComposerChanged
                                                      : null,
                                                  onSendText: _sendMessage,
                                                  onRecordingStarted: widget
                                                          .usesApi
                                                      ? () => context
                                                          .read<
                                                              ChatRoomCubit>()
                                                          .onRecordingChanged(
                                                              true)
                                                      : null,
                                                  onRecordingStopped: widget
                                                          .usesApi
                                                      ? () => context
                                                          .read<
                                                              ChatRoomCubit>()
                                                          .onRecordingChanged(
                                                              false)
                                                      : null,
                                                  onVoiceRecorded: widget
                                                          .usesApi
                                                      ? (file, duration) {
                                                          _closeAttachmentPanel();
                                                          unawaited(
                                                            context
                                                                .read<
                                                                    ChatRoomCubit>()
                                                                .sendMessage(
                                                              voices: [
                                                                file
                                                              ],
                                                              voiceDurationMs:
                                                                  duration
                                                                      .inMilliseconds,
                                                            ),
                                                          );
                                                        }
                                                      : null,
                                                );
                                              },
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final chromeH =
                                                    _bottomInset(context);
                                                final showAttach =
                                                    _isRenderingAttachmentPanel;
                                                final showEmoji =
                                                    _isRenderingEmojiPanel;
                                                return ColoredBox(
                                                  color: ChatRoomGlassSurface
                                                      .solidBarColor(
                                                          isDarkMode),
                                                  child: SizedBox(
                                                    height: chromeH,
                                                    width: double.infinity,
                                                    child: showAttach
                                                        ? ChatAttachmentPanel(
                                                            height: chromeH,
                                                            onPhoto:
                                                                _pickPhotosFromGallery,
                                                            onCamera:
                                                                _pickPhotoFromCamera,
                                                            onDocument:
                                                                _pickDocument,
                                                          )
                                                        : showEmoji
                                                            ? ChatEmojiPanel(
                                                                height:
                                                                    chromeH,
                                                                onEmojiSelected:
                                                                    _insertEmoji,
                                                                onBackspace:
                                                                    _emojiBackspace,
                                                              )
                                                            : const SizedBox
                                                                .expand(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                    );
                                  }

                                  return AnimatedSize(
                                    duration: _composerSwapDuration,
                                    curve: Curves.easeInOutCubic,
                                    alignment: Alignment.bottomCenter,
                                    child: AnimatedSwitcher(
                                      duration: _composerSwapDuration,
                                      reverseDuration: const Duration(
                                          milliseconds: 320),
                                      switchInCurve: Curves.easeOutCubic,
                                      switchOutCurve: Curves.easeInCubic,
                                      layoutBuilder: (currentChild,
                                          previousChildren) {
                                        return Stack(
                                          alignment: Alignment.bottomCenter,
                                          clipBehavior: Clip.none,
                                          children: [
                                            ...previousChildren,
                                            if (currentChild != null)
                                              currentChild,
                                          ],
                                        );
                                      },
                                      transitionBuilder:
                                          (child, animation) {
                                        final curved = CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOutCubic,
                                          reverseCurve: Curves.easeInCubic,
                                        );
                                        return FadeTransition(
                                          opacity: curved,
                                          child: SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0, 0.08),
                                              end: Offset.zero,
                                            ).animate(curved),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: footerChild,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          if (_isSeekingMessage)
                            Positioned.fill(
                              child: AbsorbPointer(
                                child: ColoredBox(
                                  color: Colors.black.withOpacity(0.18),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18.w,
                                        vertical: 14.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? const Color(0xFF1E1E1E)
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.18),
                                            blurRadius: 16,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 18.r,
                                            height: 18.r,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.2,
                                              color: isDarkMode
                                                  ? AppColors.darkPrimary
                                                  : AppColors.primary,
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Text(
                                            context.tr(
                                              AppStrings.searchingMessages,
                                            ),
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: isDarkMode
                                                  ? AppColors.darkTitle
                                                  : AppColors.title,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (!_selectionMode &&
                              _overlayMessageIndex != null &&
                              _overlayAnchorRect != null &&
                              _overlayMessageIndex! < messages.length)
                ChatMessageOverlay(
                              key: ValueKey(messages[_overlayMessageIndex!].id),
                              message: messages[_overlayMessageIndex!],
                  anchorRect: _overlayAnchorRect!,
                              lockMessagePosition: _overlayLockPosition,
                              anchorMenuFromBottom: _overlayAnchorFromBottom,
                              keyboardInsetAtOpen: _keyboardInsetAtOverlayOpen,
                              bottomReservedHeight: 52,
                  peerInitials: _peerInitials,
                              peerImageUrl: resolvedPeerImage,
                              isGroup: _isGroupChat,
                              onDismiss: () => _dismissMessageOverlay(),
                  onEmojiSelected: _applyEmojiReaction,
                              selectedEmoji: _myReactionEmojiFor(
                                  messages[_overlayMessageIndex!]),
                  onAction: _handleMessageAction,
                ),
            ],
                      ),
                    ),
                  ),
                ),
          ),
            );
          },
        );
      },
    );
  }
}

class _ChatEmptyMessagesState extends StatelessWidget {
  final bool isDark;
  final bool isGroup;
  final double topInset;

  const _ChatEmptyMessagesState({
    required this.isDark,
    required this.isGroup,
    required this.topInset,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor =
        isDark ? AppColors.darkTitle : AppColors.title;
    final subColor =
        isDark ? AppColors.darkDescription : Colors.grey.shade600;
    final card = isDark
        ? const Color(0xFF221C2E)
        : Colors.white.withOpacity(0.92);
    final border = isDark
        ? Colors.white.withOpacity(0.08)
        : AppColors.primary.withOpacity(0.12);

    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.only(top: topInset),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 76.r,
                  height: 76.r,
                  decoration: BoxDecoration(
                    color: card,
                    shape: BoxShape.circle,
                    border: Border.all(color: border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.14),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    isGroup
                        ? Icons.forum_rounded
                        : Icons.chat_bubble_outline_rounded,
                    color: AppColors.primary,
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  context.tr(AppStrings.noMessagesYet),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  context.tr(
                    isGroup
                        ? AppStrings.sendFirstMessageInGroup
                        : AppStrings.sendFirstMessage,
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: subColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
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

class _BlockedMemberFooter extends StatelessWidget {
  final bool iBlockedPeer;
  final bool isDark;
  final bool isUnblocking;
  final VoidCallback? onUnblock;

  const _BlockedMemberFooter({
    super.key,
    required this.iBlockedPeer,
    required this.isDark,
    this.isUnblocking = false,
    this.onUnblock,
  });

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.viewPaddingOf(context).bottom;
    final blockedBg =
        isDark ? const Color(0xFF2A1A1A) : const Color(0xFFFFF1F2);
    final title = isDark ? const Color(0xFFFECACA) : const Color(0xFF9F1239);
    final sub = isDark ? const Color(0xFFFCA5A5) : const Color(0xFFBE123C);

    return Material(
      color: blockedBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 12.h),
            decoration: BoxDecoration(
              color: blockedBg,
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFE11D48).withOpacity(0.28),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.block_rounded,
                  size: 22.sp,
                  color: const Color(0xFFE11D48),
                ),
                SizedBox(height: 8.h),
                Text(
                  context.tr(
                    iBlockedPeer
                        ? AppStrings.memberHasBeenBlocked
                        : AppStrings.cantMessageThisUser,
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: title,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  context.tr(AppStrings.blockUserDescription),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    color: sub,
                  ),
                ),
                if (iBlockedPeer && onUnblock != null) ...[
                  SizedBox(height: 10.h),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: isUnblocking
                        ? SizedBox(
                            key: const ValueKey('unblock_loading'),
                            width: 22.w,
                            height: 22.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: Color(0xFFE11D48),
                            ),
                          )
                        : TextButton(
                            key: const ValueKey('unblock_btn'),
                            onPressed: onUnblock,
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFE11D48),
                              backgroundColor:
                                  const Color(0xFFE11D48).withOpacity(0.12),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              context.tr(AppStrings.unblock),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                  ),
                ],
              ],
            ),
          ),
          ColoredBox(
            color: blockedBg,
            child: SizedBox(height: safeBottom, width: double.infinity),
          ),
        ],
      ),
    );
  }
}

/// Reports header height so the reverse message list can pad under it.
class _HeaderSizeReporter extends StatefulWidget {
  final Widget child;
  final ValueChanged<double> onHeight;

  const _HeaderSizeReporter({
    required this.child,
    required this.onHeight,
  });

  @override
  State<_HeaderSizeReporter> createState() => _HeaderSizeReporterState();
}

class _HeaderSizeReporterState extends State<_HeaderSizeReporter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _report());
  }

  @override
  void didUpdateWidget(covariant _HeaderSizeReporter oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _report());
  }

  void _report() {
    if (!mounted) return;
    final height = context.size?.height;
    if (height == null || height <= 0) return;
    widget.onHeight(height);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
