import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/app_tile_skeleton_list.dart';
import 'package:news_task/core/widgets/failure_widgets/app_error_widget.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/logic/bookmarks_cubit.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/ui/widgets/bookmarks_empty_view.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/ui/widgets/bookmarks_list.dart';

class BookmarksBody extends StatelessWidget {
  const BookmarksBody({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BookmarksCubit, BookmarksState>(
        buildWhen: (previous, current) =>
            current is GetBookmarksLoadingState ||
            current is GetBookmarksSuccessState ||
            current is GetBookmarksFailureState,
        builder: (context, state) {
          final cubit = context.read<BookmarksCubit>();
          if (state is GetBookmarksLoadingState) {
            return const AppTileSkeletonList(itemCount: 4);
          }
          if (state is GetBookmarksFailureState) {
            return Center(
              child: AppErrorWidget(
                fallbackMessage: LocaleKeys.bookmarkError.tr(),
                failure: state.failure,
                retryLabel: LocaleKeys.retry.tr(),
                onRetry: cubit.getBookmarks,
              ),
            );
          }
          if (cubit.bookmarks.isEmpty) return const BookmarksEmptyView();
          return const BookmarksList();
        },
      );
}
