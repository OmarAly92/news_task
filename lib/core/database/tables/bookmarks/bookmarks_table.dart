import 'package:drift/drift.dart';

@DataClassName('BookmarkEntity')
class Bookmarks extends Table {
  TextColumn get articleId => text()();
  TextColumn get title => text().nullable()();
  TextColumn get summary => text().nullable()();
  TextColumn get source => text().nullable()();
  TextColumn get topicId => text().nullable()();
  TextColumn get authorName => text().nullable()();
  TextColumn get authorAvatar => text().nullable()();
  TextColumn get image => text().nullable()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  DateTimeColumn get savedAt =>
      dateTime().clientDefault(() => DateTime.now())();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get pendingRemoval =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {articleId};
}
