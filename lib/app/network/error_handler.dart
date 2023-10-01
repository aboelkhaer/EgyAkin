import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../exports.dart';

class DioExceptions implements Exception {
  static late String message;
  static int statusCode = -1;

  DioExceptions.fromDioError(
      {required DioException dioError, required String? errorFrom}) {
    //This will print error is Json format and colorful
    _prettyPrintError(dioError: dioError, errorFrom: errorFrom);
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;

      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badCertificate:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        statusCode = dioError.response?.statusCode ?? -1;
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  String errorMessage() => message;

  int errorStatusCode() => statusCode;

  void _prettyPrintError(
      {required DioException dioError, required String? errorFrom}) {
    debugPrint(
        '\x1B[31m${"********************************************************"}\x1B[0m');
    debugPrint('\x1B[31m${"🚨 ERROR exception from: $errorFrom"} \x1B[0m');
    debugPrint(
        '\x1B[31m${"🚨 ERROR it's status Code : ${dioError.response?.statusCode ?? -1}"}\x1B[0m');
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(dioError.response?.data ?? '');
      debugPrint(
          '\x1B[31m${"********************************************************"}\x1B[0m');
      log("🕵️ $errorFrom Error Response :\n$prettyprint", name: "Error");
      debugPrint(
          '\x1B[31m🕵️ $errorFrom Error Response :\n$prettyprint", name: "Error"\x1B[0m');
      debugPrint(
          '\x1B[31m${"********************************************************"}\x1B[0m');
    } catch (e) {
      log("🕵️ $errorFrom Error Response :\n${dioError.response?.data ?? ''}",
          name: "Error");
      debugPrint(
          '\x1B[31m${"********************************************************"}\x1B[0m');
    }
  }
}
