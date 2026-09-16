import 'package:drift/drift.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/feed_items/feed_items_table.dart';
import 'package:news_task/core/error_handling/drift_error_handler/drift_error_handler.dart';

part 'feed_items_dao.g.dart';

@DriftAccessor(tables: [FeedItems])
class FeedItemsDao extends DatabaseAccessor<AppDatabase>
    with _$FeedItemsDaoMixin {
  FeedItemsDao(super.db);

  Future<List<FeedItemEntity>> getFeedItems(String feedTopicId) =>
      (select(feedItems)
            ..where((t) => t.feedTopicId.equals(feedTopicId))
            ..orderBy([(t) => OrderingTerm.asc(t.feedPosition)]))
          .get()
          .handleLocalFailure();

  Future<void> replaceFeed(
    String feedTopicId,
    List<FeedItemsCompanion> items,
  ) => transaction(() async {
    await (delete(
      feedItems,
    )..where((t) => t.feedTopicId.equals(feedTopicId))).go();
    await batch((b) => b.insertAllOnConflictUpdate(feedItems, items));
  }).handleLocalFailure();

  Future<void> upsertFeedItems(List<FeedItemsCompanion> items) => batch(
    (b) => b.insertAllOnConflictUpdate(feedItems, items),
  ).handleLocalFailure();

  Future<int> deleteArticles(List<String> articleIds) => (delete(
    feedItems,
  )..where((t) => t.articleId.isIn(articleIds))).go().handleLocalFailure();
}
