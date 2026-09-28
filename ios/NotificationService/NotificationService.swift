import Intents
import UserNotifications

/// Runs for every visible push — even after the user swiped the app away,
/// in Low Power Mode, or with Background App Refresh off — and tells the
/// server the chat message reached this phone, so the sender sees ✓✓.
///
/// Also upgrades chat banners to WhatsApp-style Communication Notifications:
/// sender profile on the left, message photo thumbnail on the right.
///
/// Deliberately has no pods: a second Firebase copy for this target makes
/// CocoaPods build GoogleUtilities twice, which breaks Archive.
class NotificationService: UNNotificationServiceExtension {
  private static let appGroupId = "group.com.incodeco.EgyAkin"

  private var contentHandler: ((UNNotificationContent) -> Void)?
  private var bestAttempt: UNMutableNotificationContent?
  private let lock = NSLock()
  private var finished = false

  override func didReceive(
    _ request: UNNotificationRequest,
    withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
  ) {
    self.contentHandler = contentHandler
    let content = request.content.mutableCopy() as? UNMutableNotificationContent
    bestAttempt = content
    let userInfo = request.content.userInfo

    let group = DispatchGroup()
    group.enter()
    ackDelivered(userInfo) { group.leave() }

    if let content {
      group.enter()
      enhanceChatBanner(userInfo, content: content) { group.leave() }
    }

    group.notify(queue: .main) { [weak self] in
      self?.finish(content ?? request.content)
    }
  }

  override func serviceExtensionTimeWillExpire() {
    if let content = bestAttempt { finish(content) }
  }

  /// The system may expire us while requests are still running — hand the
  /// banner over exactly once.
  private func finish(_ content: UNNotificationContent) {
    lock.lock()
    defer { lock.unlock() }
    guard !finished, let handler = contentHandler else { return }
    finished = true
    handler(content)
  }

  // MARK: - Delivered receipt

  /// `POST {chat_conversations_url}/{context_id}/receipts/delivered?chat_type=…`
  private func ackDelivered(_ info: [AnyHashable: Any], done: @escaping () -> Void) {
    let shared = UserDefaults(suiteName: Self.appGroupId)
    guard let token = shared?.string(forKey: "auth_token"), !token.isEmpty,
          let conversationsUrl = shared?.string(forKey: "chat_conversations_url"),
          let route = Self.chatRoute(info),
          var components = URLComponents(
            string: "\(conversationsUrl)/\(route.contextId)/receipts/delivered"
          )
    else { return done() }

    components.queryItems = [URLQueryItem(name: "chat_type", value: route.chatType)]
    guard let url = components.url else { return done() }
    var request = URLRequest(url: url, timeoutInterval: 10)
    request.httpMethod = "POST"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    URLSession.shared.dataTask(with: request) { _, _, _ in done() }.resume()
  }

  // MARK: - Banner enrichment

  /// Avatar (left via Communication Notification) + message image (right attachment).
  private func enhanceChatBanner(
    _ info: [AnyHashable: Any],
    content: UNMutableNotificationContent,
    done: @escaping () -> Void
  ) {
    let avatarURL = Self.avatarImageURL(info)
    let mediaURL = Self.messageImageURL(info, avatarURL: avatarURL)
    let isChat = Self.isChatPush(info)

    let group = DispatchGroup()
    var avatarData: Data?
    var mediaFileURL: URL?

    if let avatarURL {
      group.enter()
      Self.downloadData(avatarURL) { data in
        avatarData = data
        group.leave()
      }
    }

    if let mediaURL {
      group.enter()
      Self.downloadImageFile(mediaURL) { fileURL in
        mediaFileURL = fileURL
        group.leave()
      }
    }

    group.notify(queue: .global(qos: .userInitiated)) { [weak self] in
      guard let self else { return done() }

      if let file = mediaFileURL {
        do {
          let attachment = try UNNotificationAttachment(
            identifier: "message-image",
            url: file
          )
          content.attachments = [attachment]
        } catch {
          // Banner still shows without the photo thumb.
        }
      }

      if isChat {
        if let updated = self.applyCommunicationIntent(
          to: content,
          info: info,
          avatarData: avatarData
        ) {
          self.bestAttempt = updated
          return done()
        }
      }

      self.bestAttempt = content
      done()
    }
  }

