import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';
import '../constants/api_end_point.dart';
import 'deep_link_navigation_service.dart';

class DeepLinkHandler {
  static final DeepLinkHandler _instance = DeepLinkHandler._internal();
  factory DeepLinkHandler() => _instance;
  DeepLinkHandler._internal();

  final AppLinks _appLinks = AppLinks();
  final DeepLinkNavigationService _navigationService =
      DeepLinkNavigationService();
  late BuildContext _context;
  bool _isAppInitialized = false;
  bool _hasPendingDeepLink = false;
  bool _isProcessingDeepLink = false;

  void initialize(BuildContext context) {
    _context = context;

    // Check if app was launched from a custom scheme deep link
    _checkIfLaunchedFromCustomScheme().then((wasLaunchedFromCustomScheme) {
      if (wasLaunchedFromCustomScheme) {
        debugPrint(
            '=== APP LAUNCHED FROM CUSTOM SCHEME - Skipping deep link handler setup ===');
        // Don't set up deep link handling if app was launched from custom scheme
        // The route generator will handle it
        _checkForExistingPendingDeepLink();
      } else {
        debugPrint(
            '=== APP LAUNCHED NORMALLY - Setting up deep link handler ===');
        _setupDeepLinkHandling();
        _checkForExistingPendingDeepLink();
      }
    });

    // Mark app as initialized after a delay
    Future.delayed(const Duration(seconds: 3), () {
      _isAppInitialized = true;
      debugPrint('App marked as initialized');
    });
  }

