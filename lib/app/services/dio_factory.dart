import 'package:dio/dio.dart';

import '../../exports.dart';
import '../constants/local_storage_key.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
// const String xtent = "X-Tenant";
const String xtentValue = "sst";
const String authorization = "authorization";
const String defaultLanguage = "Accept-Language";

class DioFactory {
  DioFactory({required this.getStorageLib});
  GetStorageLib getStorageLib;
  String? token;

  Future<Dio> getDio() async {
    Dio dio = Dio();
    // token = await getStorageLib.getString(AppLocalStrings.keyToken);
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,

      // xtent: xtentValue,
    };

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        token = await getStorageLib.getString(AppLocalStrings.keyToken) ?? '';
        options.headers = headers;
        options.headers[authorization] = 'Bearer $token';
        options.baseUrl = ApiEndPoint.baseUrl;
        options.contentType = applicationJson;

        options.sendTimeout =
            const Duration(milliseconds: AppStrings.apiTimeOut);
        options.receiveTimeout =
            const Duration(milliseconds: AppStrings.apiTimeOut);

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
