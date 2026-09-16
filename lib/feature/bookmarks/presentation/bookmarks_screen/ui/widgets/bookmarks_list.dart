import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_routes/routes_strings.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/animation/list_item_animation.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/logic/bookmarks_cubit.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/ui/widgets/bookmark_dismiss_background.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/ui/widgets/bookmark_tile.dart';

class BookmarksList extends StatelessWidget {
  const BookmarksList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksCubit>();
    return BlocBuilder<BookmarksCubit, BookmarksState>(
      buildWhen: (previous, current) => current is GetBookmarksSuccessState,
      builder: (context, state) => CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              4,
              AppConstants.horizontalPadding,
              8,
            ),
            sliver: SliverToBoxAdapter(
              child: AppText(
                LocaleKeys.bookmarksCount.tr(
                  args: ['${cubit.bookmarks.length}'],
                ),
                style: AppTextStyle.overline.copyWith(
                  color: context.skin.textMuted,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: AppConstants.horizontalPaddingEdge,
            sliver: SliverList.separated(
              itemCount: cubit.bookmarks.length,
              separatorBuilder: (_, _) => const VerticalSpace(10),
              itemBuilder: (context, index) {
                final item = cubit.bookmarks[index];
                final id = item.articleId ?? '$index';
                return ListItemAnimation(
                  index: index,
                  child: Dismissible(
                    key: ValueKey(id),
                    direction: DismissDirection.endToStart,
                    background: const BookmarkDismissBackground(),
                    onDismissed: (_) => cubit.removeBookmark(id),
                    child: BookmarkTile(
                      title: item.title ?? '',
                      summary: item.summary ?? '',
                      source: item.source ?? '',
                      imageUrl: item.image,
                      savedAt: item.savedAt,
                      isSynced: item.isSynced ?? true,
                      onRemove: () => cubit.removeBookmark(id),
                      onTap: () => context.pushNamed(
                        RoutesStrings.articleDetailsScreen,
                        arguments: id,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SliverVerticalSpace(24),
        ],
      ),
    );
  }
}
