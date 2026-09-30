import 'package:dio/dio.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/chat/data/services/chat_session_cleanup.dart';
import '../../exports.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
// const String xtent = "X-Tenant";
const String xtentValue = 'sst';
const String authorization = 'authorization';
const String defaultLanguage = 'Accept-Language';

class DioFactory {
  DioFactory({required this.appPreferences});
  AppPreferences appPreferences;
  String? token;

  /// Prevents stacking multiple sign-in redirects from parallel 401s.
  static bool _handlingUnauthorized = false;

  Future<Dio> getDio() async {
    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        token = await appPreferences.getString(AppLocalStrings.keyToken) ?? '';
        options.baseUrl = ApiEndPoint.baseUrl;
        options.headers[accept] = applicationJson;
        options.headers[authorization] = 'Bearer $token';

        // Never force JSON content-type onto multipart chat uploads
        // (images/voices/files) — that drops attachments on the server.
        final isMultipart = options.data is FormData ||
            (options.contentType?.toLowerCase().contains('multipart') ?? false);
        if (!isMultipart) {
          options.headers[contentType] = applicationJson;
          options.contentType = applicationJson;
        } else {
          options.headers.remove(contentType);
        }

        options.sendTimeout = const Duration(seconds: AppStrings.apiTimeOut);
        options.receiveTimeout = const Duration(seconds: AppStrings.apiTimeOut);

        return handler.next(options);
      },
      onError: (e, handler) {
        if (_isUnauthenticatedBadResponse(e) &&
            !_isAuthFlowRequest(e.requestOptions)) {
          unawaited(_forceSignInOnUnauthenticated());
        }
        return handler.next(e);
      },
      onResponse: (e, handler) {
        // Some gateways return 401 as a completed response instead of Dio error.
        if (e.statusCode == 401 && !_isAuthFlowRequest(e.requestOptions)) {
          unawaited(_forceSignInOnUnauthenticated());
        }
        return handler.next(e);
      },
    ));

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          request: true,
          responseBody: true,
          error: true,
          compact: true));
    }

    return dio;
  }

  /// Matches [DioExceptionType.badResponse] with 401 / unauthenticated body.
  bool _isUnauthenticatedBadResponse(DioException e) {
    if (e.type != DioExceptionType.badResponse) return false;

    final status = e.response?.statusCode;
    if (status == 401) return true;

    final data = e.response?.data;
    if (data is! Map) return false;

    final message = data['message']?.toString().toLowerCase() ?? '';
    if (message.contains('authentication required') ||
        message.contains('unauthenticated')) {
      return true;
    }

    final errors = data['errors'];
    if (errors is Map) {
      final title = errors['title']?.toString().toLowerCase() ?? '';
      final errStatus = errors['status']?.toString();
      if (title.contains('unauthenticated') || errStatus == '401') {
        return true;
      }
    }

    return false;
  }

  /// Skip redirect on login/register/forgot so wrong-password 401s stay put.
  bool _isAuthFlowRequest(RequestOptions options) {
    final path = options.path.toLowerCase();
    final uri = options.uri.toString().toLowerCase();
    bool hit(String s) => path.contains(s) || uri.contains(s);
    return hit('/login') ||
        hit('/register') ||
        hit('/auth/social') ||
        hit('forgot') ||
        hit('reset-password') ||
        hit('/otp') ||
        hit('verify-email') ||
        hit('verify_email');
  }

  Future<void> _forceSignInOnUnauthenticated() async {
    if (_handlingUnauthorized) return;
    _handlingUnauthorized = true;

    try {
      try {
        if (sl.isRegistered<HomeCubit>()) {
          await sl<HomeCubit>().signOutForUnUnauthenticated();
        } else {
          await appPreferences.removeDoctorData();
          await appPreferences.removeData(AppLocalStrings.permissions);
          PermissionHelper.clearCache();
          await clearChatSessionOnSignOut();
        }
      } catch (e) {
        debugPrint('forceSignIn session clear failed: $e');
        try {
          await appPreferences.removeDoctorData();
        } catch (_) {}
      }

      void goSignIn() {
        final nav = navigatorKey.currentState;
        if (nav == null) return;

        final context = navigatorKey.currentContext;
        final currentName =
            context != null ? ModalRoute.of(context)?.settings.name : null;
        if (currentName == AppRoutes.signIn) return;

        nav.pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
      }

      WidgetsBinding.instance.addPostFrameCallback((_) => goSignIn());
    } finally {
      // Allow a future session expiry after the user signs in again.
      Future<void>.delayed(const Duration(seconds: 2), () {
        _handlingUnauthorized = false;
      });
    }
  }
}
