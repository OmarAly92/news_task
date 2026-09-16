import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_routes/routes_strings.dart';
import 'package:news_task/core/utils/app_strings.dart';
import 'package:news_task/core/utils/service_locator.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/article_details_screen.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/logic/app_nav_bar_cubit.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/ui/app_nav_bar_screen.dart';

sealed class AppRouter {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesStrings.appNavBarScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => sl<AppNavBarCubit>(),
              child: const AppNavBarScreen(),
            );
          },
        );
      case RoutesStrings.articleDetailsScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) =>
                  sl<ArticleDetailsCubit>(param1: settings.arguments as String),
              child: const ArticleDetailsScreen(),
            );
          },
        );
    }
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(child: Text(AppStrings.noRouteFound)),
        );
      },
    );
  }
}
