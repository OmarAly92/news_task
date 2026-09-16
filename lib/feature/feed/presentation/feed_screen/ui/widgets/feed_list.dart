import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_routes/routes_strings.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/utils/topic_icons.dart';
import 'package:news_task/core/widgets/animation/list_item_animation.dart';
import 'package:news_task/core/widgets/main_widgets/app_refresh_indicator.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_article_card.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_load_more_footer.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedCubit>();
    return AppRefreshIndicator(
      onRefresh: cubit.refresh,
      child: BlocBuilder<FeedCubit, FeedState>(
        buildWhen: (previous, current) =>
            current is LoadMoreSuccessState ||
            current is RefreshFeedSuccessState ||
            current is UpdateArticleSuccessState ||
            current is SyncBookmarksSuccessState,
        builder: (context, state) => CustomScrollView(
          controller: cubit.scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            const SliverVerticalSpace(8),
            SliverPadding(
              padding: AppConstants.horizontalPaddingEdge,
              sliver: SliverList.separated(
                itemCount: cubit.articles.length,
                separatorBuilder: (_, _) => const VerticalSpace(16),
                itemBuilder: (context, index) {
                  final article = cubit.articles[index];
                  final topic = cubit.topicById(article.topicId);
                  return ListItemAnimation(
                    index: index,
                    child: FeedArticleCard(
                      key: ValueKey(article.id),
                      isFeatured: index == 0,
                      title: article.title ?? '',
                      summary: article.summary ?? '',
                      source: article.source ?? '',
                      topicName: topic?.name ?? '',
                      topicIcon: TopicIcons.resolve(topic?.icon),
                      imageUrl: article.image,
                      authorName: article.author?.name ?? '',
                      authorAvatar: article.author?.avatar,
                      publishedAt: article.publishedAt,
                      likes: article.likes ?? 0,
                      comments: article.comments ?? 0,
                      isLiked: article.isLiked ?? false,
                      isBookmarked: article.isBookmarked ?? false,
                      onLikeTap: () => cubit.toggleLike(article),
                      onBookmarkTap: () => cubit.toggleBookmark(article),
                      onTap: () => context.pushNamed(
                        RoutesStrings.articleDetailsScreen,
                        arguments: article.id,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: FeedLoadMoreFooter()),
            const SliverVerticalSpace(24),
          ],
        ),
      ),
    );
  }
}
