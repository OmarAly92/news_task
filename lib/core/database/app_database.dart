import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:news_task/core/database/tables/articles/articles_dao.dart';
import 'package:news_task/core/database/tables/articles/articles_table.dart';
import 'package:news_task/core/database/tables/bookmarks/bookmarks_dao.dart';
import 'package:news_task/core/database/tables/bookmarks/bookmarks_table.dart';
import 'package:news_task/core/database/tables/feed_items/feed_items_dao.dart';
import 'package:news_task/core/database/tables/feed_items/feed_items_table.dart';
import 'package:news_task/core/database/tables/outbox/outbox_dao.dart';
import 'package:news_task/core/database/tables/outbox/outbox_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Bookmarks, OutboxMutations, FeedItems, Articles],
  daos: [BookmarksDao, OutboxDao, FeedItemsDao, ArticlesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'news_feed_db'));

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (m) => m.createAll());
}