  /// WhatsApp-style left avatar via `INSendMessageIntent`.
  private func applyCommunicationIntent(
    to content: UNMutableNotificationContent,
    info: [AnyHashable: Any],
    avatarData: Data?
  ) -> UNMutableNotificationContent? {
    let senderName = Self.senderDisplayName(info, fallback: content.title)
    let senderId = Self.stringValue(info, "sender_id")
      ?? Self.stringValue(info, "senderId")
      ?? senderName
    let conversationId = Self.conversationIdentifier(info)

    var nameComponents = PersonNameComponents()
    nameComponents.nickname = senderName

    let avatar = avatarData.flatMap { INImage(imageData: $0) }
    let sender = INPerson(
      personHandle: INPersonHandle(value: senderId, type: .unknown),
      nameComponents: nameComponents,
      displayName: senderName,
      image: avatar,
      contactIdentifier: nil,
      customIdentifier: senderId,
      isMe: false,
      suggestionType: .none
    )

    let chatType = (
      Self.stringValue(info, "chat_type")
        ?? Self.stringValue(info, "conversation_type")
        ?? ""
    ).lowercased()
    let isGroup = ["group", "social_group", "socialgroup", "case_group", "casegroup"]
      .contains(chatType)

    var speakableGroupName: INSpeakableString?
    if isGroup {
      let groupName = Self.stringValue(info, "conversation_name")
        ?? Self.stringValue(info, "conversationName")
        ?? Self.stringValue(info, "group_name")
        ?? Self.stringValue(info, "groupName")
      if let groupName, !groupName.isEmpty {
        speakableGroupName = INSpeakableString(spokenPhrase: groupName)
      }
    }

    let intent = INSendMessageIntent(
      recipients: nil,
      outgoingMessageType: .outgoingMessageText,
      content: content.body,
      speakableGroupName: speakableGroupName,
      conversationIdentifier: conversationId,
      serviceName: nil,
      sender: sender,
      attachments: nil
    )

    if let avatar {
      intent.setImage(avatar, forParameterNamed: \.sender)
      if speakableGroupName != nil {
        intent.setImage(avatar, forParameterNamed: \.speakableGroupName)
      }
    }

    let interaction = INInteraction(intent: intent, response: nil)
    interaction.direction = .incoming
    interaction.donate(completion: nil)

    do {
      return try content.updating(from: intent) as? UNMutableNotificationContent
    } catch {
      return nil
    }
  }

  // MARK: - Payload helpers

  private static func isChatPush(_ info: [AnyHashable: Any]) -> Bool {
    if chatRoute(info) != nil { return true }
    let type = (stringValue(info, "type") ?? "").lowercased()
    return ["chat_message", "chat", "message", "new_message"].contains(type)
  }

  private static func senderDisplayName(
    _ info: [AnyHashable: Any],
    fallback: String
  ) -> String {
    for key in [
      "sender_name", "senderName", "title", "conversation_name", "conversationName",
    ] {
      if let s = stringValue(info, key), !s.isEmpty { return s }
    }
    return fallback.isEmpty ? "EgyAkin" : fallback
  }

  private static func conversationIdentifier(_ info: [AnyHashable: Any]) -> String {
    if let id = stringValue(info, "conversation_id")
      ?? stringValue(info, "conversationId")
      ?? stringValue(info, "context_id")
      ?? stringValue(info, "contextId")
    {
      return id
    }
    if let route = chatRoute(info) {
      return "\(route.chatType):\(route.contextId)"
    }
    return UUID().uuidString
  }

  /// Profile / group image for the left Communication Notification avatar.
  private static func avatarImageURL(_ info: [AnyHashable: Any]) -> URL? {
    for key in [
      "sender_image", "senderImage", "sender_avatar", "senderAvatar",
      "sender_image_url", "senderImageUrl", "avatar", "peer_image", "peerImage",
      "conversation_image", "conversationImage", "group_image", "groupImage",
    ] {
      if let s = stringValue(info, key), let url = URL(string: s),
         url.scheme?.hasPrefix("http") == true {
        return url
      }
    }
    return nil
  }

