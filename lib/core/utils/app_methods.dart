import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/helpers/cache/cache_helper.dart';

sealed class AppMethods {
  static Future<void> changeLanguage(
    BuildContext context, {
    required Locale locale,
  }) async {
    await EasyLocalization.of(context)!.setLocale(locale);
    await CacheHelper.save(CacheKeys.currentLanguage, locale.languageCode);
  }
}
