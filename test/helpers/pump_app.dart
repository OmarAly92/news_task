import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_task/core/app_routes/app_router.dart';
import 'package:news_task/core/app_themes/colors/light_skin.dart';
import 'package:news_task/core/app_themes/colors/logic/skin_cubit.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/themes/app_themes.dart';
import 'package:news_task/core/helpers/cache/cache_helper.dart';
import 'package:news_task/core/helpers/localization/app_localization.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/feature/sync/presentation/logic/sync_cubit.dart';

class _FileAssetLoader extends AssetLoader {
  const _FileAssetLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final raw = File('$path/${locale.languageCode}.json').readAsStringSync();
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}

Future<void> initLocalization() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await CacheHelper.init();
  EasyLocalization.logger.enableBuildModes = [];
  await EasyLocalization.ensureInitialized();
}

Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  required NetworkCubit networkCubit,
  required SyncCubit syncCubit,
  double textScale = 1,
}) async {
  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [AppLocalization.enLocal],
      path: 'assets/translations',
      assetLoader: const _FileAssetLoader(),
      startLocale: AppLocalization.enLocal,
      fallbackLocale: AppLocalization.enLocal,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SkinCubit()),
          BlocProvider.value(value: networkCubit),
          BlocProvider.value(value: syncCubit),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, _) => SkinScope(
            skin: const LightSkin(),
            child: Builder(
              builder: (context) => MaterialApp(
                navigatorKey: AppRouter.navigationKey,
                scaffoldMessengerKey: AppRouter.scaffoldMessengerKey,
                theme: AppThemes.fromSkin(const LightSkin()),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: (context, app) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(textScale)),
                  child: app!,
                ),
                home: child,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

Future<void> settle(WidgetTester tester, {int frames = 6}) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
