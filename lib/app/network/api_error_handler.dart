import 'package:dio/dio.dart';
import '../../exports.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  recieveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  defaultError
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    // var mContext = navigatorKey!.currentState!.context;
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.recieveTimeOut:
        return Failure(
            ResponseCode.recieveTimeOut, ResponseMessage.recieveTimeOut);
      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int recieveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  static const String success = AppStrings.success;
  static const String noContent = AppStrings.success;
  static const String badRequest = AppStrings.badRequestError;
  static const String unauthorized = AppStrings.unAuthorizedError;
  static const String forbidden = AppStrings.forbiddenError;
  static const String internalServerError = AppStrings.internalServerError;
  static const String notFound = AppStrings.notFoundError;

  // local status code
  static const String connectTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.defaultError;
  static const String recieveTimeOut = AppStrings.timeoutError;
  static const String sendTimeOut = AppStrings.timeoutError;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnection = AppStrings.noInternetError;
  static const String defaultError = AppStrings.defaultError;
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.recieveTimeOut.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        // return Failure(error.response?.statusCode ?? 0,
        //     error.response?.statusMessage ?? "");
        return Failure(
          error.response?.statusCode ?? 0,
          error.response!.data['message'],
        );
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    default:
      return DataSource.defaultError.getFailure();
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }
}