  /// Message photo for the right-side notification thumbnail.
  private static func messageImageURL(
    _ info: [AnyHashable: Any],
    avatarURL: URL?
  ) -> URL? {
    for key in [
      "attachment_url", "attachmentUrl", "media_url", "mediaUrl",
      "message_image", "messageImage", "photo_url", "photoUrl",
      "image_url", "imageUrl",
    ] {
      if let s = stringValue(info, key), let url = URL(string: s),
         url.scheme?.hasPrefix("http") == true,
         url.absoluteString != avatarURL?.absoluteString {
        return url
      }
    }

    if let options = info["fcm_options"] as? [AnyHashable: Any],
       let raw = options["image"] as? String,
       let url = URL(string: raw),
       url.scheme?.hasPrefix("http") == true,
       url.absoluteString != avatarURL?.absoluteString {
      return url
    }

    // Generic `image` only when it isn't the avatar we already picked.
    if let raw = stringValue(info, "image"),
       let url = URL(string: raw),
       url.scheme?.hasPrefix("http") == true,
       url.absoluteString != avatarURL?.absoluteString {
      return url
    }
    return nil
  }

  private static func stringValue(_ info: [AnyHashable: Any], _ key: String) -> String? {
    if let s = info[key] as? String {
      let t = s.trimmingCharacters(in: .whitespacesAndNewlines)
      return t.isEmpty ? nil : t
    }
    if let n = info[key] as? NSNumber {
      return n.stringValue
    }
    return nil
  }

  private static func downloadData(_ url: URL, done: @escaping (Data?) -> Void) {
    var request = URLRequest(url: url, timeoutInterval: 8)
    request.setValue("image/*", forHTTPHeaderField: "Accept")
    URLSession.shared.dataTask(with: request) { data, response, _ in
      guard let data, !data.isEmpty else { return done(nil) }
      if let http = response as? HTTPURLResponse,
         !(200...299).contains(http.statusCode) {
        return done(nil)
      }
      done(data)
    }.resume()
  }

  private static func downloadImageFile(
    _ url: URL,
    done: @escaping (URL?) -> Void
  ) {
    var request = URLRequest(url: url, timeoutInterval: 10)
    request.setValue("image/*", forHTTPHeaderField: "Accept")
    URLSession.shared.downloadTask(with: request) { location, response, _ in
      guard let location,
            let ext = imageExtension(mimeType: response?.mimeType, url: url)
      else { return done(nil) }
      // Must move before this completion returns — URLSession deletes the temp file.
      let dest = FileManager.default.temporaryDirectory
        .appendingPathComponent(UUID().uuidString)
        .appendingPathExtension(ext)
      do {
        if FileManager.default.fileExists(atPath: dest.path) {
          try FileManager.default.removeItem(at: dest)
        }
        try FileManager.default.moveItem(at: location, to: dest)
        done(dest)
      } catch {
        done(nil)
      }
    }.resume()
  }

  private static func imageExtension(mimeType: String?, url: URL) -> String? {
    switch mimeType?.lowercased() {
    case "image/jpeg", "image/jpg": return "jpg"
    case "image/png": return "png"
    case "image/gif": return "gif"
    case "image/webp": return "webp"
    default:
      let ext = url.pathExtension.lowercased()
      return ["jpg", "jpeg", "png", "gif", "webp"].contains(ext) ? ext : "jpg"
    }
  }

  /// `chat_type` + `context_id` from the push data. Falls back like the Dart
  /// handler when `context_id` is missing: 1:1 → sender, groups → conversation.
  private static func chatRoute(
    _ info: [AnyHashable: Any]
  ) -> (chatType: String, contextId: String)? {
    if let type = stringValue(info, "type")?.lowercased(),
       !["chat_message", "chat", "message", "new_message"].contains(type) {
      return nil
    }
    guard let chatType = stringValue(info, "chat_type")
      ?? stringValue(info, "conversation_type")
    else {
      return nil
    }
    let lower = chatType.lowercased()
    let isPrivate = lower == "private" || lower == "individual"
    guard let contextId = stringValue(info, "context_id")
      ?? (isPrivate
          ? stringValue(info, "sender_id") ?? stringValue(info, "senderId")
          : stringValue(info, "conversation_id")
            ?? stringValue(info, "conversationId"))
    else { return nil }
    return (chatType, contextId)
  }
}
