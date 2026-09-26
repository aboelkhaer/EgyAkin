import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_link_preview.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_duration_cache.dart';

/// WhatsApp-style reply / edit banner with slide / fade / scale enter & exit.
///
/// Pass [message] as null to dismiss — the banner animates out before
/// removing itself. Tapping X runs the same exit, then calls [onClose].
///
/// Set [isEditing] for the edit-composer chrome (title + pencil icon).
class ChatReplyBanner extends StatefulWidget {
  final ChatMessageItem? message;
  final String? myDisplayName;
  final String? peerDisplayName;
  final VoidCallback onClose;
  final bool isEditing;

  const ChatReplyBanner({
    super.key,
    required this.message,
    required this.onClose,
    this.myDisplayName,
    this.peerDisplayName,
    this.isEditing = false,
  });

  @override
  State<ChatReplyBanner> createState() => _ChatReplyBannerState();
}

class _ChatReplyBannerState extends State<ChatReplyBanner>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 320);

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _size;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;
  late final Animation<double> _accentSlide;

  ChatMessageItem? _visible;
  bool _closingFromTap = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeInCubic),
    );
    _size = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.55),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
        reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeInCubic),
      ),
    );
    _scale = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.05, 1.0, curve: Curves.easeOutBack),
        reverseCurve: Curves.easeInCubic,
      ),
    );
    _accentSlide = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 1.0, curve: Curves.easeOutCubic),
        reverseCurve: Curves.easeIn,
      ),
    );

    _visible = widget.message;
    if (_visible != null) {
      _controller.value = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void didUpdateWidget(covariant ChatReplyBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    final next = widget.message;
    final prev = oldWidget.message;

    if (next != null) {
      _closingFromTap = false;
      final switched = prev?.id != next.id;
      setState(() => _visible = next);
      if (switched || _controller.value < 1) {
        if (switched && _controller.value > 0) {
          _controller.forward(from: 0);
        } else {
          _controller.forward();
        }
      }
      return;
    }

    // Cleared by cubit (send / external) — animate out if still showing.
    if (_visible != null && !_closingFromTap) {
      _animateOut(clearVisible: true);
    }
  }

  Future<void> _animateOut({required bool clearVisible}) async {
    if (_controller.isDismissed && _visible == null) return;
    try {
      await _controller.reverse();
    } catch (_) {}
    if (!mounted) return;
    if (clearVisible) {
      setState(() => _visible = null);
    }
  }

  Future<void> _onCloseTap() async {
    if (_closingFromTap) return;
    _closingFromTap = true;
    await _animateOut(clearVisible: true);
    if (!mounted) return;
    widget.onClose();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message = _visible;
    if (message == null && _controller.isDismissed) {
      return const SizedBox.shrink();
    }
    if (message == null) return const SizedBox.shrink();

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final bgColor =
            isDark ? const Color(0xFF1C1826) : const Color(0xFFF3F4F6);
        final accentColor = widget.isEditing
            ? AppColors.primary
            : (message.isOutgoing ? AppColors.primary : const Color(0xFF8B5CF6));
        final titleLabel = widget.isEditing
            ? context.tr(AppStrings.editingMessage)
            : (message.isOutgoing
                ? context.tr(AppStrings.you)
                : (widget.peerDisplayName ?? 'Unknown'));
        final nameColor = widget.isEditing || message.isOutgoing
            ? accentColor
            : (isDark ? Colors.white : accentColor);
        final textColor = isDark
            ? Colors.white.withOpacity(0.6)
            : const Color(0xFF6B7280);
        final image = message.firstImageAttachment;
        final imageCount = message.imageAttachmentCount;
        final voice = image == null ? message.firstVoiceAttachment : null;

        return ClipRect(
          child: SizeTransition(
            sizeFactor: _size,
            axisAlignment: -1,
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: ScaleTransition(
                  scale: _scale,
                  alignment: Alignment.bottomCenter,
                  child: ValueListenableBuilder<int>(
                    valueListenable: ChatVoiceDurationCache.revision,
                    builder: (context, _, __) {
                      final voiceDurationMs = voice == null
                          ? null
                          : ChatVoiceDurationCache.get(voice);
                      final previewLabel = replyPreviewLabel(
                        context,
                        message.text,
                        hasImage: image != null || imageCount > 0,
                        hasVoice: voice != null,
                        imageCount: imageCount,
                        voiceDurationMs: voiceDurationMs,
                      );

                      return Container(
                        padding: EdgeInsets.fromLTRB(6.w, 4.h, 2.w, 4.h),
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border(
                            top: BorderSide(
                              color: isDark
                                  ? Colors.white.withOpacity(0.06)
                                  : const Color(0xFFE5E7EB),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            AnimatedBuilder(
                              animation: _accentSlide,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                    -6.w * (1 - _accentSlide.value),
                                    0,
                                  ),
                                  child: Opacity(
                                    opacity: _accentSlide.value.clamp(0.0, 1.0),
                                    child: child,
                                  ),
                                );
                              },
                              child: Container(
                                width: 3.w,
                                height: 34.h,
                                decoration: BoxDecoration(
                                  color: accentColor,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      if (widget.isEditing) ...[
                                        Icon(
                                          Icons.edit_rounded,
                                          size: 12.sp,
                                          color: nameColor,
                                        ),
                                        SizedBox(width: 4.w),
                                      ],
                                      Expanded(
                                        child: Text(
                                          titleLabel,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11.5.sp,
                                            fontWeight: FontWeight.w700,
                                            height: 1.15,
                                            color: nameColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      if (image != null || imageCount > 0) ...[
                                        Icon(
                                          Icons.photo_camera_outlined,
                                          size: 12.sp,
                                          color: textColor,
                                        ),
                                        SizedBox(width: 4.w),
                                      ] else if (voice != null) ...[
                                        Icon(
                                          Icons.mic_rounded,
                                          size: 12.sp,
                                          color: textColor,
                                        ),
                                        SizedBox(width: 4.w),
                                      ],
                                      Expanded(
                                        child: Text(
                                          previewLabel,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11.5.sp,
                                            height: 1.15,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final hasLinkThumb = image == null &&
                                    firstChatUrl(message.text) != null;
                                if (image == null &&
                                    voice == null &&
                                    !hasLinkThumb) {
                                  return const SizedBox.shrink();
                                }
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (image != null || hasLinkThumb) ...[
                                      SizedBox(width: 6.w),
                                      ChatReplyMediaThumb(
                                        imageAttachment: image,
                                        messageText: message.text,
                                        size: 32,
                                        isDark: isDark,
                                      ),
                                    ] else if (voice != null) ...[
                                      SizedBox(width: 6.w),
                                      _ReplyVoiceThumb(
                                        accentColor: accentColor,
                                        size: 32,
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                            _CloseReplyButton(
                              isDark: isDark,
                              onTap: _onCloseTap,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CloseReplyButton extends StatefulWidget {
  final bool isDark;
  final VoidCallback onTap;

  const _CloseReplyButton({
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_CloseReplyButton> createState() => _CloseReplyButtonState();
}

class _CloseReplyButtonState extends State<_CloseReplyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isDark
        ? Colors.white.withOpacity(0.5)
        : const Color(0xFF9CA3AF);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.86 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _pressed
                ? (widget.isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.06))
                : Colors.transparent,
          ),
          child: Icon(
            Icons.close_rounded,
            size: 16.sp,
            color: color,
          ),
        ),
      ),
    );
  }
}

String replyPreviewLabel(
  BuildContext context,
  String text, {
  required bool hasImage,
  required bool hasVoice,
  int imageCount = 0,
  int? voiceDurationMs,
}) {
  final trimmed = text.trim();
  final isImagePlaceholder = trimmed.isEmpty ||
      trimmed == '[Image]' ||
      trimmed == '[Photo]' ||
      trimmed.toLowerCase() == 'photo' ||
      trimmed.toLowerCase() == 'image' ||
      RegExp(r'^\d+\s+photos?$', caseSensitive: false).hasMatch(trimmed);
  final isVoicePlaceholder = trimmed.isEmpty ||
      trimmed == '[Voice]' ||
      trimmed == '[Voice message]' ||
      trimmed.toLowerCase() == 'voice' ||
      trimmed.toLowerCase() == 'voice message';

  if (hasImage && isImagePlaceholder) {
    final count = imageCount > 0 ? imageCount : 1;
    if (count > 1) {
      return '$count ${context.tr(AppStrings.photosPlural)}';
    }
    return context.tr(AppStrings.photo);
  }
  if (hasVoice && isVoicePlaceholder) {
    final label = context.tr(AppStrings.voiceMessage);
    if (voiceDurationMs != null && voiceDurationMs > 0) {
      return '$label (${ChatVoiceDurationCache.format(voiceDurationMs)})';
    }
    return label;
  }
  return trimmed;
}

class _ReplyVoiceThumb extends StatelessWidget {
  final Color accentColor;
  final double size;

  const _ReplyVoiceThumb({
    required this.accentColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.18),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(
        Icons.mic_rounded,
        size: (size * 0.48).sp,
        color: accentColor,
      ),
    );
  }
}
