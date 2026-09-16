import 'package:dio/dio.dart';
import 'package:news_task/core/error_handling/dio_error_handler/api_error_handler_helper.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';

extension DioErrorExtension on DioException {
  Failure<T> getFailure<T>(
    StackTrace stacktrace, {
    T Function(Map<String, dynamic>)? fromJsonValidationErrors,
  }) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectionTimeout.getFailure(stacktrace);
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure(stacktrace);
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure(stacktrace);
      case DioExceptionType.badResponse:
        final data = response?.data;
        if (response != null && response?.statusCode != null) {
          final messageStr =
              _readField(data, 'message') ?? (data is String ? data : '') ?? '';
          final errorsField = _readField(data, 'errors');
          return ServerFailure<T>(
            statusCode: response?.statusCode ?? 0,
            error: messageStr,
            message: messageStr,
            stacktrace: stacktrace,
            validationErrors: errorsField is Map<String, dynamic>
                ? fromJsonValidationErrors?.call(errorsField)
                : null,
          );
        }
        return DataSource.kDefault.getFailure(stacktrace);
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure(stacktrace);
      default:
        return DataSource.kDefault.getFailure(stacktrace);
    }
  }
}

dynamic _readField(dynamic data, String key) {
  if (data is Map && data.containsKey(key)) return data[key];
  return null;
}
