import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/feed_items/feed_items_dao.dart';
import 'package:news_task/core/helpers/cache/cache_helper.dart';
import 'package:news_task/feature/feed/data/model/article_model.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/params/cache_feed_page_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_cached_feed_params.dart';
import 'package:news_task/feature/feed/data/model/topic_model.dart';

abstract class FeedLocalDataSource {
  Future<FeedPageModel?> getCachedFeed(GetCachedFeedParams params);

  Future<void> cacheFeedPage(CacheFeedPageParams params);

  Future<void> removeArticles(List<String> articleIds);

  Future<void> cacheTopics(List<TopicModel> topics);

  List<TopicModel> getCachedTopics();
}

class FeedLocalDataSourceImp implements FeedLocalDataSource {
  FeedLocalDataSourceImp(this._dao);

  final FeedItemsDao _dao;

  static String _key(String? topicId) => topicId ?? '';

  @override
  Future<FeedPageModel?> getCachedFeed(GetCachedFeedParams params) async {
    final entities = await _dao.getFeedItems(_key(params.topicId));
    if (entities.isEmpty) return null;
    final oldest = entities
        .map((e) => e.cachedAt)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    return FeedPageModel(
      data: entities.map(ArticleModel.fromDB).toList(),
      page: 1,
      pageSize: entities.length,
      total: entities.length,
      cachedAt: oldest,
    );
  }

  @override
  Future<void> cacheFeedPage(CacheFeedPageParams params) {
    final key = _key(params.topicId);
    final offset = (params.page - 1) * params.pageSize;
    final now = DateTime.now();
    final rows = [
      for (final (index, article) in params.articles.indexed)
        if (article.id != null)
          FeedItemsCompanion.insert(
            articleId: article.id!,
            feedTopicId: Value(key),
            feedPosition: offset + index,
            title: Value(article.title),
            summary: Value(article.summary),
            source: Value(article.source),
            topicId: Value(article.topicId),
            authorId: Value(article.author?.id),
            authorName: Value(article.author?.name),
            authorAvatar: Value(article.author?.avatar),
            image: Value(article.image),
            tags: Value(jsonEncode(article.tags ?? [])),
            publishedAt: Value(article.publishedAt),
            likes: Value(article.likes),
            comments: Value(article.comments),
            isLiked: Value(article.isLiked),
            version: Value(article.version),
            cachedAt: Value(now),
          ),
    ];
    return params.page == 1
        ? _dao.replaceFeed(key, rows)
        : _dao.upsertFeedItems(rows);
  }

  @override
  Future<void> removeArticles(List<String> articleIds) =>
      _dao.deleteArticles(articleIds);

  @override
  Future<void> cacheTopics(List<TopicModel> topics) => CacheHelper.save(
    CacheKeys.cachedTopics,
    jsonEncode(topics.map((t) => t.toJson()).toList()),
  );

  @override
  List<TopicModel> getCachedTopics() {
    final raw = CacheHelper.get(CacheKeys.cachedTopics) as String?;
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => TopicModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
