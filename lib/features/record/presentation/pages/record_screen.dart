import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart' hide RecordState;

import '../../../../exports.dart';
import '../cubit/record_cubit.dart';
import '../cubit/record_state.dart';

class RecordScreen extends StatefulWidget {
  final List<QuestionModel> questions;
  final String source;
  final String sectionId;

  const RecordScreen({
    super.key,
    required this.questions,
    required this.source,
    required this.sectionId,
  });

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  // Change this to control the max recording limit.
  static const Duration _recordLimit = Duration(minutes: 2);

  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isPlaybackCompleted = false;
  bool _isRecordPaused = false;
  String? _recordFilePath;
  final List<double> _waveSamples = [];
  StreamSubscription<Amplitude>? _amplitudeSub;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<PlayerState>? _playerStateSub;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  Duration _recordDuration = Duration.zero;
  Duration _lastDragSeekTarget = Duration.zero;
  int _lastSeekAtMs = 0;
  final Stopwatch _recordStopwatch = Stopwatch();
  Timer? _recordTimer;
  bool _isAutoStopping = false;

  @override
  void dispose() {
    _amplitudeSub?.cancel();
    _positionSub?.cancel();
    _durationSub?.cancel();
    _playerStateSub?.cancel();
    _recordTimer?.cancel();
    _player.dispose();
    _recorder.dispose();
    super.dispose();
  }

  void _startRecordTimer() {
    _recordTimer?.cancel();
    _recordTimer = Timer.periodic(const Duration(milliseconds: 200), (_) async {
      if (!mounted || !_isRecording || _isRecordPaused) return;
      final elapsed = _recordStopwatch.elapsed;
      if (elapsed >= _recordLimit && !_isAutoStopping) {
        _isAutoStopping = true;
        await _stopRecord();
        if (mounted) {
          customSnackBar(
            context: context,
            message:
                'Recording stopped at ${_formatDuration(_recordLimit)} limit.',
          );
        }
        _isAutoStopping = false;
        return;
      }
      if (!mounted) return;
      setState(() {
        _recordDuration = elapsed;
      });
    });
  }

