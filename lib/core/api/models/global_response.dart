import 'package:equatable/equatable.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';

class GlobalResponse<T> extends Equatable {
  final String? status;
  final String? message;
  final T? data;
  final bool isCached;
  final DateTime? cachedAt;

  const GlobalResponse({
    this.status,
    this.message,
    this.data,
    this.isCached = false,
    this.cachedAt,
  });

  factory GlobalResponse.fromJson(
    Map<String, dynamic> json, {
    dynamic Function(Map<String, dynamic>)? fromJsonT,
    bool withDataKey = true,
    String key = 'data',
  }) {
    try {
      final rawData = withDataKey ? json[key] : json;
      final parsedData = fromJsonT == null ? null : fromJsonT(rawData);

      return GlobalResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: parsedData,
      );
    } catch (error, stackTrace) {
      throw MappingFailure(error: error, stacktrace: stackTrace);
    }
  }

  @override
  List<Object?> get props => [status, message, data, isCached, cachedAt];
}
