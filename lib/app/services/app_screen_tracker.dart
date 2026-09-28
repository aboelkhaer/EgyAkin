/// Tracks whether the Chats (inbox) tab is visible under no pushed route.
///
/// Used by [NotificationServices] to skip the foreground chat banner when the
/// user is already looking at the inbox, or (separately) when they are inside
/// the same conversation via [ChatRealtimeService.subscribedConversationId].
class AppScreenTracker {
  AppScreenTracker._();

  static bool _inboxTabSelected = false;
  static bool _homeIsTopRoute = true;

  /// True only when the inbox tab is selected AND nothing is pushed over home.
  static bool get inboxOnScreen => _inboxTabSelected && _homeIsTopRoute;

  static void setInboxTabSelected(bool value) => _inboxTabSelected = value;

  static void setHomeIsTopRoute(bool value) => _homeIsTopRoute = value;
}
