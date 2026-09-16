import 'package:drift/drift.dart';

@DataClassName('FeedItemEntity')
class FeedItems extends Table {
  TextColumn get articleId => text()();
  TextColumn get feedTopicId => text().withDefault(const Constant(''))();
  IntColumn get feedPosition => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get summary => text().nullable()();
  TextColumn get source => text().nullable()();
  TextColumn get topicId => text().nullable()();
  TextColumn get authorId => text().nullable()();
  TextColumn get authorName => text().nullable()();
  TextColumn get authorAvatar => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get tags => text().nullable()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  IntColumn get likes => integer().nullable()();
  IntColumn get comments => integer().nullable()();
  BoolColumn get isLiked => boolean().nullable()();
  IntColumn get version => integer().nullable()();
  DateTimeColumn get cachedAt =>
      dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {articleId, feedTopicId};
}
