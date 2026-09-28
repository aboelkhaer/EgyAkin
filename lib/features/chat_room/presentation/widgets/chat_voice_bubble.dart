import 'dart:math' as math;

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat/data/services/chat_audio_session.dart';
import 'package:egy_akin/features/chat/data/services/chat_voice_playback_coordinator.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_duration_cache.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_played_cache.dart';
import 'package:just_audio/just_audio.dart';

/// WhatsApp-style voice note player inside a chat bubble.
class ChatVoiceBubble extends StatefulWidget {
  final ChatAttachmentItem attachment;
  final bool isOutgoing;
  final bool isDarkMode;
  final String? senderImageUrl;
  final String? senderInitials;

  /// Message time shown on the same row as duration (WhatsApp).
  final String? timeLabel;
  final ChatMessageStatus? status;

  const ChatVoiceBubble({
    super.key,
    required this.attachment,
    required this.isOutgoing,
    required this.isDarkMode,
    this.senderImageUrl,
    this.senderInitials,
    this.timeLabel,
    this.status,
  });

  @override
  State<ChatVoiceBubble> createState() => _ChatVoiceBubbleState();
}

class _ChatVoiceBubbleState extends State<ChatVoiceBubble> {
  AudioPlayer? _player;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<Duration?>? _durSub;

  bool _loading = false;
  bool _playing = false;
  bool _ready = false;
  bool _disposed = false;
  int _loadToken = 0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  void _rememberDuration(Duration d) {
    if (d.inMilliseconds <= 0) return;
    ChatVoiceDurationCache.put(widget.attachment, d.inMilliseconds);
  }

  Duration _resolveDisplayDuration() {
    final fromApi = widget.attachment.durationMs;
    if (fromApi != null && fromApi > 0) {
      return Duration(milliseconds: fromApi);
    }
    final known = ChatVoiceDurationCache.get(widget.attachment);
    if (known != null && known > 0) {
      return Duration(milliseconds: known);
    }
    return Duration.zero;
  }

