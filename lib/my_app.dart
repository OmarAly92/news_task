import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_task/core/app_routes/app_router.dart';
import 'package:news_task/core/app_routes/routes_strings.dart';
import 'package:news_task/core/app_themes/colors/dark_skin.dart';
import 'package:news_task/core/app_themes/colors/light_skin.dart';
import 'package:news_task/core/app_themes/colors/logic/skin_cubit.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/themes/app_themes.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/core/utils/app_strings.dart';
import 'package:news_task/core/utils/service_locator.dart';
import 'package:news_task/feature/sync/presentation/logic/sync_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SkinCubit()),
        BlocProvider.value(value: sl<NetworkCubit>()),
        BlocProvider.value(value: sl<SyncCubit>()),
      ],
      child: BlocBuilder<SkinCubit, SkinState>(
        builder: (context, state) {
          final skin = context.read<SkinCubit>().skin;
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: (context, child) => SkinScope(
              skin: skin,
              child: MaterialApp(
                title: AppStrings.appName,
                debugShowCheckedModeBanner: false,
                navigatorKey: AppRouter.navigationKey,
                scaffoldMessengerKey: AppRouter.scaffoldMessengerKey,
                theme: AppThemes.fromSkin(const LightSkin()),
                darkTheme: AppThemes.fromSkin(const DarkSkin()),
                themeMode: skin.themeMode,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                onGenerateRoute: AppRouter.generateRoute,
                initialRoute: _initialRoute,
              ),
            ),
          );
        },
      ),
    );
  }

  String get _initialRoute => RoutesStrings.appNavBarScreen;
}
