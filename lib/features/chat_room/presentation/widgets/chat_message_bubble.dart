import 'dart:ui' as ui;

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/app/shared/functions/chat_text_direction.dart';
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_cubit.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_file_bubble.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_link_preview.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_reply_banner.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_bubble.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_duration_cache.dart';

const _kBubbleBaseBottomPadding = 6.0;

/// Extra space under the bubble when a reaction is present (animated in).
const _kReactionReserve = 18.0;

/// How far the badge hangs below the bubble into the reserved space.
const _kReactionHang = 16.0;

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageItem message;
  final String? peerImageUrl;
  final String peerInitials;
  final bool isGroup;
  final void Function(Rect anchorRect)? onLongPress;
  final VoidCallback? onResend;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onReactionTap;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.peerInitials,
    this.peerImageUrl,
    this.isGroup = false,
    this.onLongPress,
    this.onResend,
    this.onCancelUpload,
    this.onReactionTap,
    this.onReplyQuoteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChatMessageBubbleContent(
      message: message,
      peerInitials: peerInitials,
      peerImageUrl: peerImageUrl,
      isGroup: isGroup,
      onLongPress: onLongPress,
      onResend: onResend,
      onCancelUpload: onCancelUpload,
      onReactionTap: onReactionTap,
      onReplyQuoteTap: onReplyQuoteTap,
    );
  }
}

/// Time + delivery ticks shown inside the message bubble.
class ChatMessageMetaRow extends StatelessWidget {
  final ChatMessageItem message;
  final bool alignEnd;
  final bool onPrimaryBackground;