  @override
  void initState() {
    super.initState();
    _duration = _resolveDisplayDuration();
    // Cache duration after this frame — never notify ValueListenableBuilders
    // while the message list is still building.
    if (_duration.inMilliseconds > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _rememberDuration(_duration);
      });
    }
    // Restore listened color after app restart.
    unawaited(
      ChatVoicePlayedCache.ensureLoaded().then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() {});
        });
      }),
    );
    // WhatsApp-style: don't create a player or download until play is tapped.
  }

  Future<void> _ensurePlayer() async {
    if (_player != null || _disposed) return;
    _player = AudioPlayer();
    _bindPlayer(_player!);
  }

  void _bindPlayer(AudioPlayer player) {
    _posSub?.cancel();
    _stateSub?.cancel();
    _durSub?.cancel();
    _posSub = player.positionStream.listen((p) {
      if (_disposed || !mounted) return;
      setState(() => _position = p);
    });
    _durSub = player.durationStream.listen((d) {
      if (_disposed || !mounted || d == null) return;
      if (d.inMilliseconds > 0) {
        setState(() => _duration = d);
        _rememberDuration(d);
      }
    });
    _stateSub = player.playerStateStream.listen((s) async {
      if (_disposed || !mounted) return;
      if (s.processingState == ProcessingState.completed) {
        try {
          await player.seek(Duration.zero);
          await player.pause();
        } catch (_) {}
        ChatVoicePlaybackCoordinator.instance.release(this);
        unawaited(ChatAudioSession.release());
        if (_disposed || !mounted) return;
        setState(() {
          _playing = false;
          _position = Duration.zero;
        });
        return;
      }
      if (!s.playing) {
        ChatVoicePlaybackCoordinator.instance.release(this);
      }
      setState(() => _playing = s.playing);
    });
  }

  @override
  void didUpdateWidget(covariant ChatVoiceBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldLocal = oldWidget.attachment.localFile?.path;
    final newLocal = widget.attachment.localFile?.path;
    final oldUrl = oldWidget.attachment.url;
    final newUrl = widget.attachment.url;
    final oldDuration = oldWidget.attachment.durationMs;
    final newDuration = widget.attachment.durationMs;
    if (oldLocal != newLocal || oldUrl != newUrl) {
      _ready = false;
      _playing = false;
      _position = Duration.zero;
      _duration = _resolveDisplayDuration();
      if (_duration.inMilliseconds > 0) {
        _rememberDuration(_duration);
      }
    } else if (oldDuration != newDuration &&
        newDuration != null &&
        newDuration > 0) {
      _duration = Duration(milliseconds: newDuration);
      _rememberDuration(_duration);
    } else {
      final known = ChatVoiceDurationCache.get(widget.attachment);
      if (known != null && known > 0 && known != _duration.inMilliseconds) {
        _duration = Duration(milliseconds: known);
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _loadToken++;
    ChatVoicePlaybackCoordinator.instance.release(this);
    _posSub?.cancel();
    _stateSub?.cancel();
    _durSub?.cancel();
    final player = _player;
    _player = null;
    // Stop before dispose to avoid iOS (-11850) Operation Stopped races.
    unawaited(() async {
      try {
        await player?.stop();
      } catch (_) {}
      try {
        await player?.dispose();
      } catch (_) {}
    }());
    super.dispose();
  }

  Future<void> _preparePlaybackSession() async {
    await ChatAudioSession.prepareVoicePlayback();
  }

  Future<void> _loadSource(AudioPlayer player) async {
    final local = widget.attachment.localFile;
    final url = widget.attachment.url?.trim();

    try {
      await player.stop();
    } catch (_) {}

    if (local != null) {
      if (!await local.exists() || await local.length() == 0) {
        throw StateError('Voice file missing or empty: ${local.path}');
      }
      // setFilePath is more reliable for freshly recorded local m4a on iOS.
      await player.setFilePath(local.path, preload: true);
      return;
    }

    if (url != null && url.isNotEmpty) {
      final resolved = resolveChatAttachmentUrl(url);
      if (resolved.isEmpty) {
        throw StateError('Voice URL empty after resolve');
      }
      // Signed /chat/files/{id} requires Bearer auth. AVPlayer/just_audio
      // often fail to attach Authorization on iOS, so download via Dio first.
      final cacheId = widget.attachment.id?.toString() ??
          resolved.hashCode.toUnsigned(32).toRadixString(16);
      final file = await downloadChatProtectedFile(
        url: resolved,
        cacheId: cacheId,
        filePrefix: 'chat_voice',
        mimeType: widget.attachment.mimeType,
        originalName: widget.attachment.originalName,
        accept: '*/*',
        fallbackExtension: '.m4a',
      );
      await player.setFilePath(file.path, preload: true);
      return;
    }

    throw StateError('No voice source');
  }

  Future<void> _recreatePlayer() async {
    final old = _player;
    _player = null;
    try {
      await old?.stop();
    } catch (_) {}
    try {
      await old?.dispose();
    } catch (_) {}
    if (_disposed) return;
    _player = AudioPlayer();
    _bindPlayer(_player!);
  }

  Future<void> _ensureReady() async {
    if (_ready || _disposed) return;
    final token = ++_loadToken;
    setState(() => _loading = true);

    try {
      await _ensurePlayer();
      await _preparePlaybackSession();
      if (_disposed || token != _loadToken) return;

      Object? lastError;
      for (var attempt = 0; attempt < 3; attempt++) {
        if (_disposed || token != _loadToken) return;
        var player = _player;
        if (player == null) return;

        try {
          if (attempt > 0) {
            await Future<void>.delayed(
              Duration(milliseconds: 120 * attempt),
            );
            await _recreatePlayer();
            if (_disposed || token != _loadToken) return;
            player = _player;
            if (player == null) return;
          }

          await _loadSource(player);
          if (_disposed || token != _loadToken) return;

          // Prefer API duration_seconds; only probe the file if missing.
          if (_duration.inMilliseconds <= 0) {
            var d = player.duration;
            if (d == null || d.inMilliseconds <= 0) {
              try {
                d = await player.durationStream
                    .firstWhere((x) => x != null && x.inMilliseconds > 0)
                    .timeout(const Duration(seconds: 4));
              } catch (_) {
                d = player.duration;
              }
            }
            if (d != null && d.inMilliseconds > 0) {
              _duration = d;
              _rememberDuration(d);
            }
          }
          _ready = true;
          lastError = null;
          break;
        } catch (e) {
          lastError = e;
          _ready = false;
          debugPrint('Voice load attempt ${attempt + 1} failed: $e');
        }
      }

      if (lastError != null && !_ready) {
        debugPrint('Voice load failed: $lastError');
      }
    } finally {
      if (mounted && !_disposed && token == _loadToken) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _toggle() async {
    if (_loading || _disposed) return;
    await _ensureReady();
    if (_disposed || !_ready) return;
    final player = _player;
    if (player == null) return;

    try {
      if (_playing) {
        await player.pause();
        ChatVoicePlaybackCoordinator.instance.release(this);
        unawaited(ChatAudioSession.release());
      } else {
        // Mark listened as soon as the user presses play (WhatsApp-style).
        if (!widget.isOutgoing) {
          ChatVoicePlayedCache.markPlayed(widget.attachment);
          if (mounted) setState(() {});
        }
        await ChatVoicePlaybackCoordinator.instance.claim(this, player);
        if (_disposed) return;
        await _preparePlaybackSession();
        await player.play();
      }
    } catch (e) {
      debugPrint('Voice play failed: $e');
      _ready = false;
      await _ensureReady();
      if (_ready && !_disposed) {
        try {
          final retryPlayer = _player;
          if (retryPlayer == null) return;
          if (!widget.isOutgoing) {
            ChatVoicePlayedCache.markPlayed(widget.attachment);
            if (mounted) setState(() {});
          }
          await ChatVoicePlaybackCoordinator.instance.claim(this, retryPlayer);
          await _preparePlaybackSession();
          await retryPlayer.play();
        } catch (e2) {
          debugPrint('Voice play retry failed: $e2');
        }
      }
    }
  }

  /// Play button: unplayed uses blue; listened/seen uses bubble accent.
  static const _unplayedPlayColor = Color(0xFF53BDEB);

  bool get _isSeenOrPlayed {
    if (widget.isOutgoing) {
      return widget.status == ChatMessageStatus.seen;
    }
    return ChatVoicePlayedCache.isPlayed(widget.attachment);
  }

  String _fmt(Duration d) {
    final total = d.inSeconds;
    final m = (total ~/ 60).toString();
    final s = (total % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final muted = widget.isOutgoing
        ? Colors.white.withOpacity(0.7)
        : (widget.isDarkMode
            ? AppColors.darkDescription
            : AppColors.description);
    final waveActive = widget.isOutgoing
        ? Colors.white.withOpacity(0.95)
        : (_isSeenOrPlayed ? AppColors.primary : _unplayedPlayColor);
    final waveIdle = widget.isOutgoing
        ? Colors.white.withOpacity(0.35)
        : (widget.isDarkMode
            ? Colors.white.withOpacity(0.25)
            : Colors.black.withOpacity(0.18));
    final playColor = widget.isOutgoing
        ? (_isSeenOrPlayed
            ? Colors.white.withOpacity(0.92)
            : _unplayedPlayColor)
        : (_isSeenOrPlayed ? AppColors.primary : _unplayedPlayColor);
    final avatarBg = widget.isOutgoing
        ? const Color(0xFF3D2E6B)
        : (widget.isDarkMode
            ? Colors.white.withOpacity(0.12)
            : AppColors.primary.withOpacity(0.12));
    final avatarFg = widget.isOutgoing ? Colors.white70 : AppColors.primary;
    final micBadgeBg = widget.isOutgoing
        ? (_isSeenOrPlayed ? Colors.white : _unplayedPlayColor)
        : (_isSeenOrPlayed ? AppColors.primary : _unplayedPlayColor);
    final micBadgeFg = widget.isOutgoing ? AppColors.primary : Colors.white;

    final totalMs =
        _duration.inMilliseconds <= 0 ? 1 : _duration.inMilliseconds;
    final value = (_position.inMilliseconds / totalMs).clamp(0.0, 1.0);
    final label = _playing || _position > Duration.zero
        ? _fmt(_position)
        : _fmt(_duration);

    final seed = (widget.attachment.id ??
            widget.attachment.localFile?.path.hashCode ??
            widget.attachment.url?.hashCode ??
            17)
        .abs();

    // WhatsApp: [avatar] [play] [waveform]
    //            duration ..................... time ✓
    return SizedBox(
      width: 220.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _MicAvatar(
            size: 28.r,
            bg: avatarBg,
            personColor: avatarFg,
            badgeBg: micBadgeBg,
            badgeFg: micBadgeFg,
            imageUrl: widget.senderImageUrl,
            initials: widget.senderInitials,
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: _loading ? null : _toggle,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 24.r,
              height: 28.r,
              child: Center(
                child: _loading
                    ? SizedBox(
                        width: 14.r,
                        height: 14.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.6,
                          color: playColor,
                        ),
                      )
                    : Icon(
                        _playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: playColor,
                        size: 22.sp,
                      ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16.h,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      void seekAt(Offset local) {
                        final v =
                            (local.dx / constraints.maxWidth).clamp(0.0, 1.0);
                        final seek = Duration(
                          milliseconds: (v * totalMs).round(),
                        );
                        _player?.seek(seek);
                        setState(() => _position = seek);
                      }

                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapDown:
                            !_ready ? null : (d) => seekAt(d.localPosition),
                        onHorizontalDragUpdate:
                            !_ready ? null : (d) => seekAt(d.localPosition),
                        child: CustomPaint(
                          size: Size(constraints.maxWidth, 16.h),
                          painter: _VoiceWavePainter(
                            progress: value,
                            seed: seed,
                            active: waveActive,
                            inactive: waveIdle,
                            thumbColor: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        height: 1,
                        color: muted,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    if (widget.timeLabel != null &&
                        widget.timeLabel!.isNotEmpty) ...[
                      const Spacer(),
                      Text(
                        widget.timeLabel!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: muted,
                        ),
                      ),
                      if (widget.isOutgoing &&
                          widget.status != null &&
                          widget.status != ChatMessageStatus.failed) ...[
                        SizedBox(width: 3.w),
                        SizedBox(
                          width: 18.sp,
                          height: 14.sp,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            layoutBuilder: (currentChild, previousChildren) {
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  ...previousChildren,
                                  if (currentChild != null) currentChild,
                                ],
                              );
                            },
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: KeyedSubtree(
                              key: ValueKey(widget.status),
                              child: _VoiceStatusTicks(
                                status: widget.status!,
                                color: widget.status == ChatMessageStatus.seen
                                    ? const Color(0xFF53BDEB)
                                    : muted,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VoiceStatusTicks extends StatelessWidget {
  final ChatMessageStatus status;
  final Color color;

  const _VoiceStatusTicks({
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Widget tick;
    switch (status) {
      case ChatMessageStatus.sending:
      case ChatMessageStatus.pending:
        tick = SizedBox(
          width: 12.sp,
          height: 12.sp,
          child: CircularProgressIndicator(
            strokeWidth: 1.4,
            color: color,
          ),
        );
      case ChatMessageStatus.sent:
        tick = Icon(Icons.done_rounded, size: 14.sp, color: color);
      case ChatMessageStatus.delivered:
      case ChatMessageStatus.seen:
        tick = Icon(Icons.done_all_rounded, size: 14.sp, color: color);
      case ChatMessageStatus.failed:
        tick = const SizedBox.shrink();
    }
    return SizedBox(
      width: 18.sp,
      height: 14.sp,
      child: Center(child: tick),
    );
  }
}

class _MicAvatar extends StatelessWidget {
  final double size;
  final Color bg;
  final Color personColor;
  final Color badgeBg;
  final Color badgeFg;
  final String? imageUrl;
  final String? initials;

  const _MicAvatar({
    required this.size,
    required this.bg,
    required this.personColor,
    required this.badgeBg,
    required this.badgeFg,
    this.imageUrl,
    this.initials,
  });

  @override
  Widget build(BuildContext context) {
    final badge = size * 0.38;
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    final initial = (initials ?? '').trim();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Container(
              width: size,
              height: size,
              color: bg,
              alignment: Alignment.center,
              child: hasImage
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      placeholder: (_, __) => ColoredBox(color: bg),
                      errorWidget: (_, __, ___) => Icon(
                        Icons.person_rounded,
                        size: size * 0.58,
                        color: personColor,
                      ),
                    )
                  : (initial.isNotEmpty
                      ? Text(
                          initial.length > 2
                              ? initial.substring(0, 2).toUpperCase()
                              : initial.toUpperCase(),
                          style: TextStyle(
                            color: personColor,
                            fontWeight: FontWeight.w700,
                            fontSize: size * 0.32,
                          ),
                        )
                      : Icon(
                          Icons.person_rounded,
                          size: size * 0.58,
                          color: personColor,
                        )),
            ),
          ),
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: badge,
              height: badge,
              decoration: BoxDecoration(
                color: badgeBg,
                shape: BoxShape.circle,
                border: Border.all(color: bg, width: 1),
              ),
              child: Icon(
                Icons.mic_rounded,
                size: badge * 0.7,
                color: badgeFg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VoiceWavePainter extends CustomPainter {
  final double progress;
  final int seed;
  final Color active;
  final Color inactive;
  final Color thumbColor;

  _VoiceWavePainter({
    required this.progress,
    required this.seed,
    required this.active,
    required this.inactive,
    required this.thumbColor,
  });

  double _heightAt(int i, int bars) {
    final t = i / (bars - 1);
    final a = math.sin((t * 7.1) + (seed % 9) * 0.41);
    final b = math.sin((t * 15.3) + (seed % 13) * 0.19);
    final hash = ((seed * 131 + i * 97) % 100) / 100.0;
    return (0.42 + a.abs() * 0.35 + b.abs() * 0.2 + hash * 0.18)
        .clamp(0.22, 1.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    const bars = 36;
    const thumbR = 4.5;
    final usableW = size.width - thumbR * 2;
    final step = usableW / bars;
    final barW = (step * 0.42).clamp(1.4, 2.4);
    final paint = Paint()..isAntiAlias = true;
    final midY = size.height / 2;

    for (var i = 0; i < bars; i++) {
      final t = (i + 0.5) / bars;
      final h = size.height * _heightAt(i, bars) * 0.92;
      final x = thumbR + i * step + (step - barW) / 2;
      final y = midY - h / 2;
      paint.color = t <= progress ? active : inactive;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barW, h),
          const Radius.circular(99),
        ),
        paint,
      );
    }

    final thumbX = thumbR + progress * usableW;
    paint.color = thumbColor;
    canvas.drawCircle(Offset(thumbX, midY), thumbR, paint);
  }

  @override
  bool shouldRepaint(covariant _VoiceWavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.seed != seed ||
        oldDelegate.active != active ||
        oldDelegate.inactive != inactive ||
        oldDelegate.thumbColor != thumbColor;
  }
}
