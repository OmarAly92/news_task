import 'package:drift/drift.dart';

@DataClassName('ArticleEntity')
class Articles extends Table {
  TextColumn get articleId => text()();
  TextColumn get title => text().nullable()();
  TextColumn get summary => text().nullable()();
  TextColumn get body => text().nullable()();
  TextColumn get source => text().nullable()();
  TextColumn get authorId => text().nullable()();
  TextColumn get authorName => text().nullable()();
  TextColumn get authorAvatar => text().nullable()();
  TextColumn get authorBio => text().nullable()();
  TextColumn get topicId => text().nullable()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  IntColumn get readTimeMinutes => integer().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get gallery => text().nullable()();
  TextColumn get tags => text().nullable()();
  TextColumn get related => text().nullable()();
  IntColumn get likes => integer().nullable()();
  IntColumn get comments => integer().nullable()();
  BoolColumn get isLiked => boolean().nullable()();
  IntColumn get version => integer().nullable()();
  DateTimeColumn get cachedAt =>
      dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {articleId};
}