  const ChatMessageMetaRow({
    super.key,
    required this.message,
    this.alignEnd = false,
    this.onPrimaryBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final timeColor = onPrimaryBackground
            ? Colors.white.withOpacity(0.78)
            : (isDarkMode ? AppColors.darkDescription : AppColors.description);

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (message.isEdited) ...[
              Text(
                context.tr(AppStrings.edited),
                style: TextStyle(
                  fontSize: 9.5.sp,
                  fontStyle: FontStyle.italic,
                  color: timeColor,
                ),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              message.timeLabel,
              style: TextStyle(
                fontSize: 10.sp,
                color: timeColor,
              ),
            ),
            if (message.isOutgoing &&
                message.status != ChatMessageStatus.failed) ...[
              SizedBox(width: 3.w),
              _MessageStatusTicks(
                status: message.isUploading
                    ? ChatMessageStatus.sending
                    : message.status,
                onPrimaryBackground: onPrimaryBackground,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _MessageStatusTicks extends StatelessWidget {
  final ChatMessageStatus status;
  final bool onPrimaryBackground;

  const _MessageStatusTicks({
    required this.status,
    required this.onPrimaryBackground,
  });

  @override
  Widget build(BuildContext context) {
    // Delivered / sent stay muted; seen uses a clear blue so it's obvious.
    final muted = onPrimaryBackground
        ? Colors.white.withOpacity(0.72)
        : const Color(0xFF9CA3AF);
    final seenColor = onPrimaryBackground
        ? const Color(0xFF7DD3FC) // light sky on purple bubble
        : const Color(0xFF34B7F1); // WhatsApp-like blue

    switch (status) {
      case ChatMessageStatus.sending:
      case ChatMessageStatus.pending:
        return Icon(
          Icons.access_time_rounded,
          size: 13.sp,
          color: muted,
        );
      case ChatMessageStatus.failed:
        return Icon(
          Icons.error_outline_rounded,
          size: 14.sp,
          color: const Color(0xFFEF4444),
        );
      case ChatMessageStatus.sent:
        return Icon(
          Icons.done_rounded,
          size: 14.sp,
          color: muted,
        );
      case ChatMessageStatus.delivered:
        return Icon(
          Icons.done_all_rounded,
          size: 14.sp,
          color: muted,
        );
      case ChatMessageStatus.seen:
        return Icon(
          Icons.done_all_rounded,
          size: 14.sp,
          color: seenColor,
        );
    }
  }
}

/// The bubble card only (text + time inside). Used in list and overlay.
/// WhatsApp-style "Forwarded" label at the top of a bubble.
class _ForwardedHint extends StatelessWidget {
  final bool isOutgoing;
  final bool isDarkMode;

  const _ForwardedHint({
    required this.isOutgoing,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final color = isOutgoing
        ? Colors.white.withOpacity(0.78)
        : (isDarkMode ? AppColors.darkDescription : const Color(0xFF8696A0));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.shortcut_rounded,
          size: 12.sp,
          color: color,
        ),
        SizedBox(width: 4.w),
        Text(
          context.tr(AppStrings.forwarded),
          style: TextStyle(
            fontSize: 11.sp,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: color,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class MessageBubbleCard extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final bool isOutgoing;
  final String? peerImageUrl;
  final String? peerInitials;
  final bool isGroup;
  final bool showSenderName;

  /// When set (overlay), image grid shrinks so padding + meta fit without overflow.
  final double? maxHeight;
  final void Function(Rect anchorRect)? onLongPress;
  final VoidCallback? onResend;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onReactionTap;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;

  const MessageBubbleCard({
    super.key,
    required this.message,
    required this.isDarkMode,
    required this.isOutgoing,
    this.peerImageUrl,
    this.peerInitials,
    this.isGroup = false,
    this.showSenderName = false,
    this.maxHeight,
    this.onLongPress,
    this.onResend,
    this.onCancelUpload,
    this.onReactionTap,
    this.onReplyQuoteTap,
  });

  @override
  Widget build(BuildContext context) {
    return _ChatDeleteMorph(
      key: ValueKey('delete_morph_${message.id}'),
      isDeleting: message.isDeleting,
      isDeleted: message.isDeleted,
      isOutgoing: isOutgoing,
      deleted: _DeletedMessageBubble(
        message: message,
        isDarkMode: isDarkMode,
        isOutgoing: isOutgoing,
      ),
      live: _LiveMessageBubbleBody(
        message: message,
        isDarkMode: isDarkMode,
        isOutgoing: isOutgoing,
        peerImageUrl: peerImageUrl,
        peerInitials: peerInitials,
        isGroup: isGroup,
        showSenderName: showSenderName,
        maxHeight: maxHeight,
        onLongPress: onLongPress,
        onResend: onResend,
        onCancelUpload: onCancelUpload,
        onReactionTap: onReactionTap,
        onReplyQuoteTap: onReplyQuoteTap,
      ),
    );
  }
}

/// Dramatic fold-away → spring-in morph between live bubble and deleted hint.
class _ChatDeleteMorph extends StatefulWidget {
  final bool isDeleting;
  final bool isDeleted;
  final bool isOutgoing;
  final Widget live;
  final Widget deleted;

  const _ChatDeleteMorph({
    super.key,
    required this.isDeleting,
    required this.isDeleted,
    required this.isOutgoing,
    required this.live,
    required this.deleted,
  });

  @override
  State<_ChatDeleteMorph> createState() => _ChatDeleteMorphState();
}

class _ChatDeleteMorphState extends State<_ChatDeleteMorph>
    with TickerProviderStateMixin {
  late final AnimationController _fold;
  late final AnimationController _reveal;

  late final Animation<double> _foldScaleX;
  late final Animation<double> _foldScaleY;
  late final Animation<double> _foldFade;
  late final Animation<double> _foldBlur;
  late final Animation<Offset> _foldSlide;
  late final Animation<double> _foldTilt;

  late final Animation<double> _revealScale;
  late final Animation<double> _revealFade;
  late final Animation<Offset> _revealSlide;
  late final Animation<double> _iconPop;

  @override
  void initState() {
    super.initState();
    _fold = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _reveal = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 460),
    );

    final foldCurve = CurvedAnimation(
      parent: _fold,
      curve: Curves.easeInCubic,
    );
    _foldScaleX = Tween<double>(begin: 1, end: 0.72).animate(foldCurve);
    _foldScaleY = Tween<double>(begin: 1, end: 0.88).animate(foldCurve);
    _foldFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _fold,
        curve: const Interval(0.15, 0.95, curve: Curves.easeOut),
      ),
    );
    _foldBlur = Tween<double>(begin: 0, end: 6).animate(foldCurve);
    _foldSlide = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(widget.isOutgoing ? 0.08 : -0.08, 0.04),
    ).animate(foldCurve);
    _foldTilt = Tween<double>(
      begin: 0,
      end: widget.isOutgoing ? 0.04 : -0.04,
    ).animate(foldCurve);

    final revealCurve = CurvedAnimation(
      parent: _reveal,
      curve: Curves.easeOutCubic,
    );
    _revealScale = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(parent: _reveal, curve: Curves.easeOutBack),
    );
    _revealFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _reveal,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    _revealSlide = Tween<Offset>(
      begin: Offset(widget.isOutgoing ? 0.12 : -0.12, 0.18),
      end: Offset.zero,
    ).animate(revealCurve);
    _iconPop = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.4, end: 1.18), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 1.18, end: 1.0), weight: 45),
    ]).animate(
      CurvedAnimation(parent: _reveal, curve: Curves.easeOutCubic),
    );

    if (widget.isDeleted) {
      _fold.value = 1;
      _reveal.value = 1;
    } else if (widget.isDeleting) {
      _fold.forward();
    }
  }

  @override
  void didUpdateWidget(covariant _ChatDeleteMorph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDeleting && !oldWidget.isDeleting && !widget.isDeleted) {
      _reveal.value = 0;
      _fold.forward(from: 0);
    }
    // API failed while folding — unfold back to the original message.
    if (!widget.isDeleting &&
        oldWidget.isDeleting &&
        !widget.isDeleted &&
        !oldWidget.isDeleted) {
      _reveal.value = 0;
      if (_fold.value > 0) {
        _fold.reverse();
      }
    }
    if (widget.isDeleted && !oldWidget.isDeleted) {
      if (_fold.status != AnimationStatus.completed) {
        _fold.value = 1;
      }
      _reveal.forward(from: 0);
    }
    if (!widget.isDeleted && !widget.isDeleting && oldWidget.isDeleted) {
      _reveal.value = 0;
      _fold.value = 0;
    }
  }

  @override
  void dispose() {
    _fold.dispose();
    _reveal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final align =
        widget.isOutgoing ? Alignment.centerRight : Alignment.centerLeft;

    if (widget.isDeleted) {
      return AnimatedBuilder(
        animation: _reveal,
        builder: (context, _) {
          return FadeTransition(
            opacity: _revealFade,
            child: SlideTransition(
              position: _revealSlide,
              child: ScaleTransition(
                scale: _revealScale,
                alignment: align,
                child: _DeletedIconScaleScope(
                  scale: _iconPop.value,
                  child: widget.deleted,
                ),
              ),
            ),
          );
        },
      );
    }

    return AnimatedBuilder(
      animation: _fold,
      builder: (context, _) {
        return SlideTransition(
          position: _foldSlide,
          child: Transform.rotate(
            angle: _foldTilt.value,
            alignment: align,
            child: Transform(
              alignment: align,
              transform: Matrix4.diagonal3Values(
                _foldScaleX.value,
                _foldScaleY.value,
                1,
              ),
              child: Opacity(
                opacity: _foldFade.value.clamp(0.0, 1.0),
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: _foldBlur.value,
                    sigmaY: _foldBlur.value,
                  ),
                  child: widget.live,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Lets [_DeletedMessageBubble] read the pop scale for its block icon.
class _DeletedIconScaleScope extends InheritedWidget {
  final double scale;

  const _DeletedIconScaleScope({
    required this.scale,
    required super.child,
  });

  static double of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<_DeletedIconScaleScope>()
            ?.scale ??
        1;
  }

  @override
  bool updateShouldNotify(_DeletedIconScaleScope oldWidget) =>
      scale != oldWidget.scale;
}

/// Extracted live bubble body so [MessageBubbleCard] can morph to deleted.
class _LiveMessageBubbleBody extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final bool isOutgoing;
  final String? peerImageUrl;
  final String? peerInitials;
  final bool isGroup;
  final bool showSenderName;
  final double? maxHeight;
  final void Function(Rect anchorRect)? onLongPress;
  final VoidCallback? onResend;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onReactionTap;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;

  const _LiveMessageBubbleBody({
    super.key,
    required this.message,
    required this.isDarkMode,
    required this.isOutgoing,
    this.peerImageUrl,
    this.peerInitials,
    this.isGroup = false,
    this.showSenderName = false,
    this.maxHeight,
    this.onLongPress,
    this.onResend,
    this.onCancelUpload,
    this.onReactionTap,
    this.onReplyQuoteTap,
  });

  @override
  Widget build(BuildContext context) {
    final reactionEmojis = message.reactions
        .map((g) => g.emoji.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    final hasReaction = reactionEmojis.isNotEmpty ||
        (message.reactionEmoji != null &&
            message.reactionEmoji!.trim().isNotEmpty);

    final imageAttachments =
        message.attachments.where((a) => a.isImage).toList(growable: false);
    final voiceAttachments =
        message.attachments.where((a) => a.isVoice).toList(growable: false);
    final fileAttachments =
        message.attachments.where((a) => a.isFile).toList(growable: false);
    final hasAttachmentImages = imageAttachments.isNotEmpty;
    final hasVoice = voiceAttachments.isNotEmpty;
    final hasFiles = fileAttachments.isNotEmpty;
    final hasCaptionText = message.text.isNotEmpty &&
        !ChatMappers.isImagePlaceholder(message.text) &&
        !ChatMappers.isVoicePlaceholder(message.text) &&
        !ChatMappers.isFilePlaceholder(message.text) &&
        message.text != '[Attachment]' &&
        !message.text.startsWith('[File:');
    // WhatsApp: for voice-only bubbles, time sits next to duration.
    final embedVoiceMeta = hasVoice && !hasCaptionText && !hasFiles;
    final linkUrlInText = hasCaptionText ? firstChatUrl(message.text) : null;
    final hasLinkPreview = linkUrlInText != null;
    final urlOnlyLink = hasLinkPreview && isChatUrlOnlyMessage(message.text);
    // Full-bleed preview (image/title flush to bubble edges), like WhatsApp.
    final linkEdgeBleed =
        hasLinkPreview && !hasAttachmentImages && !hasVoice && !hasFiles;

    final padT = linkEdgeBleed
        ? 0.0
        : (hasAttachmentImages ? 3.h : (hasVoice || hasFiles ? 5.h : 8.h));
    // Keep bottom padding stable — reactions hang outside and must not
    // grow/shrink the bubble when added or removed.
    final padB = embedVoiceMeta
        ? 5.h
        : (linkEdgeBleed ? 4.h : (hasVoice || hasFiles ? 4.h : 3.h));
    final hPad = linkEdgeBleed
        ? 0.0
        : (hasAttachmentImages ? 3.w : (hasVoice || hasFiles ? 3.w : 12.w));
    final chromeH = padT +
        padB +
        (showSenderName ? 18.h : 0) +
        (message.isForwarded ? 18.h : 0) +
        (message.replyTo != null ? 40.h : 0) +
        (hasCaptionText ? 28.h : 0) +
        (embedVoiceMeta ? 0 : (hasVoice ? 6.h : 4.h) + 18.h) +
        12.h; // buffer so meta/ticks never clip under tight overlay max

    double? imageMaxHeight;
    if (maxHeight != null && maxHeight!.isFinite && hasAttachmentImages) {
      imageMaxHeight = (maxHeight! - chromeH).clamp(80.h, 220.h);
    }

    // Link OG image (5:4) is often taller than the overlay budget — shrink it
    // so title/description/ticks still fit without RenderFlex overflow.
    double? linkImageMaxHeight;
    if (maxHeight != null && maxHeight!.isFinite && hasLinkPreview) {
      final linkMetaReserve = 88.h; // title + desc + host strip
      linkImageMaxHeight =
          (maxHeight! - chromeH - linkMetaReserve).clamp(48.h, 160.h);
    }

    final bubbleRadius = BorderRadius.only(
      topLeft: Radius.circular(14.r),
      topRight: Radius.circular(14.r),
      bottomLeft: Radius.circular(isOutgoing ? 14.r : 4.r),
      bottomRight: Radius.circular(isOutgoing ? 4.r : 14.r),
    );

    final rawCard = Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.fromLTRB(hPad, padT, hPad, padB),
      decoration: BoxDecoration(
        color: isOutgoing
            ? AppColors.primary
            : (isDarkMode ? AppColors.darkCardBG : Colors.white),
        borderRadius: bubbleRadius,
        boxShadow: isOutgoing
            ? null
            : (isDarkMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]),
      ),
      child: Column(
        crossAxisAlignment: message.replyTo != null || linkEdgeBleed
            ? CrossAxisAlignment.stretch
            : (isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start),
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showSenderName && message.senderName.trim().isNotEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 8.w
                    : 0,
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 4.h
                    : 0,
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 8.w
                    : 0,
                2.h,
              ),
              child: Text(
                message.senderName.trim(),
                style: TextStyle(
                  color: _groupSenderNameColor(
                    message.senderId,
                    message.senderName,
                  ),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (message.isForwarded)
            Padding(
              padding: EdgeInsets.fromLTRB(
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 8.w
                    : 0,
                showSenderName
                    ? 0
                    : (hasAttachmentImages ||
                            hasVoice ||
                            hasFiles ||
                            linkEdgeBleed
                        ? 4.h
                        : 0),
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 8.w
                    : 0,
                4.h,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _ForwardedHint(
                  isOutgoing: isOutgoing,
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
          // Reply quote banner.
          if (message.replyTo != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 8.w
                    : 0,
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 4.h
                    : 0,
                hasAttachmentImages || hasVoice || hasFiles || linkEdgeBleed
                    ? 8.w
                    : 0,
                0,
              ),
              child: _ReplyQuoteBanner(
                reply: message.replyTo!,
                isOutgoing: isOutgoing,
                isDarkMode: isDarkMode,
                onTap: onReplyQuoteTap == null
                    ? null
                    : () => onReplyQuoteTap!(message.replyTo!),
              ),
            ),
          // Image attachments.
          if (hasAttachmentImages)
            _ImageAttachmentGrid(
              attachments: imageAttachments,
              isUploading: message.isUploading,
              showRetry: message.needsMediaUploadRetry,
              uploadProgress: message.uploadProgress ?? 0,
              isOutgoing: isOutgoing,
              maxHeight: imageMaxHeight,
              onCancelUpload: onCancelUpload,
              onRetryUpload: onResend,
            ),
          // Voice notes.
          if (hasVoice)
            Padding(
              padding: EdgeInsets.zero,
              child: Builder(
                builder: (context) {
                  String? senderImageUrl;
                  String? senderInitials;
                  if (isOutgoing) {
                    try {
                      senderImageUrl = context.read<ChatRoomCubit>().myImageUrl;
                    } catch (_) {}
                  } else if (isGroup &&
                      (message.senderImageUrl != null &&
                          message.senderImageUrl!.isNotEmpty)) {
                    senderImageUrl = message.senderImageUrl;
                    senderInitials = message.senderInitials;
                  } else {
                    senderImageUrl = peerImageUrl;
                    senderInitials = peerInitials;
                  }
                  return Column(
                    children: [
                      for (final voice in voiceAttachments)
                        ChatVoiceBubble(
                          attachment: voice,
                          isOutgoing: isOutgoing,
                          isDarkMode: isDarkMode,
                          senderImageUrl: senderImageUrl,
                          senderInitials: senderInitials,
                          timeLabel: embedVoiceMeta ? message.timeLabel : null,
                          status: embedVoiceMeta ? message.status : null,
                        ),
                    ],
                  );
                },
              ),
            ),
          // Document / file attachments (Bearer auth download).
          if (hasFiles)
            Padding(
              padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 2.h),
              child: Builder(
                builder: (context) {
                  return Column(
                    crossAxisAlignment: isOutgoing
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      for (final file in fileAttachments) ...[
                        ChatFileBubble(
                          attachment: file,
                          isOutgoing: isOutgoing,
                          isDarkMode: isDarkMode,
                          isUploading: message.isUploading,
                          showRetry: message.needsMediaUploadRetry,
                          uploadProgress: message.uploadProgress ?? 0,
                          onCancelUpload: onCancelUpload,
                          onRetryUpload: onResend,
                          onExpired: () {
                            try {
                              context
                                  .read<ChatRoomCubit>()
                                  .refreshSignedAttachmentUrls();
                            } catch (_) {}
                          },
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ],
                  );
                },
              ),
            ),
          if (hasCaptionText)
            Padding(
              padding: EdgeInsets.only(
                left: (hasAttachmentImages || hasVoice || hasFiles) ? 8.w : 0,
                right: (hasAttachmentImages || hasVoice || hasFiles) ? 8.w : 0,
                top: message.attachments.isNotEmpty
                    ? 6.h
                    : (message.replyTo != null ? 2.h : 0),
              ),
              child: Builder(
                builder: (context) {
                  final linkUrl = linkUrlInText;
                  final urlOnly = urlOnlyLink;
                  // When preview is shown, hide the URL itself and drop the
                  // blank line from "paste link → Enter → hello".
                  final displayText = linkUrl != null
                      ? chatCaptionWithoutPreviewUrl(
                          message.text,
                          previewUrl: linkUrl,
                        )
                      : message.text;
                  final showCaption = !urlOnly && displayText.isNotEmpty;
                  final jumboCount = _jumboEmojiCount(displayText);
                  // Slightly larger than default — composer field stays unchanged.
                  final fontSize = jumboCount == null
                      ? 15.sp
                      : jumboCount == 1
                          ? 40.sp
                          : jumboCount == 2
                              ? 34.sp
                              : 28.sp;
                  final baseStyle = TextStyle(
                    color: isOutgoing
                        ? Colors.white
                        : (isDarkMode ? AppColors.darkTitle : AppColors.title),
                    fontSize: fontSize,
                    height: jumboCount == null ? 1.32 : 1.12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Tajawal',
                    fontFamilyFallback: const [
                      'Apple Color Emoji',
                      'Segoe UI Emoji',
                      'Noto Color Emoji',
                      'Android Emoji',
                    ],
                  );
                  final hashtagStyle = baseStyle.copyWith(
                    color: isOutgoing
                        ? const Color(0xFFB3E5FC)
                        : (isDarkMode
                            ? AppColors.darkPrimary
                            : AppColors.primary),
                    fontWeight: FontWeight.w700,
                  );
                  final scope = ChatHashtagScope.maybeOf(context);
                  final textDirection = ChatTextDirection.resolve(displayText);
                  final textWidget = scope != null
                      ? HashtagText(
                          content: displayText,
                          currentDoctorModel: scope.currentDoctorModel,
                          homeDataModel: scope.homeDataModel,
                          disableTrimLines: true,
                          showLinkPreviews: false,
                          style: baseStyle,
                          hashtagStyle: hashtagStyle,
                        )
                      : Text(
                          displayText,
                          style: baseStyle,
                          textDirection: textDirection,
                          textAlign: textDirection == TextDirection.rtl
                              ? TextAlign.right
                              : TextAlign.left,
                        );

                  return Column(
                    crossAxisAlignment: linkUrl != null
                        ? CrossAxisAlignment.stretch
                        : (textDirection == TextDirection.rtl
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (linkUrl != null)
                        ChatLinkBubblePreview(
                          url: linkUrl,
                          isOutgoing: isOutgoing,
                          isDark: isDarkMode,
                          edgeToEdge: linkEdgeBleed,
                          maxImageHeight: linkImageMaxHeight,
                        ),
                      if (showCaption)
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            linkEdgeBleed ? 10.w : 0,
                            linkUrl != null ? 6.h : 0,
                            linkEdgeBleed ? 10.w : 0,
                            0,
                          ),
                          child: Directionality(
                            textDirection: textDirection,
                            child: Align(
                              alignment: textDirection == TextDirection.rtl
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: textWidget,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          if (!embedVoiceMeta) ...[
            SizedBox(
                height:
                    hasVoice || hasFiles ? 4.h : (linkEdgeBleed ? 2.h : 1.h)),
            Padding(
              padding: EdgeInsets.only(
                left: (hasAttachmentImages ||
                        hasVoice ||
                        hasFiles ||
                        linkEdgeBleed)
                    ? 8.w
                    : 0,
                right: (hasAttachmentImages ||
                        hasVoice ||
                        hasFiles ||
                        linkEdgeBleed)
                    ? 8.w
                    : 0,
              ),
              child: ChatMessageMetaRow(
                message: message,
                alignEnd: isOutgoing,
                onPrimaryBackground: isOutgoing,
              ),
            ),
          ],
        ],
      ),
    );

    // Cap width so long AR/EN text wraps. IntrinsicWidth keeps short
    // bubbles tight; link cards use a compact WhatsApp-style width.
    final screenW = MediaQuery.sizeOf(context).width;
    final maxBubbleWidth =
        linkEdgeBleed ? (screenW * 0.70).clamp(220.0, 292.0) : screenW * 0.78;
    final useIntrinsicWidth =
        !hasAttachmentImages && !hasVoice && !hasFiles && !linkEdgeBleed;
    final card = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxBubbleWidth,
        minWidth: linkEdgeBleed ? maxBubbleWidth : 0,
        maxHeight: (maxHeight != null && maxHeight!.isFinite)
            ? maxHeight!
            : double.infinity,
      ),
      child: maxHeight != null && maxHeight!.isFinite
          ? ClipRect(
              // Absorb leftover height so overlay never paints a yellow stripe
              // if link meta / caption still exceeds the shrink budget.
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: useIntrinsicWidth
                    ? IntrinsicWidth(child: rawCard)
                    : rawCard,
              ),
            )
          : (useIntrinsicWidth ? IntrinsicWidth(child: rawCard) : rawCard),
    );

    // Reaction hangs under the bubble into reserved bottom space (not inside card).
    final bubble = Stack(
      clipBehavior: Clip.none,
      children: [
        card,
        if (hasReaction)
          Positioned(
            left: isOutgoing ? null : 2.w,
            right: isOutgoing ? 2.w : null,
            bottom: -_kReactionHang.h - 2.h,
            child: GestureDetector(
              onTap: onReactionTap,
              behavior: HitTestBehavior.opaque,
              child: _AnimatedReactionBadge(
                emojis: reactionEmojis.isNotEmpty
                    ? reactionEmojis
                    : [message.reactionEmoji!.trim()],
                count: message.totalReactionCount > 0
                    ? message.totalReactionCount
                    : reactionEmojis.isNotEmpty
                        ? reactionEmojis.length
                        : 1,
                isDarkMode: isDarkMode,
              ),
            ),
          ),
      ],
    );

    Widget content = bubble;
    if (onLongPress != null) {
      content = _BubbleLongPressTarget(
        onLongPress: onLongPress,
        child: bubble,
      );
    }

    if (!isOutgoing || !message.canResend || onResend == null) {
      return content;
    }

    // Media failures use the center retry control on the attachment itself.
    if (message.needsMediaUploadRetry) {
      return content;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onResend,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(right: 6.w, bottom: 2.h),
                child: Icon(
                  Icons.error_rounded,
                  size: 20.sp,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ),
            Flexible(child: content),
          ],
        ),
        SizedBox(height: 4.h),
        GestureDetector(
          onTap: onResend,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: Text(
              context.tr(AppStrings.resend),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFEF4444),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Shared bubble UI for list items and long-press overlay.
class ChatMessageBubbleContent extends StatelessWidget {
  final ChatMessageItem message;
  final String? peerImageUrl;
  final String peerInitials;
  final bool isGroup;
  final bool inOverlay;
  final double? maxHeight;
  final void Function(Rect anchorRect)? onLongPress;
  final VoidCallback? onResend;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onReactionTap;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;

  const ChatMessageBubbleContent({
    super.key,
    required this.message,
    required this.peerInitials,
    this.peerImageUrl,
    this.isGroup = false,
    this.inOverlay = false,
    this.maxHeight,
    this.onLongPress,
    this.onResend,
    this.onCancelUpload,
    this.onReactionTap,
    this.onReplyQuoteTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        if (message.isSystem) {
          return _SystemHintChip(
            text: message.text,
            isDarkMode: isDarkMode,
          );
        }

        if (inOverlay) {
          return MessageBubbleCard(
            message: message,
            isDarkMode: isDarkMode,
            isOutgoing: message.isOutgoing,
            peerImageUrl: peerImageUrl,
            peerInitials: peerInitials,
            isGroup: isGroup,
            showSenderName: isGroup &&
                !message.isOutgoing &&
                message.showAvatar &&
                message.senderName.trim().isNotEmpty,
            maxHeight: maxHeight,
          );
        }

        if (message.isOutgoing) {
          return _OutgoingBubble(
            message: message,
            isDarkMode: isDarkMode,
            onLongPress: onLongPress,
            onResend: onResend,
            onCancelUpload: onCancelUpload,
            onReactionTap: onReactionTap,
            onReplyQuoteTap: onReplyQuoteTap,
          );
        }
        return _IncomingBubble(
          message: message,
          isDarkMode: isDarkMode,
          peerImageUrl: peerImageUrl,
          peerInitials: peerInitials,
          isGroup: isGroup,
          onLongPress: onLongPress,
          onReactionTap: onReactionTap,
          onReplyQuoteTap: onReplyQuoteTap,
        );
      },
    );
  }
}

/// WhatsApp-style centered system notice (no chat bubble).
class _SystemHintChip extends StatelessWidget {
  final String text;
  final bool isDarkMode;

  const _SystemHintChip({
    required this.text,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final label = text.trim();
    if (label.isEmpty) return const SizedBox.shrink();

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 28.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: (isDarkMode ? Colors.black : Colors.white)
              .withOpacity(isDarkMode ? 0.38 : 0.78),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.06),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            height: 1.25,
            color:
                isDarkMode ? AppColors.darkDescription : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}

class _BubbleLongPressTarget extends StatelessWidget {
  final void Function(Rect anchorRect)? onLongPress;
  final Widget child;

  const _BubbleLongPressTarget({
    required this.child,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    if (onLongPress == null) return child;

    return Builder(
      builder: (targetContext) {
        return GestureDetector(
          onLongPress: () {
            HapticFeedback.lightImpact();
            final box = targetContext.findRenderObject() as RenderBox?;
            if (box == null || !box.hasSize) return;
            final offset = box.localToGlobal(Offset.zero);
            onLongPress!(offset & box.size);
          },
          behavior: HitTestBehavior.opaque,
          child: child,
        );
      },
    );
  }
}

class _OutgoingBubble extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final void Function(Rect anchorRect)? onLongPress;
  final VoidCallback? onResend;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onReactionTap;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;

  const _OutgoingBubble({
    required this.message,
    required this.isDarkMode,
    this.onLongPress,
    this.onResend,
    this.onCancelUpload,
    this.onReactionTap,
    this.onReplyQuoteTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasReaction = message.reactions.isNotEmpty ||
        (message.reactionEmoji != null &&
            message.reactionEmoji!.trim().isNotEmpty);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(
        left: 48.w,
        right: 12.w,
        bottom: hasReaction
            ? (_kBubbleBaseBottomPadding + _kReactionReserve).h
            : _kBubbleBaseBottomPadding.h,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: MessageBubbleCard(
          message: message,
          isDarkMode: isDarkMode,
          isOutgoing: true,
          onLongPress: onLongPress,
          onResend: onResend,
          onCancelUpload: onCancelUpload,
          onReactionTap: onReactionTap,
          onReplyQuoteTap: onReplyQuoteTap,
        ),
      ),
    );
  }
}

class _IncomingBubble extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final String? peerImageUrl;
  final String peerInitials;
  final bool isGroup;
  final void Function(Rect anchorRect)? onLongPress;
  final VoidCallback? onReactionTap;
  final void Function(ChatReplyItem reply)? onReplyQuoteTap;

  const _IncomingBubble({
    required this.message,
    required this.isDarkMode,
    this.peerImageUrl,
    required this.peerInitials,
    this.isGroup = false,
    this.onLongPress,
    this.onReactionTap,
    this.onReplyQuoteTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasReaction = message.reactions.isNotEmpty ||
        (message.reactionEmoji != null &&
            message.reactionEmoji!.trim().isNotEmpty);
    // 1:1 voice notes embed the peer avatar inside the bubble. Groups keep the
    // outer list avatar (WhatsApp) even for voice.
    final hideOuterAvatar = message.hasVoice && !isGroup;
    final avatarUrl = isGroup
        ? (message.senderImageUrl?.isNotEmpty == true
            ? message.senderImageUrl
            : peerImageUrl)
        : peerImageUrl;
    final avatarInitials = isGroup && message.senderInitials.isNotEmpty
        ? message.senderInitials
        : peerInitials;
    final showSenderName =
        isGroup && message.showAvatar && message.senderName.trim().isNotEmpty;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(
        left: 12.w,
        right: 48.w,
        bottom: hasReaction
            ? (_kBubbleBaseBottomPadding + _kReactionReserve).h
            : _kBubbleBaseBottomPadding.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isGroup) ...[
            if (!hideOuterAvatar && message.showAvatar)
              Padding(
                padding: EdgeInsets.only(right: 6.w, bottom: 4.h),
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: avatarUrl != null && avatarUrl.isNotEmpty
                      ? ClipOval(
                          child: CustomCachedNetworkImage(
                            imageUrl: avatarUrl,
                            width: 24.r,
                            height: 24.r,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          avatarInitials,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp,
                          ),
                        ),
                ),
              )
            else if (!hideOuterAvatar)
              SizedBox(width: 30.w),
          ],
          Flexible(
            child: MessageBubbleCard(
              message: message,
              isDarkMode: isDarkMode,
              isOutgoing: false,
              peerImageUrl: avatarUrl,
              peerInitials: avatarInitials,
              isGroup: isGroup,
              showSenderName: showSenderName,
              onLongPress: onLongPress,
              onReactionTap: onReactionTap,
              onReplyQuoteTap: onReplyQuoteTap,
            ),
          ),
        ],
      ),
    );
  }
}

Color _groupSenderNameColor(int? senderId, String name) {
  const palette = <Color>[
    Color(0xFF53BDEB),
    Color(0xFFFF8A65),
    Color(0xFFDFB23C),
    Color(0xFF7C9CFF),
    Color(0xFF55C2A7),
    Color(0xFFE07AD3),
    Color(0xFF6ECB63),
    Color(0xFFFF6B9D),
  ];
  final key = senderId ?? name.hashCode;
  return palette[key.abs() % palette.length];
}

/// WhatsApp-style jumbo: 1–3 emoji-only messages scale up. Returns count or null.
int? _jumboEmojiCount(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return null;

  final matches = _kEmojiSequence.allMatches(trimmed).toList(growable: false);
  if (matches.isEmpty || matches.length > 3) return null;

  final remainder =
      trimmed.replaceAll(_kEmojiSequence, '').replaceAll(RegExp(r'\s+'), '');
  if (remainder.isNotEmpty) return null;
  return matches.length;
}

final RegExp _kEmojiSequence = RegExp(
  r'(?:'
  r'\p{Extended_Pictographic}'
  r'(?:\uFE0F)?'
  r'(?:\u200D\p{Extended_Pictographic}(?:\uFE0F)?)*'
  r'|'
  r'[\u{1F1E6}-\u{1F1FF}]{2}'
  r')',
  unicode: true,
);

class _AnimatedReactionBadge extends StatefulWidget {
  /// Distinct reaction emojis on this message (❤️, 👍, …).
  final List<String> emojis;
  final int count;
  final bool isDarkMode;

  const _AnimatedReactionBadge({
    required this.emojis,
    required this.isDarkMode,
    this.count = 1,
  });

  @override
  State<_AnimatedReactionBadge> createState() => _AnimatedReactionBadgeState();
}

class _AnimatedReactionBadgeState extends State<_AnimatedReactionBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _AnimatedReactionBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_listEquals(oldWidget.emojis, widget.emojis) ||
        oldWidget.count != widget.count) {
      _controller
        ..reset()
        ..forward();
    }
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emojis = widget.emojis.isEmpty ? const <String>['👍'] : widget.emojis;
    // WhatsApp: always show the total when 2+ people reacted, next to every
    // distinct emoji (e.g. 👍❤️ 2). Single reaction stays a plain circle.
    final showCount = widget.count > 1;
    final size = 26.r;
    final emojiSize = 16.sp;

    Widget emojiGlyph(String emoji) {
      return Align(
        alignment: const Alignment(0, -0.22),
        child: Text(
          emoji,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: emojiSize,
            height: 1,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      );
    }

    final emojiRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < emojis.length; i++) ...[
          if (i > 0) SizedBox(width: 1.w),
          SizedBox(
            width: emojiSize + 2,
            height: size,
            child: emojiGlyph(emojis[i]),
          ),
        ],
      ],
    );

    if (!showCount && emojis.length == 1) {
      return FadeTransition(
        opacity: _opacity,
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.isDarkMode ? AppColors.darkCardBG : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withOpacity(0.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: emojiGlyph(emojis.first),
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: size,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isDarkMode ? AppColors.darkCardBG : Colors.white,
            borderRadius: BorderRadius.circular(size / 2),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              emojiRow,
              if (showCount) ...[
                SizedBox(width: 3.w),
                Text(
                  '${widget.count}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    color: widget.isDarkMode
                        ? AppColors.darkTitle
                        : AppColors.title,
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

/// Reply quote banner shown at the top of a message bubble.
class _ReplyQuoteBanner extends StatelessWidget {
  final ChatReplyItem reply;
  final bool isOutgoing;
  final bool isDarkMode;
  final VoidCallback? onTap;

  const _ReplyQuoteBanner({
    required this.reply,
    required this.isOutgoing,
    required this.isDarkMode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = reply.isOutgoing
        ? (isOutgoing ? Colors.white.withOpacity(0.6) : AppColors.primary)
        : const Color(0xFF8B5CF6);
    final bgColor = isOutgoing
        ? Colors.white.withOpacity(0.12)
        : (isDarkMode
            ? Colors.white.withOpacity(0.06)
            : AppColors.primary.withOpacity(0.06));
    final textColor = isOutgoing
        ? Colors.white.withOpacity(0.8)
        : (isDarkMode ? Colors.white.withOpacity(0.6) : AppColors.description);
    final image = reply.imageAttachment;
    final voice = image == null ? reply.voiceAttachment : null;
    final hasLinkThumb = image == null && firstChatUrl(reply.text) != null;
    final hasMedia = image != null || voice != null || hasLinkThumb;
    final displayName = reply.isOutgoing
        ? context.tr(AppStrings.you)
        : (reply.senderName.isEmpty ? 'Unknown' : reply.senderName);
    final nameColor = reply.isOutgoing
        ? (isOutgoing ? Colors.white : AppColors.primary)
        : (isOutgoing ? Colors.white : accentColor);

    return ValueListenableBuilder<int>(
      valueListenable: ChatVoiceDurationCache.revision,
      builder: (context, _, __) {
        final previewLabel = replyPreviewLabel(
          context,
          reply.text,
          hasImage: image != null || reply.imageCount > 0,
          hasVoice: voice != null,
          imageCount:
              reply.imageCount > 0 ? reply.imageCount : (image != null ? 1 : 0),
          voiceDurationMs:
              voice == null ? null : ChatVoiceDurationCache.get(voice),
        );

        final banner = Container(
          margin: EdgeInsets.only(bottom: 1.h),
          padding: EdgeInsets.fromLTRB(8.w, 5.h, hasMedia ? 4.w : 8.w, 5.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border(
              left: BorderSide(color: accentColor, width: 3.w),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: nameColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        if (image != null || reply.imageCount > 0) ...[
                          Icon(
                            Icons.photo_camera_outlined,
                            size: 12.sp,
                            color: textColor,
                          ),
                          SizedBox(width: 3.w),
                        ] else if (voice != null) ...[
                          Icon(
                            Icons.mic_rounded,
                            size: 12.sp,
                            color: textColor,
                          ),
                          SizedBox(width: 3.w),
                        ],
                        Expanded(
                          child: Text(
                            previewLabel,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (image != null || hasLinkThumb) ...[
                SizedBox(width: 6.w),
                ChatReplyMediaThumb(
                  imageAttachment: image,
                  messageText: reply.text,
                  size: 36,
                  isDark: isDarkMode || isOutgoing,
                ),
              ] else if (voice != null) ...[
                SizedBox(width: 6.w),
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(isOutgoing ? 0.22 : 0.16),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Icon(
                    Icons.mic_rounded,
                    size: 18.sp,
                    color: isOutgoing ? Colors.white : accentColor,
                  ),
                ),
              ],
            ],
          ),
        );

        if (onTap == null) return banner;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.r),
            child: banner,
          ),
        );
      },
    );
  }
}

/// Image attachment grid with upload progress overlay (WhatsApp-style).
class _ImageAttachmentGrid extends StatelessWidget {
  final List<ChatAttachmentItem> attachments;
  final bool isUploading;
  final bool showRetry;
  final double uploadProgress;
  final bool isOutgoing;
  final double? maxHeight;
  final VoidCallback? onCancelUpload;
  final VoidCallback? onRetryUpload;

  const _ImageAttachmentGrid({
    required this.attachments,
    required this.isUploading,
    required this.uploadProgress,
    required this.isOutgoing,
    this.showRetry = false,
    this.maxHeight,
    this.onCancelUpload,
    this.onRetryUpload,
  });

  Future<void> _openViewer(BuildContext context, int index) async {
    final urls = <String>[];
    final cacheKeys = <String?>[];
    var allLocal = true;
    for (final a in attachments) {
      if (a.localFile != null) {
        urls.add(a.localFile!.path);
        cacheKeys.add(chatAttachmentCacheKey(a));
      } else {
        final resolved = resolveChatAttachmentUrl(a.url);
        if (resolved.isNotEmpty) {
          urls.add(resolved);
          cacheKeys.add(chatAttachmentCacheKey(a));
          allLocal = false;
        }
      }
    }
    if (urls.isEmpty) return;

    final tapped = attachments[index.clamp(0, attachments.length - 1)];
    final isLocal = tapped.localFile != null;
    final headers = allLocal ? null : await chatProtectedFileHeaders();
    if (!context.mounted) return;

    Navigator.of(context).push(
      FullScreenImage.route(
        imageUrls: urls,
        initialIndex: index.clamp(0, urls.length - 1),
        isLocal: isLocal || allLocal,
        httpHeaders: headers,
        cacheKeys: cacheKeys,
      ),
    );
  }

  void _onExpired(BuildContext context) {
    try {
      context.read<ChatRoomCubit>().refreshSignedAttachmentUrls();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final count = attachments.length;
    if (count == 0) return const SizedBox.shrink();

    final radius = BorderRadius.circular(10.r);

    if (count == 1) {
      // WhatsApp-like square tile filled with BoxFit.cover (crops tall shots).
      final tileW = 240.w;
      var tileH = tileW;
      if (maxHeight != null && maxHeight!.isFinite) {
        tileH = maxHeight!.clamp(120.h, tileW);
      }
      final tile = _SingleImageTile(
        attachment: attachments.first,
        width: tileW,
        height: tileH,
        borderRadius: 10.r,
        onTap:
            (isUploading || showRetry) ? null : () => _openViewer(context, 0),
        onExpired: () => _onExpired(context),
      );
      if (!isUploading && !showRetry) return tile;
      return _UploadOverlay(
        borderRadius: radius,
        progress: uploadProgress,
        isRetry: showRetry,
        onAction: showRetry ? onRetryUpload : onCancelUpload,
        child: tile,
      );
    }

    // Multi-image collage — WhatsApp layouts:
    // 2 → side by side
    // 3 → one full-width + two half-width (no empty cell)
    // 4+ → 2×2 grid (extra images still open in the viewer)
    final gridW = 220.w;
    final gap = 2.w;
    final halfW = (gridW - gap) / 2;

    Widget grid;
    if (count == 2) {
      var tileH = 148.h;
      var tileW = halfW;
      if (maxHeight != null && maxHeight!.isFinite && tileH > maxHeight!) {
        final scale = maxHeight! / tileH;
        tileH *= scale;
        tileW *= scale;
      }
      grid = ClipRRect(
        borderRadius: radius,
        child: SizedBox(
          width: tileW * 2 + gap,
          child: Row(
            children: [
              _SingleImageTile(
                attachment: attachments[0],
                width: tileW,
                height: tileH,
                borderRadius: 2.r,
                onTap: (isUploading || showRetry)
                    ? null
                    : () => _openViewer(context, 0),
                onExpired: () => _onExpired(context),
              ),
              SizedBox(width: gap),
              _SingleImageTile(
                attachment: attachments[1],
                width: tileW,
                height: tileH,
                borderRadius: 2.r,
                onTap: (isUploading || showRetry)
                    ? null
                    : () => _openViewer(context, 1),
                onExpired: () => _onExpired(context),
              ),
            ],
          ),
        ),
      );
    } else if (count == 3) {
      // Full-width hero on top, two equal tiles below — fills the bubble.
      var topH = 128.h;
      var bottomH = 108.h;
      var width = gridW;
      final naturalH = topH + gap + bottomH;
      if (maxHeight != null && maxHeight!.isFinite && naturalH > maxHeight!) {
        final scale = maxHeight! / naturalH;
        topH *= scale;
        bottomH *= scale;
        width *= scale;
      }
      final bottomW = (width - gap) / 2;
      grid = ClipRRect(
        borderRadius: radius,
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SingleImageTile(
                attachment: attachments[0],
                width: width,
                height: topH,
                borderRadius: 2.r,
                onTap: (isUploading || showRetry)
                    ? null
                    : () => _openViewer(context, 0),
                onExpired: () => _onExpired(context),
              ),
              SizedBox(height: gap),
              Row(
                children: [
                  _SingleImageTile(
                    attachment: attachments[1],
                    width: bottomW,
                    height: bottomH,
                    borderRadius: 2.r,
                    onTap: (isUploading || showRetry)
                        ? null
                        : () => _openViewer(context, 1),
                    onExpired: () => _onExpired(context),
                  ),
                  SizedBox(width: gap),
                  _SingleImageTile(
                    attachment: attachments[2],
                    width: bottomW,
                    height: bottomH,
                    borderRadius: 2.r,
                    onTap: (isUploading || showRetry)
                        ? null
                        : () => _openViewer(context, 2),
                    onExpired: () => _onExpired(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      // 4+: 2×2 (show first 4; tap opens full gallery).
      var tileW = halfW;
      var tileH = 108.h;
      final naturalH = tileH * 2 + gap;
      if (maxHeight != null && maxHeight!.isFinite && naturalH > maxHeight!) {
        final scale = maxHeight! / naturalH;
        tileW *= scale;
        tileH *= scale;
      }
      final shown = attachments.take(4).toList(growable: false);
      grid = ClipRRect(
        borderRadius: radius,
        child: SizedBox(
          width: tileW * 2 + gap,
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (var i = 0; i < shown.length; i++)
                _SingleImageTile(
                  attachment: shown[i],
                  width: tileW,
                  height: tileH,
                  borderRadius: 2.r,
                  onTap: (isUploading || showRetry)
                      ? null
                      : () => _openViewer(context, i),
                  onExpired: () => _onExpired(context),
                ),
            ],
          ),
        ),
      );
    }

    if (!isUploading && !showRetry) return grid;

    return _UploadOverlay(
      borderRadius: radius,
      progress: uploadProgress,
      isRetry: showRetry,
      onAction: showRetry ? onRetryUpload : onCancelUpload,
      child: grid,
    );
  }
}

/// Dim + centered progress / cancel / retry over media (WhatsApp-style).
class _UploadOverlay extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final double progress;
  final bool isRetry;
  final VoidCallback? onAction;

  const _UploadOverlay({
    required this.child,
    required this.borderRadius,
    required this.progress,
    this.isRetry = false,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withOpacity(0.35),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onAction,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 56.r,
                height: 56.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!isRetry)
                      SizedBox(
                        width: 48.r,
                        height: 48.r,
                        child: CircularProgressIndicator(
                          value: progress > 0 ? progress.clamp(0.0, 1.0) : null,
                          strokeWidth: 2.8,
                          color: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0.25),
                        ),
                      ),
                    Container(
                      width: 34.r,
                      height: 34.r,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isRetry ? Icons.refresh_rounded : Icons.close_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleImageTile extends StatelessWidget {
  final ChatAttachmentItem attachment;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onExpired;

  const _SingleImageTile({
    required this.attachment,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.onTap,
    this.onExpired,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: ClipRRect(
            borderRadius: radius,
            clipBehavior: Clip.hardEdge,
            child: SizedBox.expand(
              child: ChatAttachmentImage(
                attachment: attachment,
                width: width,
                height: height,
                fit: BoxFit.cover,
                onExpired: onExpired,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// WhatsApp-style soft-deleted message placeholder.
class _DeletedMessageBubble extends StatelessWidget {
  final ChatMessageItem message;
  final bool isDarkMode;
  final bool isOutgoing;

  const _DeletedMessageBubble({
    super.key,
    required this.message,
    required this.isDarkMode,
    required this.isOutgoing,
  });

  @override
  Widget build(BuildContext context) {
    final muted = isOutgoing
        ? Colors.white.withOpacity(0.72)
        : (isDarkMode ? AppColors.darkDescription : AppColors.description);
    // Soft-delete for everyone (WhatsApp-style).
    final label = context.tr(
      isOutgoing
          ? AppStrings.youDeletedThisMessage
          : AppStrings.thisMessageWasDeleted,
    );

    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 6.h),
      decoration: BoxDecoration(
        color: isOutgoing
            ? AppColors.primary
            : (isDarkMode ? AppColors.darkCardBG : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          topRight: Radius.circular(14.r),
          bottomLeft: Radius.circular(isOutgoing ? 14.r : 4.r),
          bottomRight: Radius.circular(isOutgoing ? 4.r : 14.r),
        ),
        boxShadow: isOutgoing
            ? null
            : (isDarkMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: _DeletedIconScaleScope.of(context),
                child: Icon(
                  Icons.block,
                  size: 15.sp,
                  color: muted,
                ),
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: muted,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            message.timeLabel,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: muted.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}
