import 'package:flutter_test/flutter_test.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/result/result.dart';

T successValue<T>(Result<T, Failure> result) {
  late T value;
  result.when(
    onSuccess: (data) => value = data,
    onFailure: (failure) => fail('Expected success, got $failure'),
  );
  return value;
}

Failure failureValue<T>(Result<T, Failure> result) {
  late Failure failure;
  result.when(
    onSuccess: (data) => fail('Expected failure, got $data'),
    onFailure: (error) => failure = error,
  );
  return failure;
}