  Future<void> _startRecord() async {
    await _player.stop();
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: 'Microphone permission is required.',
      );
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final path =
        '${tempDir.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000),
      path: path,
    );

    _amplitudeSub?.cancel();
    _amplitudeSub =
        _recorder.onAmplitudeChanged(const Duration(milliseconds: 80)).listen(
      (amp) {
        final normalized = ((amp.current + 60) / 60).clamp(0.0, 1.0);
        if (!mounted) return;
        setState(() {
          _waveSamples.add(normalized);
          if (_waveSamples.length > 45) {
            _waveSamples.removeAt(0);
          }
        });
      },
    );

    if (!mounted) return;
    setState(() {
      _isRecording = true;
      _isRecordPaused = false;
      _recordFilePath = path;
      _currentPosition = Duration.zero;
      _totalDuration = Duration.zero;
      _isPlaying = false;
      _isPlaybackCompleted = false;
      _waveSamples.clear();
      _recordDuration = Duration.zero;
    });
    _recordStopwatch
      ..reset()
      ..start();
    _startRecordTimer();
  }

  Future<void> _pauseOrResumeRecord() async {
    if (!_isRecording) return;
    if (_isRecordPaused) {
      await _recorder.resume();
      _recordStopwatch.start();
      _startRecordTimer();
    } else {
      await _recorder.pause();
      _recordStopwatch.stop();
    }
    if (!mounted) return;
    setState(() {
      _isRecordPaused = !_isRecordPaused;
    });
  }

  Future<void> _stopRecord() async {
    final path = await _recorder.stop();
    _recordStopwatch.stop();
    _recordTimer?.cancel();
    await _amplitudeSub?.cancel();
    _amplitudeSub = null;
    await _initPlayer(path ?? _recordFilePath);
    if (!mounted) return;
    setState(() {
      _isRecording = false;
      _isRecordPaused = false;
      _recordFilePath = path ?? _recordFilePath;
      _recordDuration = _recordStopwatch.elapsed;
    });
  }

  Future<void> _reRecord() async {
    await _player.stop();
    await _player.seek(Duration.zero);
    if (!mounted) return;
    context.read<RecordCubit>().resetAnalysis();
    setState(() {
      _recordFilePath = null;
      _isPlaybackCompleted = false;
      _isPlaying = false;
      _currentPosition = Duration.zero;
      _totalDuration = Duration.zero;
      _waveSamples.clear();
      _recordDuration = Duration.zero;
    });
    _recordStopwatch
      ..reset()
      ..stop();
    await _startRecord();
  }

  Future<void> _initPlayer(String? path) async {
    if (path == null || path.isEmpty) return;
    await _player.setFilePath(path);
    _positionSub?.cancel();
    _durationSub?.cancel();
    _playerStateSub?.cancel();
    _positionSub = _player.positionStream.listen((pos) {
      if (!mounted) return;
      setState(() => _currentPosition = pos);
    });
    _durationSub = _player.durationStream.listen((dur) {
      if (!mounted) return;
      setState(() => _totalDuration = dur ?? Duration.zero);
    });
    _playerStateSub = _player.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() {
        _isPlaying = state.playing;
        _isPlaybackCompleted =
            state.processingState == ProcessingState.completed;
        if (_isPlaybackCompleted) {
          _isPlaying = false;
          _currentPosition = _totalDuration;
        }
      });
    });
  }

  Future<void> _togglePlayPause() async {
    if (_recordFilePath == null) return;
    if (_isPlaying) {
      await _player.pause();
    } else {
      if (_isPlaybackCompleted ||
          (_totalDuration > Duration.zero &&
              _currentPosition >= _totalDuration)) {
        await _player.seek(Duration.zero);
      }
      await _player.play();
    }
  }

  void _seekFromWaveRatio(double ratio, {bool isDragging = false}) {
    if (_totalDuration.inMilliseconds <= 0) return;
    final target = Duration(
      milliseconds:
          (_totalDuration.inMilliseconds * ratio.clamp(0.0, 1.0)).round(),
    );

    if (_isPlaybackCompleted && target < _totalDuration) {
      setState(() {
        _isPlaybackCompleted = false;
      });
    }

    // During drag, throttle seek calls for smoother UX.
    if (isDragging) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (target == _lastDragSeekTarget && (now - _lastSeekAtMs) < 16) return;
      if ((now - _lastSeekAtMs) < 30) return;
      _lastDragSeekTarget = target;
      _lastSeekAtMs = now;
      _player.seek(target);
      return;
    }

    _player.seek(target);
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _sendRecordAndFill() async {
    if (_recordFilePath == null || _recordFilePath!.isEmpty) {
      customSnackBar(context: context, message: 'Please record first.');
      return;
    }

    if (!File(_recordFilePath!).existsSync()) {
      customSnackBar(context: context, message: 'Recorded file was not found.');
      return;
    }

    context.read<RecordCubit>().processSection(
          sectionId: widget.sectionId,
          audioFile: File(_recordFilePath!),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final bgGradient = isDarkMode
            ? [const Color(0xFF11161E), const Color(0xFF0B0F14)]
            : [const Color(0xFFF7FAFF), const Color(0xFFEFF4FF)];

        return BlocConsumer<RecordCubit, RecordState>(
            listenWhen: (prev, curr) {
              final err = curr.errorMessage != prev.errorMessage &&
                  (curr.errorMessage != null && curr.errorMessage!.isNotEmpty);
              final fill =
                  curr.analysisPhase == RecordAnalysisPhase.fillingForm &&
                      prev.analysisPhase != RecordAnalysisPhase.fillingForm &&
                      curr.answersMap != null;
              return err || fill;
            },
            listener: (context, state) {
              if (state.errorMessage != null &&
                  state.errorMessage!.isNotEmpty) {
                customSnackBar(context: context, message: state.errorMessage!);
                context.read<RecordCubit>().clearErrorMessageOnly();
                return;
              }
              if (state.analysisPhase == RecordAnalysisPhase.fillingForm &&
                  state.answersMap != null) {
                final map = state.answersMap!;
                Future<void>.delayed(const Duration(milliseconds: 1300), () {
                  if (!context.mounted) return;
                  Navigator.of(context).pop(map);
                  context.read<RecordCubit>().clearResult();
                });
              }
            },
            builder: (context, recordState) => Scaffold(
                  backgroundColor:
                      isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
                  appBar: AppBar(
                    title: const Text('Record Answers'),
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor:
                        isDarkMode ? AppColors.darkCardBG : AppColors.primary,
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: bgGradient,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: isDarkMode
                                      ? [
                                          AppColors.darkCardBG,
                                          AppColors.darkScaffoldBG
                                        ]
                                      : [
                                          Colors.white,
                                          const Color(0xFFF3F7FF),
                                        ],
                                ),
                                border: Border.all(
                                  color: isDarkMode
                                      ? AppColors.darkBorder
                                      : AppColors.primary.withOpacity(0.18),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDarkMode
                                        ? Colors.black.withOpacity(0.2)
                                        : AppColors.primary.withOpacity(0.08),
                                    blurRadius: 22,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 84,
                                    width: 84,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDarkMode
                                          ? AppColors.darkBorder
                                              .withOpacity(0.35)
                                          : AppColors.primary.withOpacity(0.1),
                                    ),
                                    child: Icon(
                                      _isRecording ? Icons.mic : Icons.mic_none,
                                      size: 44,
                                      color: _isRecording
                                          ? Colors.red
                                          : AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  if (_isRecording)
                                    SizedBox(
                                      height: 56,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          _waveSamples.isEmpty
                                              ? 35
                                              : _waveSamples.length,
                                          (index) {
                                            final value = _waveSamples.isEmpty
                                                ? 0.06
                                                : _waveSamples[index];
                                            final h = 6 + (value * 26);
                                            return AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 120),
                                              width: 3.6,
                                              height: h,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 1.2),
                                              decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _isRecording
                                        ? (_isRecordPaused
                                            ? 'Recording paused'
                                            : 'Recording...')
                                        : (_recordFilePath == null
                                            ? 'Tap Start to record your answers'
                                            : (_isPlaying
                                                ? 'Listening to your recording...'
                                                : (_isPlaybackCompleted
                                                    ? 'Playback finished'
                                                    : 'Recording ready'))),
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppColors.darkTitle
                                          : Colors.black87,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _isRecording
                                        ? '${_formatDuration(_recordDuration)} / ${_formatDuration(_recordLimit)}'
                                        : (_recordDuration > Duration.zero
                                            ? 'Recorded: ${_formatDuration(_recordDuration)}'
                                            : 'Max: ${_formatDuration(_recordLimit)}'),
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppColors.darkDescription
                                          : Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.5.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 420),
                              curve: Curves.easeOutCubic,
                              alignment: Alignment.topCenter,
                              child: recordState.isAnalysisBusy
                                  ? Column(
                                      key: const ValueKey('analysis_open'),
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 12),
                                        if (recordState.analysisPhase ==
                                            RecordAnalysisPhase.fillingForm)
                                          _FillingFormSliderLoader(
                                            isDarkMode: isDarkMode,
                                          )
                                        else
                                          FadeInUp(
                                            duration: const Duration(
                                                milliseconds: 480),
                                            curve: Curves.easeOutCubic,
                                            from: 22,
                                            child: _ProfessionalAnalysisLoader(
                                              label: recordState
                                                      .analysisStepLabel ??
                                                  '',
                                              progress:
                                                  recordState.analysisProgress,
                                              isDarkMode: isDarkMode,
                                            ),
                                          ),
                                      ],
                                    )
                                  : const SizedBox(
                                      key: ValueKey('analysis_closed'),
                                      width: double.infinity,
                                    ),
                            ),
                            const SizedBox(height: 14),
                            if (!_isRecording &&
                                _recordFilePath != null &&
                                !recordState.isAnalysisBusy) ...[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.darkCardBG
                                      : Colors.white.withOpacity(0.94),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isDarkMode
                                        ? AppColors.darkBorder
                                        : AppColors.primary.withOpacity(0.13),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.primary
                                                .withOpacity(0.14),
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            onPressed: _togglePlayPause,
                                            icon: Icon(
                                              _isPlaying
                                                  ? Icons.pause
                                                  : (_isPlaybackCompleted
                                                      ? Icons.replay
                                                      : Icons.play_arrow),
                                              size: 26,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              const barWidth = 3.2;
                                              const barHorizontalMargin = 1.2;
                                              const perBarWidth = barWidth +
                                                  (barHorizontalMargin * 2);
                                              final totalBars =
                                                  _waveSamples.isEmpty
                                                      ? 45
                                                      : _waveSamples.length;
                                              final playedRatio = _totalDuration
                                                          .inMilliseconds <=
                                                      0
                                                  ? 0.0
                                                  : (_currentPosition
                                                          .inMilliseconds /
                                                      _totalDuration
                                                          .inMilliseconds);
                                              final activeBars =
                                                  (playedRatio.clamp(0.0, 1.0) *
                                                          totalBars)
                                                      .round();

                                              void seekByDx(double dx,
                                                  {bool isDragging = false}) {
                                                if (_totalDuration
                                                        .inMilliseconds <=
                                                    0) {
                                                  return;
                                                }
                                                final barsVisualWidth =
                                                    totalBars * perBarWidth;
                                                final startX = ((constraints
                                                                .maxWidth -
                                                            barsVisualWidth) /
                                                        2)
                                                    .clamp(
                                                        0.0, double.infinity);
                                                final adjustedDx = (dx - startX)
                                                    .clamp(
                                                        0.0, barsVisualWidth);
                                                final tappedBarIndex =
                                                    (adjustedDx / perBarWidth)
                                                        .floor()
                                                        .clamp(
                                                            0, totalBars - 1);
                                                final ratio = (tappedBarIndex /
                                                        (totalBars - 1))
                                                    .clamp(0.0, 1.0);
                                                _seekFromWaveRatio(
                                                  ratio,
                                                  isDragging: isDragging,
                                                );
                                              }

                                              return GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTapDown: (details) =>
                                                    seekByDx(
                                                  details.localPosition.dx,
                                                ),
                                                onHorizontalDragStart:
                                                    (details) => seekByDx(
                                                  details.localPosition.dx,
                                                  isDragging: true,
                                                ),
                                                onHorizontalDragUpdate:
                                                    (details) => seekByDx(
                                                  details.localPosition.dx,
                                                  isDragging: true,
                                                ),
                                                onHorizontalDragEnd: (_) {
                                                  _lastSeekAtMs = 0;
                                                },
                                                child: SizedBox(
                                                  height: 44,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: List.generate(
                                                      totalBars,
                                                      (index) {
                                                        final value =
                                                            _waveSamples.isEmpty
                                                                ? 0.06
                                                                : _waveSamples[
                                                                    index];
                                                        final h =
                                                            6 + (value * 28);
                                                        return AnimatedContainer(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      120),
                                                          width: barWidth,
                                                          height: h,
                                                          margin: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                                  barHorizontalMargin),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: index <
                                                                    activeBars
                                                                ? AppColors
                                                                    .primary
                                                                : (isDarkMode
                                                                    ? Colors
                                                                        .grey
                                                                        .shade700
                                                                    : Colors
                                                                        .grey
                                                                        .shade300),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.2),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _formatDuration(_currentPosition),
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? AppColors.darkDescription
                                                : Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          _formatDuration(_totalDuration),
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? AppColors.darkDescription
                                                : Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const Spacer(),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 380),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.12),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOutCubic,
                                    )),
                                    child: child,
                                  ),
                                );
                              },
                              child: recordState.isAnalysisBusy
                                  ? const SizedBox.shrink(
                                      key: ValueKey('no_actions'),
                                    )
                                  : Column(
                                      key: const ValueKey('actions'),
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_isRecording)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _ActionButton(
                                                  title: _isRecordPaused
                                                      ? 'Continue'
                                                      : 'Pause',
                                                  onTap: _pauseOrResumeRecord,
                                                  background: isDarkMode
                                                      ? AppColors.darkCardBG
                                                      : Colors.white,
                                                  borderColor: isDarkMode
                                                      ? AppColors.darkBorder
                                                      : AppColors.primary
                                                          .withOpacity(0.35),
                                                  textColor: AppColors.primary,
                                                  icon: _isRecordPaused
                                                      ? Icons.play_arrow_rounded
                                                      : Icons.pause_rounded,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: _ActionButton(
                                                  title: 'Stop',
                                                  onTap: _stopRecord,
                                                  background: Colors.red,
                                                  borderColor: Colors.red,
                                                  textColor: Colors.white,
                                                  icon: Icons.stop_rounded,
                                                ),
                                              ),
                                            ],
                                          )
                                        else ...[
                                          SizedBox(
                                            width: double.infinity,
                                            child: _ActionButton(
                                              title: _recordFilePath == null
                                                  ? 'Start'
                                                  : 'Re-record',
                                              onTap: _recordFilePath == null
                                                  ? _startRecord
                                                  : _reRecord,
                                              background: AppColors.primary,
                                              borderColor: AppColors.primary,
                                              textColor: Colors.white,
                                              icon: _recordFilePath == null
                                                  ? Icons.mic_rounded
                                                  : Icons.restart_alt_rounded,
                                            ),
                                          ),
                                          if (_recordFilePath != null) ...[
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: double.infinity,
                                              child: _ActionButton(
                                                title: 'Analysis Answers',
                                                onTap: _sendRecordAndFill,
                                                background: isDarkMode
                                                    ? AppColors.darkCardBG
                                                    : Colors.white,
                                                borderColor: isDarkMode
                                                    ? AppColors.darkBorder
                                                    : AppColors.primary
                                                        .withOpacity(0.35),
                                                textColor: AppColors.primary,
                                                icon: Icons
                                                    .check_circle_outline_rounded,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
      },
    );
  }
}

