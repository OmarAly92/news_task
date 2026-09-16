import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_routes/routes_strings.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_load_more_footer.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_result_tile.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is LoadMoreResultsSuccessState ||
          current is SearchSuccessState,
      builder: (context, state) => CustomScrollView(
        controller: cubit.scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              8,
              AppConstants.horizontalPadding,
              8,
            ),
            sliver: SliverToBoxAdapter(
              child: AppText(
                LocaleKeys.resultsCount.tr(args: ['${cubit.total}']),
                style: AppTextStyle.overline.copyWith(
                  color: context.skin.textMuted,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: AppConstants.horizontalPaddingEdge,
            sliver: SliverList.separated(
              itemCount: cubit.results.length,
              separatorBuilder: (_, _) => const VerticalSpace(10),
              itemBuilder: (context, index) {
                final item = cubit.results[index];
                return SearchResultTile(
                  key: ValueKey(item.id),
                  title: item.title ?? '',
                  summary: item.summary ?? '',
                  source: item.source ?? '',
                  topicName: cubit.topicById(item.topicId)?.name ?? '',
                  imageUrl: item.image,
                  publishedAt: item.publishedAt,
                  query: cubit.query,
                  onTap: () => context.pushNamed(
                    RoutesStrings.articleDetailsScreen,
                    arguments: item.id,
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SearchLoadMoreFooter()),
          const SliverVerticalSpace(24),
        ],
      ),
    );
  }
}
