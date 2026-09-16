import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/mock/mock_http_exception.dart';
import 'package:news_task/core/api/mock/mock_server.dart';
import 'package:news_task/core/error_handling/dio_error_handler/dio_error_handler.dart';
import 'package:news_task/core/helpers/logging/app_logger.dart';

class MockApiConsumer implements ApiConsumer {
  MockApiConsumer(this.server);

  final MockServer server;

  @override
  final Dio client = Dio();

  @override
  set client(_) {}

  @override
  void setDefaultDioOptions() {}

  @override
  Future<Response> get<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? errorFromJsonT,
  }) => _request('GET', path, query: queryParameters, body: body);

  @override
  Future<Response> post<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    Options? options,
    T Function(Map<String, dynamic>)? errorFromJsonT,
  }) => _request('POST', path, query: queryParameters, body: body);

  @override
  Future<Response> put<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? errorFromJsonT,
  }) => _request('PUT', path, query: queryParameters, body: body);

  @override
  Future<Response> patch<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? errorFromJsonT,
  }) => _request('PATCH', path, query: queryParameters, body: body);

  @override
  Future<Response> delete<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? errorFromJsonT,
  }) => _request('DELETE', path, query: queryParameters, body: body);

  Future<Response> _request(
    String method,
    String path, {
    Map<String, dynamic>? query,
    dynamic body,
  }) async {
    final options = RequestOptions(
      path: path,
      method: method,
      queryParameters: query ?? const {},
      data: body,
    );
    if (kDebugMode) {
      AppLogger.info('[MOCK] $method $path ${query ?? ''}');
    }
    try {
      final data = await server.handle(method, path, query: query, body: body);
      return Response(requestOptions: options, data: data, statusCode: 200);
    } on MockHttpException catch (error, stacktrace) {
      throw DioException.badResponse(
        statusCode: error.statusCode,
        requestOptions: options,
        response: Response(
          requestOptions: options,
          data: error.body,
          statusCode: error.statusCode,
        ),
      ).getFailure(stacktrace);
    }
  }
}