/// Smooth 0→1 slider while answers are applied after the API returns.
class _FillingFormSliderLoader extends StatelessWidget {
  final bool isDarkMode;

  const _FillingFormSliderLoader({required this.isDarkMode});

  static const Duration _animDuration = Duration(milliseconds: 1200);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: _animDuration,
      curve: Curves.easeInOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, _) {
        return _ProfessionalAnalysisLoader(
          label: 'Filling form with audio data...',
          progress: value,
          isDarkMode: isDarkMode,
        );
      },
    );
  }
}

class _ProfessionalAnalysisLoader extends StatefulWidget {
  final String label;
  final double progress;
  final bool isDarkMode;

  const _ProfessionalAnalysisLoader({
    required this.label,
    required this.progress,
    required this.isDarkMode,
  });

  @override
  State<_ProfessionalAnalysisLoader> createState() =>
      _ProfessionalAnalysisLoaderState();
}

class _ProfessionalAnalysisLoaderState
    extends State<_ProfessionalAnalysisLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = AppColors.primary;
    final trackColor = widget.isDarkMode
        ? Colors.white.withOpacity(0.09)
        : primary.withOpacity(0.11);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDarkMode
              ? [
                  AppColors.darkCardBG,
                  AppColors.darkScaffoldBG.withOpacity(0.92),
                ]
              : [
                  Colors.white,
                  const Color(0xFFF3F7FF),
                ],
        ),
        border: Border.all(
          color: widget.isDarkMode
              ? AppColors.darkBorder.withOpacity(0.85)
              : primary.withOpacity(0.16),
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(widget.isDarkMode ? 0.14 : 0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, anim) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.06, 0),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              );
            },
            child: Row(
              key: ValueKey(widget.label),
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.45),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.isDarkMode
                          ? AppColors.darkTitle
                          : Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, c) {
              final maxW = c.maxWidth;
              return ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Container(
                      height: 11,
                      width: maxW,
                      color: trackColor,
                    ),
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOutCubic,
                      tween: Tween<double>(
                        end: widget.progress.clamp(0.0, 1.0),
                      ),
                      builder: (context, widthFactor, _) {
                        final w = (maxW * widthFactor).clamp(0.0, maxW);
                        if (w < 1) return const SizedBox.shrink();
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedBuilder(
                            animation: _shimmer,
                            builder: (context, child) {
                              final t = _shimmer.value;
                              return Container(
                                height: 11,
                                width: w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  gradient: LinearGradient(
                                    begin: Alignment(-1.2 + t * 2.4, 0),
                                    end: Alignment(0.2 + t * 2.4, 0),
                                    colors: [
                                      Color.lerp(primary, Colors.white, 0.12) ??
                                          primary,
                                      primary,
                                      Color.lerp(primary, Colors.white, 0.28) ??
                                          primary,
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary.withOpacity(0.28),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color background;
  final Color borderColor;
  final Color textColor;
  final IconData icon;

  const _ActionButton({
    required this.title,
    required this.onTap,
    required this.background,
    required this.borderColor,
    required this.textColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.1),
          boxShadow: [
            BoxShadow(
              color: background.withOpacity(0.18),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: textColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
