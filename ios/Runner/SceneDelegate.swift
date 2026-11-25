import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)

    if let response = connectionOptions.notificationResponse {
      AppDelegate.storeColdStartPushUserInfo(
        response.notification.request.content.userInfo
      )
    }

    let theme = UserDefaults.standard.string(forKey: "flutter.theme_mode") ?? "system"
    applyInterfaceStyle(theme, windowScene: scene as? UIWindowScene)
  }

  private func applyInterfaceStyle(_ mode: String, windowScene: UIWindowScene?) {
    let style: UIUserInterfaceStyle
    switch mode {
    case "dark":
      style = .dark
    case "light":
      style = .light
    default:
      style = .unspecified
    }
    windowScene?.windows.forEach { $0.overrideUserInterfaceStyle = style }
  }
}
