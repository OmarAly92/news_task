import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_scaffold.dart';
import 'package:news_task/core/widgets/main_widgets/global_appbar.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/logic/bookmarks_cubit.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/ui/widgets/bookmarks_body.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocListener<BookmarksCubit, BookmarksState>(
        listener: (context, state) {
          if (state is RemoveBookmarkSuccessState) {
            context.showSnackBar(
              LocaleKeys.bookmarkRemoved.tr(),
              actionLabel: LocaleKeys.undo.tr(),
              onAction: context.read<BookmarksCubit>().restoreLastRemoved,
              duration: const Duration(seconds: 5),
            );
          }
          if (state is RemoveBookmarkFailureState ||
              state is RestoreBookmarkFailureState) {
            context.showErrorSnackBar(LocaleKeys.bookmarkError.tr());
          }
        },
        child: AppScaffold(
          appBar: GlobalAppbar(titleText: LocaleKeys.bookmarks.tr()),
          body: const BookmarksBody(),
        ),
      );
}
