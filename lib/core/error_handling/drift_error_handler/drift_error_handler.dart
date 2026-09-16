import 'package:news_task/core/error_handling/failures/failure.dart';

extension DriftFutureErrorHandler<T> on Future<T> {
  Future<T> handleLocalFailure() async {
    try {
      return await this;
    } catch (error, stacktrace) {
      throw LocalFailure(error: error, stacktrace: stacktrace);
    }
  }
}

extension DriftStreamErrorHandler<T> on Stream<T> {
  Stream<T> handleLocalFailure() {
    return handleError((Object error, StackTrace stacktrace) {
      throw LocalFailure(error: error, stacktrace: stacktrace);
    });
  }
}
