import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/articles/articles_dao.dart';
import 'package:news_task/feature/article/data/model/article_details_model.dart';
import 'package:news_task/feature/article/data/model/params/cache_article_params.dart';

abstract class ArticleLocalDataSource {
  Future<(ArticleDetailsModel, DateTime)?> getCachedArticle(String articleId);

  Future<void> cacheArticle(CacheArticleParams params);

  Future<void> removeArticle(String articleId);
}

class ArticleLocalDataSourceImp implements ArticleLocalDataSource {
  ArticleLocalDataSourceImp(this._dao);

  final ArticlesDao _dao;

  @override
  Future<(ArticleDetailsModel, DateTime)?> getCachedArticle(
    String articleId,
  ) async {
    final entity = await _dao.getArticle(articleId);
    if (entity == null) return null;
    return (ArticleDetailsModel.fromDB(entity), entity.cachedAt);
  }

  @override
  Future<void> cacheArticle(CacheArticleParams params) async {
    final article = params.article;
    final id = article.id;
    if (id == null) return;
    await _dao.upsertArticle(
      ArticlesCompanion.insert(
        articleId: id,
        title: Value(article.title),
        summary: Value(article.summary),
        body: Value(jsonEncode(article.body?.map((b) => b.toJson()).toList())),
        source: Value(article.source),
        authorId: Value(article.author?.id),
        authorName: Value(article.author?.name),
        authorAvatar: Value(article.author?.avatar),
        authorBio: Value(article.author?.bio),
        topicId: Value(article.topicId),
        publishedAt: Value(article.publishedAt),
        updatedAt: Value(article.updatedAt),
        readTimeMinutes: Value(article.readTimeMinutes),
        image: Value(article.image),
        gallery: Value(jsonEncode(article.gallery ?? [])),
        tags: Value(jsonEncode(article.tags ?? [])),
        related: Value(jsonEncode(article.related ?? [])),
        likes: Value(article.likes),
        comments: Value(article.comments),
        isLiked: Value(article.isLiked),
        version: Value(article.version),
        cachedAt: Value(DateTime.now()),
      ),
    );
    await _dao.pruneOldest();
  }

  @override
  Future<void> removeArticle(String articleId) => _dao.deleteArticle(articleId);
}
