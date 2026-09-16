import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/utils/service_locator.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/logic/app_nav_bar_cubit.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/logic/bookmarks_cubit.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/ui/bookmarks_screen.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/feed_screen.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/search_screen.dart';

class AppNavBarBody extends StatelessWidget {
  const AppNavBarBody({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppNavBarCubit, AppNavBarState>(
        buildWhen: (previous, current) => current is ChangeTabSuccessState,
        builder: (context, state) => IndexedStack(
          index: context.read<AppNavBarCubit>().currentTab.index,
          children: [
            BlocProvider(
              create: (context) => sl<FeedCubit>(),
              child: const FeedScreen(),
            ),
            BlocProvider(
              create: (context) => sl<SearchCubit>(),
              child: const SearchScreen(),
            ),
            BlocProvider(
              create: (context) => sl<BookmarksCubit>(),
              child: const BookmarksScreen(),
            ),
          ],
        ),
      );
}
