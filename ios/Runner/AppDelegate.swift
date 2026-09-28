import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  let gcmMessageIDKey = "gcm.message_id"
  private static let coldStartPushKey = "egyakin_cold_start_push_userinfo"
  private static let coldStartPushTsKey = "egyakin_cold_start_push_ts"
  /// Readable from Flutter SharedPreferences (keys are prefixed with `flutter.`).
  private static let flutterColdStartJsonKey = "flutter.egyakin_cold_start_push_v1"
  private static let flutterColdStartTsKey = "flutter.egyakin_cold_start_push_ts"
  /// Shared with the NotificationService extension (delivered receipts).
  private static let appGroupId = "group.com.incodeco.EgyAkin"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    applySavedThemeStyle()

    // Default Firebase app only — Dart must also use the default app
    // (no custom name). Named apps break Messaging on notification taps.
    if FirebaseApp.app() == nil {
      FirebaseApp.configure()
    }

    Messaging.messaging().delegate = self

    // Persist remote-notification launch so Dart can open chat if
    // getInitialMessage() loses the UIScene race.
    if let remote = launchOptions?[.remoteNotification] as? [AnyHashable: Any] {
      Self.storeColdStartPushUserInfo(remote)
    }

    // Do NOT set UNUserNotificationCenter.delegate here before plugins —
    // that fights flutter_local_notifications / FlutterAppDelegate and can
    // native-crash when the user taps a push on a real device.
    application.registerForRemoteNotifications()

    GeneratedPluginRegistrant.register(with: self)
    setupSharedAuthChannel()
    let launched = super.application(application, didFinishLaunchingWithOptions: launchOptions)

    // After FlutterAppDelegate wires delegates, keep Messaging in the loop.
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    applySavedThemeStyle()
    setupNativeThemeChannel()
    // FlutterViewController may not exist on the first tick — retry.
    setupNativePushChannelWithRetry()
    return launched
  }

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    Messaging.messaging().apnsToken = deviceToken
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  private func applySavedThemeStyle() {
    let theme = UserDefaults.standard.string(forKey: "flutter.theme_mode") ?? "system"
    applyInterfaceStyle(theme)
  }

  private func applyInterfaceStyle(_ mode: String?) {
    if #available(iOS 13.0, *) {
      let style: UIUserInterfaceStyle
      switch mode {
      case "dark":
        style = .dark
      case "light":
        style = .light
      default:
        style = .unspecified
      }
      if let window = window {
        window.overrideUserInterfaceStyle = style
      }
      UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .forEach { $0.overrideUserInterfaceStyle = style }
    }
  }

  private func setupNativeThemeChannel() {
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return
    }

    let channel = FlutterMethodChannel(
      name: "com.incode.EgyAkin/theme",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { [weak self] call, result in
      guard call.method == "setBrightness" else {
        result(FlutterMethodNotImplemented)
        return
      }

      let mode = call.arguments as? String
      DispatchQueue.main.async {
        self?.applyInterfaceStyle(mode)
        result(nil)
      }
    }
  }

  /// Flutter writes the login token here after login / on start and clears
  /// it on logout, so the NotificationService extension can ack deliveries
  /// while the app is closed.
  private func setupSharedAuthChannel() {
    guard let registrar = registrar(forPlugin: "EgyAkinSharedAuth") else { return }
    let channel = FlutterMethodChannel(
      name: "com.incode.EgyAkin/shared_auth",
      binaryMessenger: registrar.messenger()
    )
    channel.setMethodCallHandler { call, result in
      let shared = UserDefaults(suiteName: Self.appGroupId)
      switch call.method {
      case "setSharedAuth":
        let args = call.arguments as? [String: Any]
        shared?.set(args?["token"] as? String, forKey: "auth_token")
        shared?.set(
          args?["chatConversationsUrl"] as? String,
          forKey: "chat_conversations_url"
        )
        result(nil)
      case "clearSharedAuth":
        shared?.removeObject(forKey: "auth_token")
        shared?.removeObject(forKey: "chat_conversations_url")
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  private func setupNativePushChannelWithRetry(attempt: Int = 0) {
    if setupNativePushChannel() { return }
    guard attempt < 20 else {
      print("EgyAkin push channel: FlutterViewController never ready")
      return
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
      self?.setupNativePushChannelWithRetry(attempt: attempt + 1)
    }
  }

  @discardableResult
  private func setupNativePushChannel() -> Bool {
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return false
    }

    let channel = FlutterMethodChannel(
      name: "com.incode.EgyAkin/push",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { call, result in
      guard call.method == "takeColdStartPushUserInfo" else {
        result(FlutterMethodNotImplemented)
        return
      }
      result(Self.takeColdStartPushUserInfo())
    }
    return true
  }

  /// Store notification userInfo for Dart cold-start open (TTL ~120s).
  static func storeColdStartPushUserInfo(_ userInfo: [AnyHashable: Any]) {
    let serializable = Self.stringifyUserInfo(userInfo)
    guard !serializable.isEmpty else { return }
    let defaults = UserDefaults.standard
    let now = Date().timeIntervalSince1970
    defaults.set(serializable, forKey: coldStartPushKey)
    defaults.set(now, forKey: coldStartPushTsKey)

    // Mirror into SharedPreferences-compatible keys so Dart can read without
    // a MethodChannel (channel setup often loses the launch race).
    if let jsonData = try? JSONSerialization.data(
      withJSONObject: serializable,
      options: []
    ),
      let json = String(data: jsonData, encoding: .utf8)
    {
      defaults.set(json, forKey: flutterColdStartJsonKey)
      defaults.set(now, forKey: flutterColdStartTsKey)
      defaults.synchronize()
      print("EgyAkin stored cold-start push for Dart (\(serializable.keys.count) keys)")
    }
  }

  static func takeColdStartPushUserInfo() -> [String: String]? {
    let defaults = UserDefaults.standard
    let ts = defaults.double(forKey: coldStartPushTsKey)
    let age = Date().timeIntervalSince1970 - ts
    let raw = defaults.dictionary(forKey: coldStartPushKey) as? [String: String]
    defaults.removeObject(forKey: coldStartPushKey)
    defaults.removeObject(forKey: coldStartPushTsKey)
    // Keep flutter.* keys — Dart SharedPreferences take owns those.
    guard let raw, !raw.isEmpty, ts > 0, age >= 0, age < 120 else {
      return nil
    }
    return raw
  }

  private static func stringifyUserInfo(_ userInfo: [AnyHashable: Any]) -> [String: String] {
    var out: [String: String] = [:]
    for (key, value) in userInfo {
      let k = String(describing: key)
      if let s = value as? String {
        out[k] = s
      } else if let n = value as? NSNumber {
        out[k] = n.stringValue
      } else if let dict = value as? [AnyHashable: Any] {
        // Flatten one level of nested maps (common FCM shapes).
        for (innerKey, innerVal) in dict {
          let ik = "\(k).\(String(describing: innerKey))"
          if let s = innerVal as? String {
            out[ik] = s
          } else if let n = innerVal as? NSNumber {
            out[ik] = n.stringValue
          } else {
            out[ik] = String(describing: innerVal)
          }
        }
        // Also keep a JSON-ish blob when possible for Dart normalizeData.
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
           let json = String(data: data, encoding: .utf8) {
          out[k] = json
        }
      } else {
        out[k] = String(describing: value)
      }
    }
    return out
  }

  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    // Required when method swizzling is disabled / for analytics handoff.
    Messaging.messaging().appDidReceiveMessage(userInfo)

    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    print(userInfo)

    super.application(
      application,
      didReceiveRemoteNotification: userInfo,
      fetchCompletionHandler: completionHandler
    )
  }

  // Foreground presentation — keep Flutter/FCM in control; avoid crashing
  // by always calling the completion handler on the main queue.
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    let userInfo = notification.request.content.userInfo
    Messaging.messaging().appDidReceiveMessage(userInfo)
    super.userNotificationCenter(
      center,
      willPresent: notification,
      withCompletionHandler: completionHandler
    )
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    let userInfo = response.notification.request.content.userInfo
    Messaging.messaging().appDidReceiveMessage(userInfo)

    // Always stash cold/background taps. Foreground taps go through FCM
    // onMessageOpenedApp / local plugin; leftover prefs are TTL-cleared.
    let state = UIApplication.shared.applicationState
    if state != .active {
      Self.storeColdStartPushUserInfo(userInfo)
    } else if Self.defaultsMissingColdStart() {
      // Rare: process just became active from a killed tap before state flips.
      Self.storeColdStartPushUserInfo(userInfo)
    }

    // Let FlutterAppDelegate / plugins deliver the tap to Dart.
    super.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
  }

  private static func defaultsMissingColdStart() -> Bool {
    UserDefaults.standard.string(forKey: flutterColdStartJsonKey) == nil
  }
}

extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")

    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: dataDict
    )
  }
}
