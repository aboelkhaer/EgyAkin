import 'dart:convert';
import 'dart:io';

import 'package:egy_akin/app/services/app_screen_tracker.dart';
import 'package:egy_akin/features/chat/data/services/chat_push_delivery_ack.dart';
import 'package:egy_akin/features/chat/data/services/chat_push_navigation.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/injection_container.dart' as di;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exports.dart';

class NotificationServices {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final Set<String> shownNotifications = {};
  int notificationCounter = 0;
  bool _firebaseHandlersBound = false;
  bool _localNotificationsReady = false;
  Future<void>? _localNotificationsInit;
  bool _coldStartCaptureStarted = false;
  bool _initialMessageHandled = false;

  static const _iosPushChannel = MethodChannel('com.incode.EgyAkin/push');

  NotificationServices();

  Future<void> createNotificationChannel() async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'high_importance_channel',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      debugPrint('fcmToken: $token');
      return token;
    } catch (e) {
      // Common on iOS Simulator (no APNs) — not a real app failure.
      debugPrint('FCM token unavailable: $e');
    }
    return 'No fcmToken';
  }

  void refreshTokenListener() {
    _messaging.onTokenRefresh.listen((event) {
      debugPrint('Token Refreshed: $event');
    });
  }

  Future<void> requestNotificationPermissions() async {
    NotificationSettings notificationSettings =
        await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    switch (notificationSettings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        debugPrint('User granted permission');
        break;
      case AuthorizationStatus.provisional:
        debugPrint('User granted provisional permission');
        break;
      case AuthorizationStatus.denied:
        debugPrint('User denied permission');
        break;
      default:
        break;
    }

    // Prefer local notifications for foreground banners so taps always carry
    // our JSON payload (system iOS banners often don't route with data).
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: false,
    );
  }

  void _bindNonChatOpener() {
    ChatPushNavigation.nonChatOpener = _openNonChatTarget;
  }

  /// Capture killed→tap payloads as early as possible (before permissions /
  /// splash finish). Queues only — does not navigate until home is ready.
  Future<void> captureColdStartLaunch() async {
    if (_coldStartCaptureStarted) return;
    _coldStartCaptureStarted = true;
    _bindNonChatOpener();

    // Local-notification launch path (Android / some iOS) — init plugin first.
    await ensureLocalNotificationsReady(openLaunchPayload: false);
    await _captureLocalNotificationLaunchDetails();

    // iOS AppDelegate writes flutter.* SharedPreferences keys at launch —
    // readable immediately, no MethodChannel race.
    await _captureSharedPrefsColdStartFallback();

    // FCM terminated-state message + MethodChannel fallback (retrying).
    unawaited(_captureInitialMessageForColdStart());
    unawaited(_captureIosNativeColdStartFallback());
  }

  Future<void> ensureLocalNotificationsReady({
    bool openLaunchPayload = true,
  }) async {
    if (_localNotificationsReady) {
      await _localNotificationsInit;
      return;
    }
    _localNotificationsInit ??= _initLocalNotifications(
      openLaunchPayload: openLaunchPayload,
    );
    await _localNotificationsInit;
  }

  Future<void> _initLocalNotifications({
    required bool openLaunchPayload,
  }) async {
    await createNotificationChannel();

    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        try {
          if (response.payload == null) return;
          debugPrint('Notification tapped with payload: ${response.payload}');
          unawaited(
            ChatPushDeliveryAck.ackFromPayloadString(response.payload),
          );
          _openFromPayload(response.payload);
        } catch (e, st) {
          debugPrint('Local notification tap failed: $e\n$st');
        }
      },
    );

    _localNotificationsReady = true;

    if (openLaunchPayload) {
      await _captureLocalNotificationLaunchDetails();
    }
  }

  Future<void> _captureLocalNotificationLaunchDetails() async {
    try {
      final launch =
          await _localNotificationsPlugin.getNotificationAppLaunchDetails();
      if (launch?.didNotificationLaunchApp != true) return;
      final payload = launch?.notificationResponse?.payload;
      if (payload == null || payload.isEmpty) return;

      // Android can keep returning the same launch details on later cold
      // starts. Skip if we already consumed this exact launch payload.
      final prefs = await SharedPreferences.getInstance();
      const handledKey = 'local_notif_launch_handled_v1';
      final responseId = launch?.notificationResponse?.id?.toString() ?? '';
      final fingerprint = '$responseId|${payload.hashCode}|$payload';
      if (prefs.getString(handledKey) == fingerprint) {
        debugPrint(
          'Ignoring already-handled local notification launch payload',
        );
        return;
      }
      await prefs.setString(handledKey, fingerprint);

      debugPrint('App launched from local notification payload');
      unawaited(ChatPushDeliveryAck.ackFromPayloadString(payload));
      _queueOrOpenFromPayload(payload);
    } catch (e, st) {
      debugPrint('getNotificationAppLaunchDetails failed: $e\n$st');
    }
  }

  /// iOS UIScene can resolve getInitialMessage as null forever if called too
  /// early — wait briefly, then call ONCE (the API is one-shot).
  Future<void> _captureInitialMessageForColdStart() async {
    if (_initialMessageHandled) return;
    try {
      if (Platform.isIOS) {
        // Give scene / notificationResponse time to land before the one-shot.
        await Future<void>.delayed(const Duration(milliseconds: 700));
      }
      if (_initialMessageHandled) return;
      _initialMessageHandled = true;
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage == null) {
        debugPrint('getInitialMessage: null (no FCM cold-start open)');
        // Re-check native prefs — UNUserNotificationCenter may have stored
        // after our first SharedPreferences read.
        await _captureSharedPrefsColdStartFallback();
        return;
      }
      debugPrint(
        'getInitialMessage: cold-start data=${initialMessage.data}',
      );
      _queueOrOpenFromRemoteMessage(initialMessage);
      unawaited(
        ChatPushDeliveryAck.ackFromRemoteMessageData(initialMessage.data),
      );
    } catch (e, st) {
      _initialMessageHandled = true;
      debugPrint('getInitialMessage failed: $e\n$st');
    }
  }

  /// Called from home after shell load — pull any late native/prefs payload.
  Future<void> recaptureColdStartIfNeeded() async {
    await _captureSharedPrefsColdStartFallback();
    if (Platform.isIOS) {
      try {
        final raw = await _iosPushChannel.invokeMethod<dynamic>(
          'takeColdStartPushUserInfo',
        );
        if (raw is Map) {
          final data = ChatPushNavigation.normalizeData(
            Map<String, dynamic>.from(raw),
          );
          if (data.isNotEmpty) {
            ChatPushNavigation.queueColdStartData(data);
          }
        }
      } catch (_) {}
    }
  }

  /// AppDelegate mirrors launch userInfo into SharedPreferences (`flutter.*`).
  Future<void> _captureSharedPrefsColdStartFallback() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const jsonKey = 'egyakin_cold_start_push_v1';
      const tsKey = 'egyakin_cold_start_push_ts';
      final raw = prefs.getString(jsonKey);
      final ts = prefs.getDouble(tsKey) ?? 0;
      if (raw == null || raw.isEmpty) return;

      final age = DateTime.now().millisecondsSinceEpoch / 1000.0 - ts;
      await prefs.remove(jsonKey);
      await prefs.remove(tsKey);
      if (ts > 0 && (age < 0 || age > 120)) {
        debugPrint('SharedPrefs cold-start push expired age=$age');
        return;
      }

      final decoded = jsonDecode(raw);
      if (decoded is! Map) return;
      final data = ChatPushNavigation.normalizeData(
        Map<String, dynamic>.from(decoded),
      );
      if (data.isEmpty) return;
      debugPrint(
        'SharedPrefs cold-start push keys=${data.keys.toList()}',
      );
      final queued = ChatPushNavigation.queueColdStartData(data);
      if (queued) {
        unawaited(ChatPushDeliveryAck.ackFromRemoteMessageData(data));
        ChatPushNavigation.flushPending();
      }
    } catch (e, st) {
      debugPrint('SharedPrefs cold-start push failed: $e\n$st');
    }
  }

  Future<void> _captureIosNativeColdStartFallback() async {
    if (!Platform.isIOS) return;
    try {
      // Retry — channel may register a few hundred ms after launch.
      for (var attempt = 0; attempt < 8; attempt++) {
        if (attempt > 0) {
          await Future<void>.delayed(const Duration(milliseconds: 400));
        } else {
          await Future<void>.delayed(const Duration(milliseconds: 600));
        }
        try {
          final raw = await _iosPushChannel.invokeMethod<dynamic>(
            'takeColdStartPushUserInfo',
          );
          if (raw is! Map) {
            // Also re-check SharedPreferences on each attempt.
            await _captureSharedPrefsColdStartFallback();
            continue;
          }
          final data = ChatPushNavigation.normalizeData(
            Map<String, dynamic>.from(raw),
          );
          if (data.isEmpty) continue;
          debugPrint('iOS native cold-start push fallback keys=${data.keys}');
          final queued = ChatPushNavigation.queueColdStartData(data);
          if (queued) {
            unawaited(ChatPushDeliveryAck.ackFromRemoteMessageData(data));
            ChatPushNavigation.flushPending();
          }
          return;
        } on MissingPluginException {
          await _captureSharedPrefsColdStartFallback();
        } catch (_) {
          await _captureSharedPrefsColdStartFallback();
        }
      }
    } catch (e, st) {
      debugPrint('iOS cold-start push fallback failed: $e\n$st');
    }
  }

  void firebaseInit() {
    if (_firebaseHandlersBound) return;
    _firebaseHandlersBound = true;
    _bindNonChatOpener();

    // Cold-start capture may already be in flight from [captureColdStartLaunch].
    unawaited(captureColdStartLaunch());
    unawaited(ensureLocalNotificationsReady());

    // App in FOREGROUND: show banner / refresh inbox — do not navigate.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      unawaited(_handleForegroundMessage(message));
    });

    // App was BACKGROUNDED: user tapped the system notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      unawaited(_handleMessageOpened(message));
    });
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    try {
      debugPrint('Received FCM message: ${message.data}');

      // Ack + inbox refresh first — even when we skip the banner.
      unawaited(ChatPushDeliveryAck.ackFromRemoteMessageData(message.data));
      ChatPushNavigation.onForegroundChatPush(message.data);

      final notification = message.notification;
      if (notification == null && message.data.isEmpty) return;

      if (message.data['silent'] == 'true') {
        debugPrint('Received a silent notification. Not showing locally.');
        return;
      }

      // Already looking at this chat or at the Chats inbox — no banner.
      if (_isChatAlreadyOnScreen(message.data)) {
        debugPrint(
          'Foreground chat push: skipping banner (chat/inbox on screen)',
        );
        return;
      }

      await ensureLocalNotificationsReady();
      final notificationId = notificationCounter++;
      final idKey = notificationId.toString();
      if (!shownNotifications.contains(idKey)) {
        shownNotifications.add(idKey);
        await _showNotification(message, idKey);
      }
    } catch (e, st) {
      debugPrint('Foreground push handle failed: $e\n$st');
    }
  }

  /// Skip the in-app banner when the user is already seeing the message
  /// (same open chat) or watching the Chats list update live.
  bool _isChatAlreadyOnScreen(Map<String, dynamic> data) {
    final type = (data['type'] ?? '').toString().trim().toLowerCase();
    final looksLikeChat = type == 'chat_message' ||
        type == 'chat' ||
        type == 'message' ||
        type == 'new_message' ||
        data['chat_type'] != null ||
        data['chatType'] != null;
    if (!looksLikeChat) return false;

    final conversationId = int.tryParse(
      '${data['conversation_id'] ?? data['conversationId'] ?? ''}',
    );
    try {
      if (di.sl.isRegistered<ChatRealtimeService>()) {
        final openId = di.sl<ChatRealtimeService>().subscribedConversationId;
        if (conversationId != null && conversationId == openId) {
          return true;
        }
      }
    } catch (_) {}

    return AppScreenTracker.inboxOnScreen;
  }

  Future<void> _handleMessageOpened(RemoteMessage message) async {
    try {
      debugPrint(
        'In handleMessageOpened function data=${message.data} '
        'notif=${message.notification?.title}',
      );
      // Navigate first — ack must never delay / crash the open path.
      // Defer one frame so resume / Metal surface can settle (esp. iOS).
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openFromRemoteMessage(message);
      });
      unawaited(ChatPushDeliveryAck.ackFromRemoteMessageData(message.data));
    } catch (e, st) {
      debugPrint('Push open handle failed: $e\n$st');
    }
  }

  void _queueOrOpenFromRemoteMessage(RemoteMessage message) {
    final data = ChatPushNavigation.normalizeData(
      Map<String, dynamic>.from(message.data),
    );
    if (data.isEmpty) {
      debugPrint(
        'Push cold-start: empty data map — cannot route '
        '(backend must put type / chat_type in FCM data)',
      );
      return;
    }
    // Always queue on cold start; home flush opens when ready (chat + non-chat).
    final queued = ChatPushNavigation.queueColdStartData(data);
    if (!queued) return;
    ChatPushNavigation.flushPending();
  }

  void _openFromRemoteMessage(RemoteMessage message) {
    final data = ChatPushNavigation.normalizeData(
      Map<String, dynamic>.from(message.data),
    );
    // If data is empty on iOS, still try to open when session can flush later.
    if (data.isEmpty) {
      debugPrint(
        'Push open: empty data map — cannot route '
        '(backend must put type / chat_type in FCM data)',
      );
      // Still flush any previously queued local-notification payload.
      ChatPushNavigation.flushPending();
      return;
    }
    final openedChat = ChatPushNavigation.openFromData(data);
    if (!openedChat) {
      _openNonChatTarget(data);
    }
  }

  void _queueOrOpenFromPayload(String? payload) {
    if (payload == null || payload.trim().isEmpty) return;
    try {
      final decoded = jsonDecode(payload);
      if (decoded is! Map) return;
      final data = ChatPushNavigation.normalizeData(
        Map<String, dynamic>.from(decoded),
      );
      final queued = ChatPushNavigation.queueColdStartData(data);
      if (!queued) return;
      ChatPushNavigation.flushPending();
    } catch (e) {
      debugPrint('Push payload cold-start queue failed: $e');
    }
  }

  void _openFromPayload(String? payload) {
    if (payload == null || payload.trim().isEmpty) return;
    try {
      final decoded = jsonDecode(payload);
      if (decoded is! Map) return;
      final data = ChatPushNavigation.normalizeData(
        Map<String, dynamic>.from(decoded),
      );
      final openedChat = ChatPushNavigation.openFromData(data);
      if (!openedChat) {
        _openNonChatTarget(data);
      }
    } catch (e) {
      debugPrint('Push payload open failed: $e');
    }
  }

  /// Prefer canonical `notification_type` (GroupPost / group_join_approved)
  /// over temporary backend aliases in `type`.
  String _resolvePushType(Map<String, dynamic> data) {
    final notificationType =
        (data['notification_type'] ?? '').toString().trim();
    if (notificationType.isNotEmpty) return notificationType;
    return (data['type'] ?? '').toString().trim();
  }

  /// Best-effort routing for non-chat pushes (matches in-app notification types).
  void _openNonChatTarget(Map<String, dynamic> data) {
    final type = _resolvePushType(data);
    if (type.isEmpty) {
      debugPrint('Push open: unknown payload keys=${data.keys.toList()}');
      return;
    }
    if (!_sessionReadyForNav()) {
      debugPrint('Push open: session not ready for type=$type — queue');
      ChatPushNavigation.queueColdStartData(data);
      return;
    }

    try {
      final home = di.sl<HomeCubit>();
      final doctor = home.currentDoctorModel;
      final homeData = home.homeDataModel;
      final typeId = data['type_id'] ?? data['typeId'] ?? data['id'];
      final role = home.currentDoctorRole;
      final points = int.tryParse(home.doctorScore ?? '') ?? 0;
      final verified = home.accountVerification ?? false;
      final syndicateRequired = home.isSyndicateCardRequired;
      final nav = navigatorKey.currentState;

      switch (type) {
        case 'Consultation':
          final consultationId = typeId?.toString();
          if (consultationId == null || consultationId.isEmpty) break;
          // List under details so Back returns to received consultations.
          nav?.pushNamed(
            AppRoutes.consultation,
            arguments: AppRoutesArgs.consultationRouteArgs(
              homeDataModel: homeData,
              currentDoctorModel: doctor,
              initialTab: 1,
            ),
          );
          nav?.pushNamed(
            AppRoutes.consultationDetails,
            arguments: AppRoutesArgs.consultationDetailsRouteArgs(
              homeDataModel: homeData,
              currentDoctorModel: doctor,
              patientName: (data['patient_name'] ?? data['patientName'] ?? '')
                  .toString(),
              consultationId: consultationId,
              isReceivedConsultation: true,
              isOpen: data['is_open']?.toString() != 'false',
            ),
          );
          return;
        case 'New Patient':
          final patientId =
              (data['patient_id'] ?? data['patientId'] ?? typeId)?.toString();
          if (patientId == null || patientId.isEmpty) break;
          nav?.pushNamed(
            AppRoutes.patientSections,
            arguments: AppRoutesArgs.patientSectionsRouteArguments(
              patientId: patientId,
              currentDoctorRole: role,
              currentDoctorPoints: points,
              currentDoctorModel: doctor,
              homeDataModel: homeData,
              isAllDataOpen: false,
            ),
          );
          return;
        case 'Comment':
          final patientId =
              (data['patient_id'] ?? data['patientId'] ?? '').toString();
          if (patientId.isEmpty) break;
          nav?.pushNamed(
            AppRoutes.comments,
            arguments: AppRoutesArgs.patientCommentsRouteArgs(
              patientId: patientId,
              currentDoctorModel: doctor,
              verified: verified,
              patientName:
                  (data['patient_name'] ?? data['patientName'] ?? '').toString(),
              homeDataModel: homeData,
              currentDoctorPoints: points,
              isSyndicateCardRequired: syndicateRequired,
              currentDoctorRole: role,
            ),
          );
          return;
        case 'Achievement':
          final doctorId = (data['type_doctor_id'] ??
                  data['typeDoctorId'] ??
                  typeId)
              ?.toString();
          if (doctorId == null || doctorId.isEmpty) break;
          nav?.pushNamed(
            AppRoutes.doctorInfoView,
            arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
              doctorId: doctorId,
              initialIndex: 1,
              currentDoctorModel: doctor,
              isSyndicateCardRequired: syndicateRequired,
              accountVerification: verified,
              currentDoctorRole: role,
              currentDoctorPoints: points,
              homeDataModel: homeData,
              isNavigateToTheButtonOfInformationTab: false,
            ),
          );
          return;
        case 'Syndicate Card':
          // Backend omits type_id; route by type_doctor_id only.
          final doctorId =
              (data['type_doctor_id'] ?? data['typeDoctorId'])?.toString();
          if (doctorId == null || doctorId.isEmpty) break;
          nav?.pushNamed(
            AppRoutes.doctorInfoView,
            arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
              doctorId: doctorId,
              initialIndex: 0,
              currentDoctorModel: doctor,
              isSyndicateCardRequired: syndicateRequired,
              accountVerification: verified,
              currentDoctorRole: role,
              currentDoctorPoints: points,
              homeDataModel: homeData,
              isNavigateToTheButtonOfInformationTab: true,
            ),
          );
          return;
        case 'Post':
        case 'GroupPost':
        case 'PostLike':
        case 'PostComment':
        case 'CommentLike':
          final feedId = typeId?.toString();
          if (feedId == null || feedId.isEmpty) break;
          nav?.pushNamed(
            AppRoutes.showSingleFeed,
            arguments: AppRoutesArgs.showSingleFeedRouteArgs(
              homeDataModel: homeData,
              currentDoctorModel: doctor,
              feed: const PostCommunityModel(),
              isComeFromNotification: true,
              feedId: feedId,
              showPostFrom: ShowPostFromEnum.notification.name,
            ),
          );
          return;
        case 'group_invitation':
        case 'group_invitation_accepted':
        case 'group_join_request':
        case 'group_join_approved':
          final groupId = typeId?.toString();
          if (groupId == null || groupId.isEmpty) break;
          nav?.pushNamed(
            AppRoutes.groupDetailsInCommunity,
            arguments: AppRoutesArgs.groupDetailsInCommunityRouteArgs(
              groupId: groupId,
              currentDoctorModel: doctor,
              homeDataModel: homeData,
            ),
          );
          return;
        case 'group_join_declined':
        case 'group_member_removed':
          // Informational only — stay on home.
          return;
        default:
          debugPrint('Push open: no route for type=$type');
      }
    } catch (e, st) {
      debugPrint('Non-chat push open failed: $e\n$st');
    }
  }

  bool _sessionReadyForNav() {
    try {
      if (!di.sl.isRegistered<HomeCubit>()) return false;
      final home = di.sl<HomeCubit>();
      final doctorId = home.currentDoctorModel.id;
      if (doctorId == null || doctorId == 0) return false;
      return home.state.maybeWhen(
        loaded: (
          _,
          __,
          ___,
          ____,
          _____,
          ______,
          _______,
          ________,
          _________,
          __________,
        ) =>
            true,
        orElse: () => false,
      );
    } catch (_) {
      return false;
    }
  }

  Future<void> _showNotification(
    RemoteMessage message,
    String notificationId,
  ) async {
    final title = message.notification?.title ??
        (message.data['title'] ?? message.data['sender_name'] ?? 'EgyAkin')
            .toString();
    final body = message.notification?.body ??
        (message.data['body'] ?? message.data['content'] ?? '').toString();

    final avatarUrl = _avatarImageUrl(message);
    final mediaUrl = _messageImageUrl(message, avatarUrl: avatarUrl);

    final avatarBytes = await _downloadImageBytes(avatarUrl);
    final mediaPath = await _downloadImageFile(mediaUrl);

    ByteArrayAndroidBitmap? largeIcon;
    ByteArrayAndroidIcon? personIcon;
    if (avatarBytes != null && avatarBytes.isNotEmpty) {
      largeIcon = ByteArrayAndroidBitmap(avatarBytes);
      personIcon = ByteArrayAndroidIcon(avatarBytes);
    }

    StyleInformation? style;
    final person = Person(
      name: title,
      key: (message.data['sender_id'] ?? message.data['senderId'] ?? title)
          .toString(),
      icon: personIcon,
    );

    if (mediaPath != null) {
      // Collapsed: avatar as largeIcon; expanded: message photo.
      style = BigPictureStyleInformation(
        FilePathAndroidBitmap(mediaPath),
        largeIcon: largeIcon,
        contentTitle: title,
        summaryText: body.isEmpty ? null : body,
        hideExpandedLargeIcon: true,
      );
    } else {
      style = MessagingStyleInformation(
        person,
        groupConversation: false,
        messages: [
          Message(
            body.isEmpty ? title : body,
            DateTime.now(),
            person,
          ),
        ],
      );
    }

    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'high_importance_channel',
      channelDescription:
          'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      channelShowBadge: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
      largeIcon: largeIcon,
      styleInformation: style,
      sound: const RawResourceAndroidNotificationSound('notification'),
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
    );

    final iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
      presentList: true,
      attachments: mediaPath == null
          ? null
          : [
              DarwinNotificationAttachment(
                mediaPath,
                identifier: 'message-image',
              ),
            ],
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    // Prefer full data map so tap can open the chat / target screen.
    final payloadMap = ChatPushNavigation.normalizeData(
      Map<String, dynamic>.from(message.data),
    );

    await _localNotificationsPlugin.show(
      int.parse(notificationId),
      title,
      body.isEmpty ? null : body,
      notificationDetails,
      payload: jsonEncode(payloadMap.isEmpty ? message.data : payloadMap),
    );
  }

  String? _dataString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final raw = data[key];
      if (raw == null) continue;
      final s = raw.toString().trim();
      if (s.isNotEmpty) return s;
    }
    return null;
  }

  String? _avatarImageUrl(RemoteMessage message) {
    final fromData = _dataString(message.data, const [
      'sender_image',
      'senderImage',
      'sender_avatar',
      'senderAvatar',
      'sender_image_url',
      'senderImageUrl',
      'avatar',
      'peer_image',
      'peerImage',
      'conversation_image',
      'conversationImage',
      'group_image',
      'groupImage',
    ]);
    if (fromData != null) return fromData;

    // FCM often only sends the sender photo as the generic notification image.
    final fcmImage = message.notification?.android?.imageUrl ??
        message.notification?.apple?.imageUrl;
    if (fcmImage != null && fcmImage.trim().isNotEmpty) {
      return fcmImage.trim();
    }
    return _dataString(message.data, const ['image']);
  }

  /// Right-side / big-picture media: explicit message photos only — never the
  /// sender avatar or FCM generic `image` (those belong on the left).
  String? _messageImageUrl(RemoteMessage message, {String? avatarUrl}) {
    final fromData = _dataString(message.data, const [
      'attachment_url',
      'attachmentUrl',
      'media_url',
      'mediaUrl',
      'message_image',
      'messageImage',
      'photo_url',
      'photoUrl',
    ]);
    if (fromData != null && fromData != avatarUrl) return fromData;
    return null;
  }

  Future<Uint8List?> _downloadImageBytes(String? url) async {
    if (url == null || url.isEmpty) return null;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return null;
      }
      if (response.bodyBytes.isEmpty) return null;
      return response.bodyBytes;
    } catch (e) {
      debugPrint('Notification avatar download failed: $e');
      return null;
    }
  }

  Future<String?> _downloadImageFile(String? url) async {
    final bytes = await _downloadImageBytes(url);
    if (bytes == null) return null;
    try {
      final dir = await getTemporaryDirectory();
      final ext = _imageExtFromUrl(url!);
      final file = File(
        '${dir.path}/notif_${DateTime.now().millisecondsSinceEpoch}.$ext',
      );
      await file.writeAsBytes(bytes, flush: true);
      return file.path;
    } catch (e) {
      debugPrint('Notification media file write failed: $e');
      return null;
    }
  }

  String _imageExtFromUrl(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('.png')) return 'png';
    if (lower.contains('.gif')) return 'gif';
    if (lower.contains('.webp')) return 'webp';
    return 'jpg';
  }
}
