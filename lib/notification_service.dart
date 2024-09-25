import 'exports.dart';

class NotificationServices {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final Set<String> shownNotifications = {}; // Track shown notifications
  int notificationCounter = 0; // Counter for unique notification IDs

  NotificationServices() {
    _initializeLocalNotifications();
    createNotificationChannel();
  }
  Future<void> createNotificationChannel() async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Channel ID
      'high_importance_channel', // Channel name
      description:
          'This channel is used for important notifications.', // Channel description
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true, // Shows badge for the app icon

      sound: const RawResourceAndroidNotificationSound('notification'),
      vibrationPattern:
          Int64List.fromList([0, 1000, 500, 1000]), // Vibration pattern
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<String?> getDeviceToken() async {
    String? token = await _messaging.getToken();
    debugPrint('fcmToken: $token');
    return token;
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
  }

  Future<void> _initializeLocalNotifications() async {
    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _localNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        debugPrint('Notification tapped with payload: ${response.payload}');
      }
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(context, message);
    });

    _handleInitialMessage(context);
  }

  Future<void> _handleInitialMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(context, initialMessage);
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint("Received FCM message: ${message.data}");

    RemoteNotification? notification = message.notification;

    if (notification != null) {
      debugPrint("Notification title: ${notification.title}");
      debugPrint("Notification body: ${notification.body}");

      // Check for silent notifications
      if (message.data['silent'] == 'true') {
        debugPrint("Received a silent notification. Not showing locally.");
        return; // Skip showing local notification
      }

      // Use a unique notification ID that fits within the 32-bit range
      int notificationId = notificationCounter++;

      // Only show the notification if it hasn't been shown yet
      if (!shownNotifications.contains(notificationId.toString())) {
        shownNotifications.add(notificationId.toString());
        await _showNotification(message, notificationId.toString());
      } else {
        debugPrint("Notification already shown: $notificationId");
      }
    }
  }

  Future<void> _handleMessage(
      BuildContext context, RemoteMessage message) async {
    debugPrint('In handleMessage function');
    String? notificationType = message.data['type'];

    if (notificationType == 'text') {
      Navigator.of(context).pushNamed('/textScreen');
    } else if (notificationType == 'alert') {
      Navigator.of(context).pushNamed('/alertScreen');
    }
  }

  Future<void> _showNotification(
      RemoteMessage message, String notificationId) async {
    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'high_importance_channel', // Channel name
      channelDescription:
          'This channel is used for important notifications.', // Channel description
      importance: Importance.max,
      priority: Priority.high,
      playSound: true, // Ensure playSound is true
      channelShowBadge: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
      sound: const RawResourceAndroidNotificationSound('notification'),
      vibrationPattern:
          Int64List.fromList([0, 1000, 500, 1000]), // Vibration pattern
    );

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true, // Ensure this is true
      sound: 'default', // Ensure sound is default or your custom sound name
      presentBanner: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _localNotificationsPlugin.show(
      int.parse(notificationId), // Unique ID for each notification
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      notificationDetails,
    );
  }
}