  Future<bool> _checkIfLaunchedFromCustomScheme() async {
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        debugPrint('=== CHECKING INITIAL LINK: $initialLink ===');
        if (initialLink.scheme == 'egyakin') {
          debugPrint('=== APP LAUNCHED FROM CUSTOM SCHEME ===');
          return true;
        } else {
          if (_isWebFileOrStorageUrlNotPostDeepLink(initialLink)) {
            return false;
          }
          debugPrint(
              '=== APP LAUNCHED FROM UNIVERSAL LINK - Processing it ===');
          _storeDeepLinkForLater(initialLink);
          return false;
        }
      }
      debugPrint('=== NO INITIAL LINK FOUND ===');
      return false;
    } catch (e) {
      debugPrint('Error checking initial link: $e');
      return false;
    }
  }

  void _checkForExistingPendingDeepLink() {
    SharedPreferences.getInstance().then((prefs) {
      final existingPostId = prefs.getString('pending_post_id');
      if (existingPostId != null) {
        _hasPendingDeepLink = true;
        debugPrint(
            'Found existing pending deep link for post: $existingPostId');
      }
    });
  }

  void _setupDeepLinkHandling() {
    // Handle deep links when app is already running
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri == null) return;
      // Opening a report PDF in a browser still delivers VIEW to the app; app_links
      // forwards it here. That is not a /post/… deep link — skip silently (no logs).
      if (_isWebFileOrStorageUrlNotPostDeepLink(uri)) return;

      debugPrint('=== DEEP LINK HANDLER: uriLinkStream called ===');
      debugPrint('URI: $uri');
      debugPrint('Scheme: ${uri.scheme}');
      debugPrint('App initialized: $_isAppInitialized');

      // When app is already running, just store the deep link, don't navigate immediately
      _storeDeepLinkForLater(uri);
      debugPrint('=== END DEEP LINK HANDLER: uriLinkStream ===');
    }, onError: (err) {
      debugPrint('Deep link error: $err');
    });
  }

  /// PDF/report URLs are opened via [launchURL]; [app_links] may still emit them.
  bool _isWebFileOrStorageUrlNotPostDeepLink(Uri uri) {
    if (uri.scheme != 'https' && uri.scheme != 'http') return false;
    final p = uri.path.toLowerCase();
    return p.contains('/storage/pdfs/') || p.endsWith('.pdf');
  }

  void _handleDeepLink(Uri uri) {
    // This method is disabled - all deep links should use _storeDeepLinkForLater
    debugPrint(
        '_handleDeepLink called but disabled - using _storeDeepLinkForLater instead');
    _storeDeepLinkForLater(uri);
  }

  void _navigateToPost(String postId) {
    debugPrint('Navigating to post: $postId');

    // Always store the post ID first
    _storePendingPostId(postId);

    // Don't navigate immediately - let the home screen handle it when ready
    // This prevents the "no page found" issue when app is already open
  }

  void _storeDeepLinkForLater(Uri uri) {
    if (_isWebFileOrStorageUrlNotPostDeepLink(uri)) return;

    // Prevent double processing
    if (_isProcessingDeepLink) {
      debugPrint('=== SKIPPING DEEP LINK - Already processing ===');
      return;
    }

    _isProcessingDeepLink = true;
    debugPrint('=== STORING DEEP LINK FOR LATER ===');
    debugPrint('URI: $uri');
    debugPrint('Scheme: ${uri.scheme}');
    debugPrint('Host: ${uri.host}');
    debugPrint('Path: ${uri.path}');
    debugPrint('Path segments: ${uri.pathSegments}');
    debugPrint('App initialized: $_isAppInitialized');

    // Extract post ID and store it for later processing
    String? postId;

    if (uri.scheme == 'https') {
      // Handle Universal Links: https://test.egyakin.com/post/123
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty &&
          pathSegments[0] == 'post' &&
          pathSegments.length >= 2) {
        postId = pathSegments[1];
      }
    } else if (uri.scheme == 'egyakin') {
      // Handle custom scheme: egyakin://post/123 or egyakin:///post/123
      if (uri.host == 'post' && uri.path.isNotEmpty) {
        // Format: egyakin://post/48 (host is 'post', path is '/48')
        postId = uri.path.substring(1); // Remove the leading '/'
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments[0] == 'post' &&
          uri.pathSegments.length >= 2) {
        // Format: egyakin:///post/48 (path segments are ['post', '48'])
        postId = uri.pathSegments[1];
      } else if (uri.pathSegments.isNotEmpty) {
        // Fallback: just get the first path segment
        postId = uri.pathSegments[0];
      }
    }

    if (postId != null) {
      debugPrint('Extracted post ID for later: $postId');
      _storePendingPostId(postId);

      // Don't process immediately - always let the home screen handle it
      debugPrint('Deep link stored, will be processed by home screen');
      debugPrint('=== END STORING DEEP LINK ===');
    } else {
      debugPrint('Invalid deep link format: $uri');
      _isProcessingDeepLink = false;
      debugPrint('=== END STORING DEEP LINK ===');
    }
  }

  void _storePendingPostId(String postId) {
    // Store in shared preferences for later use
    _hasPendingDeepLink = true;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('pending_post_id', postId);
    });
  }

  String? getPendingPostId() {
    // This will be called from the main app to check for pending deep links
    return null; // Will be implemented with async call
  }

  bool hasPendingDeepLink() {
    return _hasPendingDeepLink;
  }

  Future<String?> getPendingPostIdAsync() async {
    final prefs = await SharedPreferences.getInstance();
    final postId = prefs.getString('pending_post_id');
    if (postId != null) {
      // Clear the pending post ID after retrieving it
      await prefs.remove('pending_post_id');
      _hasPendingDeepLink = false;
      _isProcessingDeepLink = false;
    }
    return postId;
  }

  // Generate deep link URL for sharing
  String generatePostDeepLink(String postId) {
    return '${ApiEndPoint.baseUrl}/post/$postId';
  }

  // Generate custom scheme URL for sharing
  String generateCustomSchemeLink(String postId) {
    return 'egyakin:///post/$postId';
  }

  // Check and process pending deep links - call this from home screen when ready
  Future<void> checkAndProcessPendingDeepLinks(BuildContext context) async {
    try {
      final pendingPostId = await getPendingPostIdAsync();
      if (pendingPostId != null) {
        debugPrint(
            'Processing pending deep link for post: $pendingPostId from home screen');
        _navigationService.navigateToPostFromDeepLink(pendingPostId, context);
      }
    } catch (e) {
      debugPrint('Error processing pending deep links: $e');
    }
  }
}
