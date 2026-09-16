import 'package:drift/drift.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/articles/articles_table.dart';
import 'package:news_task/core/error_handling/drift_error_handler/drift_error_handler.dart';

part 'articles_dao.g.dart';

@DriftAccessor(tables: [Articles])
class ArticlesDao extends DatabaseAccessor<AppDatabase>
    with _$ArticlesDaoMixin {
  ArticlesDao(super.db);

  static const int maxCachedArticles = 150;

  Future<ArticleEntity?> getArticle(String articleId) =>
      (select(articles)..where((t) => t.articleId.equals(articleId)))
          .getSingleOrNull()
          .handleLocalFailure();

  Future<void> upsertArticle(ArticlesCompanion article) =>
      into(articles).insertOnConflictUpdate(article).handleLocalFailure();

  Future<int> deleteArticle(String articleId) => (delete(
    articles,
  )..where((t) => t.articleId.equals(articleId))).go().handleLocalFailure();

  Future<void> pruneOldest() => transaction(() async {
    final keep =
        await (select(articles)
              ..orderBy([(t) => OrderingTerm.desc(t.cachedAt)])
              ..limit(maxCachedArticles))
            .map((row) => row.articleId)
            .get();
    if (keep.isEmpty) return;
    await (delete(articles)..where((t) => t.articleId.isNotIn(keep))).go();
  }).handleLocalFailure();
}
