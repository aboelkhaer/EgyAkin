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

  /// Avoid stacking multiple sign-in redirects from parallel `/user/me` 401s.
  static bool _handlingUserMeUnauthorized = false;

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
        if (_isUserMeUnauthenticated(e)) {
          unawaited(_forceSignInFromUserMe());
        } else if (e.response?.statusCode == 401) {
          getDio();
        }
        return handler.next(e);
      },
      onResponse: (e, handler) {
        if (e.statusCode == 401 && _isUserMePath(e.requestOptions)) {
          unawaited(_forceSignInFromUserMe());
        } else if (e.statusCode == 401) {
          getDio();
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

  bool _isUserMePath(RequestOptions options) {
    final path = options.path.toLowerCase();
    final uri = options.uri.toString().toLowerCase();
    return path.contains('/user/me') || uri.contains('/user/me');
  }

  /// `/user/me` + [DioExceptionType.badResponse] auth failure.
  bool _isUserMeUnauthenticated(DioException e) {
    if (!_isUserMePath(e.requestOptions)) return false;

    final status = e.response?.statusCode;
    if (status == 401) return true;

    if (e.type != DioExceptionType.badResponse) return false;

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

  Future<void> _forceSignInFromUserMe() async {
    if (_handlingUserMeUnauthorized) return;
    _handlingUserMeUnauthorized = true;

    try {
      try {
        if (sl.isRegistered<HomeCubit>()) {
          // Session clear + single Sign In navigation live in the cubit.
          await sl<HomeCubit>().signOutForUnUnauthenticated();
        } else {
          await appPreferences.removeDoctorData();
          await appPreferences.removeData(AppLocalStrings.permissions);
          PermissionHelper.clearCache();
          await clearChatSessionOnSignOut();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final nav = navigatorKey.currentState;
            if (nav == null) return;
            final context = navigatorKey.currentContext;
            final currentName =
                context != null ? ModalRoute.of(context)?.settings.name : null;
            if (currentName == AppRoutes.signIn) return;
            nav.pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
          });
        }
      } catch (e) {
        debugPrint('user/me forceSignIn clear failed: $e');
        try {
          await appPreferences.removeDoctorData();
        } catch (_) {}
      }
    } finally {
      Future<void>.delayed(const Duration(seconds: 2), () {
        _handlingUserMeUnauthorized = false;
      });
    }
  }
}
