import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_task/core/helpers/cache/cache_helper.dart';
import 'package:news_task/core/helpers/localization/app_localization.dart';
import 'package:news_task/core/utils/service_locator.dart';
import 'package:news_task/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting();
  await CacheHelper.init();
  await ServiceLocator.init();
  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.locales,
      path: 'assets/translations',
      fallbackLocale: AppLocalization.enLocal,
      startLocale: AppLocalization.enLocal,
      child: const MyApp(),
    ),
  );
}

/// To Run Build Runner
/// flutter pub run build_runner build --delete-conflicting-outputs

/// To Generate Localizations
/// dart run easy_localization:generate -S assets/translations -O lib/core/helpers/localization -o locale_keys.g.dart -f keys

/// Run against a real backend instead of the json_data mock
/// flutter run --dart-define=USE_MOCK_API=false --dart-define=BASE_URL=https://your.api
