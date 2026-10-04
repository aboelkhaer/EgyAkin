import 'dart:async';
import 'dart:io';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/app/shared/functions/chat_text_direction.dart';
import 'package:egy_akin/features/chat/data/services/chat_audio_session.dart';
import 'package:egy_akin/features/chat/data/services/chat_typing_sound.dart';
import 'package:egy_akin/features/chat/data/services/chat_voice_feedback.dart';
import 'package:egy_akin/features/chat/data/services/chat_voice_playback_coordinator.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_link_preview.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

typedef VoiceRecordedCallback = FutureOr<void> Function(
  File file,
  Duration duration,
);

/// Chat composer with:
/// - tap mic → locked recording (tap send / trash)
/// - hold mic → record while held (release to send, slide left to cancel)
class ChatInputBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onAttach;
  final VoidCallback onSendText;
  final VoiceRecordedCallback? onVoiceRecorded;
  final bool hasText;
  final bool isEditing;
  final bool attachmentPanelOpen;
  final bool emojiPanelOpen;

  /// When false, skip home-indicator padding (panel open, keyboard open, or
  /// bridging panel → keyboard). Prevents the composer from jumping.
  final bool reserveBottomSafeArea;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEmoji;
  final FocusNode? focusNode;
  final VoidCallback? onOpenKeyboard;
  final VoidCallback? onRecordingStarted;
  final VoidCallback? onRecordingStopped;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onAttach,
    required this.onSendText,
    required this.hasText,
    this.isEditing = false,
    this.onVoiceRecorded,
    this.attachmentPanelOpen = false,
    this.emojiPanelOpen = false,
    this.reserveBottomSafeArea = true,
    this.onOpenKeyboard,
    this.onChanged,
    this.onEmoji,
    this.focusNode,
    this.onRecordingStarted,
    this.onRecordingStopped,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar>
    with SingleTickerProviderStateMixin {
  static const double _barHeight = 36;

  /// Grow with long messages so Arabic/English lines are not clipped.
  static const int _maxInputLines = 5;
  static const double _cancelThreshold = 72;
  static const Duration _minDuration = Duration(milliseconds: 800);
  static const Duration _maxDuration = Duration(minutes: 2);

  final AudioRecorder _recorder = AudioRecorder();
  late final AnimationController _pulse;
  late TextDirection _textDirection;

  bool _recording = false;
  bool _starting = false;
  bool _finishing = false;
  bool _lockedMode = false; // tap-to-record
  bool _holdMode = false; // hold-to-record
  bool _willCancel = false;
  bool _pointerActive = false;
  bool _holdArmed = false;
  bool _sendPressed = false;

  /// Finger released while hold recording was still starting.
  bool _finishHoldWhenReady = false;
  bool _cancelHoldWhenReady = false;
  double _slideDx = 0;
  Offset? _pointerStart;
  Duration _elapsed = Duration.zero;
  Timer? _tick;
  Timer? _holdArmTimer;
  StreamSubscription<Amplitude>? _ampSub;
  double _amp = 0;
  String? _path;
  DateTime? _startedAt;

  String? _previewUrl;
  ChatLinkMeta? _previewMeta;
  bool _previewLoading = false;
  String? _dismissedPreviewUrl;
  int _previewRequestId = 0;

  @override
  void initState() {
    super.initState();
    _textDirection = TextDirection.ltr;
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    widget.controller.addListener(_syncTextDirection);
    widget.controller.addListener(_onComposerTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _syncTextDirection();
      _onComposerTextChanged();
    });
  }

  @override
  void didUpdateWidget(covariant ChatInputBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_syncTextDirection);
      oldWidget.controller.removeListener(_onComposerTextChanged);
      widget.controller.addListener(_syncTextDirection);
      widget.controller.addListener(_onComposerTextChanged);
      _syncTextDirection();
      _onComposerTextChanged();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncTextDirection);
    widget.controller.removeListener(_onComposerTextChanged);
    _tick?.cancel();
    _holdArmTimer?.cancel();
    _ampSub?.cancel();
    _pulse.dispose();
    unawaited(_safeStopAndDiscard());
    _recorder.dispose();
    super.dispose();
  }

  /// Same rule as create-post / [HashtagText]: Arabic-aware direction.
  TextDirection _directionFor(String value) {
    return ChatTextDirection.resolve(
      value,
      fallback: context.isRTL ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  void _syncTextDirection() {
    final next = _directionFor(widget.controller.text);
    if (next == _textDirection || !mounted) return;
    setState(() => _textDirection = next);
  }

  void _onComposerTextChanged() {
    final url = firstChatUrl(widget.controller.text);
    if (url == null) {
      if (_previewUrl != null ||
          _previewMeta != null ||
          _previewLoading ||
          _dismissedPreviewUrl != null) {
        setState(() {
          _previewUrl = null;
          _previewMeta = null;
          _previewLoading = false;
          _dismissedPreviewUrl = null;
        });
      }
      return;
    }
    if (url == _dismissedPreviewUrl) return;
    if (url == _previewUrl &&
        _previewMeta?.imageUrl != null &&
        !_previewLoading) {
      return;
    }
    _loadComposerPreview(url);
  }

  Future<void> _loadComposerPreview(String url) async {
    final requestId = ++_previewRequestId;
    final cached = chatLinkMetaCache[url];
    final needsFetch = cached == null || cached.imageUrl == null;
    setState(() {
      _previewUrl = url;
      _previewMeta = cached;
      _previewLoading = needsFetch;
      _dismissedPreviewUrl = null;
    });
    if (!needsFetch) return;
    final meta = await fetchChatLinkMeta(url);
    if (!mounted || requestId != _previewRequestId || _previewUrl != url) {
      return;
    }
    setState(() {
      _previewMeta = meta;
      _previewLoading = false;
    });
  }

  void _dismissComposerPreview() {
    setState(() {
      _dismissedPreviewUrl = _previewUrl;
      _previewUrl = null;
      _previewMeta = null;
      _previewLoading = false;
    });
  }

  Future<void> _safeStopAndDiscard() async {
    try {
      if (await _recorder.isRecording()) {
        final path = await _recorder.stop();
        if (path != null) {
          final file = File(path);
          if (await file.exists()) await file.delete();
        }
      }
    } catch (_) {}
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _startRecording({required bool locked}) async {
    if (_starting || _recording || widget.onVoiceRecorded == null) return;
    _starting = true;

    try {
      // Free the audio session — typing clicks / voice playback block the mic.
      ChatTypingSound.stopPeerTypingClicks();
      await ChatVoicePlaybackCoordinator.instance.stopActive();

      final allowed = await _recorder.hasPermission();
      if (!allowed) {
        if (!mounted) return;
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.microphonePermissionRequired),
        );
        return;
      }

      FocusManager.instance.primaryFocus?.unfocus();

      // Click + haptic first — never while the mic is already open.
      await ChatVoiceFeedback.recordStart();
      if (!mounted) return;

      await ChatAudioSession.prepareRecording();

      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/chat_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

      try {
        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
            numChannels: 1,
          ),
          path: path,
        );
      } catch (e) {
        // Session races (permission dialog / soft audio interrupt) — one retry.
        debugPrint('Chat voice start retry after: $e');
        await _safeStopAndDiscard();
        await ChatAudioSession.prepareRecording();
        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
            numChannels: 1,
          ),
          path: path,
        );
      }

      _path = path;
      _startedAt = DateTime.now();
      _elapsed = Duration.zero;
      _amp = 0;
      _slideDx = 0;
      _willCancel = false;
      _lockedMode = locked;
      _holdMode = !locked;

      _tick?.cancel();
      _tick = Timer.periodic(const Duration(milliseconds: 200), (_) {
        if (!mounted || _startedAt == null) return;
        final next = DateTime.now().difference(_startedAt!);
        setState(() => _elapsed = next);
        if (next >= _maxDuration) {
          unawaited(_finishRecording(send: true));
        }
      });

      await _ampSub?.cancel();
      _ampSub = _recorder
          .onAmplitudeChanged(const Duration(milliseconds: 120))
          .listen((a) {
        if (!mounted) return;
        final db = a.current;
        final norm = ((db + 45) / 45).clamp(0.0, 1.0);
        setState(() => _amp = norm);
      });

      if (!mounted) return;
      setState(() => _recording = true);
      _pulse.repeat(reverse: true);
      // Presence/Ably side effects must never abort an open mic session.
      try {
        widget.onRecordingStarted?.call();
      } catch (e) {
        debugPrint('Chat voice onRecordingStarted failed: $e');
      }

      // Hold released while we were still starting → finish/cancel now.
      if (!locked && (_finishHoldWhenReady || _cancelHoldWhenReady)) {
        final send =
            _finishHoldWhenReady && !_cancelHoldWhenReady && !_willCancel;
        _finishHoldWhenReady = false;
        _cancelHoldWhenReady = false;
        unawaited(_finishRecording(send: send));
      }
    } catch (e) {
      debugPrint('Chat voice start failed: $e');
      _lockedMode = false;
      _holdMode = false;
      _finishHoldWhenReady = false;
      _cancelHoldWhenReady = false;
      if (mounted) {
        customSnackBar(
          context: context,
          message: context.tr(AppStrings.somethingWentWrong),
        );
      }
    } finally {
      _starting = false;
    }
  }

  Future<void> _finishRecording({required bool send}) async {
    if (_finishing) return;
    if (!_recording && !_starting) return;
    _finishing = true;

    if (send) {
      unawaited(ChatVoiceFeedback.send());
    }

    String? path = _path;
    final startedAt = _startedAt;
    final elapsed =
        startedAt == null ? _elapsed : DateTime.now().difference(startedAt);

    _tick?.cancel();
    _tick = null;
    unawaited(_ampSub?.cancel());
    _ampSub = null;
    _pulse.stop();
    _pulse.reset();
    _sendPressed = false;
    _finishHoldWhenReady = false;
    _cancelHoldWhenReady = false;
    _holdArmed = false;
    _pointerActive = false;

    // Collapse recording UI immediately — don't wait for file finalize/upload.
    if (mounted) {
      setState(() {
        _recording = false;
        _lockedMode = false;
        _holdMode = false;
        _willCancel = false;
        _slideDx = 0;
        _amp = 0;
        _elapsed = Duration.zero;
        _path = null;
        _startedAt = null;
      });
    } else {
      _recording = false;
      _lockedMode = false;
      _holdMode = false;
      _path = null;
      _startedAt = null;
    }
    widget.onRecordingStopped?.call();

    try {
      try {
        final stopped = await _recorder.stop();
        if (stopped != null && stopped.isNotEmpty) path = stopped;
      } catch (e) {
        debugPrint('Chat voice stop failed: $e');
      }

      // Playback session restore can happen in parallel with send.
      unawaited(ChatAudioSession.release());

      if (path == null || path.isEmpty) return;
      var file = File(path);
      if (!await file.exists()) return;

      if (!send || elapsed < _minDuration) {
        try {
          if (await file.exists()) await file.delete();
        } catch (_) {}
        if (send && mounted && elapsed < _minDuration) {
          customSnackBar(
            context: context,
            message: context.tr(AppStrings.recordingTooShort),
          );
        }
        return;
      }

      // Prefer a stable copy, but don't stall send on long iOS flush waits.
      try {
        if (await file.length() == 0) {
          await Future<void>.delayed(const Duration(milliseconds: 80));
        }
        final dir = await getTemporaryDirectory();
        final stable =
            '${dir.path}/chat_voice_ready_${DateTime.now().millisecondsSinceEpoch}.m4a';
        file = await file.copy(stable);
        try {
          await File(path).delete();
        } catch (_) {}
      } catch (_) {}

      if (!await file.exists() || await file.length() == 0) return;

      // Fire-and-forget so upload never blocks the composer.
      final cb = widget.onVoiceRecorded;
      if (cb != null) {
        unawaited(Future<void>(() async {
          try {
            await cb(file, elapsed);
          } catch (e) {
            debugPrint('Chat voice send callback failed: $e');
          }
        }));
      }
    } finally {
      _finishing = false;
    }
  }

  void _requestHoldFinish({required bool send}) {
    if (_starting && !_recording) {
      _finishHoldWhenReady = send;
      _cancelHoldWhenReady = !send;
      return;
    }
    if (_holdMode && (_recording || _starting)) {
      unawaited(_finishRecording(send: send));
    }
  }

  void _updateHoldSlide(Offset globalPosition) {
    if (!_recording || !_holdMode || _pointerStart == null) return;
    final dx = (globalPosition.dx - _pointerStart!.dx).clamp(-160.0, 0.0);
    final cancel = dx.abs() >= _cancelThreshold;
    if (cancel != _willCancel) {
      HapticFeedback.selectionClick();
    }
    setState(() {
      _slideDx = dx;
      _willCancel = cancel;
    });
  }

  void _onCancelTap() {
    unawaited(_finishRecording(send: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final borderColor =
            (isDarkMode ? AppColors.darkBorder : Colors.grey.shade300)
                .withOpacity(0.55);
        final fieldBg = ChatRoomGlassSurface.fieldGlassColor(isDarkMode);
        final hintColor =
            isDarkMode ? AppColors.darkDescription : Colors.grey.shade500;
        final textColor = isDarkMode ? AppColors.darkTitle : AppColors.title;

        final controller = widget.controller;
        if (controller is HashtagTextEditingController) {
          controller.hashtagStyle = TextStyle(
            color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
            height: 1.2,
            fontFamily: 'Tajawal',
            fontFamilyFallback: const [
              'Apple Color Emoji',
              'Segoe UI Emoji',
              'Noto Color Emoji',
              'Android Emoji',
            ],
          );
        }

        // Keep the idle mic Listener mounted during hold-recording so the
        // active pointer is never cancelled by a rebuild (that was aborting send).
        // Bottom safe-area / keyboard gap lives in the parent spacer — not here.
        final bottomPad = 8.h;

        return ChatRoomGlassSurface(
          isDark: isDarkMode,
          border: Border(
            top: BorderSide(color: borderColor, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_previewUrl != null && !_recording)
                ChatLinkComposerPreview(
                  url: _previewUrl!,
                  meta: _previewMeta,
                  loading: _previewLoading,
                  isDark: isDarkMode,
                  onDismiss: _dismissComposerPreview,
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, bottomPad),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Idle composer stays in tree (invisible) while holding.
                    Offstage(
                      offstage: _recording && !_holdMode,
                      child: Opacity(
                        opacity: _recording ? 0 : 1,
                        child: _buildIdleRow(
                          isDarkMode: isDarkMode,
                          borderColor: borderColor,
                          fieldBg: fieldBg,
                          hintColor: hintColor,
                          textColor: textColor,
                        ),
                      ),
                    ),
                    if (_recording)
                      IgnorePointer(
                        // Hold: let events fall through to the still-mounted mic.
                        ignoring: _holdMode,
                        child: _buildRecordingRow(isDarkMode: isDarkMode),
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

  Widget _buildIdleRow({
    required bool isDarkMode,
    required Color borderColor,
    required Color fieldBg,
    required Color hintColor,
    required Color textColor,
  }) {
    final isRtlLocale = context.isRTL;

    // WhatsApp-style: +/-/send stay on the bottom edge as the field grows.
    final lineHeight = 15.sp * 1.25;
    final maxFieldHeight = _barHeight + (lineHeight * (_maxInputLines - 1));

    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: _recording || widget.isEditing,
          child: Opacity(
            opacity: widget.isEditing ? 0.35 : 1,
            child: _CircleIconButton(
              size: _barHeight,
              onPressed: widget.isEditing ? () {} : widget.onAttach,
              backgroundColor: fieldBg,
              icon: widget.attachmentPanelOpen
                  ? Icons.keyboard_rounded
                  : Icons.add_rounded,
              iconColor: widget.attachmentPanelOpen
                  ? (isDarkMode ? AppColors.darkTitle : AppColors.title)
                  : hintColor,
              borderColor: borderColor,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final fieldStyle = TextStyle(
                fontSize: 15.sp,
                height: 1.25,
                color: textColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal',
                fontFamilyFallback: const [
                  'Apple Color Emoji',
                  'Segoe UI Emoji',
                  'Noto Color Emoji',
                  'Android Emoji',
                ],
              );
              final textDir = widget.hasText
                  ? _textDirection
                  : (isRtlLocale ? TextDirection.rtl : TextDirection.ltr);

              // Draw the pill ourselves and keep emoji outside InputDecoration.
              // suffixIcon + expands both break equal top/bottom text inset.
              final verticalPad =
                  ((_barHeight - lineHeight) / 2).clamp(0.0, 12.0);
              final focusListenable =
                  widget.focusNode ?? const AlwaysStoppedAnimation<int>(0);

              return IgnorePointer(
                ignoring: _recording,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.center,
                  child: ListenableBuilder(
                    listenable: focusListenable,
                    builder: (context, _) {
                      final focused = widget.focusNode?.hasFocus ?? false;
                      final activeBorder = focused
                          ? (isDarkMode
                              ? AppColors.darkPrimary
                              : AppColors.primary)
                          : borderColor;

                      return Container(
                        width: constraints.maxWidth,
                        constraints: BoxConstraints(
                          minHeight: _barHeight,
                          maxHeight: maxFieldHeight,
                        ),
                        decoration: BoxDecoration(
                          color: fieldBg,
                          borderRadius: BorderRadius.circular(_barHeight / 2),
                          border: Border.all(color: activeBorder),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: widget.controller,
                                  focusNode: widget.focusNode,
                                  onTap: (widget.attachmentPanelOpen ||
                                          widget.emojiPanelOpen)
                                      ? widget.onOpenKeyboard
                                      : null,
                                  onChanged: (value) {
                                    _syncTextDirection();
                                    widget.onChanged?.call(value);
                                  },
                                  onSubmitted: (_) {
                                    if (widget.hasText) {
                                      widget.onSendText();
                                    }
                                  },
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: _maxInputLines,
                                  textDirection: textDir,
                                  // start follows textDirection (RTL/LTR) so
                                  // mixed Arabic + emoji stay tightly packed.
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.center,
                                  cursorOpacityAnimates: true,
                                  enableSuggestions: true,
                                  contextMenuBuilder:
                                      (context, editableTextState) {
                                    if (SystemContextMenu.isSupported(
                                        context)) {
                                      return SystemContextMenu.editableText(
                                        editableTextState: editableTextState,
                                      );
                                    }
                                    final items =
                                        List<ContextMenuButtonItem>.of(
                                      editableTextState.contextMenuButtonItems,
                                    );
                                    final hasPaste = items.any(
                                      (item) =>
                                          item.type ==
                                          ContextMenuButtonType.paste,
                                    );
                                    if (!hasPaste) {
                                      items.insert(
                                        0,
                                        ContextMenuButtonItem(
                                          type: ContextMenuButtonType.paste,
                                          onPressed: () {
                                            editableTextState.pasteText(
                                              SelectionChangedCause.toolbar,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                    return AdaptiveTextSelectionToolbar
                                        .buttonItems(
                                      anchors:
                                          editableTextState.contextMenuAnchors,
                                      buttonItems: items,
                                    );
                                  },
                                  style: fieldStyle,
                                  strutStyle: StrutStyle(
                                    fontSize: 15.sp,
                                    height: 1.25,
                                    forceStrutHeight: true,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                  cursorColor: AppColors.primary,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    isDense: true,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    filled: false,
                                    hintText: null,
                                    // Equal top/bottom so glyphs sit centered
                                    // inside the fixed pill height.
                                    contentPadding: EdgeInsets.fromLTRB(
                                      12.w,
                                      verticalPad,
                                      4.w,
                                      verticalPad,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: _barHeight,
                                height: _barHeight,
                                child: IconButton(
                                  onPressed: widget.onEmoji ?? () {},
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: _barHeight,
                                    minHeight: _barHeight,
                                  ),
                                  icon: Icon(
                                    widget.emojiPanelOpen
                                        ? Icons.keyboard_rounded
                                        : Icons.emoji_emotions_outlined,
                                    color: widget.emojiPanelOpen
                                        ? (isDarkMode
                                            ? AppColors.darkPrimary
                                            : AppColors.primary)
                                        : hintColor,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 8.w),
        widget.hasText
            ? IgnorePointer(
                ignoring: _recording,
                child: _CircleIconButton(
                  size: _barHeight,
                  onPressed: widget.onSendText,
                  backgroundColor: AppColors.primary,
                  icon: widget.isEditing
                      ? Icons.check_rounded
                      : Icons.send_rounded,
                  iconColor: Colors.white,
                ),
              )
            // Mic Listener must stay mounted + hittable during hold-to-send.
            : Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: (e) {
                  if (widget.hasText || _recording || _starting) return;
                  _holdArmTimer?.cancel();
                  _pointerActive = true;
                  _holdArmed = false;
                  _finishHoldWhenReady = false;
                  _cancelHoldWhenReady = false;
                  _pointerStart = e.position;
                  _slideDx = 0;
                  _willCancel = false;
                  _holdArmTimer = Timer(const Duration(milliseconds: 140), () {
                    if (!_pointerActive || _recording || _starting) {
                      return;
                    }
                    _holdArmed = true;
                    unawaited(_startRecording(locked: false));
                  });
                },
                onPointerMove: (e) {
                  if (_holdArmed || _holdMode) {
                    _updateHoldSlide(e.position);
                  }
                },
                onPointerUp: (_) {
                  _holdArmTimer?.cancel();
                  final wasArmed = _holdArmed;
                  _pointerActive = false;
                  if (!wasArmed && !_recording && !_starting) {
                    unawaited(_startRecording(locked: true));
                    return;
                  }
                  _requestHoldFinish(send: !_willCancel);
                },
                onPointerCancel: (_) {
                  _holdArmTimer?.cancel();
                  _pointerActive = false;
                  if (_holdArmed || _holdMode) {
                    _requestHoldFinish(send: !_willCancel);
                  }
                },
                child: const SizedBox(
                  width: _barHeight,
                  height: _barHeight,
                  child: Material(
                    color: AppColors.primary,
                    shape: CircleBorder(),
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Icon(
                        Icons.mic_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildRecordingRow({required bool isDarkMode}) {
    final surface = isDarkMode
        ? Colors.white.withOpacity(0.08)
        : AppColors.primary.withOpacity(0.06);
    final cancelSurface = const Color(0xFFEF4444).withOpacity(0.12);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      height: 56.h,
      padding: EdgeInsets.fromLTRB(4.w, 0, _lockedMode ? 4.w : 8.w, 0),
      decoration: BoxDecoration(
        color: _willCancel ? cancelSurface : surface,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: _willCancel
              ? const Color(0xFFEF4444).withOpacity(0.35)
              : (isDarkMode
                  ? Colors.white.withOpacity(0.08)
                  : AppColors.primary.withOpacity(0.12)),
        ),
      ),
      child: Row(
        children: [
          if (_lockedMode)
            _RecIconButton(
              onTap: _onCancelTap,
              color: const Color(0xFFEF4444).withOpacity(0.14),
              icon: Icons.delete_rounded,
              iconColor: const Color(0xFFEF4444),
            )
          else
            SizedBox(width: 6.w),
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, _) {
              final t = _pulse.value;
              return Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEF4444),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(0xFFEF4444).withOpacity(0.25 + t * 0.45),
                      blurRadius: 6 + t * 10,
                      spreadRadius: t * 2,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(width: 8.w),
          Text(
            _format(_elapsed),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              fontFeatures: const [FontFeature.tabularFigures()],
              color: _willCancel
                  ? const Color(0xFFEF4444)
                  : (isDarkMode ? Colors.white : AppColors.title),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (context, _) {
                return _LiveWaveform(
                  level: _amp,
                  pulse: _pulse.value,
                  cancel: _willCancel,
                  isDark: isDarkMode,
                );
              },
            ),
          ),
          // Hold: slide-to-cancel hint + visible sliding mic.
          if (_holdMode) ...[
            SizedBox(width: 8.w),
            Flexible(
              child: Transform.translate(
                offset: Offset(_slideDx * 0.2, 0),
                child: Opacity(
                  opacity: (1 - (_slideDx.abs() / 140)).clamp(0.3, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!_willCancel) _SlideChevrons(isDark: isDarkMode),
                      Flexible(
                        child: Text(
                          _willCancel
                              ? context.tr(AppStrings.releaseToCancel)
                              : context.tr(AppStrings.slideToCancel),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: _willCancel
                                ? const Color(0xFFEF4444)
                                : (isDarkMode
                                    ? Colors.white60
                                    : AppColors.description),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Transform.translate(
              offset: Offset(_slideDx, 0),
              child: _micOrb(
                cancel: _willCancel,
                icon: _willCancel ? Icons.delete_rounded : Icons.mic_rounded,
                ampBoost: true,
              ),
            ),
          ],
          if (_lockedMode) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTapDown: (_) {
                if (_finishing) return;
                setState(() => _sendPressed = true);
              },
              onTapCancel: () {
                if (mounted) setState(() => _sendPressed = false);
              },
              onTapUp: (_) {
                if (_finishing) return;
                setState(() => _sendPressed = false);
                unawaited(_finishRecording(send: true));
              },
              child: AnimatedScale(
                scale: _sendPressed ? 0.86 : 1.0,
                duration: const Duration(milliseconds: 90),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: _finishing ? 0.65 : 1,
                  duration: const Duration(milliseconds: 120),
                  child: _micOrb(
                    cancel: false,
                    icon: Icons.send_rounded,
                    ampBoost: false,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _micOrb({
    required bool cancel,
    required IconData icon,
    required bool ampBoost,
  }) {
    final color = cancel ? const Color(0xFFEF4444) : AppColors.primary;
    final scale = cancel
        ? 0.92
        : (ampBoost ? (1.0 + (_amp.clamp(0.0, 1.0) * 0.14)) : 1.0);
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final ring = cancel ? 0.0 : (0.35 + _pulse.value * 0.55);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 52.r,
            height: 52.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.28 + ring * 0.22),
                  blurRadius: 12 + ring * 10,
                  spreadRadius: ring * 1.5,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 160),
        child: Icon(
          icon,
          key: ValueKey(icon.codePoint),
          color: Colors.white,
          size: 22.sp,
        ),
      ),
    );
  }
}

class _RecIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final IconData icon;
  final Color iconColor;

  const _RecIconButton({
    required this.onTap,
    required this.color,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Material(
        color: color,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 40.r,
            height: 40.r,
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
        ),
      ),
    );
  }
}

class _SlideChevrons extends StatelessWidget {
  final bool isDark;

  const _SlideChevrons({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final color =
        isDark ? Colors.white38 : AppColors.description.withOpacity(0.7);
    return SizedBox(
      width: 18.w,
      child: Row(
        children: [
          Icon(Icons.chevron_left_rounded,
              size: 14.sp, color: color.withOpacity(0.45)),
          Transform.translate(
            offset: Offset(-6.w, 0),
            child: Icon(Icons.chevron_left_rounded, size: 14.sp, color: color),
          ),
        ],
      ),
    );
  }
}

class _LiveWaveform extends StatelessWidget {
  final double level;
  final double pulse;
  final bool cancel;
  final bool isDark;

  const _LiveWaveform({
    required this.level,
    required this.pulse,
    required this.cancel,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final base = cancel
        ? const Color(0xFFEF4444)
        : (isDark ? Colors.white : AppColors.primary);
    return SizedBox(
      height: 28.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(18, (i) {
          final mid = (i - 8.5).abs() / 8.5;
          final wave = (0.35 + level * 0.65) * (1 - mid * 0.35) +
              (pulse * 0.2 * (i.isEven ? 1 : 0.55));
          final h = (6.h + 20.h * wave.clamp(0.15, 1.0));
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 70),
                curve: Curves.easeOut,
                height: h,
                decoration: BoxDecoration(
                  color: base.withOpacity(0.35 + wave * 0.45),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final double size;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final Color? borderColor;

  const _CircleIconButton({
    required this.size,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: backgroundColor,
        shape: CircleBorder(
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 1)
              : BorderSide.none,
        ),
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Center(
            child: Icon(icon, color: iconColor, size: 18),
          ),
        ),
      ),
    );
  }
}
