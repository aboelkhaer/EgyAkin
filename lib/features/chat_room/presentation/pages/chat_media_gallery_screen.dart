import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/models/chat_media_list_models.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/chat_room/presentation/models/chat_message_item.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_attachment_image.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_voice_bubble.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

class ChatMediaGalleryScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String displayName;
  final List<ChatMessageItem> messages;
  final String? chatType;
  final int? contextId;
  final int? conversationId;
  /// 1:1 peer avatar fallback when media API omits sender image.
  final String? peerImageUrl;

  const ChatMediaGalleryScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.displayName,
    this.messages = const [],
    this.chatType,
    this.contextId,
    this.conversationId,
    this.peerImageUrl,
  });

  @override
  State<ChatMediaGalleryScreen> createState() => _ChatMediaGalleryScreenState();
}

class _ChatMediaGalleryScreenState extends State<ChatMediaGalleryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabs;
  late final AnimationController _intro;
  late final Animation<double> _fade;
  late final ScrollController _mediaScroll;
  late final ScrollController _voicesScroll;
  late final ScrollController _docsScroll;

  final List<_MediaEntry> _images = [];
  final List<_VoiceEntry> _voices = [];
  final List<_DocEntry> _docs = [];
  final Set<String> _seenImageKeys = {};
  final Set<String> _seenVoiceKeys = {};
  final Set<String> _seenDocKeys = {};

  bool _loadingImages = false;
  bool _loadingVoices = false;
  bool _loadingDocs = false;
  bool _loadingMoreImages = false;
  bool _loadingMoreVoices = false;
  bool _loadingMoreDocs = false;
  bool _hasMoreImages = false;
  bool _hasMoreVoices = false;
  bool _hasMoreDocs = false;
  int _imagesPage = 1;
  int _voicesPage = 1;
  int _docsPage = 1;
  int? _totalImages;
  int? _totalVoices;
  int? _totalDocs;
  String? _error;

  ChatRoomRepository get _repo => GetIt.I<ChatRoomRepository>();

  /// Same addressing as messages / chat info:
  /// private (+ case/social groups) → [contextId]; ad-hoc group → conversation id.
  int? get _addressId {
    if (widget.chatType == ChatApiType.group) {
      return widget.conversationId ?? widget.contextId;
    }
    return widget.contextId;
  }

  bool get _canUseApi =>
      _addressId != null &&
      widget.chatType != null &&
      widget.chatType!.isNotEmpty;

  bool get _loading =>
      _loadingImages || _loadingVoices || _loadingDocs;

  /// Prefer server `counts`; never flash seeded/local page lengths while API loads.
  int? get _displayImageCount {
    if (_totalImages != null) return _totalImages;
    if (_canUseApi) return null;
    return _images.length;
  }

  int? get _displayVoiceCount {
    if (_totalVoices != null) return _totalVoices;
    if (_canUseApi) return null;
    return _voices.length;
  }

  int? get _displayDocCount {
    if (_totalDocs != null) return _totalDocs;
    if (_canUseApi) return null;
    return _docs.length;
  }

  void _applyCounts(ChatMediaCountsModel? counts) {
    if (counts == null) return;
    if (counts.image != null) _totalImages = counts.image;
    if (counts.voice != null) _totalVoices = counts.voice;
    if (counts.file != null) _totalDocs = counts.file;
  }

  String _headerTotalsSubtitle(String name) {
    final images = _displayImageCount;
    final voices = _displayVoiceCount;
    final docs = _displayDocCount;
    final parts = <String>[];
    if (images != null) parts.add('$images photos');
    if (voices != null) parts.add('$voices voices');
    if (docs != null) parts.add('$docs files');
    if (name.isNotEmpty) parts.add(name);
    return parts.join(' · ');
  }

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fade = CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic);
    _mediaScroll = ScrollController()..addListener(_onMediaScroll);
    _voicesScroll = ScrollController()..addListener(_onVoicesScroll);
    _docsScroll = ScrollController()..addListener(_onDocsScroll);
    // Local seed only when we can't hit the media API (offline / missing ids).
    if (!_canUseApi) {
      _seedFromMessages(widget.messages);
    }
    _intro.forward();
    if (_canUseApi) {
      // Mark loading before the first frame so tabs never flash empty state.
      _loadingImages = true;
      _loadingVoices = true;
      _loadingDocs = true;
      unawaited(_loadImages(reset: true));
      unawaited(_loadVoices(reset: true));
      unawaited(_loadDocs(reset: true));
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    _intro.dispose();
    _mediaScroll.dispose();
    _voicesScroll.dispose();
    _docsScroll.dispose();
    super.dispose();
  }

  void _onMediaScroll() {
    if (!_mediaScroll.hasClients ||
        !_canUseApi ||
        !_hasMoreImages ||
        _loadingMoreImages ||
        _loadingImages) {
      return;
    }
    if (_mediaScroll.position.pixels >=
        _mediaScroll.position.maxScrollExtent - 240) {
      unawaited(_loadImages(reset: false));
    }
  }

  void _onVoicesScroll() {
    if (!_voicesScroll.hasClients ||
        !_canUseApi ||
        !_hasMoreVoices ||
        _loadingMoreVoices ||
        _loadingVoices) {
      return;
    }
    if (_voicesScroll.position.pixels >=
        _voicesScroll.position.maxScrollExtent - 240) {
      unawaited(_loadVoices(reset: false));
    }
  }

  void _onDocsScroll() {
    if (!_docsScroll.hasClients ||
        !_canUseApi ||
        !_hasMoreDocs ||
        _loadingMoreDocs ||
        _loadingDocs) {
      return;
    }
    if (_docsScroll.position.pixels >=
        _docsScroll.position.maxScrollExtent - 240) {
      unawaited(_loadDocs(reset: false));
    }
  }

  void _seedFromMessages(List<ChatMessageItem> messages) {
    for (final m in messages.reversed) {
      for (final a in m.attachments) {
        final key = a.id != null
            ? 'a:${a.id}'
            : '${m.id}:${a.url ?? a.localFile?.path ?? ''}';

        if (a.isImage) {
          if (!_seenImageKeys.add(key)) continue;
          final hasUrl = a.url?.trim().isNotEmpty == true;
          final hasLocal = a.localFile != null;
          if (!hasUrl && !hasLocal) continue;
          _images.add(_MediaEntry(
            attachment: a,
            timeLabel: m.timeLabel,
            messageId: m.id,
            createdAt: m.createdAt,
          ));
        } else if (a.isVoice) {
          if (!_seenVoiceKeys.add(key)) continue;
          final hasUrl = a.url?.trim().isNotEmpty == true;
          final hasLocal = a.localFile != null;
          if (!hasUrl && !hasLocal) continue;
          _voices.add(_VoiceEntry(
            attachment: a,
            timeLabel: m.timeLabel,
            messageId: m.id,
            createdAt: m.createdAt,
            isOutgoing: m.isOutgoing,
            senderImageUrl: _voiceSenderImage(
              isOutgoing: m.isOutgoing,
              senderImageUrl: m.senderImageUrl,
            ),
            senderInitials: _voiceSenderInitials(
              isOutgoing: m.isOutgoing,
              senderInitials: m.senderInitials,
              senderName: m.senderName,
            ),
          ));
        } else if (a.isFile) {
          if (!_seenDocKeys.add(key)) continue;
          final url = a.url?.trim();
          if (url == null || url.isEmpty) continue;
          _docs.add(_DocEntry(
            attachment: a,
            name: (a.originalName?.trim().isNotEmpty == true)
                ? a.originalName!.trim()
                : 'File',
            sizeLabel: null,
            timeLabel: m.timeLabel,
            messageId: m.id,
            createdAt: m.createdAt,
          ));
        }
      }
    }
  }

  void _ingestMediaItems(
    List<ChatMediaItemModel> items, {
    required String kind, // image | voice | file
  }) {
    for (final item in items) {
      final model = item.toAttachmentModel();
      final seconds = model.durationSeconds ?? item.durationSeconds;
      final attachment = ChatAttachmentItem(
        id: model.id,
        type: model.type ?? kind,
        originalName: model.originalName,
        mimeType: model.mimeType,
        url: model.url,
        durationMs: seconds == null ? null : seconds * 1000,
      );
      final key = attachment.id != null
          ? 'a:${attachment.id}'
          : '${item.messageId ?? ''}:${attachment.url ?? ''}';
      final createdAt = DateTime.tryParse(item.createdAt ?? '');
      final timeLabel = ChatMappers.formatMessageTime(item.createdAt);
      final messageId = (item.messageId ?? item.id ?? 0).toString();

      if (kind == 'image') {
        if (!_seenImageKeys.add(key)) continue;
        final hasUrl = attachment.url?.trim().isNotEmpty == true;
        if (!hasUrl) continue;
        _images.add(_MediaEntry(
          attachment: attachment,
          timeLabel: timeLabel,
          messageId: messageId,
          createdAt: createdAt,
        ));
      } else if (kind == 'voice') {
        if (!_seenVoiceKeys.add(key)) continue;
        final hasUrl = attachment.url?.trim().isNotEmpty == true;
        if (!hasUrl) continue;
        final seeded = _seededVoiceForMessage(messageId);
        final isOutgoing = item.senderId != null
            ? item.senderId == widget.currentDoctorModel.id
            : (seeded?.isOutgoing ?? false);
        _voices.add(_VoiceEntry(
          attachment: attachment,
          timeLabel: timeLabel,
          messageId: messageId,
          createdAt: createdAt,
          isOutgoing: isOutgoing,
          senderImageUrl: _voiceSenderImage(
            isOutgoing: isOutgoing,
            senderImageUrl: item.senderImageUrl ?? seeded?.senderImageUrl,
          ),
          senderInitials: _voiceSenderInitials(
            isOutgoing: isOutgoing,
            senderInitials: item.senderInitials ?? seeded?.senderInitials,
            senderName: item.senderName ?? seeded?.senderName,
          ),
        ));
      } else {
        if (!_seenDocKeys.add(key)) continue;
        final url = attachment.url?.trim();
        if (url == null || url.isEmpty) continue;
        _docs.add(_DocEntry(
          attachment: attachment,
          name: (attachment.originalName?.trim().isNotEmpty == true)
              ? attachment.originalName!.trim()
              : 'File',
          sizeLabel: _formatBytes(item.sizeBytes),
          timeLabel: timeLabel,
          messageId: messageId,
          createdAt: createdAt,
        ));
      }
    }
  }

  String? _formatBytes(int? bytes) {
    if (bytes == null || bytes <= 0) return null;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> _loadImages({required bool reset}) async {
    final addressId = _addressId;
    final chatType = widget.chatType;
    if (addressId == null || chatType == null) return;
    if (!reset && (_loadingImages || _loadingMoreImages)) return;
    if (reset && _loadingMoreImages) return;

    final nextPage = reset ? 1 : _imagesPage + 1;
    if (!_loadingImages || !reset) {
      setState(() {
        if (reset) {
          _loadingImages = true;
          _error = null;
        } else {
          _loadingMoreImages = true;
        }
      });
    } else if (reset) {
      _error = null;
    }

    final result = await _repo.getConversationMedia(
      contextId: addressId,
      chatType: chatType,
      mediaType: 'image',
      page: nextPage,
    );
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _loadingImages = false;
          _loadingMoreImages = false;
          _error = failure.message;
        });
      },
      (response) {
        setState(() {
          if (reset) {
            _images.clear();
            _seenImageKeys.clear();
          }
          _loadingImages = false;
          _loadingMoreImages = false;
          _imagesPage = nextPage;
          _hasMoreImages = response.hasMore == true;
          _applyCounts(response.counts);
          _ingestMediaItems(response.items, kind: 'image');
          int idNum(String id) => int.tryParse(id) ?? 0;
          _images.sort(
            (a, b) => idNum(b.messageId).compareTo(idNum(a.messageId)),
          );
        });
      },
    );
  }

  Future<void> _loadVoices({required bool reset}) async {
    final addressId = _addressId;
    final chatType = widget.chatType;
    if (addressId == null || chatType == null) return;
    if (!reset && (_loadingVoices || _loadingMoreVoices)) return;
    if (reset && _loadingMoreVoices) return;

    final nextPage = reset ? 1 : _voicesPage + 1;
    if (!_loadingVoices || !reset) {
      setState(() {
        if (reset) {
          _loadingVoices = true;
          _error = null;
        } else {
          _loadingMoreVoices = true;
        }
      });
    } else if (reset) {
      _error = null;
    }

    final result = await _repo.getConversationMedia(
      contextId: addressId,
      chatType: chatType,
      mediaType: 'voice',
      page: nextPage,
    );
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _loadingVoices = false;
          _loadingMoreVoices = false;
          _error = failure.message;
        });
      },
      (response) {
        setState(() {
          if (reset) {
            _voices.clear();
            _seenVoiceKeys.clear();
          }
          _loadingVoices = false;
          _loadingMoreVoices = false;
          _voicesPage = nextPage;
          _hasMoreVoices = response.hasMore == true;
          _applyCounts(response.counts);
          _ingestMediaItems(response.items, kind: 'voice');
          int idNum(String id) => int.tryParse(id) ?? 0;
          _voices.sort(
            (a, b) => idNum(b.messageId).compareTo(idNum(a.messageId)),
          );
        });
      },
    );
  }

  Future<void> _loadDocs({required bool reset}) async {
    final addressId = _addressId;
    final chatType = widget.chatType;
    if (addressId == null || chatType == null) return;
    if (!reset && (_loadingDocs || _loadingMoreDocs)) return;
    if (reset && _loadingMoreDocs) return;

    final nextPage = reset ? 1 : _docsPage + 1;
    if (!_loadingDocs || !reset) {
      setState(() {
        if (reset) {
          _loadingDocs = true;
          _error = null;
        } else {
          _loadingMoreDocs = true;
        }
      });
    } else if (reset) {
      _error = null;
    }

    final result = await _repo.getConversationMedia(
      contextId: addressId,
      chatType: chatType,
      mediaType: 'file',
      page: nextPage,
    );
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _loadingDocs = false;
          _loadingMoreDocs = false;
          _error = failure.message;
        });
      },
      (response) {
        setState(() {
          if (reset) {
            _docs.clear();
            _seenDocKeys.clear();
          }
          _loadingDocs = false;
          _loadingMoreDocs = false;
          _docsPage = nextPage;
          _hasMoreDocs = response.hasMore == true;
          _applyCounts(response.counts);
          _ingestMediaItems(response.items, kind: 'file');
          int idNum(String id) => int.tryParse(id) ?? 0;
          _docs.sort(
            (a, b) => idNum(b.messageId).compareTo(idNum(a.messageId)),
          );
        });
      },
    );
  }

  Future<void> _openImageViewer(int index) async {
    final urls = <String>[];
    final cacheKeys = <String?>[];
    var allLocal = true;
    for (final item in _images) {
      final a = item.attachment;
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

    final tapped = _images[index.clamp(0, _images.length - 1)];
    final isLocal = tapped.attachment.localFile != null;
    final headers = allLocal ? null : await chatProtectedFileHeaders();
    if (!mounted) return;

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

  void _goToMessage(String messageId) {
    final id = messageId.trim();
    if (id.isEmpty || id == '0') {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.originalMessageNotAvailable),
      );
      return;
    }
    Navigator.of(context).pop(id);
  }

  Future<void> _showGoToMessageOverlay({
    required String messageId,
    required Rect anchorRect,
    required _OverlayPreviewKind kind,
    ChatAttachmentItem? attachment,
    String? title,
    String? subtitle,
    bool isOutgoing = false,
    bool isDark = true,
    String? senderImageUrl,
    String? senderInitials,
  }) async {
    HapticFeedback.selectionClick();
    final action = await showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return _GoToMessageOverlay(
          anchorRect: anchorRect,
          kind: kind,
          attachment: attachment,
          title: title,
          subtitle: subtitle,
          isOutgoing: isOutgoing,
          isDark: isDark,
          senderImageUrl: senderImageUrl,
          senderInitials: senderInitials,
          routeAnimation: animation,
          onGoToMessage: () => Navigator.pop(ctx, 'goto'),
          onDismiss: () => Navigator.pop(ctx),
        );
      },
      transitionBuilder: (ctx, animation, secondary, child) {
        // Content drives its own motion; keep route transition idle.
        return child;
      },
    );
    if (!mounted || action != 'goto') return;
    _goToMessage(messageId);
  }

  Future<void> _openDoc(_DocEntry doc) async {
    try {
      final a = doc.attachment;
      if (a.localFile != null) {
        await OpenFile.open(a.localFile!.path);
        return;
      }
      final resolved = resolveChatAttachmentUrl(a.url);
      if (resolved.isEmpty) return;
      final file = await downloadChatProtectedFile(
        url: resolved,
        cacheId: '${a.id ?? doc.messageId}_${a.originalName ?? 'doc'}',
        filePrefix: 'chat_gallery_doc',
        mimeType: a.mimeType,
        originalName: a.originalName,
      );
      if (!mounted) return;
      await OpenFile.open(file.path);
    } catch (_) {
      if (!mounted) return;
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.somethingWentWrong),
      );
    }
  }

  String? _voiceSenderImage({
    required bool isOutgoing,
    String? senderImageUrl,
  }) {
    if (isOutgoing) {
      final mine = widget.currentDoctorModel.image?.trim();
      if (mine != null && mine.isNotEmpty) return mine;
    }
    final fromSender = senderImageUrl?.trim();
    if (fromSender != null && fromSender.isNotEmpty) return fromSender;
    final peer = widget.peerImageUrl?.trim();
    if (!isOutgoing && peer != null && peer.isNotEmpty) return peer;
    return null;
  }

  String? _voiceSenderInitials({
    required bool isOutgoing,
    String? senderInitials,
    String? senderName,
  }) {
    if (isOutgoing) {
      final mine = ChatMappers.initialsFromTitle(
        [
          widget.currentDoctorModel.firstName,
          widget.currentDoctorModel.lastName,
        ]
            .whereType<String>()
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .join(' '),
      );
      return mine == '?' ? null : mine;
    }
    final initials = senderInitials?.trim();
    if (initials != null && initials.isNotEmpty) return initials;
    final fromName = ChatMappers.initialsFromTitle(senderName);
    if (fromName != '?') return fromName;
    final peer = ChatMappers.initialsFromTitle(widget.displayName);
    return peer == '?' ? null : peer;
  }

  ChatMessageItem? _seededVoiceForMessage(String messageId) {
    if (messageId.isEmpty || messageId == '0') return null;
    for (final m in widget.messages) {
      if (m.id == messageId) return m;
    }
    return null;
  }

  List<_MediaSection<_MediaEntry>> _groupMedia() {
    return _groupByDay(_images, (e) => e.createdAt);
  }

  List<_MediaSection<_VoiceEntry>> _groupVoices() {
    return _groupByDay(_voices, (e) => e.createdAt);
  }

  List<_MediaSection<_DocEntry>> _groupDocs() {
    return _groupByDay(_docs, (e) => e.createdAt);
  }

  List<_MediaSection<T>> _groupByDay<T>(
    List<T> items,
    DateTime? Function(T) createdAtOf,
  ) {
    final map = <DateTime, List<T>>{};
    final order = <DateTime>[];
    for (final item in items) {
      final raw = createdAtOf(item)?.toLocal() ?? DateTime.now();
      final day = DateTime(raw.year, raw.month, raw.day);
      if (!map.containsKey(day)) {
        map[day] = <T>[];
        order.add(day);
      }
      map[day]!.add(item);
    }
    return [
      for (final day in order)
        _MediaSection<T>(day: day, items: map[day] ?? const []),
    ];
  }

  String _dayLabel(BuildContext context, DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return context.tr(AppStrings.today);
    if (diff == 1) return context.tr(AppStrings.yesterday);
    final locale = context.currentLocale?.toString() ?? 'en';
    if (diff > 1 && diff < 7) {
      return DateFormat.EEEE(locale).format(day);
    }
    if (day.year == today.year) {
      return DateFormat.MMMMd(locale).format(day);
    }
    return DateFormat.yMMMMd(locale).format(day);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final bg = HomeDashboardColors.scaffold(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final subColor = HomeDashboardColors.subtitle(isDark);
        final card = HomeDashboardColors.cardBg(isDark);
        final border = HomeDashboardColors.border(isDark);
        final name = widget.displayName.trim();

        return Scaffold(
          backgroundColor: bg,
          body: Stack(
            children: [
              Positioned(
                top: -80.h,
                right: -60.w,
                child: IgnorePointer(
                  child: Container(
                    width: 220.w,
                    height: 220.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withOpacity(isDark ? 0.22 : 0.14),
                          AppColors.primary.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 40.h,
                left: -80.w,
                child: IgnorePointer(
                  child: Container(
                    width: 260.w,
                    height: 260.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF6366F1)
                              .withOpacity(isDark ? 0.12 : 0.08),
                          const Color(0xFF6366F1).withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: FadeTransition(
                  opacity: _fade,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _GalleryHeader(
                        title: context.tr(AppStrings.mediaGallery),
                        subtitle: _headerTotalsSubtitle(name),
                        titleColor: titleColor,
                        subColor: subColor,
                        onBack: () => Navigator.of(context).pop(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                        child: _SegmentedTabs(
                          controller: _tabs,
                          isDark: isDark,
                          card: card,
                          border: border,
                          subColor: subColor,
                          mediaCount: _displayImageCount,
                          voicesCount: _displayVoiceCount,
                          docsCount: _displayDocCount,
                          mediaLabel: context.tr(AppStrings.mediaGallery),
                          voicesLabel: context.tr(AppStrings.voices),
                          docsLabel: context.tr(AppStrings.documents),
                        ),
                      ),
                      Expanded(
                        child: _loading &&
                                _images.isEmpty &&
                                _voices.isEmpty &&
                                _docs.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            : TabBarView(
                                controller: _tabs,
                                children: [
                                  _buildMediaBody(
                                    subColor: subColor,
                                    card: card,
                                    border: border,
                                  ),
                                  _buildVoicesBody(
                                    titleColor: titleColor,
                                    subColor: subColor,
                                    card: card,
                                    border: border,
                                    isDark: isDark,
                                  ),
                                  _buildDocsBody(
                                    titleColor: titleColor,
                                    subColor: subColor,
                                    card: card,
                                    border: border,
                                  ),
                                ],
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
    );
  }

  Widget _buildMediaBody({
    required Color subColor,
    required Color card,
    required Color border,
  }) {
    if (_error != null && _images.isEmpty && !_loadingImages) {
      return _EmptyState(
        icon: Icons.wifi_off_rounded,
        title: _error!,
        subColor: subColor,
        card: card,
        border: border,
      );
    }
    if (_images.isEmpty && _loadingImages) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (_images.isEmpty) {
      return _EmptyState(
        icon: Icons.photo_library_outlined,
        title: context.tr(AppStrings.noMediaYet),
        subColor: subColor,
        card: card,
        border: border,
      );
    }

    final sections = _groupMedia();
    return CustomScrollView(
      controller: _mediaScroll,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        for (final section in sections) ...[
          SliverToBoxAdapter(
            child: _SectionHeader(
              label: _dayLabel(context, section.day),
              count: section.items.length,
              subColor: subColor,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6.w,
                mainAxisSpacing: 6.w,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final item = section.items[i];
                  final globalIndex = _images.indexOf(item);
                  return _MediaTile(
                    entry: item,
                    onTap: () => unawaited(
                      _openImageViewer(globalIndex < 0 ? 0 : globalIndex),
                    ),
                    onLongPress: (rect) => unawaited(
                      _showGoToMessageOverlay(
                        messageId: item.messageId,
                        anchorRect: rect,
                        kind: _OverlayPreviewKind.image,
                        attachment: item.attachment,
                      ),
                    ),
                  );
                },
                childCount: section.items.length,
              ),
            ),
          ),
        ],
        if (_loadingMoreImages)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              child: Center(
                child: SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          )
        else
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }

  Widget _buildVoicesBody({
    required Color titleColor,
    required Color subColor,
    required Color card,
    required Color border,
    required bool isDark,
  }) {
    if (_error != null && _voices.isEmpty && !_loadingVoices) {
      return _EmptyState(
        icon: Icons.wifi_off_rounded,
        title: _error!,
        subColor: subColor,
        card: card,
        border: border,
      );
    }
    if (_voices.isEmpty && _loadingVoices) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (_voices.isEmpty) {
      return _EmptyState(
        icon: Icons.mic_none_rounded,
        title: context.tr(AppStrings.noVoicesYet),
        subColor: subColor,
        card: card,
        border: border,
      );
    }

    final sections = _groupVoices();
    return ListView.builder(
      controller: _voicesScroll,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
      itemCount: sections.length + (_loadingMoreVoices ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= sections.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: SizedBox(
                width: 22.r,
                height: 22.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        }
        final section = sections[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(
              label: _dayLabel(context, section.day),
              count: section.items.length,
              subColor: subColor,
            ),
            ...section.items.map(
              (voice) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _VoiceCard(
                  entry: voice,
                  isDark: isDark,
                  card: card,
                  border: border,
                  onLongPress: (rect) => unawaited(
                    _showGoToMessageOverlay(
                      messageId: voice.messageId,
                      anchorRect: rect,
                      kind: _OverlayPreviewKind.voice,
                      attachment: voice.attachment,
                      isOutgoing: voice.isOutgoing,
                      isDark: isDark,
                      senderImageUrl: voice.senderImageUrl,
                      senderInitials: voice.senderInitials,
                      subtitle: voice.timeLabel,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDocsBody({
    required Color titleColor,
    required Color subColor,
    required Color card,
    required Color border,
  }) {
    if (_docs.isEmpty && _loadingDocs) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (_docs.isEmpty) {
      return _EmptyState(
        icon: Icons.folder_open_rounded,
        title: context.tr(AppStrings.noDocumentsYet),
        subColor: subColor,
        card: card,
        border: border,
      );
    }

    final sections = _groupDocs();
    return ListView.builder(
      controller: _docsScroll,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
      itemCount: sections.length + (_loadingMoreDocs ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= sections.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: SizedBox(
                width: 22.r,
                height: 22.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        }
        final section = sections[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(
              label: _dayLabel(context, section.day),
              count: section.items.length,
              subColor: subColor,
            ),
            ...section.items.map(
              (doc) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _DocCard(
                  doc: doc,
                  titleColor: titleColor,
                  subColor: subColor,
                  card: card,
                  border: border,
                  onTap: () => unawaited(_openDoc(doc)),
                  onLongPress: (rect) => unawaited(
                    _showGoToMessageOverlay(
                      messageId: doc.messageId,
                      anchorRect: rect,
                      kind: _OverlayPreviewKind.document,
                      attachment: doc.attachment,
                      title: doc.name,
                      subtitle: [
                        if (doc.sizeLabel != null && doc.sizeLabel!.isNotEmpty)
                          doc.sizeLabel!,
                        doc.timeLabel,
                      ].join(' · '),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GalleryHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color titleColor;
  final Color subColor;
  final VoidCallback onBack;

  const _GalleryHeader({
    required this.title,
    required this.titleColor,
    required this.subColor,
    required this.onBack,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 16.w, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 18.sp,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: subColor,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final TabController controller;
  final bool isDark;
  final Color card;
  final Color border;
  final Color subColor;
  final int? mediaCount;
  final int? voicesCount;
  final int? docsCount;
  final String mediaLabel;
  final String voicesLabel;
  final String docsLabel;

  const _SegmentedTabs({
    required this.controller,
    required this.isDark,
    required this.card,
    required this.border,
    required this.subColor,
    required this.mediaCount,
    required this.voicesCount,
    required this.docsCount,
    required this.mediaLabel,
    required this.voicesLabel,
    required this.docsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: card.withOpacity(isDark ? 0.72 : 0.95),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border.withOpacity(0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor: subColor,
        labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
        labelStyle: TextStyle(
          fontSize: 11.5.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11.5.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(
            height: 40.h,
            child: _TabLabel(label: mediaLabel, count: mediaCount),
          ),
          Tab(
            height: 40.h,
            child: _TabLabel(label: voicesLabel, count: voicesCount),
          ),
          Tab(
            height: 40.h,
            child: _TabLabel(label: docsLabel, count: docsCount),
          ),
        ],
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  final String label;
  final int? count;

  const _TabLabel({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (count != null) ...[
          SizedBox(width: 6.w),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final int count;
  final Color subColor;

  const _SectionHeader({
    required this.label,
    required this.count,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 8.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: subColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaTile extends StatefulWidget {
  final _MediaEntry entry;
  final VoidCallback onTap;
  final ValueChanged<Rect>? onLongPress;

  const _MediaTile({
    required this.entry,
    required this.onTap,
    this.onLongPress,
  });

  @override
  State<_MediaTile> createState() => _MediaTileState();
}

class _MediaTileState extends State<_MediaTile> {
  bool _pressed = false;

  Rect _tileRect() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return Rect.zero;
    return box.localToGlobal(Offset.zero) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      onLongPressStart: widget.onLongPress == null
          ? null
          : (_) => widget.onLongPress!(_tileRect()),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final side = constraints.maxWidth.isFinite
                        ? constraints.maxWidth
                        : 120.0;
                    return SizedBox(
                      width: side,
                      height: side,
                      child: ChatAttachmentImage(
                        attachment: widget.entry.attachment,
                        width: side,
                        height: side,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 28.h,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.35),
                          ],
                        ),
                      ),
                    ),
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

class _DocCard extends StatelessWidget {
  final _DocEntry doc;
  final Color titleColor;
  final Color subColor;
  final Color card;
  final Color border;
  final VoidCallback onTap;
  final ValueChanged<Rect>? onLongPress;

  const _DocCard({
    required this.doc,
    required this.titleColor,
    required this.subColor,
    required this.card,
    required this.border,
    required this.onTap,
    this.onLongPress,
  });

  IconData get _icon {
    final name = doc.name.toLowerCase();
    if (name.endsWith('.pdf')) return Icons.picture_as_pdf_rounded;
    if (name.endsWith('.doc') || name.endsWith('.docx')) {
      return Icons.description_rounded;
    }
    if (name.endsWith('.xls') ||
        name.endsWith('.xlsx') ||
        name.endsWith('.csv')) {
      return Icons.table_chart_rounded;
    }
    return Icons.insert_drive_file_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress == null
            ? null
            : () {
                final box = context.findRenderObject() as RenderBox?;
                if (box == null || !box.hasSize) return;
                onLongPress!(box.localToGlobal(Offset.zero) & box.size);
              },
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: border.withOpacity(0.8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46.r,
                height: 46.r,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withOpacity(0.22),
                      AppColors.primary.withOpacity(0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: Icon(_icon, color: AppColors.primary, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      [
                        if (doc.sizeLabel != null && doc.sizeLabel!.isNotEmpty)
                          doc.sizeLabel!,
                        if (doc.timeLabel.isNotEmpty) doc.timeLabel,
                      ].join(' · '),
                      style: TextStyle(
                        color: subColor,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: subColor.withOpacity(0.7),
                size: 22.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color subColor;
  final Color card;
  final Color border;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subColor,
    required this.card,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                color: card,
                shape: BoxShape.circle,
                border: Border.all(color: border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.primary, size: 30.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaSection<T> {
  final DateTime day;
  final List<T> items;

  const _MediaSection({
    required this.day,
    required this.items,
  });
}

class _MediaEntry {
  final ChatAttachmentItem attachment;
  final String timeLabel;
  final String messageId;
  final DateTime? createdAt;

  const _MediaEntry({
    required this.attachment,
    required this.timeLabel,
    required this.messageId,
    this.createdAt,
  });
}

class _VoiceEntry {
  final ChatAttachmentItem attachment;
  final String timeLabel;
  final String messageId;
  final DateTime? createdAt;
  final bool isOutgoing;
  final String? senderImageUrl;
  final String? senderInitials;

  const _VoiceEntry({
    required this.attachment,
    required this.timeLabel,
    required this.messageId,
    required this.isOutgoing,
    this.createdAt,
    this.senderImageUrl,
    this.senderInitials,
  });
}

class _VoiceCard extends StatelessWidget {
  final _VoiceEntry entry;
  final bool isDark;
  final Color card;
  final Color border;
  final ValueChanged<Rect>? onLongPress;

  const _VoiceCard({
    required this.entry,
    required this.isDark,
    required this.card,
    required this.border,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onLongPress == null
          ? null
          : (_) {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null || !box.hasSize) return;
              onLongPress!(box.localToGlobal(Offset.zero) & box.size);
            },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: border.withOpacity(0.8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ChatVoiceBubble(
          attachment: entry.attachment,
          isOutgoing: entry.isOutgoing,
          isDarkMode: isDark,
          timeLabel: entry.timeLabel,
          senderImageUrl: entry.senderImageUrl,
          senderInitials: entry.senderInitials,
        ),
      ),
    );
  }
}

class _DocEntry {
  final ChatAttachmentItem attachment;
  final String name;
  final String? sizeLabel;
  final String timeLabel;
  final String messageId;
  final DateTime? createdAt;

  const _DocEntry({
    required this.attachment,
    required this.name,
    required this.timeLabel,
    required this.messageId,
    this.sizeLabel,
    this.createdAt,
  });
}

enum _OverlayPreviewKind { image, voice, document }

class _GoToMessageOverlay extends StatefulWidget {
  final Rect anchorRect;
  final _OverlayPreviewKind kind;
  final ChatAttachmentItem? attachment;
  final String? title;
  final String? subtitle;
  final bool isOutgoing;
  final bool isDark;
  final String? senderImageUrl;
  final String? senderInitials;
  final Animation<double> routeAnimation;
  final VoidCallback onGoToMessage;
  final VoidCallback onDismiss;

  const _GoToMessageOverlay({
    required this.anchorRect,
    required this.kind,
    required this.routeAnimation,
    required this.onGoToMessage,
    required this.onDismiss,
    this.attachment,
    this.title,
    this.subtitle,
    this.isOutgoing = false,
    this.isDark = true,
    this.senderImageUrl,
    this.senderInitials,
  });

  @override
  State<_GoToMessageOverlay> createState() => _GoToMessageOverlayState();
}

class _GoToMessageOverlayState extends State<_GoToMessageOverlay> {
  static const double _menuWidth = 210;
  static const double _menuHeight = 52;
  static const double _gap = 10;

  late final Animation<double> _scrim;
  late final Animation<double> _content;
  late final Animation<double> _menu;

  @override
  void initState() {
    super.initState();
    final parent = widget.routeAnimation;
    _scrim = CurvedAnimation(
      parent: parent,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeIn),
    );
    _content = CurvedAnimation(
      parent: parent,
      curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeInCubic),
    );
    _menu = CurvedAnimation(
      parent: parent,
      curve: const Interval(0.28, 1.0, curve: Curves.easeOutCubic),
      reverseCurve: const Interval(0.0, 0.7, curve: Curves.easeIn),
    );
  }

  Rect _targetPreviewRect(Size size, EdgeInsets padding) {
    late final double previewW;
    late final double previewH;
    switch (widget.kind) {
      case _OverlayPreviewKind.image:
        final side =
            (widget.anchorRect.shortestSide * 1.12).clamp(100.0, 156.0);
        previewW = side;
        previewH = side;
      case _OverlayPreviewKind.voice:
        previewW = (size.width - 48).clamp(240.0, 300.0);
        previewH = 70;
      case _OverlayPreviewKind.document:
        previewW = (size.width - 48).clamp(240.0, 300.0);
        previewH = 72;
    }

    var left = widget.anchorRect.center.dx - previewW / 2;
    left = left.clamp(16.0, size.width - previewW - 16.0);

    var top = widget.anchorRect.center.dy - previewH / 2;
    final stackH = previewH + _gap + _menuHeight;
    if (top + stackH > size.height - padding.bottom - 16) {
      top = size.height - padding.bottom - 16 - stackH;
    }
    if (top < padding.top + 12) {
      top = padding.top + 12;
    }
    return Rect.fromLTWH(left, top, previewW, previewH);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final from = widget.anchorRect;
    final to = _targetPreviewRect(size, padding);
    final previewAnim = RectTween(begin: from, end: to).animate(_content);

    var menuLeft = to.left + (to.width - _menuWidth) / 2;
    menuLeft = menuLeft.clamp(16.0, size.width - _menuWidth - 16.0);
    final menuTop = to.bottom + _gap;

    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: widget.routeAnimation,
        builder: (context, _) {
          final previewRect = previewAnim.value ?? to;
          final menuT = _menu.value.clamp(0.0, 1.0);
          final scrimT = _scrim.value.clamp(0.0, 1.0);

          return Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onDismiss,
                  child: ColoredBox(
                    // Soft dim only — blur was causing jank/panicking.
                    color: Colors.black.withOpacity(0.52 * scrimT),
                  ),
                ),
              ),
              Positioned.fromRect(
                rect: previewRect,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: (0.35 + 0.65 * _content.value).clamp(0.0, 1.0),
                    child: _buildPreview(
                      context,
                      width: previewRect.width,
                      height: previewRect.height,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: menuLeft,
                top: menuTop + (8 * (1 - menuT)),
                width: _menuWidth,
                child: Opacity(
                  opacity: menuT,
                  child: Transform.scale(
                    scale: 0.96 + (0.04 * menuT),
                    alignment: Alignment.topCenter,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onGoToMessage,
                        borderRadius: BorderRadius.circular(14),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color(0xFF23202C),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.35 * menuT),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary.withOpacity(0.22),
                                ),
                                child: const Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  context.tr(AppStrings.goToMessage),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPreview(
    BuildContext context, {
    required double width,
    required double height,
  }) {
    switch (widget.kind) {
      case _OverlayPreviewKind.image:
        final a = widget.attachment;
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.22),
                blurRadius: 20,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: a == null
                ? const ColoredBox(color: Color(0xFF2A2438))
                : ChatAttachmentImage(
                    attachment: a,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  ),
          ),
        );
      case _OverlayPreviewKind.voice:
        return DecoratedBox(
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF221C2E) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: widget.attachment == null
                ? const SizedBox.shrink()
                : IgnorePointer(
                    child: ChatVoiceBubble(
                      attachment: widget.attachment!,
                      isOutgoing: widget.isOutgoing,
                      isDarkMode: widget.isDark,
                      timeLabel: widget.subtitle ?? '',
                      senderImageUrl: widget.senderImageUrl,
                      senderInitials: widget.senderInitials,
                    ),
                  ),
          ),
        );
      case _OverlayPreviewKind.document:
        return DecoratedBox(
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF221C2E) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.28),
                        AppColors.primary.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.insert_drive_file_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title ?? context.tr(AppStrings.download),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              widget.isDark ? Colors.white : AppColors.title,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (widget.subtitle != null &&
                          widget.subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          widget.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: widget.isDark
                                ? Colors.white.withOpacity(0.55)
                                : AppColors.description,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}
