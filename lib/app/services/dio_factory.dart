import 'package:dio/dio.dart';
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
        if (e.response?.statusCode == 401) {
          getDio();
        }
        return handler.next(e);
      },
      onResponse: (e, handler) {
        if (e.statusCode == 401) {
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
}
