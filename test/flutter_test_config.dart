import 'dart:async';

import 'package:news_task/core/helpers/logging/app_logger.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  AppLogger.logger.disable();
  await testMain();
}
